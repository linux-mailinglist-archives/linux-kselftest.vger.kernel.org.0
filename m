Return-Path: <linux-kselftest+bounces-37405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EA2B06E3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 08:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601023B368E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 06:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8210B28751D;
	Wed, 16 Jul 2025 06:51:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E528507C;
	Wed, 16 Jul 2025 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648669; cv=none; b=SmiO6ZA+2VPMUULU3W0wSkd2ly7n629i8I8BIJWuEb/0kkqO0MEz90AlEH/4BR53N/ooB2ePtXOoUPi/Nro2hVGJLy5u5QbBB2ecbRYu5WL1g+4MoJq8FyYgICeIh4Y6r0AqgP+F7lx5Uo8ncXgeLRGLYKitlZ4angCS1g1W8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648669; c=relaxed/simple;
	bh=rsl1d40tFD5sYVAn0ZPymV19Zpt5kKaJdMHgmZOE70g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgyB4U46DYfjAyJylxK47iCR8+VN6dR7HBBy1Pg2elohdpajQB+ucHNdcWvXLbxAgbMiSU5C7kogNGielBFHv1tvV3902w/mUj1kLAtE5SQwMlMsLsXDy/2IKhDzIi7kyPDWxmkAogFSgdHdcbjJiKeLTu+ATBXxJHoZrWPu/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 56G6ohoC030763;
	Wed, 16 Jul 2025 08:50:43 +0200
Date: Wed, 16 Jul 2025 08:50:43 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Richard Henderson <richard.henderson@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Matt Turner <mattst88@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] tools/nolibc: add support for Alpha
Message-ID: <20250716065043.GA30755@1wt.eu>
References: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
 <ceef9e43-5591-4c03-ba51-af1ccc68a05b@linaro.org>
 <6cb31334-8b39-4920-810e-de123898a2e0@t-8ch.de>
 <20250715062809.GA28609@1wt.eu>
 <c39ae47e-8a07-44e3-8d71-d44fa804877d@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c39ae47e-8a07-44e3-8d71-d44fa804877d@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 15, 2025 at 04:42:10PM +0200, Thomas Weißschuh wrote:
> > I finally managed to reinstall my DS10 to build and test this and FWIW
> > the test passes:
> 
> Thanks for getting real hardware involved!

You're welcome, I was happy to revive it after 15yr of downtime and
upgrade it from 2.4.37 to 6.12 ;-)

> > The result is exactly the same if I comment that line that resets brk,
> > as brk was apparently already NULL:
> > 
> >   13 sbrk_0 = <0x120024000>                                         [OK]
> >   14 sbrk = 0                                                       [OK]
> >   15 brk = 0                                                        [OK]
> 
> brk shouldn't be NULL I think. It looks instead like it's 0x120024000.
> And it looks weird because the raw numbers look similar to my machine.
> 
> >   1 argv_addr = <0x11fc7b428>                                       [OK]
> 
> >   13 sbrk_0 = <0x120024000>                                         [OK]
> 
> argv is not greater than brk.
> 
> Could you double-check your test modification?

I only commented out the "brk = NULL;" line enclosed in the
"#if defined(__alpha__)" block. But I can recheck everything. I
must say, the machine is old and super slow, I untarred a kernel
and applied the for-next patches then your alpha series on top
of it. Cloning via git would take a day or two based on my
experience with haproxy which is hundreds of times smaller...

> How does it behave in QEMU for you?

Not tested.

> Also could you provide your kernel config?

I could but for this I'll need to find a way to access it again. For an
unknown reason the console stopped responding yesterday, and now it only
speaks but I cannot enter anything. I suspect a voltage issue (same with
two adapters). Anyway it was the default config from the 6.12 debian 13
kernel apparently.

Will report back when I figure out this console issue (I'm still having
machines with real serial ports anyway).

Willy

