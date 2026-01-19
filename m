Return-Path: <linux-kselftest+bounces-49384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCF8D3B48D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 442D330556F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3D13148B6;
	Mon, 19 Jan 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+zY1UOE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BEB313523;
	Mon, 19 Jan 2026 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842558; cv=none; b=ieT0qYiqPkqgMeqsqLU99tN0D6Mg6GJ7YJGN8uCVYniADGPXtNUd/dk6BLN5ytCz9RSEXr8CxyeDkyAXYtIz9BEvoqv8px9UBD7m8WjPOI4jODgMU7QVJ50Y4ad475oXXod08PIRMeZ+qziKhPbvo/noIa89/c3JwWsBHTwQFaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842558; c=relaxed/simple;
	bh=cahfTJDbZdVnGQYk03DTEf+iNDlTr5tp19jvjxAz+0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdFeLMqGr0yNYROGHBkEyb7gDmeKvA+aOhC7MX+N9PKVKcmNUmHVS84aD+Qkb6YrPD3oA7bM7pe1h8Pq/5DdtpwNYznSj6ESUdFU4g0V+tnvM2L0smnpwlc4+V2DicNzrQTtkfs4Vhld3DqVxIgqdZqxHbRZta+3RtGAOllkDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+zY1UOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F500C116C6;
	Mon, 19 Jan 2026 17:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768842557;
	bh=cahfTJDbZdVnGQYk03DTEf+iNDlTr5tp19jvjxAz+0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l+zY1UOEXxJ8+Bly6cbY00KGO35QHSxNlYzJHTZZySxLKGNbc89fd3rYJJTls+pNe
	 YlKG1mJxKbbIk1Nnpi7ngxRkQkBiKTDiD+3+rJr1VHzKL6MFddUO7l95Wh6yDkk5un
	 uWLyY5plEe1Hs2Ozc8L/LRsZIS5/eSZflMpFjjqnwJAXDodMNfuYnWFcjWoapt9DWT
	 CcH25+bvDSrVxRvIPeOZCjGa/80HRxFWW8VsJ7qiS1ra3Z5FEPYHnApP0zAOEeceNE
	 VhuckJLw6gQE115nyWxe75aNGWGHPzXvwcvcRlw+CugyL3tZR42aGU9aCM2dqVYqQk
	 42IK4BwjYOd0g==
Date: Mon, 19 Jan 2026 09:09:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xu Du <xudu@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/7] selftest: tun: Refactor tun_delete to
 use tuntap_helpers
Message-ID: <20260119090916.1fe303a4@kernel.org>
In-Reply-To: <58c5767a8a82352fb784d8d51ec844055b6d7ff2.1768800198.git.xudu@redhat.com>
References: <cover.1768800198.git.xudu@redhat.com>
	<58c5767a8a82352fb784d8d51ec844055b6d7ff2.1768800198.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 13:40:00 +0800 Xu Du wrote:
>  # YNL files, must be before "include ..lib.mk"
>  YNL_GEN_FILES := busy_poller
> -YNL_GEN_PROGS := netlink-dumps
> +YNL_GEN_PROGS := \
> +	netlink-dumps \
> +	tun \
>  TEST_GEN_FILES += $(YNL_GEN_FILES)

You're missing the terminating comment:

# end of TEST_GEN_PROGS

so the \ at the end makes the next line a part of YNL_GEN_PROGS.

Please try running this series thru:
https://github.com/linux-netdev/nipa/tree/main?tab=readme-ov-file#running-locally

Since it's a selftest-only series you can use:

  --disable-test patch/build_32bit patch/build_allmodconfig_warn \
                 patch/build_clang patch/build_clang_rust

to skip kernel builds which take rather long time.
-- 
pw-bot: cr

