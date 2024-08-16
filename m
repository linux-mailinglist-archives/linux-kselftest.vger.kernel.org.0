Return-Path: <linux-kselftest+bounces-15566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA3B955188
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699C61C21382
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3070D1C37AB;
	Fri, 16 Aug 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBlkA24g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369580045
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723837076; cv=none; b=PK78RabHmwkelnTaQRi0uZjbKgoTchwVxn7mxMhFFwV0SaCrznvBob69EgerzjJgJTqeet0ipzEB+US9+lpsdSFVcocgp+Lr8KOI7tzDixXnhlUVE+WFcSoMDc4fces4gQxixi0DP7tapr767DF4bgoPK2LaBu5CKnnfMFGlimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723837076; c=relaxed/simple;
	bh=Of5HpGVVuTUuNfj4AJMT8Y+0YqFufRVSujNfXIl5CBA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ItvNweJGNaGx4ZVRfeR2/YR2ws3RCq+hP+7rT2Y9raST7SMBeLslE2A1nXL2mFIWwjEL8a3jykxql4HODp0WNhscXM/J2T0pq/jUkfL0AKvI6R52eJENJVsHoGO8gHp4umK5FmTwQkFshTIOjaaRowbMa37/B9r8NVI1bmQ+WGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBlkA24g; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so3624008276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723837073; x=1724441873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMKtRBmBdUEbdDNzAx0RjmHjXksW76vMe5L0MyK/hs0=;
        b=QBlkA24gINfNFXJw+6Bs5mI4n0PBkUwKH8nZraJpv0RA3zDyn8/k27/zF4Mb3C23z0
         zfLQxlWbtFPhu9lz+RjrWLMT3uC98tdth95ECReDaoR9W5RVBXCQuo0dPWfn/4L/2cay
         sGnKi3K2DiIk8JoXFpalemwoHSArnUEuwvvZTcFm0vMGDYXe3ww8heyDNMZKik4RNvRU
         l2LIiZZ3b9C6HW+FQ/dOCku1WbazHnc/y0lHl9Q4p8emnzhDxAKuKLqbmHWLIiHOJUUF
         dHDew7EGLqziwmvBaVxZJ+AXHtSO2wVpVM05AeVB7SxI+UttEmhCN1mlcJiS8ieGYcQ6
         pHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723837073; x=1724441873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMKtRBmBdUEbdDNzAx0RjmHjXksW76vMe5L0MyK/hs0=;
        b=Ex1D48obx3UsIkXEBwkOtpBGRAGsjIC1zS/FsTTpQGXfrAgtE53qZLtaM6TEmgLEBT
         MQHJvsabYnbw/G2ghbEY3208VJEuHlLknCx0+kGvEE/THvhspvDUfJYqvnrq2S7QVnOa
         aWMtb3gtydEYrw5pcBn/EmUPmeYJpBbea7ZT6baQ4CivgnztecSLnL+1eoOdL2hTxW2u
         xM+xc4Q/hRqbp8FizxuBOpODPfSv/k5sqKABewZPwCBCDPtu8c+ecJ+b4pcCe1O8YlFR
         pbwxvmR9KZtNcujLDYQ7z4IIuN30dIA9f0nF1XSZqNIynnL/UvaB3EY+L3huUY5yFoP6
         x15Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSIGG+TdXMN9xkcZZ2zDqzNjNvW0FfR7ux1WFz3YLGS5Omg0XjrGWNxpH+sVVuVKYq7s5DC64ZHvKAI4pZITiBD71CBP/Nb2jIibDsiQDI
X-Gm-Message-State: AOJu0YyMOKVvOJf2S7gT0mfXKzWIIBw4cj6FVfyGeznBAgf2F0W5Htya
	CcKG6PdKuZhlNsStVVeS2Bxlk7X9gsfvL7rfRTzcB9O0iaIw0WK+l02CqFHErM/0F87BxTbTxES
	LCQ==
X-Google-Smtp-Source: AGHT+IHXOFjx/mXErXlc00eHtSMRGExz9VV8bSAL/E4iMQhlh4xkfi3KGMIeTACfrjhamsRqjvx47hyJres=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6854:0:b0:e11:5f9f:f069 with SMTP id
 3f1490d57ef6-e1180f677bamr32754276.8.1723837073570; Fri, 16 Aug 2024 12:37:53
 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:37:52 -0700
In-Reply-To: <20240709175145.9986-2-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709175145.9986-1-manali.shukla@amd.com> <20240709175145.9986-2-manali.shukla@amd.com>
Message-ID: <Zr-qkJirOC_GM9o6@google.com>
Subject: Re: [RFC PATCH v1 1/4] x86/cpufeatures: Add CPUID feature bit for the
 Bus Lock Threshold
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 09, 2024, Manali Shukla wrote:
> Malicious guests can cause bus locks to degrade the performance of

I would say "misbehaving", I bet the overwhelming majority of bus locks in practice
are due to legacy/crusty software, not malicious software.

> a system. Non-WB(write-back) and misaligned locked
> RMW(read-modify-write) instructions are referred to as "bus locks" and
> require system wide synchronization among all processors to guarantee
> atomicity.  The bus locks may incur significant performance penalties
> for all processors in the system.
> 
> The Bus Lock Threshold feature proves beneficial for hypervisors
> seeking to restrict guests' ability to initiate numerous bus locks,
> thereby preventing system slowdowns that affect all tenants.

None of this actually says what the feature does.

> Presence of the Bus Lock threshold feature is indicated via CPUID
> function 0x8000000A_EDX[29]
> 
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 3c7434329661..10f397873790 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -381,6 +381,7 @@
>  #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
>  #define X86_FEATURE_VNMI		(15*32+25) /* Virtual NMI */
>  #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
> +#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "" Bus lock threshold */

I would strongly prefer to enumerate this in /proc/cpuinfo, having to manually
query CPUID to see if a CPU supports a feature I want to test is beyond annoying.

>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
>  #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/
> 
> base-commit: 704ec48fc2fbd4e41ec982662ad5bf1eee33eeb2
> -- 
> 2.34.1
> 

