Return-Path: <linux-kselftest+bounces-25515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF0A24851
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 11:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1748C7A2DA2
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 10:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430E14B955;
	Sat,  1 Feb 2025 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Z8yiu3H7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF7A13D504;
	Sat,  1 Feb 2025 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738406524; cv=none; b=e+eeYi0EH6DcDUT3H7wQqXFbg4RTSzhzvDmKOCq1mAWxVN+q9YBL18n2Zj6X+x3ZAjB9lhCsY54hX+NOtX7U+rJ78eibU+sVkdAads8JTs+uKEUlEp6UuDe83iki3mjhaVjDPZjCDz4IGJfepiLmL97easbn2dvRsBpcUZYQmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738406524; c=relaxed/simple;
	bh=7C1Qm5Tgg8X+QkmBbIp2/yIRmTvSnBBB8JVQBtsEKdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJaGHhrljvPi4QLrXp+G68lmqOjPXkio4mEufnoh4EREIZajRaz2dh/p17x9G1n0inwFZDLLYubh/hQeLCxWjyCNJsB+WnwOWQ4jXeKASJfTSyBY+QLc+pJjwFLwQwjSbOBozVt7dkB1rP4v3JNN32doOkwJp/7g0v4W/fBBey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Z8yiu3H7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738406519;
	bh=7C1Qm5Tgg8X+QkmBbIp2/yIRmTvSnBBB8JVQBtsEKdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8yiu3H7862w94zb7U317SLxpE+rp4pCtcxOCOPDXTul9YFdNv/5+gVba2PQ4azfC
	 UHHsu9ZHGcnn57iZzDZXmUOjBzcXBVVNk5m4A23CKdVyPv1q45jhIhLR8w6odFF6BY
	 I8muUCxUZIyaaJKrUEvkdR3IKt9uBa9a0UQIuwc0=
Date: Sat, 1 Feb 2025 11:41:58 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 2/2] tools/nolibc: add support for directory access
Message-ID: <58dbcb3c-5d5a-4f81-ac42-494b1fcaf932@t-8ch.de>
References: <20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net>
 <20250130-nolibc-dir-v1-2-ea9950b52e29@weissschuh.net>
 <20250201103438.GH5849@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201103438.GH5849@1wt.eu>

On 2025-02-01 11:34:38+0100, Willy Tarreau wrote:
> On Thu, Jan 30, 2025 at 08:54:03PM +0100, Thomas Weißschuh wrote:
> > From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > 
> > Add an allocation-free implementation of readdir() and related
> > functions. The implementation is modelled after the one for FILE.
> 
> I think you'd need to mention/remind the two important points that
> come out of that choice, one being that DIR is a fake pointer that
> instead stores ~fd so that it can be turned back to a valid FD, and
> that subsequent readdir() calls will only work from the same file
> unit since it relies on a local static storage.

Point one is true.
Point two not so much. It is fine to have multiple directories open at
the same time. All state is kept inside the kernel.
Only the *current* return value is in the static buffer.
So multithreading wouldn't work, but nolibc doesn't support that
anyways.

> Better have this visible in the commit message so that in the event
> someone faces a difficulty due to this, they can easily find that it's
> an on-purpose design choice.

Ack.

> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > 
> > ---
> > I'm not entirely sure where to put it. It doesn't really belong into
> > stdio.h, but that's where the FILE stuff is.
> > sys.h wants alphabetical ordering, but IMO these functions should stick
> > together.
> 
> My man pages suggest that userland code will include <dirent.h>, thus
> I think it could be the moment to create it with that new code.

Ack. Now that you suggest it, it seems obvious.

> > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> > index 3892034198dd566d21a5cc0a9f67cf097d428393..1f275a0a7b6b2c6f1c15405d027c282bb77aa618 100644
> > --- a/tools/include/nolibc/stdio.h
> > +++ b/tools/include/nolibc/stdio.h
> (...)
> > +static __attribute__((unused))
> > +struct dirent *readdir(DIR *dirp)
> > +{
> > +	static struct dirent dirent;
> > +
> > +	char buf[sizeof(struct linux_dirent64) + NAME_MAX];
> 
> I'm uncertain where NAME_MAX is defined, I haven't found it in the
> nolibc sources, just double-checking that it's not just in your build
> environment by accident.

It comes from linux/limits.h. I don't think it can ever go away.

> > +	struct linux_dirent64 *ldir = (void *)buf;
> > +	intptr_t i = (intptr_t)dirp;
> > +	int fd, ret;
> > +
> > +	if (i >= 0) {
> > +		SET_ERRNO(EBADF);
> > +		return NULL;
> > +	}
> > +
> > +	fd = ~i;
> > +
> > +	ret = getdents64(fd, ldir, sizeof(buf));
> > +	if (ret == -1 || ret == 0)
> > +		return NULL;
> > +
> > +	/*
> > +	 * getdents64() returns as many entries as fit the buffer.
> > +	 * readdir() can only return one entry at a time.
> > +	 * Make sure the non-returned ones are not skipped.
> > +	 */
> > +	ret = lseek(fd, ldir->d_off, SEEK_SET);
> > +	if (ret == -1)
> > +		return NULL;
> > +
> > +	dirent = (struct dirent) {
> > +		.d_ino = ldir->d_ino,
> > +	};
> > +	strlcpy(dirent.d_name, ldir->d_name, sizeof(dirent.d_name));
> 
> Just out of curiosity, could this copy fail, and if so, should we handle
> it (e.g. NAME_MAX != 255) ? My guess here is that if it could almost never
> fail and checking it would needlessly complicate the function, let's just
> handle it with a comment for now. And if it cannot at all, let's mention
> why on top of it as well.

If NAME_MAX changes it would be a userspace regression IMO.
I'll add a comment.


Thanks!
Thomas

