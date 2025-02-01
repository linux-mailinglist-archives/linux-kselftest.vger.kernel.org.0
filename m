Return-Path: <linux-kselftest+bounces-25516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DCA24853
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 11:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603723A7FF9
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE0A14AD19;
	Sat,  1 Feb 2025 10:47:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2333119A;
	Sat,  1 Feb 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738406826; cv=none; b=rzoTzb14zC64RxuBXB1mbO32yedh4Uoin9H3JOXZWheW4RZHqlLauR/OFPbb/onsmo6mc0hgzxHi76aEZw9YjYrAZLyBybOYudpus2zmR8zfwFF/2kVgM8l3u/Whj3x3fhltmLglIFoX7zeYW0INb9oUH0q65nNrfXMmALkUHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738406826; c=relaxed/simple;
	bh=yIzuzElCgQQb6/6GBQQZSKuZExTmtFdbaE9T6tcEsb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA3Idjy4olt2/F+8ehtelIlKFkeePsYD1aAgeb0RnH4mN5/09owxOjWgkRrQJHk+c2+rWCuU4zKixqG8G+vJXYjl2TEFVQsglz8mkUej7JKqKULScMkOF2kix4ctGS4A61eqUQorXxvIPwonUKhp9F4Xi99aS9OutDJ/r7GEPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 511Akx0L008336;
	Sat, 1 Feb 2025 11:46:59 +0100
Date: Sat, 1 Feb 2025 11:46:59 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 2/2] tools/nolibc: add support for directory access
Message-ID: <20250201104659.GA8168@1wt.eu>
References: <20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net>
 <20250130-nolibc-dir-v1-2-ea9950b52e29@weissschuh.net>
 <20250201103438.GH5849@1wt.eu>
 <58dbcb3c-5d5a-4f81-ac42-494b1fcaf932@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58dbcb3c-5d5a-4f81-ac42-494b1fcaf932@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Feb 01, 2025 at 11:41:58AM +0100, Thomas Weiﬂschuh wrote:
> On 2025-02-01 11:34:38+0100, Willy Tarreau wrote:
> > On Thu, Jan 30, 2025 at 08:54:03PM +0100, Thomas Weiﬂschuh wrote:
> > > From: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > 
> > > Add an allocation-free implementation of readdir() and related
> > > functions. The implementation is modelled after the one for FILE.
> > 
> > I think you'd need to mention/remind the two important points that
> > come out of that choice, one being that DIR is a fake pointer that
> > instead stores ~fd so that it can be turned back to a valid FD, and
> > that subsequent readdir() calls will only work from the same file
> > unit since it relies on a local static storage.
> 
> Point one is true.
> Point two not so much. It is fine to have multiple directories open at
> the same time. All state is kept inside the kernel.
> Only the *current* return value is in the static buffer.

Excellent point! It also needs to be mentioned.

> So multithreading wouldn't work, but nolibc doesn't support that
> anyways.

Not only that, but it also means recursive directory scanning is not
possible either, this definitely deserve being mentioned!

That's something we could improve in the future if there is some demand,
by also keeping a static "level" and use a hand-built stack. But let's
not overengineer something that nobody asked for yet ;-)

> > > I'm not entirely sure where to put it. It doesn't really belong into
> > > stdio.h, but that's where the FILE stuff is.
> > > sys.h wants alphabetical ordering, but IMO these functions should stick
> > > together.
> > 
> > My man pages suggest that userland code will include <dirent.h>, thus
> > I think it could be the moment to create it with that new code.
> 
> Ack. Now that you suggest it, it seems obvious.

Obvious is always the hardest thing to find as it's assumed to be known
and is rarely documented ;-)

> > I'm uncertain where NAME_MAX is defined, I haven't found it in the
> > nolibc sources, just double-checking that it's not just in your build
> > environment by accident.
> 
> It comes from linux/limits.h. I don't think it can ever go away.

Ah fine then!

> > Just out of curiosity, could this copy fail, and if so, should we handle
> > it (e.g. NAME_MAX != 255) ? My guess here is that if it could almost never
> > fail and checking it would needlessly complicate the function, let's just
> > handle it with a comment for now. And if it cannot at all, let's mention
> > why on top of it as well.
> 
> If NAME_MAX changes it would be a userspace regression IMO.
> I'll add a comment.

Perfect! Consider an acked-by from me on the next one as I'm generally
fine with the principles.

Willy

