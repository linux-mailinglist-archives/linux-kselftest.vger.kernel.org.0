Return-Path: <linux-kselftest+bounces-46635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E90C8E269
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 12:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECEAD4E6CF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4D03314AE;
	Thu, 27 Nov 2025 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAUgLSfU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE732F76C;
	Thu, 27 Nov 2025 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244325; cv=none; b=RykMhQCOG0Xi3rqfoLuUOnPoaDxHNsWnKrIqi+E68lwnGyIFgcCkOwNEVO1wzGoWWST04fsq5qQGVlXzPcaqZ8Z1ZJcwlpqx1lPwDHyZtywSiuuPQrkZAmOvz8K3UGDD5cg43dYuI4FvpvjmK2zdm7B+DExwzUKThMe1RRcjzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244325; c=relaxed/simple;
	bh=vXMAPEVvuqkmNZC1/QV8tfrfTIWyuSpb49vHXINrQ90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j1ShVzoNIedPn5kFGWC8TpPT3pzCFQPOGJembH1TRHIQ47/w2pzEe0MFswPof443dTHNAmxH5faFjLRaiH4HDK7Gv9bJKiMQUgCdQ6i9qpw+kd5KE7zpf4MudGNn3ObqMReMUrnF8sa1d9aTJDmPrHgJ3969lZRzHX5zwBA2p/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAUgLSfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22C1C4CEF8;
	Thu, 27 Nov 2025 11:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764244324;
	bh=vXMAPEVvuqkmNZC1/QV8tfrfTIWyuSpb49vHXINrQ90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iAUgLSfUY3cNdJ/lT8f6NFrNMIESS5uRK+gHgrsOa8ABQMJM2Pq4+JhUD3tUxtR8B
	 a9ck5u/IGTN4PbljvRT1s59ncfU+mNuNdoDU4lZ08eSLzAvzGKcT6g8xuA3JWmdDIF
	 q3m32k3tdSERBBGLGKUW+9jSxGccWSXYK2eigKxA+PgXc7B4EF41RKFMY2kjyzesbf
	 zV6mf0j3oDs0F7vgyK/KUvV1jZw/Y4liLLqkk69UpZZq9YEW71efF4BwESsj+boqrd
	 7/7cGY5n94WTp8kGxp2xmmwHfIzkl6+QQzSlrLJhqZWuASjYuRoFjoC0LppMXQPyaY
	 LDXBBCVIFI3Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D93380CFE0;
	Thu, 27 Nov 2025 11:51:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: af_unix: remove unused stdlib.h
 include
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176424428626.2543014.2747107697046734578.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 11:51:26 +0000
References: <20251125113648.25903-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251125113648.25903-1-adelodunolaoluwa@yahoo.com>
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org,
 oe-kbuild-all@lists.linux.dev, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Nov 2025 12:36:48 +0100 you wrote:
> The unix_connreset.c test included <stdlib.h>, but no symbol from that
> header is used. This causes a fatal build error under certain
> linux-next configurations where stdlib.h is not available.
> 
> Remove the unused include to fix the build.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202511221800.hcgCKvVa-lkp@intel.com/
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: af_unix: remove unused stdlib.h include
    https://git.kernel.org/netdev/net-next/c/5c9c1e78de1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



