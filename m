Return-Path: <linux-kselftest+bounces-48617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF4FD0B12F
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 16:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08F26300EBB4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DD335CB96;
	Fri,  9 Jan 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOnZrg1O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB0363C46
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974184; cv=pass; b=RhPYI99bRnyNuGlsWUnGDDZI4HuxAdjht88KVbHiFEA6LSAYaZABQoUIDE8jGb1M+YbjQAb9Q4z/IhMOAZzYpmcBudwxPhl2K2NNdd5KXICmnkUf3aL2X35ZyZiaoUasHO+ec6iY/58qL6mVDAHKkFNHcQEh5t9QTSimJNqXHTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974184; c=relaxed/simple;
	bh=RJop5DvCjIWLKeaevl0mMUi6g/p1XvGrRQjivQIYqSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxbJQNWfAbT4CuPR3TiR0RmkVywSo3TdroudqbMSkfwyRhZ9y8h4ureC5hYFuiEKXWO5DktQ0IzDjE/n/o7RW2OaKPgaASJKRf2EQNLCnYKVhLltoxwS3Tv/0AUE+Q5IW96agREEIMr6quEzCpQJSpnleT1yyp8hfEW3q166Fto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOnZrg1O; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4edb8d6e98aso578391cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 07:56:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767974182; cv=none;
        d=google.com; s=arc-20240605;
        b=e4Pv8z7/5YfRS6dKnpqlYzQ73o5XmZteUFd8sO6L9fHBsQaUV8goJork79PPv/NLLG
         2J3aMK7jqA+aFNQZIJnc45iu89tt5vCG11h6bkApa8t/B8GBMFRJFTJkZVVTnxNwc4qs
         krKfb7Gqnnqq9H/iwk/QpJFmxzWTQlyBZTkPJjobH3Hh65eBCfQwZtSQa/3aXjst9Bf3
         sFAAzN8rIlefkdA0xcNRlb5xkFg3txEaDlrD3eeIIbwoxEdolq9It+0zpd0mqkXLLfOs
         yyqYit/ot+wvuNoT4fFcCb8zGs7erkgKmaL9TmVnjpwbg/aFlzbYiNZvGCJfuNT+3PAL
         K5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b5CL8FxNgdT9nItA6mQg13QZSgYd92jfbMmDmpgGf0w=;
        fh=YZIKSv+ox9toXG/c++aZpWU0uJKv/N2tmcoNDd36fw0=;
        b=kEZKGA5Me3Tpwd+nbkLymesYz0TgL1lbcdsuJNqwIPYTtr+WKDtQDVyms9U7d5Xc+5
         GoqtTbIpAQ4LoX6wspwwqMNrsmbfdIiLQ6IGjNyfK4/Mq8efKJZ4jsGanksMNw8sf2Vw
         ySXxfTJ1T524jc6NJYfi474GvFBsYZcw50GoTBzl+63ahsoIrO+nXfu5aIdQyP2d/+hp
         lWJMy1eUjev1o2QsRh15MXXBcXVQdNhZSpZ6+cunx5f4gZz14AUCXJDR4qKrIMpAd9hL
         8GlsO8PSYagM26nt7dO3GpQINrqjEb3XZVIUc7MBYGCeIr5YORJMRrCZP6ixW3vd+dU9
         JiPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767974182; x=1768578982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b5CL8FxNgdT9nItA6mQg13QZSgYd92jfbMmDmpgGf0w=;
        b=aOnZrg1OPl7eDlojGo98JRYTJvq/PnfnNQZ9XcAV/DHytRrdch0y/4x5n+5k3Xp8E8
         9mSQAxxSyg1covqqhLMvcHpYWZBomI6se0JkRaPkoQ4M3cYxLK62tmjM2eqwghvtyA2/
         s9chezLI2pDKYDGOa6EyZQDuvSO7XvMiX7rLgzM5khLqUpDYvLfcXsZT/mfCjeJENi/F
         KtDCFATbEQkFlr/c5a6EGPZcMsViCLHgVsP80mwTf3t47xFHMBtQUBpRtSKnphrzLNxX
         lhcUwN7gu/HVScIFCq3BILbuoqHBxaA9PlA77RyrxyzMWGQAwN57xNwzWIRDZ/gu0J2d
         5nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767974182; x=1768578982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5CL8FxNgdT9nItA6mQg13QZSgYd92jfbMmDmpgGf0w=;
        b=m61e2Mj4BBpXi4lgT7+OBeStr3vLu1lPbl3yrNOK0tPI1Z3U6UZn6o9bVIVOQnV8Yp
         c3TDA8y0HSAv9cg+S82SnefltlIVYvthDjEC2bpKobCkkNLX5egVjA2/fPI4uHL86nGo
         e+pRFdx0zdwzJyQ93AM4VRkzVGt0ihDleh0OOsNWYrxmZeL5yf9OiGtn4+FO+MH9ob/e
         toj1H4n6qLfgWyuRIIlryHEC0+bfUl/clCGtmmuGqdRl+Xf+cGJHR6Oh8v5frQxC6b5I
         LnqN/hvPS3JR+9u2cOM2TirQf7rYffcdCeB+fOH6G5UU95/bohMwi7D1BolSkGKjOx3a
         TAgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpmnlnmZ8A2z3Na4aX1T2cXECwmGKJ2ubVNUnAjrnCn3kh2LDlTHh7MDptptCvuPThnHxiDBvxDCFUvpixZaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCMSQIHL9fKcgqB4dgZfJfsiCPTxV6rdXJaB5U2cLdvH4Ulsa
	cN/SQYvS5xzXRZDQ/yrrjTnikA4tFTx3U9Vn636kYLqfQa4uDZBO/E4AWafWw3+xvD1z6lKJznE
	VvAnye4Vj8nB0u98mfNWqWJHwBCx8CzgsUAuznLS6
X-Gm-Gg: AY/fxX4JmFXLxJCq+KV0hOpDWNjWNMEY0pkKBJ90Ttp0iEBC2siFmMsOjtgUdykWvwU
	vGt0SSz2NOsHJSEH8x2r73xPODHgmsoVeOSka5Am/hw7jbzgpIt+4fa2BigrBJeJxrQAHW0+XFN
	oasqnK3xq1r8eXfEPeiQ3BJbTqYFrZlnPnxgbNS6a4+a7lGKQuxa1T0WnLUwFJV82PIcu5UgxeE
	rk/BqN63Unv7tHha23s/KICLbEyUAv9RZeiWStqSnakkusMogl8NlSzHtGjfyPTv0As1O3o
X-Received: by 2002:a05:622a:1827:b0:4ed:ff77:1a85 with SMTP id
 d75a77b69052e-4ffcb233993mr10494381cf.17.1767974181223; Fri, 09 Jan 2026
 07:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-12-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-12-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 9 Jan 2026 15:55:44 +0000
X-Gm-Features: AZwV_QjYKCnQMH_dJFXuijQwcG8RABb6JnH52RR1LbUrpQK_8_OFYA5NFixm6a4
Message-ID: <CA+EHjTy95BPnZzZcrR8eOekTm9Cv41D_BCkH1puWtDG3JO6yTQ@mail.gmail.com>
Subject: Re: [PATCH v9 12/30] KVM: arm64: Rename sve_state_reg_region
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

On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:
>
> As for SVE we will need to pull parts of dynamically sized registers out of
> a block of memory for SME so we will use a similar code pattern for this.
> Rename the current struct sve_state_reg_region in preparation for this.
>
> No functional change.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kvm/guest.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index d15aa2da1891..8c3405b5d7b1 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -404,9 +404,9 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>   */
>  #define vcpu_sve_slices(vcpu) 1
>
> -/* Bounds of a single SVE register slice within vcpu->arch.sve_state */
> -struct sve_state_reg_region {
> -       unsigned int koffset;   /* offset into sve_state in kernel memory */
> +/* Bounds of a single register slice within vcpu->arch.s[mv]e_state */

nit: I'm not sure that the space saving of s[mv]e_state is worth the
added difficulty or reading compared with writing sve_state/sme_state

That said:
Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad



> +struct vec_state_reg_region {
> +       unsigned int koffset;   /* offset into s[mv]e_state in kernel memory */
>         unsigned int klen;      /* length in kernel memory */
>         unsigned int upad;      /* extra trailing padding in user memory */
>  };
> @@ -415,7 +415,7 @@ struct sve_state_reg_region {
>   * Validate SVE register ID and get sanitised bounds for user/kernel SVE
>   * register copy
>   */
> -static int sve_reg_to_region(struct sve_state_reg_region *region,
> +static int sve_reg_to_region(struct vec_state_reg_region *region,
>                              struct kvm_vcpu *vcpu,
>                              const struct kvm_one_reg *reg)
>  {
> @@ -485,7 +485,7 @@ static int sve_reg_to_region(struct sve_state_reg_region *region,
>  static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  {
>         int ret;
> -       struct sve_state_reg_region region;
> +       struct vec_state_reg_region region;
>         char __user *uptr = (char __user *)reg->addr;
>
>         /* Handle the KVM_REG_ARM64_SVE_VLS pseudo-reg as a special case: */
> @@ -511,7 +511,7 @@ static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  {
>         int ret;
> -       struct sve_state_reg_region region;
> +       struct vec_state_reg_region region;
>         const char __user *uptr = (const char __user *)reg->addr;
>
>         /* Handle the KVM_REG_ARM64_SVE_VLS pseudo-reg as a special case: */
>
> --
> 2.47.3
>

