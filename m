Return-Path: <linux-kselftest+bounces-39280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A502B2B81D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 05:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A0474E10A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 03:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2ED220F21;
	Tue, 19 Aug 2025 03:55:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48D3C33;
	Tue, 19 Aug 2025 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575710; cv=none; b=FOpR/Y+9cfmtsHkxqJanLXkArTl4O3GKgdxp7FkX5GBNHe+5Ip+YrP9NSu4aYdHi9BZMaxkc+gwb/WAyO4elhFLAEidIQ/SqCJKxWiwgdziY60o9/G/Rx3d22mLHfkJ3wBHdhSNyQzRzyjNaoc9HO8rJJTwcb9rmztINvTuxC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575710; c=relaxed/simple;
	bh=7k1jgUV0Noyq4dphWhvVjw4rxiR6g7AlYVitiWpYMhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExXmAiZYTkWIMhdizEGGb7xCNIgqa02fNz7EJmwJmJcLBl0LctQCEz20sJYJy4SMhDYeTmJICgh61ofsFQ5YnkBmbl69T9U77rMmOvQuiUxUEBbabcyKEw6UMpN4osZbiJqAOPDBMw0oQyxUiUDE6z48KLmt9GrOtzmqAOzV03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 57J3smBS017765;
	Tue, 19 Aug 2025 05:54:48 +0200
Date: Tue, 19 Aug 2025 05:54:48 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] selftests/nolibc: don't pass CC to toplevel Makefile
Message-ID: <20250819035448.GA17734@1wt.eu>
References: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
 <20250719-nolibc-llvm-system-v1-2-1730216ce171@weissschuh.net>
 <20250721025627.GB1886@1wt.eu>
 <ebb84a9c-8771-4791-8a81-b615cecec7c3@t-8ch.de>
 <20250817093905.GA14213@1wt.eu>
 <d742c315-273d-417e-b1c7-00a9cec6a2c4@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d742c315-273d-417e-b1c7-00a9cec6a2c4@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 18, 2025 at 04:07:21PM +0200, Thomas Weißschuh wrote:
> On 2025-08-17 11:39:05+0200, Willy Tarreau wrote:
> > On Sun, Aug 17, 2025 at 10:30:52AM +0200, Thomas Weißschuh wrote:
> > > On 2025-07-21 04:56:27+0200, Willy Tarreau wrote:
> > > > On Sat, Jul 19, 2025 at 05:38:28PM +0200, Thomas Weißschuh wrote:
> 
> (...)
> 
> > > > I think I'd be fine with this, but then we need to make it
> > > > explicit in the help message and fix the current one, possibly just
> > > > with this:
> > > > 
> > > > -	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
> > > > +	@echo "  nolibc-test       build the executable (uses \$$CC)"
> > > 
> > > I don't think this is correct. $CC itself depends on $CROSS_COMPILE
> > > through tools/scripts/Makefile.include.
> > 
> > I don't understand what you mean by "depends on" here. CC defaults
> > to ${CROSS_COMPILE}gcc and may override it if set. So if one sets
> > CC, CROSS_COMPILE will not be used for it. Or maybe we could change
> > it to this to indicate a precedence if that's the idea you want to
> > convey ?
> > 
> >  -	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
> >  +	@echo "  nolibc-test       build the executable (uses \$$CC or \$$CROSS_COMPILE)"
> 
> Yes, that is the idea. 
> I pushed a commit to this effect to nolibc/for-next.

OK perfect, thank you!
Willy

