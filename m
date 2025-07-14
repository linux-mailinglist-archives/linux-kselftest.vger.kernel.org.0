Return-Path: <linux-kselftest+bounces-37223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68A0B03586
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 07:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A11763CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 05:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0DC1E1DE7;
	Mon, 14 Jul 2025 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dkEP3VwA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE734CF9;
	Mon, 14 Jul 2025 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470503; cv=none; b=oqoBaviWzmVGriVm0YGONrtthOSTUOWHxIuAtlwzZxqzk76buxk0EgZxeNRE15fh9tyNMXbm01kq+DcYR42lVtw5v+XXqxV9xB2fMJxwyS9blbcWHEmSJJf8jGohERFYm+hQgZJe/gjKURSERxRiqwnilPtfF+yKprsWcMX6RwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470503; c=relaxed/simple;
	bh=/BiSzimMSvNh/AKevqHPH8cH7nKlihij6DZUgRmNu3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg6agmMHlr3eFU+LLtbTB3yaZzvvfgD7KBMC+L+I+ae2zc40PStb5PK3xaSeWie6oBx70opWWT2Fh/vpUiJ4EuyiII8N0452vIqUnSxXTlcmTWXB70CY0ltCa64JzFBNXQ9j8kTsKVFLy/BCcbGVoKbqp+rpWAxLF12tbwhCM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dkEP3VwA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752470499;
	bh=/BiSzimMSvNh/AKevqHPH8cH7nKlihij6DZUgRmNu3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkEP3VwA0gFNJxxIsOGau5WreWEW9znwrimCJWF9oX/6y0kHFDbVkfPIU5PJzTwKw
	 kiKYlArHtDudA4iRLGr4Mnc9NZ2wlA5XJecDsD75ITkaWGsiiblb94MrI+EENyEXD5
	 yLwzpb1N9f8QBRNEdFBUPq/5EaUzJp1I/EZuCIQ0=
Date: Mon, 14 Jul 2025 07:21:38 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] tools/nolibc: add support for Alpha
Message-ID: <6cb31334-8b39-4920-810e-de123898a2e0@t-8ch.de>
References: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
 <ceef9e43-5591-4c03-ba51-af1ccc68a05b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ceef9e43-5591-4c03-ba51-af1ccc68a05b@linaro.org>

Hi Richard,

On 2025-07-13 16:21:58-0600, Richard Henderson wrote:
> On 7/13/25 14:08, Thomas Weißschuh wrote:
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -709,6 +709,10 @@ int run_startup(int min, int max)
> >   	/* checking NULL for argv/argv0, environ and _auxv is not enough, let's compare with sbrk(0) or &end */
> >   	extern char end;
> >   	char *brk = sbrk(0) != (void *)-1 ? sbrk(0) : &end;
> > +#if defined(__alpha__)
> > +	/* the ordering above does not work on an alpha kernel */
> > +	brk = NULL;
> > +#endif
> 
> The syscall api is different for brk on alpha.
> A change to sys_brk or brk in include/nolibc/sys.h is required.

You are referring to osf_brk, right?
I think that should work as-is with the current wrappers.
On alpha, mm->brk and mm->arg_start are ordered differently from other
architectures. Personally I think the nolibc tests are a bit bogus here.


Thomas

