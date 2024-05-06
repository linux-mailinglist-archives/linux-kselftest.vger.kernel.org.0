Return-Path: <linux-kselftest+bounces-9518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201908BCEEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 15:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055EAB208AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8974BF8;
	Mon,  6 May 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkxuhrZG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E26FBF0;
	Mon,  6 May 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002112; cv=none; b=cy5PwryP2ypYIbalqPKdiDHq4bIYeWOjXHWdQhSosVonPXJWBK71fTDh8cOFeP/CiWhA2wQowSmA/aHv6Okf0pDNP5IWJjbPxeoJ4N7VPB5ht6dL+WPWldTRI/PjmKwMSLqHww2R4x034XPRso3c+xBhWC3Py6lt8hcRD3rW/nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002112; c=relaxed/simple;
	bh=Dfx6pj9LKfRR9YIdXoepncaL1dO4lHXtJSDyAoINafM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btEStOSjjkHeh8Lg96h1ognrPvEuuqMlTCt4HOG34H9iclcL/SjljhfhNoHqOpotEUJYx0Y+0ehpDrCa1scV34uWmg2RyLcJGLUJ6axB8vtKYPq67jM7wdpXLxGu/0BAKuwYenU3lmyV9uTZSi+RYK/LHf3eeejpUsHopz7zCoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkxuhrZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF150C116B1;
	Mon,  6 May 2024 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002112;
	bh=Dfx6pj9LKfRR9YIdXoepncaL1dO4lHXtJSDyAoINafM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GkxuhrZGQVJLSfDkpLocfe5R5E1tI8vKz/2a4Tu4JBsfFKScBwVPbpRE72tbKz8ql
	 wGim/nMHOAGKB8nZwXKinqrh7zuSELo8WxQ/ZHQjZXAlpIPFpvh+8vjWSHBNLwxvAn
	 1CjUkBkrKOdi3B5wT6mnxbA4RCzK3Kgbn+vlfiSueoXJ2Ygahy4dv4/TFR3kfUDZjC
	 UcxnbHkez1bEYAiYrjG5wY86iVvgCvvx/i9trMFVQvXpQHJaQ65rm45Rzwvs58DlqC
	 fbFD4fNBoJfRX13VFpjwsvEe+QY/PtEk1DkRRazYaMcGgNPetohezcpXiw5tBtMCud
	 WOzLXfb9KUdBw==
Date: Mon, 6 May 2024 06:28:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, Shuah Khan <shuah@kernel.org>,
 <devel@linux-ipsec.org>
Subject: Re: [PATCH net-next v3 2/2] selftests/net: add ICMP unreachable
 over IPsec tunnel
Message-ID: <20240506062830.5d48ba48@kernel.org>
In-Reply-To: <053f57d79058138d09a0e606c0500a40cb78596d.1714982035.git.antony.antony@secunet.com>
References: <cover.1714982035.git.antony.antony@secunet.com>
	<053f57d79058138d09a0e606c0500a40cb78596d.1714982035.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 10:05:54 +0200 Antony Antony wrote:
> Add IPsec tunnel, aka xfrm state, tests with ICMP flags enabled.
> IPv4 and IPv6, unreachable tests over xfrm/IPsec tunnels,
> xfrm SA with "flag icmp" set.

Doesn't seem to work:

# selftests: net: xfrm_state.sh
# ./xfrm_state.sh: line 91: test_: command not found
# TEST: unreachable_ipv4IPv6 unreachable from router r3           [ FAIL ]
# ./xfrm_state.sh: line 91: test_: command not found
# TEST: unreachable_gw_ipv6IPv6 unreachable from IPsec gateway s2 [ FAIL ]
# ./xfrm_state.sh: line 91: test_: command not found
# TEST: mtu_ipv6_r2IPv6 MTU exceeded from ESP router r2          [ FAIL ]
# ./xfrm_state.sh: line 91: test_: command not found
# TEST: mtu_ipv6_r3IPv6 MTU exceeded router r3                   [ FAIL ]
not ok 1 selftests: net: xfrm_state.sh # exit=1

