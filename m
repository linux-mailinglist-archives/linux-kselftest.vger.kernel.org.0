Return-Path: <linux-kselftest+bounces-34341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F598ACE64D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 23:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BCF3A8E1B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33751213E76;
	Wed,  4 Jun 2025 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARtmdMnW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1A319F422;
	Wed,  4 Jun 2025 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749074036; cv=none; b=JoEpsjvM1+ACEAbrGEV3+tJaxWGN0dbqlgmUfCkVGuu3vrFVoqCtoAKHlGW+CEwGJFWtX/FiiO9sI51h7W+2kTqlKUda+6m3/yYZn0t1o5YuwQsOfD5wqzX/xv2BqghlAohdx1ajRNedb4bKnS0fY0A+bqLKxKZG5bVkhPsFqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749074036; c=relaxed/simple;
	bh=KJEIQnyMAwRYTmEXOATAsggQLx5dWaTkHtimHUMbGss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+TBzx3msQCJ9ucXdduR2MW2I9ISKBwIdgb+Z2pW4eWc5NI+2ASfqbShnYuETg3n3aw3iVdW6T+tlHbNjNuDWnX9oGiVp5Dj7Fs8Da4/I77tW5U3OS6pthcJEuwqs/ilKZDJi3mWGIVBFfsHmrFOrxDXwX+ujH21aCo6Sh93ZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARtmdMnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E1CC4CEE4;
	Wed,  4 Jun 2025 21:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749074035;
	bh=KJEIQnyMAwRYTmEXOATAsggQLx5dWaTkHtimHUMbGss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ARtmdMnWfD9oCIErNghyc7LcUmh6DegnHJat5NwxhIfn22f2jlTutbliGRD/y0JW1
	 DuGVlDgBn/io0M/kkU2gR3YZA/Z/UWuC4IYHF6083W9XF9/p8cdfZB/NvfNsbJxyKt
	 99qoibooE8KFQvzwjYToPBTuZdMtZEYM3tVNLitgkjJ6i++bjiycEswPD9G5cKMx5z
	 nZeWagynpOWnxHbjObA9M519YoszcfqIjt/pDQ//AfvzLpFa4FJmREujqukb/LAP/V
	 wKZWfPV+NpgmbbQEgrBUjumkidn5LYmyHIA3oKriXKitSSpXD4ZkRAK94YOtGe2QPL
	 Yrw0ySLQsJzIg==
Date: Wed, 4 Jun 2025 14:53:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: drv-net: add configs for the TSO test
Message-ID: <20250604145354.4f9c33b4@kernel.org>
In-Reply-To: <68404e84d0f58_1e99f529441@willemb.c.googlers.com.notmuch>
References: <20250604001653.853008-1-kuba@kernel.org>
	<68404e84d0f58_1e99f529441@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Jun 2025 09:47:48 -0400 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > Add missing config options for the tso.py test, specifically
> > to make sure the kernel is built with vxlan and gre tunnels.
> > 
> > I noticed this while adding a TSO-capable device QEMU to the CI.
> > Previously we only run virtio tests and it doesn't report LSO
> > stats on the QEMU we have.
> > 
> > Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> I wonder if we'll slowly recreate tools/testing/selftests/net/config.
> An ugly hack, but maybe let the Makefile just copy that config here?
> Or append it.

Yes, even drivers/net vs drivers/net/hw is a bit annoying.
Not sure how to cleanly align with selftest infra here :(
Our CI right now only uses configs from the TARGETS we're intending 
to run. While it makes sense "to a human" to include net,
is it clean to auto-include $target if drivers/$target is included?
Maybe...

To some extent I think the issue was that we haven't actually had
any device on which NIPA could run this test. Otherwise we'd have
caught the problem before merging.

