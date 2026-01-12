Return-Path: <linux-kselftest+bounces-48782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C25D14A59
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 19:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80DE9303C9FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CCD37F730;
	Mon, 12 Jan 2026 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z9wZuziO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0F3570BE
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240799; cv=pass; b=M5fMuo+xI7uk7fWTmKf2xfd6Y2zyKZ/WW2Ea4vpxB7mcFLIyI/VEx/jxPeeVOGYfHU2q1AcKyn3/21rJkRw2P10Y77yLRtCzNpRfSGc5iMkJWVWQ5/ErVmFDQAHujCTkoOU1aCeVYkqHVW9188HkcJXQkef4fmYsSZR3Kzlhgg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240799; c=relaxed/simple;
	bh=W2KRaBZYvG8HVg3eIWgL8kg0vNUppturNmvWPxflHbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioQSJtmWmp3W+Ism7GmIf3X7r9fJi7FA+b6Z0aZl2W/Pafx2jaQMCj1NQl352pqUwypORI50a4UOnHPdS/ND1DQ653GeUWqDxkOt54H5HtI7CO4mHGEWwYMXNU2JI089l9qs+SDkwvdBVqCNiMzZ6hNOU33sJ4702qvOlDaFVSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z9wZuziO; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ffbaaafac4so8171cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 09:59:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768240796; cv=none;
        d=google.com; s=arc-20240605;
        b=BqxZDZYxX+XUTkM3kQ8brXqzsvAZob1hPCBiuMw0l0GFoWcK9gY+VodM5arGBT4B+4
         lhe9xbiVp51O8p2YPGJ40EpKQfVx0MQ5jPl2jkRpvoOgUG5gNbNNUZM9n4Bi5czSVCms
         eXhP/cU7ofmJ3TBHn+ya9694y2sAmp9OdJLHBrnEESn2pZJ+GSu0JoWNdyEyKi9tg7+8
         XTxy4oRn1qMUVLD9o/MlmWUsq5GMVa3yBhwrsyAz20OU0wpREQkCf3DH76Gvhueg5W2s
         f/+qxL5lFFNBvQrNYvrHKOBzSqXypYW0fte1euV5A9n5v2Qyfa8avUR+LQJiNbnXl3Ho
         SRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bJjpEAphM/NB+/t61DhxYCEIiQ3uh5viKOO+at6PH6g=;
        fh=mjDsByRhY4ztLLy43IkgOlZyqZXrJUNAGSY56No/gsg=;
        b=Px6gsITXnRpJztKH5ysGYdQi1xk85yZtjrNYsPsfkb7FDAIC/zZ8/xyzwETNWFCCjB
         DKHS73ps2eQywROZnJsTdWGpEtsJRi+X2AGAVlYtIPYD9ughrsmmtsPkJjFDknUJOUlr
         ausYdqH8Q9zIBg8E7ho/whL5YnTjOEqtBE/ubh/rBQqFEKw2kIIVqkeJt3ox9ywhFVsk
         lhBbw9W4djYfRgTeSzg/awFZ2hwokhEhJQgsPfv+zMp6OQoh6oWa8HWCqg+d5ld3CpgR
         WKEluvNCB8QGh2IeCODqfD1NjX8bE9tBKXGYAgD1xNryAfQdGjrE0RUhnXEwBDkpDdJY
         tTgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768240796; x=1768845596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJjpEAphM/NB+/t61DhxYCEIiQ3uh5viKOO+at6PH6g=;
        b=z9wZuziO/HLkdQvgQlLAQeD650exNhp3chBXsmGignnysuk3g8vtBx1tED3fq1fp4Q
         XhTgrjRzniyPykzbI6ggldfLy+EjSZasJ35/9ajLagge7t0vh2BXqLgpImUxaaPoOQcW
         bSC4xSd+TvNOPXWGo7j0YTfRHjN+2HSfNlvTByBKZByVx2gp1OG7oRNk0O3wvb1aFTHF
         VHkUx9DJ1pGTd3RcznuGvaeN07uJWRAs6zOioLQxmotS/fb/C+HsOT9LgSDJGLAOP0Z3
         DC4YQLiWJYS2c7vAxx0kna8t8o1uAwOt8Rc7U98llPuwua9DowDDG6gPNWZUS4OpWnus
         YbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240796; x=1768845596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJjpEAphM/NB+/t61DhxYCEIiQ3uh5viKOO+at6PH6g=;
        b=o7gO9AMV6sAxPyxbTGsnChrTbZMk4U2Clmg4frvGA90urN+PW5BRdjRllIAsOViDoP
         U+yU+X5E2cNd8KYJMHM+9wkJAk+kkC1IWuKYpGgxleYv21r6NVZ1hbcCIJQEdXXxUvSK
         D4xQAo0eO//JTj9ZWBPqC7dT3LQmuQWAhe5V65WZoXEjlvxyXx3L4ldisC+PzlYKHulT
         f8NvIfihLg0dMT1inurhAKlfcmETiTD4jjaZW7BrpSA10tWUUFduc7WDUq/cNkQFR14s
         bm0azCaGJBv8UnnoZxgi7nUVFtGUhF+7+1koOUn76eFJ5yZw3RXFM+4cbRoZa8sL9pJe
         Nrow==
X-Forwarded-Encrypted: i=1; AJvYcCVf8hOC82Qdju282Cph6XlyC6a7dwFsJjFMMFFEk3KAKJxS3o3ie2KacAk7pi8Svvormy24JS4gNNdTDx4kMtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7/WfbC30zo0PT0R/THz2xWy48i3a2dokQmV+9F47xF4DvWNv
	69tvkU2m1dUdniCq5ebK/nLmD0fAvFKffiuiC0+5qjWZ+naUycC2fk5NGFLOmAgRij9jt16sXAk
	k12XXXZV+OFYmqDoOSNaA8z2172AI7d//I+7aQ4q2
X-Gm-Gg: AY/fxX7ID3GulKnk26yJ9I/0TEAJix8AnI2S4Wrto1GZWJa0I77eW7DmS+SScSSk0jn
	c3Odg9KCtyI78bpmhgyE6DS+wwVNmO13RHHZ2/Ix6n55qA7OjLhty8ymhKMpq9ajCLVs+ZUyfXC
	BpOD1IbKu2jj4e+I7HNoORU2h/mcrhULhaP0qodsDNG4hORyekngOmUysN1GKw2USwHkd7jRJb0
	wYW+gXyVYnUDdcyYGmNapn5snS2aMGOtgqEEq8z5qa44UkH4kDRyhFgQ3rCtiyVh+mlUYpF
X-Received: by 2002:ac8:7dc5:0:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-50119766a66mr21632291cf.9.1768240795172; Mon, 12 Jan 2026
 09:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-19-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-19-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 12 Jan 2026 17:59:17 +0000
X-Gm-Features: AZwV_QiQU0Otl0OZ50pDvqjq5GLQexN4JJXUaeH6JoNDjhaymp7I-l_cuFsktUI
Message-ID: <CA+EHjTwQ4fLBE1YXoB6M0eamSgGDW=nfLaC+-_surBfVbh3byQ@mail.gmail.com>
Subject: Re: [PATCH v9 19/30] KVM: arm64: Provide assembly for SME register access
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, 
	Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:
>
> Provide versions of the SME state save and restore functions for the
> hypervisor to allow it to restore ZA and ZT for guests.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_hyp.h |  3 +++
>  arch/arm64/kvm/hyp/fpsimd.S      | 26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 0317790dd3b7..1cef9991d238 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -116,6 +116,9 @@ void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
>  void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
>  void __sve_save_state(void *sve_pffr, u32 *fpsr, int save_ffr);
>  void __sve_restore_state(void *sve_pffr, u32 *fpsr, int restore_ffr);
> +int __sve_get_vl(void);
> +void __sme_save_state(void const *state, bool restore_zt);
> +void __sme_restore_state(void const *state, bool restore_zt);

Would it be a good idea to pass the VL to these functions. Currently,
they assume that the hardware's current VL matches the buffer's
intended layout. But if there is a mismatch between the guest's VL and
the current one, this could be difficult to debug. Passing the VL and
checking it against _sme_rdsvl would be an inexpensive way to avoid
these.

>
>  u64 __guest_enter(struct kvm_vcpu *vcpu);
>
> diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
> index 6e16cbfc5df2..44a1b0a483da 100644
> --- a/arch/arm64/kvm/hyp/fpsimd.S
> +++ b/arch/arm64/kvm/hyp/fpsimd.S
> @@ -29,3 +29,29 @@ SYM_FUNC_START(__sve_save_state)
>         sve_save 0, x1, x2, 3
>         ret
>  SYM_FUNC_END(__sve_save_state)
> +
> +SYM_FUNC_START(__sve_get_vl)
> +       _sve_rdvl       0, 1
> +       ret
> +SYM_FUNC_END(__sve_get_vl)

Since this is just one instruction, would it be better to implement it
as an inline assembly in the header file rather than a full
SYM_FUNC_START, to reduce the overhead?

> +
> +SYM_FUNC_START(__sme_save_state)

I think that this needs an isb(). We need to ensure that SMCR updates
are visible here. Looking ahead to where you introduce
__hyp_sme_save_guest(), that doesn't have a barrier after updating
SMCR. The alternative is to call the barrier where it's needed, but
make sure that this is well documented.

> +       _sme_rdsvl      2, 1            // x2 = VL/8
> +       sme_save_za 0, x2, 12           // Leaves x0 pointing to the end of ZA
> +
> +       cbz     x1, 1f
> +       _str_zt 0
> +1:
> +       ret
> +SYM_FUNC_END(__sme_save_state)
> +
> +SYM_FUNC_START(__sme_restore_state)

Same as above.

Cheers,
/fuad







> +       _sme_rdsvl      2, 1            // x2 = VL/8
> +       sme_load_za     0, x2, 12       // Leaves x0 pointing to end of ZA
> +
> +       cbz     x1, 1f
> +       _ldr_zt 0
> +
> +1:
> +       ret
> +SYM_FUNC_END(__sme_restore_state)
>
> --
> 2.47.3
>

