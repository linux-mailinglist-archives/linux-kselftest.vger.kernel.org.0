Return-Path: <linux-kselftest+bounces-42012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95375B8D6F3
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 09:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FC217AFBE
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975722857C2;
	Sun, 21 Sep 2025 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BVeEIDXL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rcs92Mkc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07528282EE;
	Sun, 21 Sep 2025 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758440998; cv=none; b=uorVhM77lAxT10X/mQ46WfOkuetbw/xlK/jgekv6BgJzsT+TWNM2mDBxYH6wEMaG5NVyq4T+CE/FkCSVyI+ogLr5zLIBwt15ZzCiI/20/JczUbMLFUCxEk3xr0sgP13qIasZcRVIBk1Jz3is7GXosd+In+wUO+0Mbjm4hviTJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758440998; c=relaxed/simple;
	bh=/zd8kGUu1YDCWPtn6EHp7zCJRb9SI26DdhLUr53dZYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MwtPq9xBigQq5h096WHFhYHvgHBgM3e7g+BDv5LL8x7FGRkVvFiMYXrcp9CXwHKL45MWejZWWECICMrJAPYRCmNTg0KF1KOPX1qOcCykzDCFeOyzqfBnEMwmkvnLqvYksOUdjwP6KLkIY7gOoCKQVrzUCfMhg7TeMEZsur47PuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BVeEIDXL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rcs92Mkc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758440995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IOOpWtwZTep5n3DEzNoxo1SKgFoVil2Adig32iJIbFQ=;
	b=BVeEIDXLzmyfzuEOaY6SEmesmRZFXti9LpkUlOSzI2JHJEgTT2URmEikyWbHa09sJf5S5H
	67Vs4nU+qbk9qvYf1/I1C+8w7Rfx2xjIA2uQzo+WJQMOoVtx38S8galPYGVhBPAdDq0ay0
	7n2bZobgMciUWfrE8OIdxXHejtUQuJYzaS7tq8qm0uhnl+f70f/rPHw2Pr1rn8QjgpGzJf
	yj7+c9QMkEo+HCb+glpJxPGxjE/cpkOBgkXsUy4H1cKTnkSQ2HlkLYY2OpYqvNdrqONTy/
	RlqZV/PujKfNpDsiVBZgQbEDYt/GRvJXNDXkG9N3fr4DHY0Ju0ZNgDgomLUHxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758440995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IOOpWtwZTep5n3DEzNoxo1SKgFoVil2Adig32iJIbFQ=;
	b=rcs92MkcRFmTsC1RjNvdSlKZVrVPWJD92z6VmPJy52bcQEuFpWWZpSkLxUEweyREEcRx+T
	WwICrJ4NGb0C45Aw==
To: Wake Liu <wakel@google.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, wakel@google.com
Subject: Re: [PATCH v2] selftests/timers: Consolidate and fix 32-bit
 overflow in timespec_sub
In-Reply-To: <20250915191944.9779-1-wakel@google.com>
References: <fbb55063-ab03-40a9-80f4-4315d12239ba@t-8ch.de>
 <20250915191944.9779-1-wakel@google.com>
Date: Sun, 21 Sep 2025 09:49:54 +0200
Message-ID: <87qzw06y8t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 16 2025 at 03:19, Wake Liu wrote:
> The timespec_sub function, as implemented in several timer

timespec_sub()

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#function-references-in-changelogs

> selftests, is prone to integer overflow on 32-bit systems.
>
> The calculation `NSEC_PER_SEC * b.tv_sec` is performed using
> 32-bit arithmetic, and the result overflows before being
> stored in the 64-bit `ret` variable. This leads to incorrect
> time delta calculations and test failures.
>
> As suggested by tglx, this patch fixes the issue by:

s/this patch fixes/fix/



> 1. Creating a new `static inline` helper function,
>    `timespec_to_ns`, which safely converts a `timespec` to
>    nanoseconds by casting `tv_sec` to `long long` before
>    multiplying with `NSEC_PER_SEC`.
>
> 2. Placing the new helper and a rewritten `timespec_sub` into
>    a common header: tools/testing/selftests/timers/helpers.h.
>
> 3. Removing the duplicated, buggy implementations from all
>    timer selftests and replacing them with an #include of the
>    new header.
>
> This consolidates the code and ensures the calculation is
> correctly performed using 64-bit arithmetic across all tests.

This lacks a Signed-off-by.

> Changes in v2:
>   - Per tglx's feedback, instead of changing NSEC_PER_SEC globally,
>     this version consolidates the buggy timespec_sub() implementations
>     into a new 32-bit safe inline function in a shared header.
>   - Amended the commit message to be more descriptive.

change logs go behind the '---' separator as they are not part of the
commit message. It's documented how to format a change log properly.

> -#define UNREASONABLE_LAT (NSEC_PER_SEC * 5) /* hopefully we resume in 5 secs */
> +#define UNREASONABLE_LAT (NSEC_PER_SEC * 5LL) /* hopefully we resume in 5 secs */

How is this change and the pile of similar ones related to $subject and
why are they required in the first place?
  
> index 000000000000..652f20247091
> --- /dev/null
> +++ b/tools/testing/selftests/timers/helpers.h
> @@ -0,0 +1,31 @@

Lacks a SPDX identifier.

scripts/checkpatch.pl exists for a reason.

Thanks,

        tglx

