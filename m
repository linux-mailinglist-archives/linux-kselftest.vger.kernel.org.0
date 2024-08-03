Return-Path: <linux-kselftest+bounces-14773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3250946AE3
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631CFB215D5
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C396182DB;
	Sat,  3 Aug 2024 18:33:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4811C22F08;
	Sat,  3 Aug 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722710013; cv=none; b=kYnpR3QP2NsIHx27j8V8jkwrhgWNYF8BFPfHjjzZXyXYAv16izlPg7itbJ82ZJbjx5PW3WKA1CVLnRKbDBtEUpWqRCXlUSYI+jZUp2t1nymM11TjumBag2e8Xmp6Nym/tNTlZt9amNxv5WCkeB8dD15S+QWZML+eyB1Tbu1M1m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722710013; c=relaxed/simple;
	bh=ync8Lgc8m0+f2VOPKpVzscPcZIlg6f4EqqLLNNPBmLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqEsOtrmwDs1LE2mJLETAPPYEK5h1hkC33IKIEYPp1P7mSHqjg5r1ArlwiSHoXObNKwBp9iRx4rRBBLqi6F20Dj9Q+GQOa64Zn9rZv0qBhhtIG64Te3O+9yK5vJkRnXrct1wbDrJGZF3mmi9smrI7W/fjn8MSXS1HtyiW3cBKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 473IXOTw029722;
	Sat, 3 Aug 2024 20:33:24 +0200
Date: Sat, 3 Aug 2024 20:33:24 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 06/12] selftests/nolibc: avoid passing NULL to
 printf("%s")
Message-ID: <20240803183324.GB29716@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <20240728-nolibc-llvm-v1-6-bc384269bc35@weissschuh.net>
 <20240803093355.GC29127@1wt.eu>
 <94a81790-1385-43d4-ab67-9a6029e245de@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94a81790-1385-43d4-ab67-9a6029e245de@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Aug 03, 2024 at 08:29:14PM +0200, Thomas Weißschuh  wrote:
> Aug 3, 2024 11:34:03 Willy Tarreau <w@1wt.eu>:
> 
> > On Sun, Jul 28, 2024 at 12:10:00PM +0200, Thomas Weißschuh wrote:
> >> Clang on higher optimization levels detects that NULL is passed to
> >> printf("%s") and warns about it.
> >> Avoid the warning.
> >
> > I don't see why this would be a problem, we do explicitly check for
> > NULL in our printf implementation and print "(null)". Or maybe it is
> > upset due to the attribute(printf) ? I don't know what the standard
> > says regarding %s and NULL, though. If it says that NULL is forbidden
> > then I can understand the warning and your fix is indeed correct. In
> > any case it's not worth fighting with a compiler for nolibc-test, but
> > it's probably worth mentioning in the commit message that it warns
> > despite the check being already done.
> 
> It's undefined as per POSIX.
> I'll update the commit message.

OK, works for me!

Thanks,
Willy

