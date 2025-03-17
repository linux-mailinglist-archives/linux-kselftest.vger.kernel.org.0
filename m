Return-Path: <linux-kselftest+bounces-29269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 989DBA65C27
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE0A179230
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B71CAA92;
	Mon, 17 Mar 2025 18:14:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824DA1A83FB;
	Mon, 17 Mar 2025 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235254; cv=none; b=DsanGjejqqsFWgf0Ybo0t3UY6SwU49qHApYwGQQCZQRfhnFg69e8ljvhfYxo8RH7Nv8S3sPuO4zPHdw292baPvMu32w3FK0W4u6uHbIrewvCmVKiA+RUN/nPuqH9L/yh5naoKEXAf3cIGtM/dFebSWSiPEbKvftDqp0LgCho7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235254; c=relaxed/simple;
	bh=zR7F1wCaZgFJ5vBc/vilMOpQNA8DV6k2v1fnEC7BpMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mova/PKZX7xrBhY/JZmkRfvT3v1E+WWorJTOQ7yM/lo8TVFSLmrFy93kzA50b+mIbk3UCSqFCDkIH9Z5aJ7r5XHI6XbarxFkr7vp9McgWPhV9KuVWyGN81OA/OpnK9+EkKZJtjTJ1/sxSjT8LvEoJy4G8W+XQy8FKEbYsTa0pLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 52HIE2eh008577;
	Mon, 17 Mar 2025 19:14:02 +0100
Date: Mon, 17 Mar 2025 19:14:02 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Add support for SPARC
Message-ID: <20250317181402.GB8377@1wt.eu>
References: <20250316-nolibc-sparc-v1-1-2e97022d5e2c@weissschuh.net>
 <20250317073746.GB5114@1wt.eu>
 <dacaa712-08a8-4fd6-ad47-2226040f02aa@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dacaa712-08a8-4fd6-ad47-2226040f02aa@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Mar 17, 2025 at 06:52:57PM +0100, Thomas Weiﬂschuh wrote:
> On 2025-03-17 08:37:46+0100, Willy Tarreau wrote:
> > On Sun, Mar 16, 2025 at 02:55:02PM +0100, Thomas Weiﬂschuh wrote:
> > > Add support for 32bit and 64bit SPARC to nolibc.
> > 
> > Oh nice!
> > 
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > ---
> > > This is only tested on QEMU.
> > > Any tests on real hardware would be very welcome.
> > 
> > I still have a working U60 here, but under solaris. Such machines are
> > not trivial to boot on alternate OSes (and when you find a working
> > image usually it's based on an old kernel).
> 
> An old kernel should be perfectly fine, no?

I don't think so (it depends how old in fact), keep in mind that
we've removed support for a number of legacy syscalls.

> > > +/* startup code */
> > > +void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
> > > +{
> > > +	__asm__ volatile (
> > > +		/*
> > > +		 * Save stack pointer to o0, as arg1 of _start_c.
> > > +		 * Account for window save area and stack bias.
> > > +		 */
> > > +#ifdef __arch64__
> > > +		"add %sp, 128 + 2047, %o0\n"
> > 
> > It's really unclear where this magical 2047 comes from, I think it must
> > be explained in the comment above so that someone disagreeing with it
> > later can figure whether it's right or wrong.
> 
> 128 is the context window and 2047 is the stack bias.
> I'll try to make it clearer.

OK thanks, but that remains quite strange to me. How can we end up
here with such an unaligned stack ? At the very minimum I'd expect
all offsets to be multiple of 8.

> > Also, I could be wrong, but from my old memories of playing with the
> > stack on SPARC long ago, I seem to remember that the stack is growing
> > down. Thus I find these "add" suspicious or at least confusing. You
> > mention "window save area and stack bias" above, I'm not sure what it
> > refers to, but if we can safely erase parts of the stack because too
> > much was preserved, maybe some more explanation about the initial and
> > target layouts is deserved here.
> 
> There is a graphic in the psABI [0] under "Process Stack and Registers".

Thanks for the link! Are you sure you can get rid of the window save
area ? I'm seeing that apparently it's used with save / restore, which
*if I remember well (30 years ago)* were used along with register bank
switches. In 3-12 it's written:

  Some registers have assigned roles.
    %sp or %o6 The stack pointer holds the limit of the current stack frame,
    %which is the address of the stacks bottommost, valid word. Stack contents
    %below the stack pointer are undened. At all times the stack pointer must
    %point to a doubleword aligned, 16- word window save area.

> I'll write something based on that.

Thanks!

> > > +		"b,a _start_c\n"     /* transfer to c runtime */
> > 
> > OK great, the delayed slot is covered! (that type of thing can work
> > by pure luck in one test and fail in another one depending on what
> > bytes follow the jump).
> 
> Yeah, it brings memories to the work on MIPS support.

absolutely!

Thanks,
Willy

