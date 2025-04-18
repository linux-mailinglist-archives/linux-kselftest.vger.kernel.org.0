Return-Path: <linux-kselftest+bounces-31187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E23A93F79
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 23:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9381E7B2FA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 21:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB724169C;
	Fri, 18 Apr 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8VvVNqj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA6224B13;
	Fri, 18 Apr 2025 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745011777; cv=none; b=L04P1qC58OrIKiHe01RMPCZotnYahbxyFrtNUuZJLvCWuWpwB7hMwRzBc1aUk9GKA9szlQMULz4pLaJv9jqPmGWDUr7o4ThDeEUnA+GgDlp4y6S6O1BIMKq7rWk7tEqjF6NzKF1BPEMZOg9rbp1B+NL5tb6ZtQeOKLh/fLOFD04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745011777; c=relaxed/simple;
	bh=aNvVE4xobOPS1x9QLfzVQTej6ekYYNlRct7l/vLeYyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxB9E+xg7r9kAiO+5GdSsIf5V09vS4XU6XY6Vw+hOy0hlZvGgKa4F+rX53+PlibWJwd8xrKnY5Q23QPK+6qs4siWndxTJBN7DbC6EKMHeRyGt9WL4okolKiSoacFn9eDXqc4de8VXN+d57Gpj36IdPhkrV7+1f8lQ/Ek0URtt0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8VvVNqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630B9C4CEE2;
	Fri, 18 Apr 2025 21:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745011776;
	bh=aNvVE4xobOPS1x9QLfzVQTej6ekYYNlRct7l/vLeYyA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=s8VvVNqjrPcmwur3BUFAD/DarQSH+es47t86ZbHJGNum0q1/TLyhMXMlHiQ37v87C
	 dB2rPY13XwwvLZEfqw/VVPjQ3MFfyAjoYqEQPytnXMjgWih1/TMIiEhrC45LhUJV+3
	 +xwS1/EIiNOdKEhUg+3EOCQEqPJbuSBx976nJUIbtWC6AcTTbUm5xKHCwBGUslStpT
	 UmPxOhCJK2DENq48V4Rr1WgagUKEGPWZRZyMwrdMG90G9M98t8MxsB1W9JnS9Ft7Hp
	 rT0U7fv6I07Kl/R6pIhCesSzYRgq3hhFAkLTapQa/Xg1tS47y5+QM2riEvkia83qBN
	 KpwA6D1AgCrnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F1C2CCE095D; Fri, 18 Apr 2025 14:29:35 -0700 (PDT)
Date: Fri, 18 Apr 2025 14:29:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/6] tools/nolibc: fix some undefined behaviour and
 enable UBSAN
Message-ID: <0527399b-acff-4452-a982-10f49144e099@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
 <acffaf72-aca5-4301-ade4-ea12571e4392@paulmck-laptop>
 <44ef9e15-d7dd-4079-93c1-5f9cf79d675b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44ef9e15-d7dd-4079-93c1-5f9cf79d675b@t-8ch.de>

On Fri, Apr 18, 2025 at 11:20:29PM +0200, Thomas Weiﬂschuh wrote:
> Hi Paul,
> 
> On 2025-04-18 10:32:27-0700, Paul E. McKenney wrote:
> > On Wed, Apr 16, 2025 at 08:40:15PM +0200, Thomas Weiﬂschuh wrote:
> > > Fix some issues uncovered by UBSAN and enable UBSAN for nolibc-test to
> > > avoid regressions.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > 
> > Thank you, Thomas!  Are these intended to go into the current v6.15
> > release, or are you instead thinking in terms of the v6.16 merge window?
> > Either works for me, but left to myself, I would assume the v6.16
> > merge window.  ;-)
> 
> They are intended for v6.16 through the normal process.

Sounds good, and thank you for the clarification.  Plus good show on
getting them out early.  ;-)

							Thanx, Paul

> Thomas
> 
> > 
> > > ---
> > > Thomas Weiﬂschuh (6):
> > >       tools/nolibc: add __nolibc_has_feature()
> > >       tools/nolibc: disable function sanitizer for _start_c()
> > >       tools/nolibc: properly align dirent buffer
> > >       tools/nolibc: fix integer overflow in i{64,}toa_r() and
> > >       selftests/nolibc: disable ubsan for smash_stack()
> > >       selftests/nolibc: enable UBSAN if available
> > > 
> > >  tools/include/nolibc/compiler.h              |  6 ++++++
> > >  tools/include/nolibc/crt.h                   |  5 +++++
> > >  tools/include/nolibc/dirent.h                |  1 +
> > >  tools/include/nolibc/stdlib.h                | 24 ++++++++----------------
> > >  tools/testing/selftests/nolibc/Makefile      |  3 ++-
> > >  tools/testing/selftests/nolibc/nolibc-test.c |  1 +
> > >  6 files changed, 23 insertions(+), 17 deletions(-)
> > > ---
> > > base-commit: 7c73c10b906778384843b9d3ac6c2224727bbf5c
> > > change-id: 20250416-nolibc-ubsan-028401698654
> > > 
> > > Best regards,
> > > -- 
> > > Thomas Weiﬂschuh <linux@weissschuh.net>
> > > 

