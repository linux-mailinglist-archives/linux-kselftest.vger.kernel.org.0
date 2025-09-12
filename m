Return-Path: <linux-kselftest+bounces-41427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FF8B55895
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 23:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C470D1CC477D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 21:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63DB2D2494;
	Fri, 12 Sep 2025 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tFP9k03y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dcd6fEft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18B2D0C96;
	Fri, 12 Sep 2025 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713500; cv=none; b=bXt++6OTyoWCiOxK1eS2g6Xy2D/S3/OaCgzVhVUR0ObDFaInamPzWwNe67BKVG1+njWHvSIy4vXJTMnaXmMwgbmaECvVkCKrY5iEGtciA+iLLWF8xo5v5fHUnALyJ1iokuyy3mV5O6JNgWrv0QvyzCGpZOdOkx8BDRjptQJkYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713500; c=relaxed/simple;
	bh=3bwpwH96FGD43V8N+Qioew5g8bhS8VcWR9Aib1bPJ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL04y4q3yIdEZSVH0ye6Ja5oEJq0bMcK5kBjhDPDn9+EA07AnurJL9aNlBWfyKyeoNTpJenZ+SjcXKFMhA+sa+woU4ksc+FPoakah9RHYSwosUDZZRhH4di1f1Q984jiCqO5PVHpa+Ba9stXBVmfQw/EeXRoJjah0nT2iMk2Nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tFP9k03y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dcd6fEft; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Sep 2025 23:44:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757713496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXTiwDjhcLaZDRFliKAViVaEmmpH7tw9UemheZXgpg4=;
	b=tFP9k03yleUE+hUQQynXhdIOm/FkEhl/zD3OwnTDv0FfPOphL6g2cXZjoonkRd90+U63kH
	YEMPEZfOoGSijGRCUQv4sCYJd1oBCXzShm/Btq+f10c5i11gfn7YXhtaENu6rOLcxOgia/
	sMMc9G8Bly5A//qqGTlveWvn2BYbWz10Q/FGlnphechNlp0Pdn70leOS+SZPiG9PPbMAOW
	pqfQNH74I8e0wIoQ6uwXXX4Um2qv1je+8qHl+HFc8aiQur0V6IRzIdtQWEmgO+0Ql1SjTd
	vsfqYJFNScY+9kCJhso97lffNl5QfaAp76rMZc8zGD9GnAopp0LfgGIvDrHBdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757713496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXTiwDjhcLaZDRFliKAViVaEmmpH7tw9UemheZXgpg4=;
	b=dcd6fEftFXzYf28tjOHQN/2x/RgZ27pswBmj/oUcB0QKOEkwZWTlL09pQSYvVt6PLv+yBy
	XhNLbphNGB7ErkBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wake Liu <wakel@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/futex: Conditionally run futex_numa_mpol test
Message-ID: <20250912214454.t0qhEqT2@linutronix.de>
References: <20250908113721.4031242-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908113721.4031242-1-wakel@google.com>

On 2025-09-08 19:37:20 [+0800], Wake Liu wrote:
> The futex_numa_mpol test requires libnuma, which is not available on
> all platforms. When the test is not built, the run.sh script fails
> because it unconditionally tries to execute the test binary.
> 
> Check for the futex_numa_mpol executable before running it. If the
> binary is not present, print a skip message and continue.
> 
> This allows the test suite to run successfully on platforms that do
> not have libnuma and therefore do not build the futex_numa_mpol
> test.

If you skip the test, how to you compile this?
Does
	https://lore.kernel.org/all/20250818135458.F352St6W@linutronix.de/

help?

> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  tools/testing/selftests/futex/functional/run.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
> index 81739849f299..f3e43eb806bf 100755
> --- a/tools/testing/selftests/futex/functional/run.sh
> +++ b/tools/testing/selftests/futex/functional/run.sh
> @@ -88,4 +88,8 @@ echo
>  ./futex_priv_hash -g $COLOR
>  
>  echo
> -./futex_numa_mpol $COLOR
> +if [ -x ./futex_numa_mpol ]; then
> +    ./futex_numa_mpol $COLOR
> +else
> +    echo "SKIP: futex_numa_mpol (not built)"
> +fi

Sebastian

