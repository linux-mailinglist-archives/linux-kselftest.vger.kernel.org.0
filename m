Return-Path: <linux-kselftest+bounces-31161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2842BA93C04
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 19:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E91E1B67C31
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6341421ABDA;
	Fri, 18 Apr 2025 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVj5s93y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0521517E;
	Fri, 18 Apr 2025 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997548; cv=none; b=l7GDtSS1lbjQY0IfqHeEOJ0mE9Aza82PW/OJOHabBDMlZzl9CjZoh8ofPWtwZzi/999z4pNOROErT+Z1eaiVzzshvCc4W8KZbNFt5T04+c++s7ZNJTyUXo3pzdOLB+S5ei/ZCtg4KHGKF77ArNbllxnOMvQXr7R1IoOx6PDqHDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997548; c=relaxed/simple;
	bh=MbkcbhNeROKVVV3erCGWeYKZbF3/1pafjd6IMvKqXNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UycA/updc0BXSE3nAp8o58/COSegB0M6RiOxs63PLBwKy5WnHUazWYvVLN7AvtEHL9DUK7SPAUi/n7irRLpYH1bl1BDo5WRGJas4Yi3kB+29z6gxGQuyy3UPDZFfdCPw1iqWv/ev9KpsE2mhmavcOLAf3xcThi04tkBneyL5vwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVj5s93y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FE0C4CEED;
	Fri, 18 Apr 2025 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744997547;
	bh=MbkcbhNeROKVVV3erCGWeYKZbF3/1pafjd6IMvKqXNM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sVj5s93yHl8nBaCP8AVY0JpdeAuwkcj7NZWxBiGnqcntU1nZ0+P6+ND6KpwhQOCtK
	 X0dOu4swioQVypkS03iL3i0Uqd03vbEjLjq22TGkHmvFPFlEmTWAhb7/KM4vi0cFkR
	 wqTqSxRrlZf1+8NI7xrkyhkUr5CEsQC2CJPd2x21VOLPa7t/pFxEP1YEV2d6WJXjhN
	 joW45OTaE2TjB8Zbiw7FsI5VPyEqip41HdrWmveINspB2vb6zCz1L5dj4a8wTHliMT
	 uL2CgYlBnBJjRWVq3PMvlqDHJ/XhaNKpt+P1L2hTLMN9L1FDGYAX9A2mOMhbYXBsiB
	 KssZFhkFwZj6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4AF3BCE077B; Fri, 18 Apr 2025 10:32:27 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:32:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/6] tools/nolibc: fix some undefined behaviour and
 enable UBSAN
Message-ID: <acffaf72-aca5-4301-ade4-ea12571e4392@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>

On Wed, Apr 16, 2025 at 08:40:15PM +0200, Thomas Weiﬂschuh wrote:
> Fix some issues uncovered by UBSAN and enable UBSAN for nolibc-test to
> avoid regressions.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Thank you, Thomas!  Are these intended to go into the current v6.15
release, or are you instead thinking in terms of the v6.16 merge window?
Either works for me, but left to myself, I would assume the v6.16
merge window.  ;-)

							Thanx, Paul

> ---
> Thomas Weiﬂschuh (6):
>       tools/nolibc: add __nolibc_has_feature()
>       tools/nolibc: disable function sanitizer for _start_c()
>       tools/nolibc: properly align dirent buffer
>       tools/nolibc: fix integer overflow in i{64,}toa_r() and
>       selftests/nolibc: disable ubsan for smash_stack()
>       selftests/nolibc: enable UBSAN if available
> 
>  tools/include/nolibc/compiler.h              |  6 ++++++
>  tools/include/nolibc/crt.h                   |  5 +++++
>  tools/include/nolibc/dirent.h                |  1 +
>  tools/include/nolibc/stdlib.h                | 24 ++++++++----------------
>  tools/testing/selftests/nolibc/Makefile      |  3 ++-
>  tools/testing/selftests/nolibc/nolibc-test.c |  1 +
>  6 files changed, 23 insertions(+), 17 deletions(-)
> ---
> base-commit: 7c73c10b906778384843b9d3ac6c2224727bbf5c
> change-id: 20250416-nolibc-ubsan-028401698654
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

