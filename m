Return-Path: <linux-kselftest+bounces-8622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EEF8ACF06
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 16:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACB31C20CA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFC21509A9;
	Mon, 22 Apr 2024 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjlSlCF4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55D15099E
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795109; cv=none; b=Dcc/Q3ALc+xzGcghXgubNxKn/Vb7bpUOeCR7PSOq9fQWzM9sAvO10D+uUysrSCHKUND2tLA8LZm8mumJxn3Uc1G933pbQKg1kHaBnDoj+0dCcVTkALHZEaQ2cDOSOR30bLHPsGQk5GiKA97XhkLlnmSenmhPL8ljhjWb0BjC0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795109; c=relaxed/simple;
	bh=+kd1MriQ8OtQgQiJ3BiUIs/SYHWbhVBk6w64kO8ty7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gw30Kbm91kDHX9sDr/UOh1z5r0CbXdWWcmiXHiMxKYGQR8H8OwPXrZ+RTXE7wh5cZdU5rnej+dL79pRSfoxOVAerxVHemQjxdAFYZlTfZIi0VZ2DB3kHKxfWoe70dFchXLt/8cvLDo+HieMgCRQ0oeg1sZJc43nXo/qb7qdYE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjlSlCF4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713795106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDPGIY9oq8IOSy73kiJD5rc5ULw/WeV0VOgsrLf59LQ=;
	b=TjlSlCF4OLl8YtGKe1kewLqgFKg4sonVts2U0qEaUaYF3vMU2+mpKlCA+ppQM9yMLmXrAr
	LQZXgncVlD2SPYzSi1F+bFBouqnqBbrI4jIHYpL+4OKpJJYl6eLyw13BpaYaCaLPdKFbZy
	G4GsoJO+P3hiPEzrrdjIXYhw0ZIRFes=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-IOoSpZjSO1asytBdjXKovg-1; Mon, 22 Apr 2024 10:11:44 -0400
X-MC-Unique: IOoSpZjSO1asytBdjXKovg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34b08e09bc4so851828f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 07:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795103; x=1714399903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDPGIY9oq8IOSy73kiJD5rc5ULw/WeV0VOgsrLf59LQ=;
        b=Vz2wlU7Pxek6TEFDwd3AXhbi54KAJA9RjztFqHqFxw1v1Q1AJB+Cbr0tdTbA+VX5Oq
         LWMckC/L1Bm0kzZigPwkU3uH/v6S9FIi6EFz4faGpdIMmbhOKEEP3dd4++1FceglInp4
         6Ps5JhKc/wWmLuZhIuCvopSd7i2ATkYKu7wsgODa+SMcAkGYOsT6MKDDlxdGT/SiQzaP
         g01Tj2kDawyFQwVbQcbepbnx5EhlPFdVOtO6bdHPDYPc49qXyGxcYeji8TDMMXOzjHKG
         qC0P5VGGhl92lAElVGn9kb0lWgAz2c7TNdB2SQbNZNGUENQeAUS35MSAd6SV8vsWM4od
         GNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbG5WiF22WR7x9YY1XxuNibov/YW8m/bhFuINtc2U6VFbVH0giQFj3cWnu2CzAvf7dhPH7U+H3OUBNOP3kBaf3muGUbWD4G7N4KL0Cuw90
X-Gm-Message-State: AOJu0YyNmkUDUQYE8KTIPw243mosJ6X7NZffgaTGw87uhdUFnRkfmD08
	fOvQXvOFf4HKsEM/6xURsupTnCF047y+GMJ1ei2HHRzAaG/FUJ65eVOz8c1w3NEc4tg008J4sxZ
	g13WWqM7Q1aUssGB+bKQbMabtCj8TgAPFuaswwJoAyuapzQaNVbHQECXwhvsV7tF90gKnnPE/of
	SP5hAeKMknStthoeKkU25IdaVlT9mbwRYfPETyv9Ov
X-Received: by 2002:adf:e5d1:0:b0:345:be70:191c with SMTP id a17-20020adfe5d1000000b00345be70191cmr8302566wrn.37.1713795103476;
        Mon, 22 Apr 2024 07:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqITR3VTP0tSKrtpHTRHacPYYLdvO/glnUhpUQumOUdaRf6zoVnC9fryb4dsAVOWbjuf3NJX3pNBIh0R73vQo=
X-Received: by 2002:adf:e5d1:0:b0:345:be70:191c with SMTP id
 a17-20020adfe5d1000000b00345be70191cmr8302539wrn.37.1713795103035; Mon, 22
 Apr 2024 07:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418193528.41780-1-dwmw2@infradead.org> <20240418193528.41780-4-dwmw2@infradead.org>
In-Reply-To: <20240418193528.41780-4-dwmw2@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Apr 2024 16:11:30 +0200
Message-ID: <CABgObfYvwjAz0cbRGbBP1nc9eA47azrGOnKuXqWwpZP=UpV3UQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate
 KVM clock migration
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>, Shuah Khan <shuah@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Marcelo Tosatti <mtosatti@redhat.com>, jalliste@amazon.co.uk, sveith@amazon.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:46=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
> +       curr_tsc_hz =3D get_cpu_tsc_khz() * 1000LL;
> +       if (unlikely(curr_tsc_hz =3D=3D 0)) {
> +               rc =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (kvm_caps.has_tsc_control)
> +               curr_tsc_hz =3D kvm_scale_tsc(curr_tsc_hz,
> +                                           v->arch.l1_tsc_scaling_ratio)=
;
> +
> +       /*
> +        * The scaling factors in the hv_clock do not depend solely on th=
e
> +        * TSC frequency *requested* by userspace. They actually use the
> +        * host TSC frequency that was measured/detected by the host kern=
el,
> +        * scaled by kvm_scale_tsc() with the vCPU's l1_tsc_scaling_ratio=
.
> +        * So a sanity check that they *precisely* match would have false
> +        * negatives. Allow for a discrepancy of 1 kHz either way.

This is not very clear - if kvm_caps.has_tsc_control, cur_tsc_hz is
exactly the "host TSC frequency [...] scaled by kvm_scale_tsc() with
the vCPU's l1_tsc_scaling_ratio". But even in that case there is a
double rounding issue, I guess.

> +       /*
> +        * The call to pvclock_update_vm_gtod_copy() has created a new ti=
me
> +        * reference point in ka->master_cycle_now and ka->master_kernel_=
ns.
> +        *
> +        * Calculate the guest TSC at that moment, and the corresponding =
KVM
> +        * clock value according to user_hv_clock. The value according to=
 the
> +        * current hv_clock will of course be ka->master_kernel_ns since =
no
> +        * TSC cycles have elapsed.
> +        *
> +        * Adjust ka->kvmclock_offset to the delta, so that both definiti=
ons
> +        * of the clock give precisely the same reading at the reference =
time.
> +        */
> +       guest_tsc =3D kvm_read_l1_tsc(v, ka->master_cycle_now);
> +       user_clk_ns =3D __pvclock_read_cycles(&user_hv_clock, guest_tsc);
> +       ka->kvmclock_offset =3D user_clk_ns - ka->master_kernel_ns;
> +
> +out:
> +       kvm_end_pvclock_update(kvm);
> +       return rc;
> +}
> +#endif
> +
>  long kvm_arch_vcpu_ioctl(struct file *filp,
>                          unsigned int ioctl, unsigned long arg)
>  {
> @@ -6256,6 +6404,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>                 srcu_read_unlock(&vcpu->kvm->srcu, idx);
>                 break;
>         }
> +#ifdef CONFIG_X86_64
> +       case KVM_SET_CLOCK_GUEST:
> +               r =3D kvm_vcpu_ioctl_set_clock_guest(vcpu, argp);
> +               break;
> +       case KVM_GET_CLOCK_GUEST:
> +               r =3D kvm_vcpu_ioctl_get_clock_guest(vcpu, argp);
> +               break;
> +#endif
>  #ifdef CONFIG_KVM_HYPERV
>         case KVM_GET_SUPPORTED_HV_CPUID:
>                 r =3D kvm_ioctl_get_supported_hv_cpuid(vcpu, argp);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 2190adbe3002..0d306311e4d6 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1548,4 +1548,7 @@ struct kvm_create_guest_memfd {
>         __u64 reserved[6];
>  };
>
> +#define KVM_SET_CLOCK_GUEST       _IOW(KVMIO,  0xd5, struct pvclock_vcpu=
_time_info)
> +#define KVM_GET_CLOCK_GUEST       _IOR(KVMIO,  0xd6, struct pvclock_vcpu=
_time_info)
> +
>  #endif /* __LINUX_KVM_H */
> --
> 2.44.0
>

On Thu, Apr 18, 2024 at 9:46=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: Jack Allister <jalliste@amazon.com>
>
> In the common case (where kvm->arch.use_master_clock is true), the KVM
> clock is defined as a simple arithmetic function of the guest TSC, based =
on
> a reference point stored in kvm->arch.master_kernel_ns and
> kvm->arch.master_cycle_now.
>
> The existing KVM_[GS]ET_CLOCK functionality does not allow for this
> relationship to be precisely saved and restored by userspace. All it can
> currently do is set the KVM clock at a given UTC reference time, which is
> necessarily imprecise.
>
> So on live update, the guest TSC can remain cycle accurate at precisely t=
he
> same offset from the host TSC, but there is no way for userspace to resto=
re
> the KVM clock accurately.
>
> Even on live migration to a new host, where the accuracy of the guest tim=
e-
> keeping is fundamentally limited by the accuracy of wallclock
> synchronization between the source and destination hosts, the clock jump
> experienced by the guest's TSC and its KVM clock should at least be
> *consistent*. Even when the guest TSC suffers a discontinuity, its KVM
> clock should still remain the *same* arithmetic function of the guest TSC=
,
> and not suffer an *additional* discontinuity.
>
> To allow for accurate migration of the KVM clock, add per-vCPU ioctls whi=
ch
> save and restore the actual PV clock info in pvclock_vcpu_time_info.
>
> The restoration in KVM_SET_CLOCK_GUEST works by creating a new reference
> point in time just as kvm_update_masterclock() does, and calculating the
> corresponding guest TSC value. This guest TSC value is then passed throug=
h
> the user-provided pvclock structure to generate the *intended* KVM clock
> value at that point in time, and through the *actual* KVM clock calculati=
on.
> Then kvm->arch.kvmclock_offset is adjusted to eliminate for the differenc=
e.
>
> Where kvm->arch.use_master_clock is false (because the host TSC is
> unreliable, or the guest TSCs are configured strangely), the KVM clock
> is *not* defined as a function of the guest TSC so KVM_GET_CLOCK_GUEST
> returns an error. In this case, as documented, userspace shall use the
> legacy KVM_GET_CLOCK ioctl. The loss of precision is acceptable in this
> case since the clocks are imprecise in this mode anyway.
>
> On *restoration*, if kvm->arch.use_master_clock is false, an error is
> returned for similar reasons and userspace shall fall back to using
> KVM_SET_CLOCK. This does mean that, as documented, userspace needs to use
> *both* KVM_GET_CLOCK_GUEST and KVM_GET_CLOCK and send both results with t=
he
> migration data (unless the intent is to refuse to resume on a host with b=
ad
> TSC).
>
> (It may have been possible to make KVM_SET_CLOCK_GUEST "good enough" in t=
he
> non-masterclock mode, as that mode is necessarily imprecise anyway. The
> explicit fallback allows userspace to deliberately fail migration to a ho=
st
> with misbehaving TSC where master clock mode wouldn't be active.)
>
> Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Jack Allister <jalliste@amazon.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> CC: Paul Durrant <paul@xen.org>
> CC: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  Documentation/virt/kvm/api.rst |  37 ++++++++
>  arch/x86/kvm/x86.c             | 156 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h       |   3 +
>  3 files changed, 196 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index f0b76ff5030d..758f6fc08fe5 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6352,6 +6352,43 @@ a single guest_memfd file, but the bound ranges mu=
st not overlap).
>
>  See KVM_SET_USER_MEMORY_REGION2 for additional details.
>
> +4.143 KVM_GET_CLOCK_GUEST
> +----------------------------
> +
> +:Capability: none
> +:Architectures: x86_64
> +:Type: vcpu ioctl
> +:Parameters: struct pvclock_vcpu_time_info (out)
> +:Returns: 0 on success, <0 on error
> +
> +Retrieves the current time information structure used for KVM/PV clocks,
> +in precisely the form advertised to the guest vCPU, which gives paramete=
rs
> +for a direct conversion from a guest TSC value to nanoseconds.
> +
> +When the KVM clock not is in "master clock" mode, for example because th=
e
> +host TSC is unreliable or the guest TSCs are oddly configured, the KVM c=
lock
> +is actually defined by the host CLOCK_MONOTONIC_RAW instead of the guest=
 TSC.
> +In this case, the KVM_GET_CLOCK_GUEST ioctl returns -EINVAL.
> +
> +4.144 KVM_SET_CLOCK_GUEST
> +----------------------------
> +
> +:Capability: none
> +:Architectures: x86_64
> +:Type: vcpu ioctl
> +:Parameters: struct pvclock_vcpu_time_info (in)
> +:Returns: 0 on success, <0 on error
> +
> +Sets the KVM clock (for the whole VM) in terms of the vCPU TSC, using th=
e
> +pvclock structure as returned by KVM_GET_CLOCK_GUEST. This allows the pr=
ecise
> +arithmetic relationship between guest TSC and KVM clock to be preserved =
by
> +userspace across migration.
> +
> +When the KVM clock is not in "master clock" mode, and the KVM clock is a=
ctually
> +defined by the host CLOCK_MONOTONIC_RAW, this ioctl returns -EINVAL. Use=
rspace
> +may choose to set the clock using the less precise KVM_SET_CLOCK ioctl, =
or may
> +choose to fail, denying migration to a host whose TSC is misbehaving.
> +
>  5. The kvm_run structure
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 23281c508c27..42abce7b4fc9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5868,6 +5868,154 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_v=
cpu *vcpu,
>         }
>  }
>
> +#ifdef CONFIG_X86_64
> +static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __use=
r *argp)
> +{
> +       struct pvclock_vcpu_time_info *hv_clock =3D &v->arch.hv_clock;
> +
> +       /*
> +        * If KVM_REQ_CLOCK_UPDATE is already pending, or if the hv_clock=
 has
> +        * never been generated at all, call kvm_guest_time_update() to d=
o so.
> +        * Might as well use the PVCLOCK_TSC_STABLE_BIT as the check for =
ever
> +        * having been written.
> +        */
> +       if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, v) ||
> +           !(hv_clock->flags & PVCLOCK_TSC_STABLE_BIT)) {
> +               if (kvm_guest_time_update(v))
> +                       return -EINVAL;
> +       }
> +
> +       /*
> +        * PVCLOCK_TSC_STABLE_BIT is set in use_master_clock mode where t=
he
> +        * KVM clock is defined in terms of the guest TSC. Otherwise, it =
is
> +        * is defined by the host CLOCK_MONOTONIC_RAW, and userspace shou=
ld
> +        * use the legacy KVM_[GS]ET_CLOCK to migrate it.
> +        */
> +       if (!(hv_clock->flags & PVCLOCK_TSC_STABLE_BIT))
> +               return -EINVAL;
> +
> +       if (copy_to_user(argp, hv_clock, sizeof(*hv_clock)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +/*
> + * Reverse the calculation in the hv_clock definition.
> + *
> + * time_ns =3D ( (cycles << shift) * mul ) >> 32;
> + * (although shift can be negative, so that's bad C)
> + *
> + * So for a single second,
> + *  NSEC_PER_SEC =3D ( ( FREQ_HZ << shift) * mul ) >> 32
> + *  NSEC_PER_SEC << 32 =3D ( FREQ_HZ << shift ) * mul
> + *  ( NSEC_PER_SEC << 32 ) / mul =3D FREQ_HZ << shift
> + *  ( NSEC_PER_SEC << 32 ) / mul ) >> shift =3D FREQ_HZ
> + */
> +static uint64_t hvclock_to_hz(uint32_t mul, int8_t shift)
> +{
> +       uint64_t tm =3D NSEC_PER_SEC << 32;
> +
> +       /* Maximise precision. Shift right until the top bit is set */
> +       tm <<=3D 2;
> +       shift +=3D 2;
> +
> +       /* While 'mul' is even, increase the shift *after* the division *=
/
> +       while (!(mul & 1)) {
> +               shift++;
> +               mul >>=3D 1;
> +       }
> +
> +       tm /=3D mul;
> +
> +       if (shift > 0)
> +               return tm >> shift;
> +       else
> +               return tm << -shift;
> +}
> +
> +static int kvm_vcpu_ioctl_set_clock_guest(struct kvm_vcpu *v, void __use=
r *argp)
> +{
> +       struct pvclock_vcpu_time_info user_hv_clock;
> +       struct kvm *kvm =3D v->kvm;
> +       struct kvm_arch *ka =3D &kvm->arch;
> +       uint64_t curr_tsc_hz, user_tsc_hz;
> +       uint64_t user_clk_ns;
> +       uint64_t guest_tsc;
> +       int rc =3D 0;
> +
> +       if (copy_from_user(&user_hv_clock, argp, sizeof(user_hv_clock)))
> +               return -EFAULT;
> +
> +       if (!user_hv_clock.tsc_to_system_mul)
> +               return -EINVAL;
> +
> +       user_tsc_hz =3D hvclock_to_hz(user_hv_clock.tsc_to_system_mul,
> +                                   user_hv_clock.tsc_shift);
> +
> +
> +       kvm_hv_request_tsc_page_update(kvm);
> +       kvm_start_pvclock_update(kvm);
> +       pvclock_update_vm_gtod_copy(kvm);
> +
> +       /*
> +        * If not in use_master_clock mode, do not allow userspace to set
> +        * the clock in terms of the guest TSC. Userspace should either
> +        * fail the migration (to a host with suboptimal TSCs), or should
> +        * knowingly restore the KVM clock using KVM_SET_CLOCK instead.
> +        */
> +       if (!ka->use_master_clock) {
> +               rc =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       curr_tsc_hz =3D get_cpu_tsc_khz() * 1000LL;
> +       if (unlikely(curr_tsc_hz =3D=3D 0)) {
> +               rc =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (kvm_caps.has_tsc_control)
> +               curr_tsc_hz =3D kvm_scale_tsc(curr_tsc_hz,
> +                                           v->arch.l1_tsc_scaling_ratio)=
;
> +
> +       /*
> +        * The scaling factors in the hv_clock do not depend solely on th=
e
> +        * TSC frequency *requested* by userspace. They actually use the
> +        * host TSC frequency that was measured/detected by the host kern=
el,
> +        * scaled by kvm_scale_tsc() with the vCPU's l1_tsc_scaling_ratio=
.
> +        *
> +        * So a sanity check that they *precisely* match would have false
> +        * negatives. Allow for a discrepancy of 1 kHz either way.
> +        */
> +       if (user_tsc_hz < curr_tsc_hz - 1000 ||
> +           user_tsc_hz > curr_tsc_hz + 1000) {
> +               rc =3D -ERANGE;
> +               goto out;
> +       }
> +
> +       /*
> +        * The call to pvclock_update_vm_gtod_copy() has created a new ti=
me
> +        * reference point in ka->master_cycle_now and ka->master_kernel_=
ns.
> +        *
> +        * Calculate the guest TSC at that moment, and the corresponding =
KVM
> +        * clock value according to user_hv_clock. The value according to=
 the
> +        * current hv_clock will of course be ka->master_kernel_ns since =
no
> +        * TSC cycles have elapsed.
> +        *
> +        * Adjust ka->kvmclock_offset to the delta, so that both definiti=
ons
> +        * of the clock give precisely the same reading at the reference =
time.
> +        */
> +       guest_tsc =3D kvm_read_l1_tsc(v, ka->master_cycle_now);
> +       user_clk_ns =3D __pvclock_read_cycles(&user_hv_clock, guest_tsc);
> +       ka->kvmclock_offset =3D user_clk_ns - ka->master_kernel_ns;
> +
> +out:
> +       kvm_end_pvclock_update(kvm);
> +       return rc;
> +}
> +#endif
> +
>  long kvm_arch_vcpu_ioctl(struct file *filp,
>                          unsigned int ioctl, unsigned long arg)
>  {
> @@ -6256,6 +6404,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>                 srcu_read_unlock(&vcpu->kvm->srcu, idx);
>                 break;
>         }
> +#ifdef CONFIG_X86_64
> +       case KVM_SET_CLOCK_GUEST:
> +               r =3D kvm_vcpu_ioctl_set_clock_guest(vcpu, argp);
> +               break;
> +       case KVM_GET_CLOCK_GUEST:
> +               r =3D kvm_vcpu_ioctl_get_clock_guest(vcpu, argp);
> +               break;
> +#endif
>  #ifdef CONFIG_KVM_HYPERV
>         case KVM_GET_SUPPORTED_HV_CPUID:
>                 r =3D kvm_ioctl_get_supported_hv_cpuid(vcpu, argp);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 2190adbe3002..0d306311e4d6 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1548,4 +1548,7 @@ struct kvm_create_guest_memfd {
>         __u64 reserved[6];
>  };
>
> +#define KVM_SET_CLOCK_GUEST       _IOW(KVMIO,  0xd5, struct pvclock_vcpu=
_time_info)
> +#define KVM_GET_CLOCK_GUEST       _IOR(KVMIO,  0xd6, struct pvclock_vcpu=
_time_info)
> +
>  #endif /* __LINUX_KVM_H */
> --
> 2.44.0
>


