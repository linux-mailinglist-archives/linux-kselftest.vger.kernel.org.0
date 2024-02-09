Return-Path: <linux-kselftest+bounces-4482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DCB84FE0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 22:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69ECF283E6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F9F16426;
	Fri,  9 Feb 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt3ckX/J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480912E4D;
	Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512431; cv=none; b=S8RfNqPcHhr7rpBpsJ8Yw6W99QXwfRkO7+lrhOQSy18RdkvhwEiRfa7qzUQPL6f+MyM5VqC62EnBcCrRhXSfQIhVyS9Lx6v6nNiUuuu7Wjt1emcSZFFlSPQ3Qf3ocOk1HB/e1ZGgdGGSV5HopZhK58vO2f/Dj1iQGvX+/Ye/E8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512431; c=relaxed/simple;
	bh=WvxI7wV7VkvRwsYw97UeAHCJXK/gMxSZ18CKIMF3PRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d6KgO0xfRI1oPeTSD8jr9UgGIwthRLkD/riV4xLbu5peoIcg3wknWSOYM0F0Ru2eOyKL+zggz8238vEEgtR63KL3tJ4MvUIAopnztR2qJ/90rLLi49UBM5m+GO6z6v16/EBpVsYkpK1rZAxbUtnKiCkY3m8WRTGMIXhN7AeGShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt3ckX/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54BDAC43390;
	Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707512430;
	bh=WvxI7wV7VkvRwsYw97UeAHCJXK/gMxSZ18CKIMF3PRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kt3ckX/JwMbpM5zqBIvC5v7rb0cWjyHnhUzYppONJbIOcTuTphqwRZao4b99cxjvg
	 rjwynNcrW17HCXoOXRgqqWFLGlxB4zlUghQO5y/GhpUonstfV4WATDUdfKXd5+T8jJ
	 nhxYT5hIJdTgXzGv9LDYV0sYa8Tuy3bXjciNCGDMMCdbGC5Yq/biQBSfv030ITprx6
	 qg0py6YgfolqQCKj5MZckyEgn2amNRwVnIPEPtJgBeQAv8X5SemFaK2q9bH5A1cygJ
	 xG49BfIO+QggUj5VAo0Tt/PlfvfNFZimS4OJq6rXVdloU1HIxuFDg/yctncMkYcvb+
	 nGzPAjDS1s+ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37F2CC395F1;
	Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: openvswitch: limit the recursions from action
 sets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751243021.9207.3276714714222361533.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 21:00:30 +0000
References: <20240207132416.1488485-1-aconole@redhat.com>
In-Reply-To: <20240207132416.1488485-1-aconole@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pshelar@ovn.org, dev@openvswitch.org,
 i.maximets@ovn.org, horms@ovn.org, echaudro@redhat.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, azhou@ovn.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Feb 2024 08:24:14 -0500 you wrote:
> Open vSwitch module accepts actions as a list from the netlink socket
> and then creates a copy which it uses in the action set processing.
> During processing of the action list on a packet, the module keeps a
> count of the execution depth and exits processing if the action depth
> goes too high.
> 
> However, during netlink processing the recursion depth isn't checked
> anywhere, and the copy trusts that kernel has large enough stack to
> accommodate it.  The OVS sample action was the original action which
> could perform this kinds of recursion, and it originally checked that
> it didn't exceed the sample depth limit.  However, when sample became
> optimized to provide the clone() semantics, the recursion limit was
> dropped.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: openvswitch: limit the number of recursions from action sets
    https://git.kernel.org/netdev/net/c/6e2f90d31fe0
  - [net,v2,2/2] selftests: openvswitch: Add validation for the recursion test
    https://git.kernel.org/netdev/net/c/bd128f62c365

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



