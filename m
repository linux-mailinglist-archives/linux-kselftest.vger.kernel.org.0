Return-Path: <linux-kselftest+bounces-36361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC4AF632B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 22:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D1E7B595D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 20:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E42D6419;
	Wed,  2 Jul 2025 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z5AO+dcM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QfXg31Yp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC52D6408;
	Wed,  2 Jul 2025 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487310; cv=none; b=t3PDiafs9pd6hS9fkbDRLH+ANe6Psc/8pOWrofdG6B4wAlkr0pw6hjFmbxJu4+Fh/t/0N/WZL8nHCWzSpBI0cKjxcYE4lp6uNF3v5nke4kDoaulbPrOUTZVbqvRpfqqGsegK9oKarF3mOJCJhPuYC4UNhixr/cCI3uSk/qJxzZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487310; c=relaxed/simple;
	bh=xoEzdAXMN+9YNOEQPnHeME9fmdpC2h7BUF6gBBURt/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G3H/1UsTwJPrn6bpQrIwREHr0r9Xrt81mXPN0uCoT+p3uEAqm4K0te4kzA1NItp/7KX4mXqY0Hq4xJH4cKVyrCp5GKmRqDGk9QevyyLZxU1J9IeHQkSsKU4QSPFvzfmZA5+utqNCCwrpBDgSiPtawfGbz4g+g4nLxcrwyfZBPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z5AO+dcM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QfXg31Yp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751487306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JhL+z41on9N9B0503MxBPByf3cm+nR0OppEpbXyGbwM=;
	b=Z5AO+dcMUJjSZuXOBpdwzVRdiewXsbJcnGYGUinI21KQtUefqC2NPNnl10T6jB10Y0zsAY
	ZacG3w265vsoRAi4Sj8KT6BHQaifHIszh9KjhPzNHDrUECKI63k6L/pphJOHeiN2e45lY1
	NBQyI3+xkBtF+mSyARjgIqkLhLH4zLcyrHKiBDx81Y3Wt0OueaU6NgbZNhtV8/23+PhXcC
	HnEDbxmwyYrf3mo1KS+qZpIyBfDRQ9hUaUC2MxBC45z5nNyzVxDJXgFnOMGJI/pJtICH9B
	TJgC4iY0bYsnGZFu1ApuIObtWKodk4LImL96x4Y4raiwRnEMIbZCukpiSov6Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751487306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JhL+z41on9N9B0503MxBPByf3cm+nR0OppEpbXyGbwM=;
	b=QfXg31Yp1L3nUgpqMntcYdcUNxmNo3vHlRMknBHFeJwi9ixPa5OnZI2vgfLv/fmJtx5AAq
	gC2EruvjFfcnPVAA==
To: Terry Tritton <terry.tritton@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: ttritton@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Terry Tritton <terry.tritton@linaro.org>,
 Wei Gao <wegao@suse.com>
Subject: Re: [PATCH v3] selftests/futex: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
In-Reply-To: <20250702102157.5222-1-terry.tritton@linaro.org>
References: <20250702102157.5222-1-terry.tritton@linaro.org>
Date: Wed, 02 Jul 2025 22:15:06 +0200
Message-ID: <87y0t6jqnp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 02 2025 at 11:21, Terry Tritton wrote:

> Futex_waitv can not accept old_timespec32 struct, so userspace should

sys_futex_wait()

> convert it from 32bit to 64bit before syscall in 32bit compatible mode.
>
> This fix is based off [1]
>
> Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]
>
> Originally-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
> ---
> Changes in v3:
> - Fix signed-off-by chain but for real this time
>
> Changes in v2:
> - Fix signed-off-by chain
>
>  .../testing/selftests/futex/include/futex2test.h  | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
> index ea79662405bc..6780e51eb2d6 100644
> --- a/tools/testing/selftests/futex/include/futex2test.h
> +++ b/tools/testing/selftests/futex/include/futex2test.h
> @@ -55,6 +55,13 @@ struct futex32_numa {
>  	futex_t numa;
>  };
>  
> +#if !defined(__LP64__)
> +struct timespec64 {
> +	int64_t tv_sec;
> +	int64_t tv_nsec;
> +};
> +#endif

Why not use __kernel_timespec which is the actual data type that syscall
requests?

> +
>  /**
>   * futex_waitv - Wait at multiple futexes, wake on any
>   * @waiters:    Array of waiters
> @@ -65,7 +72,15 @@ struct futex32_numa {
>  static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
>  			      unsigned long flags, struct timespec *timo, clockid_t clockid)
>  {
> +#if !defined(__LP64__)
> +	struct timespec64 timo64 = {0};
> +
> +	timo64.tv_sec = timo->tv_sec;
> +	timo64.tv_nsec = timo->tv_nsec;
> +	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &timo64, clockid);
> +#else
>  	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
> +#endif

You simply can do

        struct __kernel_timespec ts = {
        	.tv_sec = timo->tv_sec,
                .tv_nsec = timo->tv_nsec,
        };

  	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts, clockid);
        
unconditionally. No?

Thanks,

        tglx

