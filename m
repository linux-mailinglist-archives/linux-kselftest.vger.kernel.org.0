Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55162D2EE9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 17:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgLHP7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 10:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbgLHP7r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 10:59:47 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0DC061793
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Dec 2020 07:59:07 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id x23so13240006lji.7
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Dec 2020 07:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD0o2ItQi8lmlRq8Dqa+emfNCTNiQ0x4iOTDpcQbY9U=;
        b=Ul80CKCLPJ0llHxeHX0lBhO+zouG55kQGC7F1okPwfPNrgjnPP1Zt5r3PpAZ30BGo4
         lMY4pT49LZ9iwpSEMzbY+Og+c9HMPyR2JE9INoK1tu5PVKWaWdr0xMy78NsRRwcpRZHg
         APKJUt8DzbrbPGCFBIQcVonPAoVejxXKOGL6cjbEetq+snhC6WNEWOLKqVPYdFFpc+1n
         J8PuxqG5cNQVR+dOrhNV4AbHxq3Je8AcsyftHD1yEW1rgSK4MNnvUb8Eyumvg8b4SMPN
         tY/ChfpXBMPBfPRBh0R+pL+PPkBR5+QaQrc4J3vZ/HAsq/iEhBy+xq5FAan1yqgeHc7k
         u6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD0o2ItQi8lmlRq8Dqa+emfNCTNiQ0x4iOTDpcQbY9U=;
        b=Gg9Ilp+0xO86fw0gWkCIS6GuV41F3GLcmUEb4UIfgs/HAl4fEThcFfeYI2QaeE0eVL
         n5eGUEM4eoxHIsvUUGlgGdNemRBPcTt9LA9WcE6UnzgeFX/cEzhoY6lGbnH/O8B20MYV
         Yi53shbHR/ttTmL5rZOZj8PVseA4AQgPHyghKnNJWTK2bt2YxYuI4+6bOsRx6TKxJ3ym
         ZVw5/g5vCzsUwVbaF0dM04+sWn5lgrb4lEepjsptG4tPGAZGPKCiOidPHkV2tlkkE/Hp
         NRbT9V4wMUsIKjvROZD9cqiMqyKjFrOsIT5JdikD2OL1irxcbRv8iwJIxiAssTq1UO+v
         Akcg==
X-Gm-Message-State: AOAM5316zddCgHDZ+eHwFyyBOB2qunlp8uq4LsNGHgz7cb1TZvpuKx6+
        XyzRGE30GfNGxUt09RaK5tjFaZvaMpP04wJnIu+3UT7o7psCKWqs
X-Google-Smtp-Source: ABdhPJzDLUfNGHhGUKU2xUqyFN0Om2efFtfIJ8KM/RkLvAQJTLM/A+ayK34nhZSiWXYvNi/nsqI4iRZ0lF0aDwpL3uM=
X-Received: by 2002:a2e:9847:: with SMTP id e7mr3123951ljj.388.1607443145075;
 Tue, 08 Dec 2020 07:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com>
 <CAOQ_Qsj6THRPj2ta3PdOxUJeCj8KxPnLkWV8EGpvN_J=qUv74A@mail.gmail.com>
 <d3dd82950301517e47630cc86fa0e6dc84f63f90.camel@redhat.com> <CAOQ_QshBUdSO_m9kAtSjx5Ti1Nn3RUC1bauGEorNWTajcLu=dw@mail.gmail.com>
In-Reply-To: <CAOQ_QshBUdSO_m9kAtSjx5Ti1Nn3RUC1bauGEorNWTajcLu=dw@mail.gmail.com>
From:   Oliver Upton <oupton@google.com>
Date:   Tue, 8 Dec 2020 09:58:54 -0600
Message-ID: <CAOQ_Qsgc3NcT2KsxmQQWSY77UNR2j5a97ST4KAwY11ogqvStNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+cc Sean's new handle

On Tue, Dec 8, 2020 at 9:57 AM Oliver Upton <oupton@google.com> wrote:
>
> On Tue, Dec 8, 2020 at 5:13 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> >
> > On Mon, 2020-12-07 at 11:29 -0600, Oliver Upton wrote:
> > > On Thu, Dec 3, 2020 at 11:12 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > > > These two new ioctls allow to more precisly capture and
> > > > restore guest's TSC state.
> > > >
> > > > Both ioctls are meant to be used to accurately migrate guest TSC
> > > > even when there is a significant downtime during the migration.
> > > >
> > > > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  Documentation/virt/kvm/api.rst | 65 ++++++++++++++++++++++++++++++
> > > >  arch/x86/kvm/x86.c             | 73 ++++++++++++++++++++++++++++++++++
> > > >  include/uapi/linux/kvm.h       | 15 +++++++
> > > >  3 files changed, 153 insertions(+)
> > > >
> > > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > > > index 70254eaa5229f..ebecfe4b414ce 100644
> > > > --- a/Documentation/virt/kvm/api.rst
> > > > +++ b/Documentation/virt/kvm/api.rst
> > > > @@ -4826,6 +4826,71 @@ If a vCPU is in running state while this ioctl is invoked, the vCPU may
> > > >  experience inconsistent filtering behavior on MSR accesses.
> > > >
> > > >
> > > > +4.127 KVM_GET_TSC_STATE
> > > > +----------------------------
> > > > +
> > > > +:Capability: KVM_CAP_PRECISE_TSC
> > > > +:Architectures: x86
> > > > +:Type: vcpu ioctl
> > > > +:Parameters: struct kvm_tsc_state
> > > > +:Returns: 0 on success, < 0 on error
> > > > +
> > > > +::
> > > > +
> > > > +  #define KVM_TSC_STATE_TIMESTAMP_VALID 1
> > > > +  #define KVM_TSC_STATE_TSC_ADJUST_VALID 2
> > > > +  struct kvm_tsc_state {
> > > > +       __u32 flags;
> > > > +       __u64 nsec;
> > > > +       __u64 tsc;
> > > > +       __u64 tsc_adjust;
> > > > +  };
> > > > +
> > > > +flags values for ``struct kvm_tsc_state``:
> > > > +
> > > > +``KVM_TSC_STATE_TIMESTAMP_VALID``
> > > > +
> > > > +  ``nsec`` contains nanoseconds from unix epoch.
> > > > +    Always set by KVM_GET_TSC_STATE, might be omitted in KVM_SET_TSC_STATE
> > > > +
> > > > +``KVM_TSC_STATE_TSC_ADJUST_VALID``
> > > > +
> > > > +  ``tsc_adjust`` contains valid IA32_TSC_ADJUST value
> > > > +
> > > > +
> > > > +This ioctl allows the user space to read the guest's IA32_TSC,IA32_TSC_ADJUST,
> > > > +and the current value of host's CLOCK_REALTIME clock in nanoseconds since unix
> > > > +epoch.
> > > > +
> > > > +
> > > > +4.128 KVM_SET_TSC_STATE
> > > > +----------------------------
> > > > +
> > > > +:Capability: KVM_CAP_PRECISE_TSC
> > > > +:Architectures: x86
> > > > +:Type: vcpu ioctl
> > > > +:Parameters: struct kvm_tsc_state
> > > > +:Returns: 0 on success, < 0 on error
> > > > +
> > > > +::
> > > > +
> > > > +This ioctl allows to reconstruct the guest's IA32_TSC and TSC_ADJUST value
> > > > +from the state obtained in the past by KVM_GET_TSC_STATE on the same vCPU.
> > > > +
> > > > +If 'KVM_TSC_STATE_TIMESTAMP_VALID' is set in flags,
> > > > +KVM will adjust the guest TSC value by the time that passed since the moment
> > > > +CLOCK_REALTIME timestamp was saved in the struct and current value of
> > > > +CLOCK_REALTIME, and set the guest's TSC to the new value.
> > > > +
> > > > +Otherwise KVM will set the guest TSC value to the exact value as given
> > > > +in the struct.
> > > > +
> > > > +if KVM_TSC_STATE_TSC_ADJUST_VALID is set, and guest supports IA32_MSR_TSC_ADJUST,
> > > > +then its value will be set to the given value from the struct.
> > > > +
> > > > +It is assumed that either both ioctls will be run on the same machine,
> > > > +or that source and destination machines have synchronized clocks.
> > > > +
> > > >  5. The kvm_run structure
> > > >  ========================
> > > >
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index a3fdc16cfd6f3..9b8a2fe3a2398 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -2438,6 +2438,21 @@ static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
> > > >
> > > >         return gtod_is_based_on_tsc(do_realtime(ts, tsc_timestamp));
> > > >  }
> > > > +
> > > > +
> > > > +static void kvm_get_walltime(u64 *walltime_ns, u64 *host_tsc)
> > > > +{
> > > > +       struct timespec64 ts;
> > > > +
> > > > +       if (kvm_get_walltime_and_clockread(&ts, host_tsc)) {
> > > > +               *walltime_ns = timespec64_to_ns(&ts);
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       *host_tsc = rdtsc();
> > > > +       *walltime_ns = ktime_get_real_ns();
> > > > +}
> > > > +
> > > >  #endif
> > > >
> > > >  /*
> > > > @@ -3757,6 +3772,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> > > >         case KVM_CAP_X86_USER_SPACE_MSR:
> > > >         case KVM_CAP_X86_MSR_FILTER:
> > > >         case KVM_CAP_ENFORCE_PV_FEATURE_CPUID:
> > > > +#ifdef CONFIG_X86_64
> > > > +       case KVM_CAP_PRECISE_TSC:
> > > > +#endif
> > > >                 r = 1;
> > > >                 break;
> > > >         case KVM_CAP_SYNC_REGS:
> > > > @@ -4999,6 +5017,61 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> > > >         case KVM_GET_SUPPORTED_HV_CPUID:
> > > >                 r = kvm_ioctl_get_supported_hv_cpuid(vcpu, argp);
> > > >                 break;
> > > > +#ifdef CONFIG_X86_64
> > > > +       case KVM_GET_TSC_STATE: {
> > > > +               struct kvm_tsc_state __user *user_tsc_state = argp;
> > > > +               u64 host_tsc;
> > > > +
> > > > +               struct kvm_tsc_state tsc_state = {
> > > > +                       .flags = KVM_TSC_STATE_TIMESTAMP_VALID
> > > > +               };
> > > > +
> > > > +               kvm_get_walltime(&tsc_state.nsec, &host_tsc);
> > > > +               tsc_state.tsc = kvm_read_l1_tsc(vcpu, host_tsc);
> > > > +
> > > > +               if (guest_cpuid_has(vcpu, X86_FEATURE_TSC_ADJUST)) {
> > > > +                       tsc_state.tsc_adjust = vcpu->arch.ia32_tsc_adjust_msr;
> > > > +                       tsc_state.flags |= KVM_TSC_STATE_TSC_ADJUST_VALID;
> > > > +               }
> > >
> > > [...]
> > >
> > > > +
> > > > +               r = -EFAULT;
> > > > +               if (copy_to_user(user_tsc_state, &tsc_state, sizeof(tsc_state)))
> > > > +                       goto out;
> > > > +               r = 0;
> > > > +               break;
> > > > +       }
> > > > +       case KVM_SET_TSC_STATE: {
> > > > +               struct kvm_tsc_state __user *user_tsc_state = argp;
> > > > +               struct kvm_tsc_state tsc_state;
> > > > +               u64 host_tsc, wall_nsec;
> > > > +
> > > > +               u64 new_guest_tsc, new_guest_tsc_offset;
> > > > +
> > > > +               r = -EFAULT;
> > > > +               if (copy_from_user(&tsc_state, user_tsc_state, sizeof(tsc_state)))
> > > > +                       goto out;
> > > > +
> > > > +               kvm_get_walltime(&wall_nsec, &host_tsc);
> > > > +               new_guest_tsc = tsc_state.tsc;
> > > > +
> > > > +               if (tsc_state.flags & KVM_TSC_STATE_TIMESTAMP_VALID) {
> > > > +                       s64 diff = wall_nsec - tsc_state.nsec;
> > > > +                       if (diff >= 0)
> > > > +                               new_guest_tsc += nsec_to_cycles(vcpu, diff);
> > > > +                       else
> > > > +                               new_guest_tsc -= nsec_to_cycles(vcpu, -diff);
> > > > +               }
> > > > +
> > > > +               new_guest_tsc_offset = new_guest_tsc - kvm_scale_tsc(vcpu, host_tsc);
> > > > +               kvm_vcpu_write_tsc_offset(vcpu, new_guest_tsc_offset);
> > >
> > > How would a VMM maintain the phase relationship between guest TSCs
> > > using these ioctls?
> >
> > By using the nanosecond timestamp.
> >
> > While I did made it optional in the V2 it was done for the sole sake of being
> > able to set TSC on (re)boot to 0 from qemu, and for cases when qemu migrates
> > from a VM where the feature is not enabled.
> > In this case the tsc is set to the given value exactly, just like you
> > can do today with KVM_SET_MSRS.
> > In all other cases the nanosecond timestamp will be given.
> >
> > When the userspace uses the nanosecond timestamp, the phase relationship
> > would not only be maintained but be exact, even if TSC reads were not
> > synchronized and even if their restore on the target wasn't synchronized as well.
> >
> > Here is an example:
> >
> > Let's assume that TSC on source/target is synchronized, and that the guest TSC
> > is synchronized as well.
>
> Can this assumption be reasonably made though?
>
> NTP could very well step or scale CLOCK_REALTIME when we are in the
> middle of saving or restoring TSCs, which could possibly result in
> observable drift between vCPUs. Calculating elapsed time between
> save/restore once per VM would avoid this issue altogether.
>
> > Let's call the guest TSC frequency F (guest TSC increments by F each second)
> >
> > We do KVM_GET_TSC_STATE on vcpu0 and receive (t0,tsc0).
> > We do KVM_GET_TSC_STATE on vcpu1 after 1 second passed (exaggerated)
> > and receive (t0 + 1s, tsc0 + F)
> >
> >
> > We do KVM_SET_TSC_STATE at t0 + 10s on vcpu0 after migration,
> > and vcpu0's guest tsc is set to tsc0 + F[(t0 + 10s) - t0] = tsc0 + 10*F
> >
> > We do KVM_SET_TSC_STATE at nsec0 + 12s on vcpu1 (also exaggerated)
> > and  get [tsc0+F] + F[(t0 + 12s) - (t0+1s)] = tsc0 + 12*F
> >
> > Since 2 seconds passed by, both vCPUs have now their TSC set to tsc0 + 12*F.
> >
> > I use kvm's own functions to read the CLOCK_REALTIME, which are done
> > in such a way that you first read host TSC once and then convert it to
> > nanoseconds by scaling/offsetting it as the kernel would, thus
> > there is no random error introduced here.
>
> Agreed. In fact, my suggestion of yielding TSC offset controls to
> userspace falls short in this regard, since userspace can't make the
> same guarantee that the clockread was derived from its paired TSC
> value.
>
> > So except numerical errors,
> > (which are unavoidable anyway, and should be neglectable) this algorithm should
> > both keep the TSC in sync, and even keep its absolute time reference
> > as accurate as the clock synchronization between the host and the target is.
> >
> > (an offset between source and destination clocks will affect
> > all the TSCs in the same manner, as long as both
> > source and destination clocks are stable)
> >
> >
> > >
> > > For as bugged as the old way of doing things is (i.e. the magic
> > > handling of IA32_TSC), it was at least possible to keep guest TSCs in
> > > sync across a live migration so long as you satisfied the conditions
> > > where KVM decides to fudge the TSCs on your behalf. However, if we
> > > migrate the TSCs by value with an optional timestamp to account for
> > > elapsed time, it would appear that the guest TSC offset is likely to
> > > be inconsistent across vCPUs as the offset calculations above do not
> > > use a fixed host tsc timestamp across all vCPUs.
> >
> > >
> > > The reason I'd suggested yielding control of the tsc offset controls
> > > to userspace is that they're unaffected by such variations in per-vCPU
> > > calculations. Not only that, userspace can decide how it wants TSCs to
> > > be handled across a migration explicitly instead of relying on the
> > > above computation being done in the kernel.
> > >
> > > > +
> > > > +               if (tsc_state.flags & KVM_TSC_STATE_TSC_ADJUST_VALID)
> > > > +                       if (guest_cpuid_has(vcpu, X86_FEATURE_TSC_ADJUST))
> > > > +                               vcpu->arch.ia32_tsc_adjust_msr = tsc_state.tsc_adjust;
> > >
> > > How is this ioctl's handling of the TSC_ADJUST msr an improvement over
> > > KVM_{GET,SET}_MSRS like before? It seems orthogonal to the rest of the
> > > intended API as it isn't involved your computation above.
> >
> > It's more a refactoring thing. The goal is to avoid 'magic' handling
> > of host accesses in KVM_{GET,SET}_MSRS and instead make them
> > behave the same way as if the guest read that msr.
> > That can be useful for debug and such.
> >
> > The second patch adds a KVM quirk, which should be disabled
> > when the new API is used.
> >
> > When disabled, it makes it hard to use the KVM_{GET,SET}_MSRS
> > to set both TSC and TSC_ADJUST at the same time to given values,
> > since these msrs are tied to each other when guest writes them,
> > and the quirk disables the special (untied) write we had for host writes
> > to these msrs.
> >
> >
> > Think of these new ioctls as a way to saving and restoring
> > the internal TSC state, without bothering even to think what is inside.
> > Kind of like we save/restore the nested state.
>
> I agree that the quirk is useful for the guest touching TSC and
> TSC_ADJUST, but host writes to the TSC_ADJUST MSR are unaffected by
> any sync issues. As such, it seems the existing plumbing for
> KVM_{GET,SET}_MSRS VMMs are using seems sufficient.
>
> > Best regards,
> >         Maxim Levitsky
> >
> >
> > >
> > > > +               r = 0;
> > > > +               break;
> > > > +       }
> > > > +#endif
> > > >         default:
> > > >                 r = -EINVAL;
> > > >         }
> > > > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > > > index 886802b8ffba3..bf4c38fd58291 100644
> > > > --- a/include/uapi/linux/kvm.h
> > > > +++ b/include/uapi/linux/kvm.h
> > > > @@ -1056,6 +1056,7 @@ struct kvm_ppc_resize_hpt {
> > > >  #define KVM_CAP_ENFORCE_PV_FEATURE_CPUID 190
> > > >  #define KVM_CAP_SYS_HYPERV_CPUID 191
> > > >  #define KVM_CAP_DIRTY_LOG_RING 192
> > > > +#define KVM_CAP_PRECISE_TSC 193
> > > >
> > > >  #ifdef KVM_CAP_IRQ_ROUTING
> > > >
> > > > @@ -1169,6 +1170,16 @@ struct kvm_clock_data {
> > > >         __u32 pad[9];
> > > >  };
> > > >
> > > > +
> > > > +#define KVM_TSC_STATE_TIMESTAMP_VALID 1
> > > > +#define KVM_TSC_STATE_TSC_ADJUST_VALID 2
> > > > +struct kvm_tsc_state {
> > > > +       __u32 flags;
> > > > +       __u64 nsec;
> > > > +       __u64 tsc;
> > > > +       __u64 tsc_adjust;
> > > > +};
> > > > +
> > > >  /* For KVM_CAP_SW_TLB */
> > > >
> > > >  #define KVM_MMU_FSL_BOOKE_NOHV         0
> > > > @@ -1563,6 +1574,10 @@ struct kvm_pv_cmd {
> > > >  /* Available with KVM_CAP_DIRTY_LOG_RING */
> > > >  #define KVM_RESET_DIRTY_RINGS          _IO(KVMIO, 0xc7)
> > > >
> > > > +/* Available with KVM_CAP_PRECISE_TSC*/
> > > > +#define KVM_SET_TSC_STATE          _IOW(KVMIO,  0xc8, struct kvm_tsc_state)
> > > > +#define KVM_GET_TSC_STATE          _IOR(KVMIO,  0xc9, struct kvm_tsc_state)
> > > > +
> > > >  /* Secure Encrypted Virtualization command */
> > > >  enum sev_cmd_id {
> > > >         /* Guest initialization commands */
> > > > --
> > > > 2.26.2
> > > >
> >
> >
