Return-Path: <linux-kselftest+bounces-36647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD79AFA347
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 08:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43F71899809
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 06:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF771A841A;
	Sun,  6 Jul 2025 06:27:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0FE14EC46;
	Sun,  6 Jul 2025 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751783235; cv=none; b=S94gypRWOSTY//HZDTp/F31kpIX3a5kHPVwa2jDtFF7P2iUsOsUjCqQ7MTXChHSdmiKyWAqW2IIbLX9zbmY6J5BxxDGP/iFwFr8BesbwPZp6oR7p+pd9YOKhDoHoVvkXjWshoEylBzpHjYApmnGmVws+RO/T5wvNfJsz0giC/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751783235; c=relaxed/simple;
	bh=VzHT7HB0BIcvDwYTr4gRhKia9BechekFeRj5bA4QstU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvRBbHbBzyYMyx5gFBleTfDDaFxaUFUiVE2hh2IitiYHfRfqHm6hqom+IGdt0OXsvFRczVK2HGZJoVy56/EUhr9CJ/gV8QI1CdhOC+KjYa/NUCQno0culZ0anK1a16VBCH/0Bqicdfma7N5pALmy7pAxjsuChmNYzf4VEYbRzlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5666QX0S029665;
	Sun, 6 Jul 2025 08:26:33 +0200
Date: Sun, 6 Jul 2025 08:26:33 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: add support for clock_nanosleep() and
 nanosleep()
Message-ID: <20250706062633.GB29601@1wt.eu>
References: <20250704-nolibc-nanosleep-v1-1-d79c19701952@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250704-nolibc-nanosleep-v1-1-d79c19701952@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Fri, Jul 04, 2025 at 04:19:48PM +0200, Thomas Weißschuh wrote:
> +static __attribute__((unused))
> +int sys_clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqtp,
> +			struct timespec *rmtp)
> +{
> +#if defined(__NR_clock_nanosleep)
> +	return my_syscall4(__NR_clock_nanosleep, clockid, flags, rqtp, rmtp);
> +#elif defined(__NR_clock_nanosleep_time64)
> +	struct __kernel_timespec krqtp, krmtp;
> +	int ret;
> +
> +	__nolibc_timespec_user_to_kernel(rqtp, &krqtp);
> +	ret = my_syscall4(__NR_clock_nanosleep_time64, clockid, flags, &krqtp, &krmtp);
> +	if (rmtp)
> +		__nolibc_timespec_kernel_to_user(&krmtp, rmtp);
> +	return ret;
> +#else
> +	return __nolibc_enosys(__func__, clockid, flags, rqtp, rmtp);
> +#endif

I don't know which archs do not have clock_nanosleep, but if it becomes
needed on some of them, we could probably fall back to pslelect() if
available, of course, and ignore the clockid.

Acked-by: Willy Tarreau <w@1wt.eu>

Cheers,
Willy

