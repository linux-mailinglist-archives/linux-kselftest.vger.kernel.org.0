Return-Path: <linux-kselftest+bounces-47858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD23CD6A38
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 17:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B5693011034
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C7532FA2C;
	Mon, 22 Dec 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssLCO+tu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3532F74C
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766419944; cv=none; b=ZdsHU2mbnNSoD6MvNYWMGa+klulMRzQQOFduUzAecfYBrovUY8vNzSjX7/TxT7T1KYt+HXhNQKhWha6jZ4DsEVP+8UI9US4V1uHQIXcJrSF6cER6QXxrNOlQXnXKvJrl4tCsAChJlt/kJezoPGYUEkyrPrH5aSx7b2TJm2fR+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766419944; c=relaxed/simple;
	bh=m9D8dhT6jwO+9CbGh4I5smZkGRQ3OP+5tO7RqWKlpq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tn8hIADUsK3vWOT8Ezcc/D9IDcGeDnzNpdM5bXb5ZrKXX+HkgAU3z6XoxfpbLfe5ss1+Vc7dh9g9pQD7mGInPhhe+mJ/t8SEoHdUd+P7iLor+CsdxbZY4mDEJizolMWMfFLyfIQUk8sNVra5vvET0S4ggIkevLmRAP+XNAUVSWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ssLCO+tu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f25a008dbso37921495ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 08:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766419941; x=1767024741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zeYdP9feRFRwQqDGc83ZSxaNa29m5lhAcRNghOQgnIo=;
        b=ssLCO+tuLAtqCLeeRDIfoThPiDJXbCIMTviI1sS74VnICPujI2uhEsYFnO4WkfWJoU
         +PXglr1OcIiYj92b/UJiWrRctzO6d64uxOM4GabZ/fW1IEBofIJZd48nyc430QFX7eOW
         w6PnIfy8BmcZV3gihHwgCH7FTISV0Cptaip8cssI2VVhjVDlHUKeRopPpd1hcts4X51K
         N+zqqwmqTVRyLwwXip3+CQoAnkClakJu/1a120xkUuwuKi4a15PbjJJiQ0Fx1Z3gkRiL
         TAE00bBZ9Dnd2stPkHMRbRHKeWJwQc+jDiNRTo73NH+s9HrlYPl4L4xTfP58EiFQogAs
         rCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766419941; x=1767024741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeYdP9feRFRwQqDGc83ZSxaNa29m5lhAcRNghOQgnIo=;
        b=wRbJpJsC4Ka63olqZmZK4GaqkZ80Xwisum85p85/ulCI3PSzwIjStrqTM7W1C6Pa7P
         YW9NDThNCirtBm5gBpFnmPAK5bd/dT6CBYayuhYQX5aLfR3Ihk8o6FvyvP36e0K2u4OZ
         ioFRuC5keeO7cMUgAnRL2eLgFFfUR/5ZUEugcAkJ8UG8z3QqpW4uvcZ7lxJA7pG9qP3s
         j3PgRrX6L3J4sVflP+UazMwIqQZL63n4DvM6L0lJRgFVslETg7j3UedQlE40b0IoUCxp
         Q1qoP0zfDSwmt50JTv8SrRrkNfBR24rltMHmT6q1mxxXPWGmtkBMTrL6Ck6AjPS2Uk5Z
         oZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU13w7sWjGvUa2HEW2R4lNiieVYbGrSJPpErqI3EqjeeVyxXW9Qk4M3G3mYs+2rPRh4yKHdderr2dAhJgxQN18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GwoukWxu71pDJ8MtJqt5+03gOx34bNtsyGLNNzz4CTJu5nrq
	2wnTzGcIevcIG8UrD5ivWqGbpJL+zA40K+4EYEMs4qNqLOISfhlT7bqMJc7+0AfAsCE3GmCM7uC
	CotLk9g==
X-Google-Smtp-Source: AGHT+IEJL9Vfq6Wmz0MCy1Ld56C/u08Z98hnfT98iTqRveIwPblpzVC3uzolI5BF1B6/fRSKSSYznuB51mQ=
X-Received: from plyw20.prod.google.com ([2002:a17:902:d714:b0:2a1:5235:1502])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef0a:b0:295:ceaf:8d76
 with SMTP id d9443c01a7336-2a2f2840085mr105799715ad.47.1766419941196; Mon, 22
 Dec 2025 08:12:21 -0800 (PST)
Date: Mon, 22 Dec 2025 08:12:19 -0800
In-Reply-To: <20251220021050.88490-1-mj@pooladkhay.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251220021050.88490-1-mj@pooladkhay.com>
Message-ID: <aUlt4zOuyQ2WNiRe@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix sign extension bug in get_desc64_base()
From: Sean Christopherson <seanjc@google.com>
To: MJ Pooladkhay <mj@pooladkhay.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Dec 20, 2025, MJ Pooladkhay wrote:
> The function get_desc64_base() performs a series of bitwise left shifts on
> fields of various sizes. More specifically, when performing '<< 24' on
> 'desc->base2' (which is a u8), 'base2' is promoted to a signed integer

Ugh, I hate integer promotion rules.  I wish there was a more useful version of
-Wconversion :-/

> before shifting.
> 
> In a scenario where base2 >= 0x80, the shift places a 1 into bit 31,
> causing the 32-bit intermediate value to become negative. When this
> result is cast to uint64_t or ORed into the return value, sign extension
> occurs, corrupting the upper 32 bits of the address (base3).
> 
> Example:
> Given:
>   base0 = 0x5000
>   base1 = 0xd6
>   base2 = 0xf8
>   base3 = 0xfffffe7c
> 
> Expected return: 0xfffffe7cf8d65000
> Actual return:   0xfffffffff8d65000
> 
> Fix this by explicitly casting the fields to 'uint64_t' before shifting
> to prevent sign extension.
> 
> Signed-off-by: MJ Pooladkhay <mj@pooladkhay.com>
> ---
> While using get_desc64_base() to set the HOST_TR_BASE value for a custom 
> educational hypervisor, I observed system freezes, either immediately or
> after migrating the guest to a new core. I eventually realized that KVM
> uses get_cpu_entry_area() for the TR base. Switching to that fixed my
> freezes (which were triple faults on one core followed by soft lockups 
> on others, waiting on smp_call_function_many_cond) and helped me identify
> the sign-extension bug in this helper function that was corrupting the
> HOST_TR_BASE value.
> 
> Thanks,
> MJ Pooladkhay
> 
>  tools/testing/selftests/kvm/include/x86/processor.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 57d62a425..cc2f8fb6f 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -436,8 +436,11 @@ struct kvm_x86_state {
>  
>  static inline uint64_t get_desc64_base(const struct desc64 *desc)
>  {
> -	return ((uint64_t)desc->base3 << 32) |
> -		(desc->base0 | ((desc->base1) << 16) | ((desc->base2) << 24));
> +	uint64_t low = (uint64_t)desc->base0 |
> +		       ((uint64_t)desc->base1 << 16) |
> +		       ((uint64_t)desc->base2 << 24);
> +
> +	return (uint64_t)desc->base3 << 32 | low;

I don't see any reason to have an intermediate "low", it just makes it harder
to piece the entire thing together.  My vote is for:

	return (uint64_t)desc->base3 << 32 |
	       (uint64_t)desc->base2 << 24 |
	       (uint64_t)desc->base1 << 16 |
	       (uint64_t)desc->base0;

>  }
>  
>  static inline uint64_t rdtsc(void)
> -- 
> 2.52.0
> 

