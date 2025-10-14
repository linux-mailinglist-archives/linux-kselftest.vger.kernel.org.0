Return-Path: <linux-kselftest+bounces-43129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A0BD9B1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93C13B393A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF744313529;
	Tue, 14 Oct 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD4JS8Ob"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C22F066A;
	Tue, 14 Oct 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448021; cv=none; b=V1M+ZUGpjBl6ZGDv0KwJo0gnIdgXwT2LVpwQfdEnTstA72lrFnEZS0B926IZEulNzoyJ/Tt0CCLWdCUgLSOS7p5RxMQdV+3/fo2uaxu9HbhQff534H74lZX0JjeiDybd5kZ7LazD8rlKgKWcPDhpclNXkq6nGS9j98710zABd4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448021; c=relaxed/simple;
	bh=Lbm9h/v0gO5+hNmuvzAEMG4Yg98hMlyr6FrcRqk4cwY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r+Aht4meNq5qhc0KPaPEH0uX2oythJEOS50K83jejTQ4jv81YUeD35bqkdf9tr//OflXSX8XqMbpSkUo1yg+ap+RfjAWoXU3TnCrLQ0SUltnYpOT5OCSzWnggIydq4R/M5mUVLpnGRIj5NVbRSJHK8llU9ROQj+ozY2+noAQO9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD4JS8Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20866C4CEF1;
	Tue, 14 Oct 2025 13:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760448021;
	bh=Lbm9h/v0gO5+hNmuvzAEMG4Yg98hMlyr6FrcRqk4cwY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OD4JS8ObHTwJmb0siP5hIkXqtH+5w6pYhBAMRtSemrKhJcsW9fxZe5ccnnrJ2B+tm
	 +Qojq/tNJ0DFYIgeF5j7STjCFwRFGywxuoQlxi9ZSIqwPq2KMPXVTnMl7KqEWErnfz
	 nBHIY/Sq9UfBOdBl4IRf+WpPEfFa0uJS/85jbX5Eni8BPT3upf+e5Nk/+224CvMz07
	 0kHaOPRJxpdFk0DcFu5IMnOzFzUf/I7SnUgFgUBtJCZB0XcC7rwDNF2uq6QSE9HqZU
	 plce4vH/S3w8poIX/VCXhKwT3bu9mdnQeo4AudkQeGwB4YsiFuZFe8+Oyl5M16pDeg
	 0vgFRPE0if2hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFC2380AA64;
	Tue, 14 Oct 2025 13:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net repost] selftests: net: check jq command is supported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176044800653.3743717.11369928550612434872.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 13:20:06 +0000
References: <20251013080039.3035898-1-wangliang74@huawei.com>
In-Reply-To: <20251013080039.3035898-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Oct 2025 16:00:39 +0800 you wrote:
> The jq command is used in vlan_bridge_binding.sh, if it is not supported,
> the test will spam the following log.
> 
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # TEST: Test bridge_binding on->off when lower down                   [FAIL]
>   #       Got operstate of , expected 0
> 
> [...]

Here is the summary with links:
  - [net,repost] selftests: net: check jq command is supported
    https://git.kernel.org/netdev/net/c/4f86eb0a38bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



