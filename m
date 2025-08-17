Return-Path: <linux-kselftest+bounces-39170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F9B29276
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 11:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E999D1B213BF
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E9221F26;
	Sun, 17 Aug 2025 09:39:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EDB1D6BB;
	Sun, 17 Aug 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423568; cv=none; b=kjrdRRdVfMmpIri1h1rJbFJSnz+DBbrI3sm5/uxx8Kgss4ycP3GATDTsfU7+XEIP1itTqVKyyvPmN110n5R3APgq8T5jemjyGlGgUvS1go4ouJY5fPZsf4GR7r85I8/RukaRvhUZ++LLspfGV9j+kG8VMbTxZ7O8zGHI3Cjtvb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423568; c=relaxed/simple;
	bh=x0wlHRCLNUADFhDxWzlFBA0EmRpXhumAsQQ4zF7tXVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx5/hUIXSYduqMN2f9CtB1P5JKZVa1Hd9UnCZURaT+t9rs9Pc6VkcJJr2ZYimYl3rz/bdw1jWMLVADJ7YGr/O3xr6bxK6fA4wfgVMiWP+KULEFngK6XZ1kW6143vX3L3TnIvJbhfS6jCBGCThiNXtLPX3qgsftGVfU+ovvICXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 57H9d5mh014247;
	Sun, 17 Aug 2025 11:39:05 +0200
Date: Sun, 17 Aug 2025 11:39:05 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] selftests/nolibc: don't pass CC to toplevel Makefile
Message-ID: <20250817093905.GA14213@1wt.eu>
References: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
 <20250719-nolibc-llvm-system-v1-2-1730216ce171@weissschuh.net>
 <20250721025627.GB1886@1wt.eu>
 <ebb84a9c-8771-4791-8a81-b615cecec7c3@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebb84a9c-8771-4791-8a81-b615cecec7c3@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas!

On Sun, Aug 17, 2025 at 10:30:52AM +0200, Thomas Weißschuh wrote:
> Hi Willy,
> 
> On 2025-07-21 04:56:27+0200, Willy Tarreau wrote:
> > On Sat, Jul 19, 2025 at 05:38:28PM +0200, Thomas Weißschuh wrote:
> > > The toplevel Makefile is capable of calculating CC from CROSS_COMPILE
> > > and/or ARCH.
> > > 
> > > Stop passing the unnecessary variable.
> > (...) 
> > >  # Execute the toplevel kernel Makefile
> > > -KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
> > > +KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
> > 
> > Here the goal was not to help the toplevel Makefile figure CC, but rather
> > to permit the user to override it, and it's also listed in "make help",
> > and even used in cc-option.
> > 
> > I understnad that you're trying to avoid forcing CC to clang when
> > building, but in this case, what will CROSS_COMPILE contain ?  My
> > guess is that you intend to make CROSS_COMPILE point to the gcc-based
> > toolchain, and have CC point to clang for userland only. Is this the
> > case ?
> 
> Correct.
> 
> > I think I'd be fine with this, but then we need to make it
> > explicit in the help message and fix the current one, possibly just
> > with this:
> > 
> > -	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
> > +	@echo "  nolibc-test       build the executable (uses \$$CC)"
> 
> I don't think this is correct. $CC itself depends on $CROSS_COMPILE
> through tools/scripts/Makefile.include.

I don't understand what you mean by "depends on" here. CC defaults
to ${CROSS_COMPILE}gcc and may override it if set. So if one sets
CC, CROSS_COMPILE will not be used for it. Or maybe we could change
it to this to indicate a precedence if that's the idea you want to
convey ?

 -	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
 +	@echo "  nolibc-test       build the executable (uses \$$CC or \$$CROSS_COMPILE)"

Willy

