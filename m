Return-Path: <linux-kselftest+bounces-21410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C29F9BC0A5
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 23:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F3D282B71
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 22:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2CE1FDFA3;
	Mon,  4 Nov 2024 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSQcESI4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501B1FDF83
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758421; cv=none; b=axOFU4TxMcKA+HxleZUawh0zKTmfzn8Oo3r5JzcUX6jhMiesM10LjguSU5T3QdbPC4rP+fB8Kne6+hnLunI0X1Vp/7vGV4HLgyUDKU6sKzaNEz01RRU5vpzfYN9TrkPjVPXiq1It/YEhtYEcR71w0euPraGaAab7vSuxehWIGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758421; c=relaxed/simple;
	bh=cJ2iwD6JRX1oQ7TlSGkMpG6bt4+iE1zrhCDc/1XXcoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQmjPWCGzuWyJ3MV0LKZpNomFl8u/nf/xoM7WgE+RhG2dRMz+EIDxyVc3UGdY4T9MiFIrbnpOZL9GmqtenSqhHSFYSracjs3k313wUmKbZojePbPYzOR7QGufB7ie9K5IZcXeB0G8057VMYbs9GUNmMhl6A1T9vNcNzlrk/84Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSQcESI4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730758417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+n54qAXwoDA0o8dpKjuMOMxb/8VNmkgzn+Qg2NOh5q8=;
	b=hSQcESI4UsQhOCpAc02g9juZOGF/CZfm8eRSUxmYAsqkYrj5Il8ySh/sLu7cfjDS0QO+Vz
	bGain6sv0uQB1H/hpslgjLoFJ76wZVtRfM13EyX/EWtTzxS98lTBuAt45Fdo9zWhiceo7T
	v3bGWdy1lqeQkolyJmNmck+PvVxDxsg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-mzN2cCEtNw63D6EeFxIP7Q-1; Mon, 04 Nov 2024 17:13:35 -0500
X-MC-Unique: mzN2cCEtNw63D6EeFxIP7Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a01cba9f7so341355366b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 14:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758412; x=1731363212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+n54qAXwoDA0o8dpKjuMOMxb/8VNmkgzn+Qg2NOh5q8=;
        b=lXe9honG2fT21WxaVIbwpWGqKjnZlcSkTTAtMquzhGuDmn2STbUA7GTyL4jedJ6KjD
         T9EKB9+LpiGZJNMoMApyqzNbVXb7OW8/cdAK7NoioV6MT5bvZ+BCDyT2HAkdEBWrrThc
         LwF6ujG1ytPoiF4ua2t3JfFFm/t16E8KLL3cWEbM+hgJVD5BYZh53HKqNyUwq5p77IKc
         GYWofDoTPvknKIKgEND3EY/RMLWoS4OLchFPVZhBo2fTGIajHlsr47jGj8Eqq0ehpuqA
         Hh8BocTInIlPzZuRvrxyfxShyr7FpeCoS3H2+/f8pJNvguXq9lUhcvyp2R9CYKrOBQsi
         JDnw==
X-Forwarded-Encrypted: i=1; AJvYcCWpI7ZS1bUAwZFrJaPSgvUsj3m9SxrFMRKh6FGzH95iMte+N3CtemXbRxk4Cblr8YAkJD7wsizipt1JHpQoBBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuzJfzGQysmNtjmQ+EybRCPRHuQBwiK6gdCejEYGrwxqRZfkJg
	luhR5Y/Nw5edyfeqIUBGe2Aa73UqN3c8ofuf1gfaMgL4oaw4UzaW3qPe8nfCcslAQY8TjOhCjz+
	FwSUgEGma4XYw2CGkChRdf57qGIcAq8DsmD+OQbSfvwmPZ1rQQ8ZMpoICURfjEw/skG8/FOunLH
	A6Jb0DhGkE1AkzDQk8KU/EaePMsyCCK57EspB7x9lH
X-Received: by 2002:a17:906:bc02:b0:a9e:b150:a99d with SMTP id a640c23a62f3a-a9eb150ac01mr87097966b.5.1730758412403;
        Mon, 04 Nov 2024 14:13:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH2wZtDD4ih8RSP9Ec74C122Mrbbr52FxVrmRQ+KVDAu3AMFOkZE+zT7hfkabKsdI7s2BGZw234GeAMJiwEY8=
X-Received: by 2002:a17:906:bc02:b0:a9e:b150:a99d with SMTP id
 a640c23a62f3a-a9eb150ac01mr87095466b.5.1730758411924; Mon, 04 Nov 2024
 14:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030033514.1728937-1-zack.rusin@broadcom.com> <20241030033514.1728937-3-zack.rusin@broadcom.com>
In-Reply-To: <20241030033514.1728937-3-zack.rusin@broadcom.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 4 Nov 2024 23:13:19 +0100
Message-ID: <CABgObfaRP6zKNhrO8_atGDLcHs=uvE0aT8cPKnt_vNHHM+8Nxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: kvm@vger.kernel.org, Doug Covelli <doug.covelli@broadcom.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Joel Stanley <joel@jms.id.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:35=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com=
> wrote:
>
> VMware products handle hypercalls in userspace. Give KVM the ability
> to run VMware guests unmodified by fowarding all hypercalls to the
> userspace.
>
> Enabling of the KVM_CAP_X86_VMWARE_HYPERCALL_ENABLE capability turns
> the feature on - it's off by default. This allows vmx's built on top
> of KVM to support VMware specific hypercalls.

Hi Zack,

is there a spec of the hypercalls that are supported by userspace? I
would like to understand if there's anything that's best handled in
the kernel.

If we allow forwarding _all_ hypercalls to userspace, then people will
use it for things other than VMware and there goes all hope of
accelerating stuff in the kernel in the future.

So even having _some_ checks in the kernel before going out to
userspace would keep that door open, or at least try.

Patch 1 instead looks good from an API point of view.

Paolo

> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Doug Covelli <doug.covelli@broadcom.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> ---
>  Documentation/virt/kvm/api.rst  | 41 +++++++++++++++++++++++++++++----
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/x86.c              | 33 ++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h        |  1 +
>  4 files changed, 72 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 33ef3cc785e4..5a8c7922f64f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6601,10 +6601,11 @@ to the byte array.
>  .. note::
>
>        For KVM_EXIT_IO, KVM_EXIT_MMIO, KVM_EXIT_OSI, KVM_EXIT_PAPR, KVM_E=
XIT_XEN,
> -      KVM_EXIT_EPR, KVM_EXIT_X86_RDMSR and KVM_EXIT_X86_WRMSR the corres=
ponding
> -      operations are complete (and guest state is consistent) only after=
 userspace
> -      has re-entered the kernel with KVM_RUN.  The kernel side will firs=
t finish
> -      incomplete operations and then check for pending signals.
> +      KVM_EXIT_EPR, KVM_EXIT_HYPERCALL, KVM_EXIT_X86_RDMSR and KVM_EXIT_=
X86_WRMSR
> +      the corresponding operations are complete (and guest state is cons=
istent)
> +      only after userspace has re-entered the kernel with KVM_RUN. The k=
ernel
> +      side will first finish incomplete operations and then check for pe=
nding
> +      signals.
>
>        The pending state of the operation is not preserved in state which=
 is
>        visible to userspace, thus userspace should ensure that the operat=
ion is
> @@ -8201,6 +8202,38 @@ default value for it is set via the kvm.enable_vmw=
are_backdoor
>  kernel parameter (false when not set). Must be set before any
>  VCPUs have been created.
>
> +7.38 KVM_CAP_X86_VMWARE_HYPERCALL
> +---------------------------------
> +
> +:Architectures: x86
> +:Parameters: args[0] whether the feature should be enabled or not
> +:Returns: 0 on success.
> +
> +Capability allows userspace to handle hypercalls. When enabled
> +whenever the vcpu has executed a VMCALL(Intel) or a VMMCALL(AMD)
> +instruction kvm will exit to userspace with KVM_EXIT_HYPERCALL.
> +
> +On exit the hypercall structure of the kvm_run structure will
> +look as follows:
> +
> +::
> +   /* KVM_EXIT_HYPERCALL */
> +   struct {
> +      __u64 nr;      // rax
> +      __u64 args[6]; // rbx, rcx, rdx, rsi, rdi, rbp
> +      __u64 ret;     // cpl, whatever userspace
> +                     // sets this to on return will be
> +                     // written to the rax
> +      __u64 flags;   // KVM_EXIT_HYPERCALL_LONG_MODE if
> +                     // the hypercall was executed in
> +                     // 64bit mode, 0 otherwise
> +   } hypercall;
> +
> +Except when running in compatibility mode with VMware hypervisors
> +userspace handling of hypercalls is discouraged. To implement
> +such functionality, use KVM_EXIT_IO (x86) or KVM_EXIT_MMIO
> +(all except s390).
> +
>  8. Other capabilities.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 7fcf185e337f..7fbb11682517 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1404,6 +1404,7 @@ struct kvm_arch {
>         struct kvm_xen xen;
>  #endif
>         bool vmware_backdoor_enabled;
> +       bool vmware_hypercall_enabled;
>
>         bool backwards_tsc_observed;
>         bool boot_vcpu_runs_old_kvmclock;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d7071907d6a5..b676c54266e7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4689,6 +4689,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>         case KVM_CAP_MEMORY_FAULT_INFO:
>         case KVM_CAP_X86_GUEST_MODE:
>         case KVM_CAP_X86_VMWARE_BACKDOOR:
> +       case KVM_CAP_X86_VMWARE_HYPERCALL:
>                 r =3D 1;
>                 break;
>         case KVM_CAP_PRE_FAULT_MEMORY:
> @@ -6784,6 +6785,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>                 }
>                 mutex_unlock(&kvm->lock);
>                 break;
> +       case KVM_CAP_X86_VMWARE_HYPERCALL:
> +               r =3D -EINVAL;
> +               if (cap->args[0] & ~1)
> +                       break;
> +               kvm->arch.vmware_hypercall_enabled =3D cap->args[0];
> +               r =3D 0;
> +               break;
>         default:
>                 r =3D -EINVAL;
>                 break;
> @@ -10127,6 +10135,28 @@ static int complete_hypercall_exit(struct kvm_vc=
pu *vcpu)
>         return kvm_skip_emulated_instruction(vcpu);
>  }
>
> +static int kvm_vmware_hypercall(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_run *run =3D vcpu->run;
> +       bool is_64_bit =3D is_64_bit_hypercall(vcpu);
> +       u64 mask =3D is_64_bit ? U64_MAX : U32_MAX;
> +
> +       vcpu->run->hypercall.flags =3D is_64_bit ? KVM_EXIT_HYPERCALL_LON=
G_MODE : 0;
> +       run->hypercall.nr =3D kvm_rax_read(vcpu) & mask;
> +       run->hypercall.args[0] =3D kvm_rbx_read(vcpu) & mask;
> +       run->hypercall.args[1] =3D kvm_rcx_read(vcpu) & mask;
> +       run->hypercall.args[2] =3D kvm_rdx_read(vcpu) & mask;
> +       run->hypercall.args[3] =3D kvm_rsi_read(vcpu) & mask;
> +       run->hypercall.args[4] =3D kvm_rdi_read(vcpu) & mask;
> +       run->hypercall.args[5] =3D kvm_rbp_read(vcpu) & mask;
> +       run->hypercall.ret =3D kvm_x86_call(get_cpl)(vcpu);
> +
> +       run->exit_reason =3D KVM_EXIT_HYPERCALL;
> +       vcpu->arch.complete_userspace_io =3D complete_hypercall_exit;
> +
> +       return 0;
> +}
> +
>  unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned lo=
ng nr,
>                                       unsigned long a0, unsigned long a1,
>                                       unsigned long a2, unsigned long a3,
> @@ -10225,6 +10255,9 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>         int op_64_bit;
>         int cpl;
>
> +       if (vcpu->kvm->arch.vmware_hypercall_enabled)
> +               return kvm_vmware_hypercall(vcpu);
> +
>         if (kvm_xen_hypercall_enabled(vcpu->kvm))
>                 return kvm_xen_hypercall(vcpu);
>
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index c7b5f1c2ee1c..4c2cc6ed29a0 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -934,6 +934,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
>  #define KVM_CAP_X86_GUEST_MODE 238
>  #define KVM_CAP_X86_VMWARE_BACKDOOR 239
> +#define KVM_CAP_X86_VMWARE_HYPERCALL 240
>
>  struct kvm_irq_routing_irqchip {
>         __u32 irqchip;
> --
> 2.43.0
>


