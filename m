Return-Path: <linux-kselftest+bounces-25514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B257AA24846
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 11:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32576165B23
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A731494D4;
	Sat,  1 Feb 2025 10:34:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21DE17BA5;
	Sat,  1 Feb 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738406093; cv=none; b=bb83xEEAKW1QJs3bkoOyTS3/b4eJbNN8PgdVxPlyvZV+5xc+6OU7wdY9j5BOoTuhuqCS+OhwAsXkOrNNXL4tFeMczb086UuNex8sze5FurQmvyKzQ1PeJRFI2FYruStAkKUiyFJ2YbaJMqbH/5AdKQgYW+8WGTca1gRC23bFf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738406093; c=relaxed/simple;
	bh=nckk6IREeGgepW/yKnetVDAc4LT+8v8kYncfJQzyg5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rinDV3sU229ShDZKOPRDnuarX8HI1J0JnVHQkHJSr8Pey0kUFQBw95LIjh6v5+TBaJkS6TuRuWw1X8QFvCgZYNapNrwske+1PWYFTGDXZ1fbVIMjNn1vJCixMgEl2nd9QZRLsq7a99qoI5Y0s32oYWAsNbIKGdiwRkDuEj6QBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 511AYcgk007838;
	Sat, 1 Feb 2025 11:34:38 +0100
Date: Sat, 1 Feb 2025 11:34:38 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 2/2] tools/nolibc: add support for directory access
Message-ID: <20250201103438.GH5849@1wt.eu>
References: <20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net>
 <20250130-nolibc-dir-v1-2-ea9950b52e29@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250130-nolibc-dir-v1-2-ea9950b52e29@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 30, 2025 at 08:54:03PM +0100, Thomas Weiﬂschuh wrote:
> From: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Add an allocation-free implementation of readdir() and related
> functions. The implementation is modelled after the one for FILE.

I think you'd need to mention/remind the two important points that
come out of that choice, one being that DIR is a fake pointer that
instead stores ~fd so that it can be turned back to a valid FD, and
that subsequent readdir() calls will only work from the same file
unit since it relies on a local static storage.

Better have this visible in the commit message so that in the event
someone faces a difficulty due to this, they can easily find that it's
an on-purpose design choice.

> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> ---
> I'm not entirely sure where to put it. It doesn't really belong into
> stdio.h, but that's where the FILE stuff is.
> sys.h wants alphabetical ordering, but IMO these functions should stick
> together.

My man pages suggest that userland code will include <dirent.h>, thus
I think it could be the moment to create it with that new code.

> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 3892034198dd566d21a5cc0a9f67cf097d428393..1f275a0a7b6b2c6f1c15405d027c282bb77aa618 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
(...)
> +static __attribute__((unused))
> +struct dirent *readdir(DIR *dirp)
> +{
> +	static struct dirent dirent;
> +
> +	char buf[sizeof(struct linux_dirent64) + NAME_MAX];

I'm uncertain where NAME_MAX is defined, I haven't found it in the
nolibc sources, just double-checking that it's not just in your build
environment by accident.

> +	struct linux_dirent64 *ldir = (void *)buf;
> +	intptr_t i = (intptr_t)dirp;
> +	int fd, ret;
> +
> +	if (i >= 0) {
> +		SET_ERRNO(EBADF);
> +		return NULL;
> +	}
> +
> +	fd = ~i;
> +
> +	ret = getdents64(fd, ldir, sizeof(buf));
> +	if (ret == -1 || ret == 0)
> +		return NULL;
> +
> +	/*
> +	 * getdents64() returns as many entries as fit the buffer.
> +	 * readdir() can only return one entry at a time.
> +	 * Make sure the non-returned ones are not skipped.
> +	 */
> +	ret = lseek(fd, ldir->d_off, SEEK_SET);
> +	if (ret == -1)
> +		return NULL;
> +
> +	dirent = (struct dirent) {
> +		.d_ino = ldir->d_ino,
> +	};
> +	strlcpy(dirent.d_name, ldir->d_name, sizeof(dirent.d_name));

Just out of curiosity, could this copy fail, and if so, should we handle
it (e.g. NAME_MAX != 255) ? My guess here is that if it could almost never
fail and checking it would needlessly complicate the function, let's just
handle it with a comment for now. And if it cannot at all, let's mention
why on top of it as well.

Thanks,
Willy

