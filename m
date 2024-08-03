Return-Path: <linux-kselftest+bounces-14766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634EA9468FD
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 12:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7141C20D89
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5B8175B;
	Sat,  3 Aug 2024 10:03:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FE823CB;
	Sat,  3 Aug 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722679406; cv=none; b=T60RX+FlNNU/ylozuXKZ3MYA1aT9RyPr2tzgEJ5UICvPjbeITSZkzJDm+az6hfWSrCLRtAXfAtM7PhIqRefoS7ein/jnnNUsnSEtaZFNpbPqMbHnciqJzSClqDmQxQl3dKLd7tfgRH3+i7pQ1PlxSWUbI9gbonxkFgQ5Rbv93s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722679406; c=relaxed/simple;
	bh=XgHkizURW65cUDWDv0m9inMJ7WqKs0VsoSHsx1KsFrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKb1qkUceIH6IUO6598oRrWJF+PYd+PbNUrKW/hJGWuZPUUqNP4t1j7YJnOqHai3dfL/8XjWysAgX2JmhrOg+GPbkUJMjdT6gBfK+KOepLRxkwe8KkYJqIo4D62RI8CQes/ugJQvlTolR6EVbJNhAA8zSc2QpKcWTIuSVG03uYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 473A3IfX029300;
	Sat, 3 Aug 2024 12:03:18 +0200
Date: Sat, 3 Aug 2024 12:03:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: pass argc, argv and envp to constructors
Message-ID: <20240803100318.GG29127@1wt.eu>
References: <20240728-nolibc-constructor-args-v1-1-36d0bf5cd4c0@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240728-nolibc-constructor-args-v1-1-36d0bf5cd4c0@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jul 28, 2024 at 10:34:11PM +0200, Thomas Weißschuh wrote:
> Mirror glibc behavior for compatibility.

Generally speaking I think you should make a bit longer sentences in
your commit messages, Thomas. One first reason is to think that during
reviews the reviewer has to scroll up to find the subject for the context
this sentence applies to. And doing so quickly encourages to give a little
bit more background to justify a change. I have a simple principle that
works reasonably fine for this, which is that a commit subject should
normally be unique in a project (modulo rare cases, reverts or accidents)
and that commit message bodies should really always be unique. Here we
see that it doesn't work ;-)

An example could be something like this:

  Glibc has been passing argc/argv/envp to constructors since version XXX.
  This is particularly convenient, and missing it can significantly
  complicate some ports to nolibc. Let's do the same since it's an easy
  change that comes at no cost.

Anyway I agree with the change, I wasn't aware of this support from glibc,
so thank you for enlighting me on this one ;-)

Willy

