Return-Path: <linux-kselftest+bounces-23726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373A29FA577
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Dec 2024 12:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3161622E4
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Dec 2024 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50206158DC4;
	Sun, 22 Dec 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="U5YmYccQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E3131E2D;
	Sun, 22 Dec 2024 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734867549; cv=none; b=VlHpkNjJC6ATnfwiNsww2eN60JK+okMRFZTsCH5ndDIq4IisHZswt4nhX3gA7ReVv3cM1kbAw8RWCci6rKCH6//wP9dQ1jEYPc2m4vdl73lzOommY8UXh5e+iUoMQWhb+ERdekwOJXi08zwrmXtE729cuMA5nKulsOXN5q4zG2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734867549; c=relaxed/simple;
	bh=YPw6sMaDMzAuh1Vjj/VL1FTkNY/UOx5jYTXHVNGYTts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCGVPAvdazlo4WEp/GfcaJmtjWsXxpcBsry4/pqlyOt424LnoP0krM+YEfyAQgUM6HtZ0no9w8Jyv9VfzSYzOQqc+hHzv0QzRpI1zVk3BGwAD2SPhmQ9l6UVe3NaC28G0FtNwL/5E+MxWp/S+y2N3XskyK9XByhzorOkIatf5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=U5YmYccQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734867542;
	bh=YPw6sMaDMzAuh1Vjj/VL1FTkNY/UOx5jYTXHVNGYTts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5YmYccQ8QsUZuEHcBgt9b/0DxV/PbWZ9oM7L875luoqZl+AzzW3MKUoNf1ql8QVg
	 PtA0+b617zdYsX24vztrIdVBeDS1M3tfvsUhsIoNYcsRCEKTCo4gEFlNv67Gfg1u6V
	 LSisdAK6Z0NCFH6lLcOzofXeNC92Ab3Zv73bl2uE=
Date: Sun, 22 Dec 2024 12:39:01 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH 1/6] tools/nolibc: add support for waitid()
Message-ID: <732f202e-c0de-493e-adec-59fe069b17c9@t-8ch.de>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
 <20241221-nolibc-rv32-v1-1-d9ef6dab7c63@weissschuh.net>
 <20241221163540.GA11984@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241221163540.GA11984@1wt.eu>

Hi Willy!

On 2024-12-21 17:35:40+0100, Willy Tarreau wrote:
> On Sat, Dec 21, 2024 at 03:44:28PM +0100, Thomas Weißschuh wrote:
> > waitid() is the modern variant of the family of wait-like syscalls.
> > Some architectures have dropped support for wait(), wait4() and waitpid()
> > but all of them support waitid().
> > It is more flexible and easier to use than the older ones.
> 
> I'm generally fine with the series, but I'm starting to get concerned
> that some simple applications that used to rely on wait() or waitpid()
> will not work on this architecture. Just like we did for some early
> syscalls that got replaced (e.g. open->openat etc), I think we'll have
> to implement a default wrapper relying on waitid() for all these calls
> in this case, and maybe as well for lseek->llseek() btw, what do you
> think ?

Indeed, it would be nice to have full compatibility. However there are
more syscalls missing than wait() and lseek(). These are just the
missing ones affecting nolibc-test.
Adding wrappers will be more work. This series is only meant to
ensure that the existing limited support does not regress.

We can add compatibility wrappers one after the other on top.
I think Zhangjin implemented and proposed a few before, but a few of
them ended up complicated.

> The single fact that you've had to modify some of the nolibc-test code
> (which is supposed to be the application here) indicates that we're
> progressively going away from what applications need on certain archs.
> Ideally an application relying on long-established calls should continue
> to work unmodified.

Agreed.

> Maybe it will be time for us to run an overall audit of arch-dependent
> syscalls we currently have, to make sure that the common ones continue
> to work fine there (and waitpid() definitely is as common a syscall as
> open() since it's the good old and portable one).

Isn't this what nolibc-test is already doing?
Or do you also want to compare it to non-current kernel versions?

In general the special rv32 syscalls are not really
architecture-dependent, they just dropped the "legacy" ones, especially
all using 32bit timestamps.


Thomas

