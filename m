Return-Path: <linux-kselftest+bounces-37362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E854B061E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F57A170BDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3FB1D5ADE;
	Tue, 15 Jul 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HzbfP0V8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D9224F6;
	Tue, 15 Jul 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590541; cv=none; b=UAgzKB6vS8JUeiWnyJclP0MZtWFAn+RYDDouZw9L/suxSSpC5pH9U9NGZD9fNADlgsVbR4hD43OWfz5D01lo7N9CZ1Ez1oLCuZ0HZdX019FvjGd3s79uPxB1z7KNwyXj7HfUEhm6uTKtDcTKWOdzmIVIuI6DbYJq6g1fXMO56+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590541; c=relaxed/simple;
	bh=tJY3hqNieRXuGt03nOj1a0lOkzvAlcy9hKEZJaR+VPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMx55ZXQhpYsDRV9Qfjfzm7byjWg2KUnJFndcXFvitN54tH2OMYbcsYetE+BCXM65hBX9xoQ9m0ZW0pgmjfmGRHeFrEVha2/t6DrYcQhtZ13+1vd1LRJswkXfjF6T3x/fwhK1pbbtprNnFER1WLI22RZGIWbx6rFnLjkWwJRPnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HzbfP0V8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752590530;
	bh=tJY3hqNieRXuGt03nOj1a0lOkzvAlcy9hKEZJaR+VPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzbfP0V84jBH+VVk92sJwWmTlWIWiv2C9Avphiqw/PJNaeWceQqILOupWMiJBl/aC
	 HpFo8NhNnUGTrZfnTt6DpwSVcHWuXt7snSd5KnMvWXNXSypl2bo2Xf+WA4QS1MTUIv
	 kiPJSDAXm3RGm7zc4kUDe5TJRIeVFjOBIhvkbL9I=
Date: Tue, 15 Jul 2025 16:42:10 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
	Shuah Khan <shuah@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] tools/nolibc: add support for Alpha
Message-ID: <c39ae47e-8a07-44e3-8d71-d44fa804877d@t-8ch.de>
References: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
 <ceef9e43-5591-4c03-ba51-af1ccc68a05b@linaro.org>
 <6cb31334-8b39-4920-810e-de123898a2e0@t-8ch.de>
 <20250715062809.GA28609@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715062809.GA28609@1wt.eu>

On 2025-07-15 08:28:09+0200, Willy Tarreau wrote:
> Hi,
> 
> On Mon, Jul 14, 2025 at 07:21:38AM +0200, Thomas Weißschuh wrote:
> > Hi Richard,
> > 
> > On 2025-07-13 16:21:58-0600, Richard Henderson wrote:
> > > On 7/13/25 14:08, Thomas Weißschuh wrote:
> > > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > > @@ -709,6 +709,10 @@ int run_startup(int min, int max)
> > > >   	/* checking NULL for argv/argv0, environ and _auxv is not enough, let's compare with sbrk(0) or &end */
> > > >   	extern char end;
> > > >   	char *brk = sbrk(0) != (void *)-1 ? sbrk(0) : &end;
> > > > +#if defined(__alpha__)
> > > > +	/* the ordering above does not work on an alpha kernel */
> > > > +	brk = NULL;
> > > > +#endif
> > > 
> > > The syscall api is different for brk on alpha.
> > > A change to sys_brk or brk in include/nolibc/sys.h is required.
> > 
> > You are referring to osf_brk, right?
> > I think that should work as-is with the current wrappers.
> 
> I finally managed to reinstall my DS10 to build and test this and FWIW
> the test passes:

Thanks for getting real hardware involved!

> 
>   $ ./nolibc-test 
>   Running test 'startup'
>   0 argc = 1                                                        [OK]
>   1 argv_addr = <0x11fc7b428>                                       [OK]
>   2 argv_environ = <0x11fc7b428>                                    [OK]
>   3 argv_total = 1                                                  [OK]
>   4 argv0_addr = <0x11fc7b665>                                      [OK]
>   5 argv0_str = <./nolibc-test>                                     [OK]
>   6 argv0_len = 13                                                  [OK]
>   7 environ_addr = <0x11fc7b438>                                    [OK]
>   8 environ_envp = <0x11fc7b438>                                    [OK]
>   9 environ_auxv = <0x11fc7b438>                                    [OK]
>   10 environ_total = 175                                            [OK]
>   11 environ_HOME = <0x11fc7b6f4>                                   [OK]
>   12 auxv_addr = <0x11fc7b4e8>                                      [OK]
>   13 auxv_AT_UID = 509                                              [OK]
>   14 constructor = 3                                                [OK]
>   15 linkage_errno = <0x1200200f8>                                  [OK]
>   16 linkage_constr = 3                                             [OK]
>   Errors during this test: 0
>   
>   Running test 'syscall'
>   0 access = 0                                                      [OK]
>   1 access_bad = -1 EPERM                                           [OK]
>   2 clock_getres = 0                                                [OK]
>   3 clock_gettime = 0                                               [OK]
>   4 clock_settime = -1 EINVAL                                       [OK]
>   5 getpid = 9201                                                   [OK]
>   6 getppid = 419                                                   [OK]
>   7 gettid = 9201                                                   [OK]
>   8 getpgid_self = 9201                                             [OK]
>   9 getpgid_bad = -1 ESRCH                                          [OK]
>   10 kill_0 = 0                                                     [OK]
>   11 kill_CONT = 0                                                  [OK]
>   12 kill_BADPID = -1 ESRCH                                         [OK]
>   13 sbrk_0 = <0x120024000>                                         [OK]
>   14 sbrk = 0                                                       [OK]
>   15 brk = 0                                                        [OK]
>   (...)
>   Total number of errors: 0
>   Exiting with status 0
> 
> The result is exactly the same if I comment that line that resets brk,
> as brk was apparently already NULL:
> 
>   13 sbrk_0 = <0x120024000>                                         [OK]
>   14 sbrk = 0                                                       [OK]
>   15 brk = 0                                                        [OK]

brk shouldn't be NULL I think. It looks instead like it's 0x120024000.
And it looks weird because the raw numbers look similar to my machine.

>   1 argv_addr = <0x11fc7b428>                                       [OK]

>   13 sbrk_0 = <0x120024000>                                         [OK]

argv is not greater than brk.

Could you double-check your test modification? How does it behave in QEMU for you?
Also could you provide your kernel config?

> > On alpha, mm->brk and mm->arg_start are ordered differently from other
> > architectures. Personally I think the nolibc tests are a bit bogus here.
> 
> I seem to remember that these are among the older minimal consistency
> tests and that it could be time to revisit this :-/

I do like them in general to be fair.

