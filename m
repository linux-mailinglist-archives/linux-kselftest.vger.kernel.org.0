Return-Path: <linux-kselftest+bounces-14713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9D94608D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 17:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FBC1C21460
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06D175D4B;
	Fri,  2 Aug 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcrp3146"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06981175D28;
	Fri,  2 Aug 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612748; cv=none; b=DaBr7pjH4OULKQe8wDv8MlHWI8f+ZEDciKQvjDImLpiou1szw9N5CoB1JH41yvI9+mCd6YYjMzMaKIWzNZ0rsR7MsQdzXAMEgqR8kA2UmrCkojdFEsT7PDBDVdnIicnu3I6GagCl1y/n9ZUO7kJiyUrKkkxmxSh4dCgeyuH0mrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612748; c=relaxed/simple;
	bh=9QxgLbIHkSOCEL3yRitF+A2vgV2hpriB4j1hLM8Q3AA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCjJygaknd0RYSYZPgxLESYiht8nllkhA2MXCDFC0mhJbLbgon70IqaG8XQ4UhafR+eKP8dUpzOTz6QQKVCcjRmKCsw0uPYJyTYLD+HjSrhs2sMQbBIjKr/geQk4V4J41imo7UADSi1EhHlQDx12DJFCZmbBafkaDtSqQHgoL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcrp3146; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384FCC32782;
	Fri,  2 Aug 2024 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722612747;
	bh=9QxgLbIHkSOCEL3yRitF+A2vgV2hpriB4j1hLM8Q3AA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xcrp314638hr71O6V74BTCkZ3hSz6vr9m2QFTmklNTSV0PixbH90C2Ly4KP1G5ul5
	 KVTPam6R9g6xy95ECvSwB27+iqMbbcjrY6HxGvhHd3J0k26eCXeEd49QKiIlON+rzM
	 uaS18SDb3Vwni3hRd6GGWIQ7JH9Ju5Tx1hUqx4U67ooYEoMIuaMCAWlCIfRh9qembq
	 tgZMxmcsSvU49BUjLdrqMM48ScBi6wDSmPa1t1ASkGeApLP9tNYNEHka/ew2U8DQi5
	 f3plp/fQ/uJRsLhjCzgR/iEYGx8a0YWvqI2y6AMjDEeLHAww5KMPEcpjTDmkWFKQLX
	 gOVzgfY1XNxjA==
Date: Fri, 2 Aug 2024 08:32:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Mohammad Nassiri <mnassiri@ciena.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/7] net/selftests: TCP-AO selftests updates
Message-ID: <20240802083226.4bb23562@kernel.org>
In-Reply-To: <20240802081823.67a27db3@kernel.org>
References: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
	<20240802081823.67a27db3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Aug 2024 08:18:23 -0700 Jakub Kicinski wrote:
> On Fri, 02 Aug 2024 10:23:24 +0100 Dmitry Safonov via B4 Relay wrote:
> > First 4 patches are more-or-less cleanups/preparations.
> > 
> > Patch 5 was sent to me/contributed off-list by Mohammad, who wants 32-bit
> > kernels to run TCP-AO.
> > 
> > Patch 6 is a workaround/fix for slow VMs. Albeit, I can't reproduce
> > the issue, but I hope it will fix netdev flakes for connect-deny-*
> > tests.  
> 
> Hm, could be a coincidence but we did hit:
> 
> # not ok 55 # error 381[unsigned-md5.c:24] Failed to add a VRF: -17
> # not ok 56 # error 383[unsigned-md5.c:33] Failed to add a route to VRF: -22: Key was rejected by service
> 
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/710001/4-unsigned-md5-ipv6/stdout
> 
> in the first run after this got queued. But the retry worked:
> 
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/710001/4-unsigned-md5-ipv6-retry/stdout

oooh another run, another (different) flake:
https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/710181/11-key-management-ipv4/stdout

I'll keep it around for another run, but looking less and less 
like a coincidence :(

