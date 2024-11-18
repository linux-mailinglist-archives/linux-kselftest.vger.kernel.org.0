Return-Path: <linux-kselftest+bounces-22187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8980F9D14BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65F5B2E460
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD11B6CFC;
	Mon, 18 Nov 2024 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4AggMtFd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892D1ABEA6
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944068; cv=none; b=uy5nIRSw+hpRADGjCUnF3Df0+URppwTuk2k2FDwRT2unAd3v4E17APSV19NwBG8E/rCiWCBjXsT/8WvYSmEL6YsdwxOB1lNQpRZoLFB3qE4x7z5CwG94s6qW0Wr5LjD/6LzOqhdBzBKYj85JTq/EwdTIS1fNXa8OeckiveA3E7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944068; c=relaxed/simple;
	bh=IzZ8vrLDeheWfdUYDbyaJVPjAgEM3gmJvyf15rXhHCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWcgW7/QZ7HJiWFTxo924ZOJfAesk1iE2MYBFf9dUuC3Ja4JRh518kMfzPMGpU7pcJc6UHI/638oBCAqOLvt8YcDwTokrAVTqBvUW/+9ibPsifG8g7cpETJEy546wnNC49M3b/Y4A7unWNgYZ5ih2bDtV/8lB4CULo+y6DU5k0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4AggMtFd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee6a218044so33900127b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 07:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731944066; x=1732548866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7K6U0T/XQ8gx+tHZUWr2faguGniMnPfsq2eZoyEnrU=;
        b=4AggMtFdv+qaXVV9v8HNVQaB5u1tFZxwWz0nyCrvOrK4qgWl/5Rj3r7o3AVy0XhejV
         9P7Ebs1tEZmtB/moDX49rAi23AiLC48T2+A1MuhmEVamzlaAxlwn8g9rEqAf9rUZ0sxX
         r30BUIJBLQNuaB3IYyuNQmBdvzl5FWUId/xtR1Ly9whJACbjlxECABtCDXryU3CdNWlh
         Hp7dCUmZuVEGrDGfM9hgKBssvO7vU+hNnVjk3av3EiN47GTGn/jddnhwlXiZTJsNXYnm
         EnoqF+u+vL+tChtpoHk0yYUn7NUPs+CpSwADYwFviEvneXQulB77RVyEXW61zWn3yu4w
         PmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731944066; x=1732548866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7K6U0T/XQ8gx+tHZUWr2faguGniMnPfsq2eZoyEnrU=;
        b=jxnHeUEhTZC1tJ4czSeiOj54l8EFMikFLA4fWIs3T0553E3Ib7W+LtDkfmFqFLq2Y9
         1dGMYSOgXDb5PGfqW6foNw22I24//SiqjAyNot1ictKPFl0A6cyWTzaIHzfVSo8B/q3L
         Dyf3spdI1jVIMvMrQFUs+r6fB2+/YpY4L9e/z8tV59fvSttHDw+BP3m7hotmEli5li+x
         5xceQdSssKeTjM+GsI4U7DEg0U9+7tqe5FYyQYNJvqCpZT/9FRr97fSayEdp3PX49R7R
         nyxgPeW1eQ+ICL6YJ2IOvv6eRhIy8vWXmT9EqKqQcO9FT3KMA+zrbKdlL7pI1uq5nRIG
         RBlw==
X-Forwarded-Encrypted: i=1; AJvYcCW0JQolf+HATT6FNIMDC1GIp5si56z965/fQuNIK7ysmWmXY64BngPR+brenNB3REpI/8RWlidhbeYI6S9I8is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamcvMDFedzXGpEcTZaJFQ3gi8KYZXMJlSP/qCcDIViTClJKeN
	2E2VTq0FxUFb8/GCLlnY0GwmnEfH5XE9AM90UI/hW2kPNq8xoADE7qKCQPJUT+kRKYsuyET+0M6
	Xxg==
X-Google-Smtp-Source: AGHT+IG53BeA5Fnt7TchljlmDo3D4tY72ogWA2od7hmQmMsBLO0ga3hzcJvpmUfayiR1at+ew1OgbLok9Wc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:424a:b0:6e2:1ab6:699a with SMTP id
 00721157ae682-6ee55ccc2e3mr1066877b3.7.1731944066382; Mon, 18 Nov 2024
 07:34:26 -0800 (PST)
Date: Mon, 18 Nov 2024 07:34:24 -0800
In-Reply-To: <20241118031502.2102-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118031502.2102-1-bajing@cmss.chinamobile.com>
Message-ID: <ZztRPUTWm5K1bsgJ@google.com>
Subject: Re: [PATCH] kvm: hardware_disable_test: remove unused macro
From: Sean Christopherson <seanjc@google.com>
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 18, 2024, Ba Jing wrote:
> After reviewing the code, it was found that the macro GUEST_CODE_PIO_PORT
> is never referenced in the code. Just remove it.
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/kvm/hardware_disable_test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> index bce73bcb973c..94bd6ed24cf3 100644
> --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> @@ -20,7 +20,6 @@
>  #define SLEEPING_THREAD_NUM (1 << 4)
>  #define FORK_NUM (1ULL << 9)
>  #define DELAY_US_MAX 2000
> -#define GUEST_CODE_PIO_PORT 4

You already sent this patch, albeit with a slightly different shortlog+changelog,
and said patch was applied.

https://lore.kernel.org/all/20240903043135.11087-1-bajing@cmss.chinamobile.com

