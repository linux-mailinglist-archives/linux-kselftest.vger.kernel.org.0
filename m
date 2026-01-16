Return-Path: <linux-kselftest+bounces-49085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA0ED2B2C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 05:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0164301394B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1CD33B6D4;
	Fri, 16 Jan 2026 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuN7iSoz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D59A2236E3
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 04:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536529; cv=pass; b=ACPj9OejEqAQATM2PdLFKMTj3Ejb7F48rzENpVXchFu6Fzg/vb/mbU47QZD6lvdrRHC6ekZ5KnaFpMtf0Akn0ofWM/Jav3cjj3cAZkckTCPQCK83gsYOUZvfNGSL4CdSPTp5kUU9airoqwuNmryCqpQ/Z/7KHlnMf4g4LG/cOOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536529; c=relaxed/simple;
	bh=gcymO8sHuZHD/0eIBqHyPY2wUAyeD3kg4ZgHuJZwI4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Bxx5ztC3tab9ycrL4cg0H9NivyIUhwxVErITSKO3X/RKoikDpazck2n5lQkXEKv/ZOpUt4Wbqn1gajnjLEPTdp8BDTTANLk8/TJsmxHmMIt5FubT6ICYyJW8ZxEWPe8iO7Ojs4YFaJehzlC2DfO+PE7mBa5i8XxuU5xFMhz8DK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cuN7iSoz; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so5473a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 20:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768536526; cv=none;
        d=google.com; s=arc-20240605;
        b=Jd83je1py6gk5Dx9pq5YQi5z0ykHckDNb/h+ZkRam+cifDyYnVzP6U2hwBNCTIfgMb
         HA+gtwlMrAEzKWYlJ/IAcvaLnpD7JswaR52xLExIH/2Z+3urhgKJD97jKmuDXLsQiHJA
         XYqhVFRAkleZHqbk52LnFrZ2QbhApFCYEQWXHm14PtlcGq4BoyIfnYD1buhstYd4Q9HI
         N/wkvKfPXe0f2EBlDHNYgf154IemY+1+jIbBQMaBKr/V4PhuFynFWac3Y1ZS6rHbCafX
         VTt9dkj6pIwBXHj00d02NCVI5RyOpkujL7lYcFB4wrGNpwusvtha5IfJODfkG/6lLBdo
         du/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jteGael7iAM+Ic4XgubDec8+SIAMb6wVEDTLznw2Hvk=;
        fh=1lKsT+JDRLoAs9M9EXJoZ1Q07AGNq/Ua6kmcVMd5Q5g=;
        b=F+IM/bZSJFDlWDd5t4bFTE9Zic9RuAfgFqbqsml4aX+H93wNBsPjF3txu4ihupl7du
         kBJHAl7eSq2SK5zB1JP9tZQOjv+52bTe4jDQJ0Yvx4ZHNcsrf6JTH2FKGyQD6raahb7j
         8kRJ7T3WYHPUl2S8rMhLUQJgztcnO+j7T4QJbW6SkIvogwvUcBEh+2QhygoiG4tdDqBv
         sUj0Vx9JNK5n3xnblrYIwPgGVNywJjCHlgrZxMLuwvx7wPxUq4BhBy/I5Ou31wz9nlgu
         LEOY7QOQumqpU/hyH0+o5nuWPCUifWaUtThOBccgnZMYZL0g9ZttqobP4k9gMCZa/c2F
         Pz+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768536526; x=1769141326; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jteGael7iAM+Ic4XgubDec8+SIAMb6wVEDTLznw2Hvk=;
        b=cuN7iSoznbLRFbttQl3l2ZzsTjOlbUaEekSSiOO5hPszSg0aC5dAG6pSv07aLQM+3P
         TDXR081GskG6ZxFLZWzJCIQcO4dByUkJwrN56527irxxJFEWeBgC1P8f4gqAt0Y2L12W
         pd3Ab+UsH8VkWgqR+HHNXEhifs6M0rOwzqCAgKU3iE7q9+CWfxo4j8NDw9gFqn0t2p1r
         J4znhFT4Qcyyf5Ju+zukMcJoftdjWJ4YQ1Vg7OtAv/pbzErrdQ9OXRjrBB5ohc0BM7Vf
         rkLdasd8MfZwPhooPpniVqe5kSdfVg3jM7AFjwyfOb7dEQ8tipIltb1s6Am8D0HHP/Kw
         rdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768536526; x=1769141326;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jteGael7iAM+Ic4XgubDec8+SIAMb6wVEDTLznw2Hvk=;
        b=XsUVG6mMhWj7XWB/AeSLvJD6gFXvNY9VRd9D8O71cQHCEsh9IYfsl9UIlFaQPZ7VUW
         d0RmSklHVLQJ3Es1Zo9MG4hA0YXAA3JK8nRE/ywJAP3xoEBh6M5kF2iK0nSSBw5ODeMt
         SSf+T24sbkXyF8sYjxdTqLR3bTHsvd2IqThi6eb6DnaDB6zupSTjbhKrzsqgrBez6ciW
         Nhdj/jgawDRgNRL2p+TDwQ1Dr+U7ayWZRkozGSssXb6QnyFlq8oDKTvLUAoUkVaVzCj8
         s4vV4pgEiNq6vqgJtxP79n5WbOiA5NnQBy9Ns7nQZUcehNit4KqGfRyZeysAkhQdnL2w
         d0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH9JdWPqqL0xaPWwfqn7o/7rrdrX2n26XqK+wLSxm0rt51Jo6WA9GCzECg1caJj/6Vt6xsOy1y77MCBSuLB2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9nPV0njufhAdop0ANIpjJCjg8nG/h/uRxtjbrHcTsFpvjiIjY
	d2zxqOOJYzfeUwgoZk58BLd92clTE72asV0+8bXUGRFmNJhKk1ueKbdru/9PDGXQgoTzm/GuPFv
	V5nhBV/m0xnsEdSaD1zxVCMTxhwGot7hKJCqQYnLw5d6Crf+Fqd82gGq7SJw=
X-Gm-Gg: AY/fxX6H//IcfIVQbOR6lnU/Z1Js2dTtkeSk7oVTd7r8BDuWjJbpGcUNcrJazUw1/w+
	qwmG/UOtx+hT2D5GWvkDKVp1TAInWhhERlHVkEntBFCLHkXnuSkBMsZDtkvDMAAOnBcXiUYpRy7
	sAdtanYlQqjIQgKkHTTHpCTFIJ+BBcX9zLJQV7OyAkXsr9XXXoWWyJ3hinVPv/88atStWzY4yoc
	JkjFhSGnrHy/7IqPQOHUnL2RlUfQTIQMFnQa4/vcjg/sStUpIBEHX8+xQJnXdH0GMcZoTdOh+/+
	l0+yHA==
X-Received: by 2002:aa7:ce1a:0:b0:624:45d0:4b33 with SMTP id
 4fb4d7f45d1cf-655250edcf6mr10540a12.7.1768536526341; Thu, 15 Jan 2026
 20:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115232154.3021475-1-jmattson@google.com> <20260115232154.3021475-2-jmattson@google.com>
In-Reply-To: <20260115232154.3021475-2-jmattson@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Jan 2026 20:08:34 -0800
X-Gm-Features: AZwV_Qiyq77W87Fw0Hqa_LDIQdFvkrquc9Zy1Y8YNrsVZ9dQ1TDzaCisflOneZM
Message-ID: <CALMp9eSMxNcV-5fcE3EUqCeoQz4m1v3j3j_2jNNv1KViJVXakw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] KVM: x86: nSVM: Redirect IA32_PAT accesses to
 either hPAT or gPAT
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
> When the vCPU is in guest mode with nested NPT enabled, guest accesses to
> IA32_PAT are redirected to the gPAT register, which is stored in
> vmcb02->save.g_pat.
>
> Non-guest accesses (e.g. from userspace) to IA32_PAT are always redirecte=
d
> to hPAT, which is stored in vcpu->arch.pat.
>
> This is architected behavior. It also makes it possible to restore a new
> checkpoint on an old kernel with reasonable semantics. After the restore,
> gPAT will be lost, and L2 will run on L1's PAT. Note that the old kernel
> would have always run L2 on L1's PAT.
>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 7041498a8091..3f8581adf0c1 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2846,6 +2846,13 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, stru=
ct msr_data *msr_info)
>         case MSR_AMD64_DE_CFG:
>                 msr_info->data =3D svm->msr_decfg;
>                 break;
> +       case MSR_IA32_CR_PAT:
> +               if (!msr_info->host_initiated && is_guest_mode(vcpu) &&
> +                   nested_npt_enabled(svm))
> +                       msr_info->data =3D svm->vmcb->save.g_pat; /* gPAT=
 */
> +               else
> +                       msr_info->data =3D vcpu->arch.pat; /* hPAT */
> +               break;
>         default:
>                 return kvm_get_msr_common(vcpu, msr_info);
>         }
> @@ -2929,14 +2936,24 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, str=
uct msr_data *msr)
>
>                 break;
>         case MSR_IA32_CR_PAT:
> -               ret =3D kvm_set_msr_common(vcpu, msr);
> -               if (ret)
> -                       break;
> +               if (!kvm_pat_valid(data))
> +                       return 1;
>
> -               svm->vmcb01.ptr->save.g_pat =3D data;
> -               if (is_guest_mode(vcpu))
> -                       nested_vmcb02_compute_g_pat(svm);
> -               vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
> +               if (!msr->host_initiated && is_guest_mode(vcpu) &&
> +                   nested_npt_enabled(svm)) {
> +                       svm->vmcb->save.g_pat =3D data; /* gPAT */
> +                       vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
> +               } else {
> +                       vcpu->arch.pat =3D data; /* hPAT */
> +                       if (npt_enabled) {
> +                               svm->vmcb01.ptr->save.g_pat =3D data;
> +                               vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_NPT=
);
> +                               if (is_guest_mode(vcpu)) {

Oops. That should be "is_guest_mode(vcpu) && !nested_npt_enabled(svm)".

> +                                       svm->vmcb->save.g_pat =3D data;
> +                                       vmcb_mark_dirty(svm->vmcb, VMCB_N=
PT);
> +                               }
> +                       }
> +               }
>                 break;
>         case MSR_IA32_SPEC_CTRL:
>                 if (!msr->host_initiated &&
> --
> 2.52.0.457.g6b5491de43-goog
>

