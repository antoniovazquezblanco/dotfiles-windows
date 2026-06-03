# Virtualization

There are two possible worlds here: Hyper-V (Microsoft) vs any other software (VirtualBox, VMWare...).

On one hand, Hyper-V lacks some basic virtualization features such as USB device passthrough or mounting isolated folders.

On the other hand, sometimes, it is not possible to disable Hyper-V if your PC has security requirements that depend on Windows virtualization services.

VirtualBox and other alternatives may be able to work with Hyper-V enabled but that will make them use Hyper-V in the background instead of their own virtualization backend.

## Can I disable Hyper-V?

Hyper-V cannot be disabled if **Virtualization Based Security (VBS)** is active — this covers features like Credential Guard or HVCI (Memory Integrity), which are commonly enforced by corporate security policies.

Run the following as `Administrator` to check:

```powershell
Virtualization_HyperV_status.ps1
```

## Enabling Hyper-V (Not recommended)

Before you proceed beware that:
- Generic USB passthrough is not possible in Hyper-V! (Only proprietary USB over IP solutions may solve this...)
- No arbitrary folder sharing support! (Only sharing full disks is possible...)

To enable Hyper-V run the following command as `Administrator`:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

Reboot your machine and you have Hyper-V Manager installed.
