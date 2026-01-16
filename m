Return-Path: <linux-kselftest+bounces-49086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A9DD2B533
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 05:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8C9B308AC0D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 04:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D0B346799;
	Fri, 16 Jan 2026 04:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vr5Shc5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC23451AE
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 04:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768537422; cv=pass; b=XBXZMI/vkgY/ynySWBsXh5MgsjZe1XBez5wixhvwsFoz2Zxd1ND2SC78A5DXvFF5sKyaMEP+jNenYFmsX6R93ZadSwFsXOAHEPqg8nu/4A3Dc3eWSaieN9xQRD8jI/5T+iZn+3AARnOXlzC3gy9ee3kZUXvzmGiMDkjjyhSV7o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768537422; c=relaxed/simple;
	bh=t9W/scSXovPATZ+gq3bWTCsz5jE4rtYjFSKZcQ2zPks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Fdr/SENfAlXKlXRtjQYHmBlhXD17mmXsfatE9/GgKaFic6xOqQGPwCoFGdy/rGsHBVL7Tx6PYqPfsiBNiHOp3VuOofaMADTA6e+F+YnCXY7/n3GB0BG6r8KTJKndAiwFON2dI3balXKIFNpIGE26R+rqMl1F9180xS3SJkhJXDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vr5Shc5; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6505d147ce4so4750a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 20:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768537418; cv=none;
        d=google.com; s=arc-20240605;
        b=guYRAlfIC1ob1dwDZin96JgBKdOuQW4+RQnXFO0bPSquqNcwRruXl1VZ1OFY5B0FeQ
         fgMyJtgW1xPo2wXCr/MjkM3CZFZaWXPoXN9mtizFLd/mEfK/4Ea9kGrv+ghRFFz5Ir1Q
         zgbgyvvxeXhTFf4YpEf+0zviz0o+FMmXYJTPDDasa6nCexYAx8gyNrbyzmklH2E0Zx1l
         bB/2K2o4Tuu1LOmtsclMrMqZVo7C+8kBijgBKtt0d3wv8pBDUGpfZ3yZ9obo3SCpZ9cx
         F1aZrvlM0bfZ/MQOZnokSvONDt0t7AX3o12wyFE/sqwuL/tE77z91WGL9VklNVeXhPQQ
         ELGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CQBnNlpZCgFRekPGXIOEqkC5tJTqz8MzcUs9mWtjz+I=;
        fh=i5KKDnj4/4XUo6Q0HQGoDs0CCpyAsLvbvmMLLNmVkeg=;
        b=EeDiADlMPLliupSkhZfTty5XqaImU8OW/EMII4zB3tsPpWfjB4qH4nD7ewCpEcP/hf
         D9t4Hu2dT/z1+Hgk3itDMiZbl6hxeYCtC9GaW0MyhWKY4uvjhdgzPHCa3avumUFF69Vx
         ONWOO5othFUJJ7rMNWQw8XOOrCaNsBYwbWCAbbJYFZ4YdfekOSN566E9p4QusoKXjI7p
         OnZyUMnhvoGX1QHGjIiqxhHO6jjKhOJdzoXL2Z8HOtDLjMn8nsovH3pDwbnKpSc6miHV
         IUSowRcpiAQMUM7QX3KcTilTn/iRcrXvRmVraDCkueCdqwjmej7BkQJoqIlys7IgLwq7
         iBxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768537418; x=1769142218; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQBnNlpZCgFRekPGXIOEqkC5tJTqz8MzcUs9mWtjz+I=;
        b=4vr5Shc5il0eVKwj+zgp+iu3NPwgvb6L33NSZ+LCCzo3QwlSnnc6o+zXobQvnpX1Sh
         Azf1HGasfTxSdyFb7rL3ygtG8GTCwjIWAXFr0pwV/pbjetgXwV+DflmNsjARYnFNr/3G
         6+R/p5M6qf48TG+TXVWzv2h3dnpGs0MpJf+ZlGuvigJpejNYH8wIx7Q9zt4XS9hUvGhF
         1tuLhDvbGebk2BOzXNhJSl3yqYWlq4dRyqQ4rjJ7SdWF9cRDGIlco/Mb0kWqiCbY2UbW
         Wa3mjlOK3mQfrq/npj5vKva3AxE4g6BJr54BkSS+XLPErgiwixWjVoDW78o5iIO6Rfgc
         2FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768537418; x=1769142218;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CQBnNlpZCgFRekPGXIOEqkC5tJTqz8MzcUs9mWtjz+I=;
        b=CkoeDE1v62L8ejh23qz+hP6HQZnFiwGNhARFr6guGbOcEdFKITkrV/kUqohVwB+k+Z
         ltIH2DnhWCzXeVEcvwfIh3KkYIlp23ZvsVctYWqXqvwaGqE2VL3t4skqpKmRwMomSId0
         EuT7WzjHGILs5V2ErxHvy86y3mtudTq8IFtoyjebfNuuSVfr38Zx97A08EK8Xu4xDBvz
         Cqn4vTMZjkZsSpXHZXMtyqHRP+y1jSdsTks/chzHXnuWPa24JmOZPHFwfJK/T/kxT4de
         MwAJmsSoDXeeRnxavIXFiJ7BhRQwchIq95EcuZVxzMN4ReogGmbYWdTvg3+JQEUYTCQu
         zxHA==
X-Forwarded-Encrypted: i=1; AJvYcCWuB03jwg9QOGnmkhvMDrty5aYG5vqmUNjoJmw/gr2vRb1A5+YidfCh8Da7gw/sPod6NClfsmapYByLgB9B5uE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6blrYMQDfBZI6FAIo3WdU9P0AXQDJfEAqD9DAkpzUo7yvIzNQ
	UlxLg+PodKEY654+GvZxiaUAd9enbw5ZGV5y5CkvimuKUTRSbxw53DI1M0r4GUNywMlDxfXZkKS
	d5nsHqZrIuMYBTvB/Qe2rJXv9BpCbt0KSMEm98kB8
X-Gm-Gg: AY/fxX5SXPf2gs+nPqyABWMLB8MYcaePe4CyOxjJY/6s+Lg+5Fqt7IOQk8m3vfVOLa1
	awo2pSTAhgmsGw13hi5JOzCJbuHWFAS13k23BcXpOJU9anjevisVzz6rWsHH0jhWRrR27lSC1jj
	SpkHSmMm/dYycKT1ulxz/gAvy0RQ4J0540sfrczfKuJ4e5K/a8ePgkcHtqe2B5zmKNYIZdwFRfE
	6HW2PEIu0gRgFLJa17IgAa3RUis5HcO1FKHtzac2YKy9BoVrfZJWUmNQTqeIvBveGG6G/s=
X-Received: by 2002:a05:6402:345b:b0:649:8aa1:e524 with SMTP id
 4fb4d7f45d1cf-655251ec768mr12527a12.11.1768537418027; Thu, 15 Jan 2026
 20:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115232154.3021475-1-jmattson@google.com> <20260115232154.3021475-7-jmattson@google.com>
In-Reply-To: <20260115232154.3021475-7-jmattson@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Jan 2026 20:23:26 -0800
X-Gm-Features: AZwV_QiDkq2kwy7nbR9fUAEWefj2zSCFllDeLOP7A8FMqaeIEAaTMQ6drundYUU
Message-ID: <CALMp9eRGSoQGu9R7CYqgRERY=x-_=59bHvEab-t519u8n6nmWA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:22=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> Add a 'flags' field to the SVM nested state header, and use bit 0 of the
> flags to indicate that gPAT is stored in the nested state.
>
> If in guest mode with NPT enabled, store the current vmcb->save.g_pat val=
ue
> into the vmcb save area of the nested state, and set the flag.
>
> Note that most of the vmcb save area in the nested state is populated wit=
h
> dead (and potentially already clobbered) vmcb01 state. A few fields hold =
L1
> state to be restored at VMEXIT. Previously, the g_pat field was in the
> former category.
>
> Also note that struct kvm_svm_nested_state_hdr is included in a union
> padded to 120 bytes, so there is room to add the flags field without
> changing any offsets.
>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/include/uapi/asm/kvm.h |  3 +++
>  arch/x86/kvm/svm/nested.c       | 13 ++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/=
kvm.h
> index 7ceff6583652..80157b9597db 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -495,6 +495,8 @@ struct kvm_sync_regs {
>
>  #define KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE        0x00000001
>
> +#define KVM_STATE_SVM_VALID_GPAT       BIT(0)
> +
>  /* vendor-independent attributes for system fd (group 0) */
>  #define KVM_X86_GRP_SYSTEM             0
>  #  define KVM_X86_XCOMP_GUEST_SUPP     0
> @@ -530,6 +532,7 @@ struct kvm_svm_nested_state_data {
>
>  struct kvm_svm_nested_state_hdr {
>         __u64 vmcb_pa;
> +       __u32 flags;
>  };
>
>  /* for KVM_CAP_NESTED_STATE */
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 5fb31faf2b46..c50fb7172672 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1789,6 +1789,8 @@ static int svm_get_nested_state(struct kvm_vcpu *vc=
pu,
>         /* First fill in the header and copy it out.  */
>         if (is_guest_mode(vcpu)) {
>                 kvm_state.hdr.svm.vmcb_pa =3D svm->nested.vmcb12_gpa;
> +               if (nested_npt_enabled(svm))
> +                       kvm_state.hdr.svm.flags |=3D KVM_STATE_SVM_VALID_=
GPAT;
>                 kvm_state.size +=3D KVM_STATE_NESTED_SVM_VMCB_SIZE;
>                 kvm_state.flags |=3D KVM_STATE_NESTED_GUEST_MODE;
>
> @@ -1823,6 +1825,11 @@ static int svm_get_nested_state(struct kvm_vcpu *v=
cpu,
>         if (r)
>                 return -EFAULT;
>
> +       /*
> +        * vmcb01->save.g_pat is dead now, so it is safe to overwrite it =
with
> +        * vmcb02->save.g_pat, whether or not nested NPT is enabled.
> +        */
> +       svm->vmcb01.ptr->save.g_pat =3D svm->vmcb->save.g_pat;

Is this too disgusting? Should I extend the payload by 8 bytes
instead? It seems like such a waste, since most of the save area is
dead/unused. Maybe I could define a new sparse save state structure,
with the ~200 bytes that are currently used, surrounded by padding for
the other 500+ bytes. Then, I could just grab 8 bytes of the padding,
and it wouldn't seem quite as hacky .

>         if (copy_to_user(&user_vmcb->save, &svm->vmcb01.ptr->save,
>                          sizeof(user_vmcb->save)))
>                 return -EFAULT;
> @@ -1904,7 +1911,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vc=
pu,
>                 goto out_free;
>
>         /*
> -        * Validate host state saved from before VMRUN (see
> +        * Validate host state saved from before VMRUN and gPAT (see
>          * nested_svm_check_permissions).
>          */
>         __nested_copy_vmcb_save_to_cache(&save_cached, save);
> @@ -1951,6 +1958,10 @@ static int svm_set_nested_state(struct kvm_vcpu *v=
cpu,
>         if (ret)
>                 goto out_free;
>
> +       if (is_guest_mode(vcpu) && nested_npt_enabled(svm) &&
> +           (kvm_state.hdr.svm.flags & KVM_STATE_SVM_VALID_GPAT))
> +               svm->vmcb->save.g_pat =3D save_cached.g_pat;
> +
>         svm->nested.force_msr_bitmap_recalc =3D true;
>
>         kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
> --
> 2.52.0.457.g6b5491de43-goog
>

