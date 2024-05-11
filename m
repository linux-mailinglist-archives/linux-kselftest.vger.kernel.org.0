Return-Path: <linux-kselftest+bounces-10086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769F8C2E6E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A781C2181E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B701643A;
	Sat, 11 May 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZCOrxB0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD812E75;
	Sat, 11 May 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391030; cv=none; b=TkxuBc+zivq25Ch5SyHqhgH1tkS1wDWkCWaGQuNgMUs5yD9N43BLz1jt199KKWSZ7yOJXQg7EI52MtxUNlWVsGT7E47H1lfjcd06/SQ7E1yt4jUvGz4+bsgo9/yFyMLYxB53ojvRR1MBaeYN0dziykgwbTqTQHlCtUaYMb59vCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391030; c=relaxed/simple;
	bh=/ZHSSqh3rUqMhO0Uzq7P/GCi2+a71wh0TC8ORjxbZoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EJUBEvL6MWjWSQk+/8bCHNWegcryaRhh3oBeMyZH7hrIq+9bbGv3Qoj8iw+TvJMTlIzk0v1uLOPIyNQXNawi0tLsylYNHZjP7+/OPLGlsPw29AezUaX06krFfbn3zKAJ311qdVZs/xzxB8sg234dCOcGnq6j6f8uQ7pRSG4iucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZCOrxB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 034F5C4AF0B;
	Sat, 11 May 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715391030;
	bh=/ZHSSqh3rUqMhO0Uzq7P/GCi2+a71wh0TC8ORjxbZoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TZCOrxB0GISX9nJzhTiSrgj0hdDxhMwmFuvQN+1hLVJAeySGFPCC0iLjc3CorltLs
	 Q/xrBoRw2dZxIxIOsEHjPkwPQ/A/4XkAAs7ed7g7tz+Tdmjjpxx/ur9dCyKTYARjEK
	 O6DhQ6cK6oU50T1rqVReFwFE06+DsTixqkjYkyVhJiPfPNrtiQe/xOotTNSVIlc44j
	 U422XV+dnPkWHPywomy2ydstcryDcFgyfLvX/+o1WtL6RNMJx/WxqWL0ZAhI5GByQN
	 HnW7KvDa3ZS01C+ZEs0V1epBJyyFujC/+WtN1VGjkvbjfl/EF/Ebjn/LOWBeGhSEXx
	 mhyePXagpurAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE681C32759;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] selftests: net: fix timestamp not arriving in
 cmsg_time.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539102997.31003.15681328963726859289.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 01:30:29 +0000
References: <20240510005705.43069-1-kuba@kernel.org>
In-Reply-To: <20240510005705.43069-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 17:57:04 -0700 you wrote:
> On slow machines the SND timestamp sometimes doesn't arrive before
> we quit. The test only waits as long as the packet delay, so it's
> easy for a race condition to happen.
> 
> Double the wait but do a bit of polling, once the SND timestamp
> arrives there's no point to wait any longer.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: net: fix timestamp not arriving in cmsg_time.sh
    https://git.kernel.org/netdev/net-next/c/2d3b8dfd82d7
  - [net-next,2/2] selftests: net: increase the delay for relative cmsg_time.sh test
    https://git.kernel.org/netdev/net-next/c/b9d5f5711dd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



