Return-Path: <linux-kselftest+bounces-37328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AFBB051BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 08:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09F25603EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 06:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BCD2D3EDD;
	Tue, 15 Jul 2025 06:28:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC82D0283;
	Tue, 15 Jul 2025 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560916; cv=none; b=mfeb9Tkp6Bm6O5Wuxq8Zu96oalp2/1wb4HugiOFuYc8oXjSuMd2cJ8rRqVTomZnc42hDnNB6LlF2KgqBITtibFqHx28dCwSRTr40JEMWSYrowKgxDPqbissmCmudOiAvHaxhiTZbsBa9vBC5uUsm+/V5ZUpfMbwnIMDTMcVMAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560916; c=relaxed/simple;
	bh=NRAKPipTn7XBaLaJuYTXRaaKr7Jvhummy7DyQx9NvCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o217fExosq3ywXOuQMinrVCXpb9eVgF4feCfueiL0smlr2BtiiDfaCYSbkqH5boDFNlAaIKmh+bcA90VLv+dzna1mw5ik2g0aQ3vTkOxy6o+DNqU76yUv09ybc1ljaH5yOZBD3aJZwM3G97FlDZGzvDCggN8ITOmzcRGg7lmhqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 56F6S9eY028621;
	Tue, 15 Jul 2025 08:28:09 +0200
Date: Tue, 15 Jul 2025 08:28:09 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Richard Henderson <richard.henderson@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Matt Turner <mattst88@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] tools/nolibc: add support for Alpha
Message-ID: <20250715062809.GA28609@1wt.eu>
References: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
 <ceef9e43-5591-4c03-ba51-af1ccc68a05b@linaro.org>
 <6cb31334-8b39-4920-810e-de123898a2e0@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cb31334-8b39-4920-810e-de123898a2e0@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi,

On Mon, Jul 14, 2025 at 07:21:38AM +0200, Thomas Weißschuh wrote:
> Hi Richard,
> 
> On 2025-07-13 16:21:58-0600, Richard Henderson wrote:
> > On 7/13/25 14:08, Thomas Weißschuh wrote:
> > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > @@ -709,6 +709,10 @@ int run_startup(int min, int max)
> > >   	/* checking NULL for argv/argv0, environ and _auxv is not enough, let's compare with sbrk(0) or &end */
> > >   	extern char end;
> > >   	char *brk = sbrk(0) != (void *)-1 ? sbrk(0) : &end;
> > > +#if defined(__alpha__)
> > > +	/* the ordering above does not work on an alpha kernel */
> > > +	brk = NULL;
> > > +#endif
> > 
> > The syscall api is different for brk on alpha.
> > A change to sys_brk or brk in include/nolibc/sys.h is required.
> 
> You are referring to osf_brk, right?
> I think that should work as-is with the current wrappers.

I finally managed to reinstall my DS10 to build and test this and FWIW
the test passes:

  $ ./nolibc-test 
  Running test 'startup'
  0 argc = 1                                                        [OK]
  1 argv_addr = <0x11fc7b428>                                       [OK]
  2 argv_environ = <0x11fc7b428>                                    [OK]
  3 argv_total = 1                                                  [OK]
  4 argv0_addr = <0x11fc7b665>                                      [OK]
  5 argv0_str = <./nolibc-test>                                     [OK]
  6 argv0_len = 13                                                  [OK]
  7 environ_addr = <0x11fc7b438>                                    [OK]
  8 environ_envp = <0x11fc7b438>                                    [OK]
  9 environ_auxv = <0x11fc7b438>                                    [OK]
  10 environ_total = 175                                            [OK]
  11 environ_HOME = <0x11fc7b6f4>                                   [OK]
  12 auxv_addr = <0x11fc7b4e8>                                      [OK]
  13 auxv_AT_UID = 509                                              [OK]
  14 constructor = 3                                                [OK]
  15 linkage_errno = <0x1200200f8>                                  [OK]
  16 linkage_constr = 3                                             [OK]
  Errors during this test: 0
  
  Running test 'syscall'
  0 access = 0                                                      [OK]
  1 access_bad = -1 EPERM                                           [OK]
  2 clock_getres = 0                                                [OK]
  3 clock_gettime = 0                                               [OK]
  4 clock_settime = -1 EINVAL                                       [OK]
  5 getpid = 9201                                                   [OK]
  6 getppid = 419                                                   [OK]
  7 gettid = 9201                                                   [OK]
  8 getpgid_self = 9201                                             [OK]
  9 getpgid_bad = -1 ESRCH                                          [OK]
  10 kill_0 = 0                                                     [OK]
  11 kill_CONT = 0                                                  [OK]
  12 kill_BADPID = -1 ESRCH                                         [OK]
  13 sbrk_0 = <0x120024000>                                         [OK]
  14 sbrk = 0                                                       [OK]
  15 brk = 0                                                        [OK]
  (...)
  Total number of errors: 0
  Exiting with status 0

The result is exactly the same if I comment that line that resets brk,
as brk was apparently already NULL:

  13 sbrk_0 = <0x120024000>                                         [OK]
  14 sbrk = 0                                                       [OK]
  15 brk = 0                                                        [OK]

> On alpha, mm->brk and mm->arg_start are ordered differently from other
> architectures. Personally I think the nolibc tests are a bit bogus here.

I seem to remember that these are among the older minimal consistency
tests and that it could be time to revisit this :-/

Willy

