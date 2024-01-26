Return-Path: <linux-kselftest+bounces-3606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7940E83D154
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 01:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC0B4B237ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F77017E;
	Fri, 26 Jan 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C73UsTeD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4515B7;
	Fri, 26 Jan 2024 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227828; cv=none; b=XGEdeGWVl75kSx2LvHBhvvUlwe37dtgQXjVo7O1oFXG2P1tnFnSfhVCLLIA5ebvi2dYj9wotLiAUi4tJd6+Rdo5rpyot/GjLLWDsKcN3xCJDGb7vfQE0qAGapwmFsNY+FSQvB8+iKmZgWx6YVLKQFg28k0m6RKnfsy3e28O2fSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227828; c=relaxed/simple;
	bh=u6i3/IR+QFa2RYSPPts8rMAwjTxZWLyhOKIzxL9pREY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BD5onXtsDTQTUOx0HGWBPnObNwLDWZLiiF7NQSGUC2b0eAaRTszXCWqygmZn12KWXikIluSj5XM2PX0Gp09THm/YiEc1PGaeAEA5egHkhNv9losGSUIBJiyJm/JPM9ce+18wlXW7E/7JjlaMqcBguqwMp9OJMpad+aoARczfYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C73UsTeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85338C433C7;
	Fri, 26 Jan 2024 00:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706227827;
	bh=u6i3/IR+QFa2RYSPPts8rMAwjTxZWLyhOKIzxL9pREY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C73UsTeDY6uyv0QdlkrABBG+/a59U+I78AGLXi6vBUP+cF7xyuIGcgLhXcXfAZlY6
	 DMnc7/maT7StggpLCQ9khNmY9yQTDhzK30Zc/lUyOabtI1qUe3tdHs54fE3MwkBp7u
	 PyfKCUi7mw/J7My5mebQQN6AC22Qx+pFBDdftDMwpai/l5WdEX+/0EC0RnPS+xLTT1
	 oLJgelqS5teUXWilV29/PJqk3CuBnspJUJd6AaNyxhsCXgMjJP0l1jcrhWzB4J215p
	 73/7CAg5DCDfRnBxz269CiLD5YrOO4WQsWl9nsaCOQaivZlfEXpUQ6ip9QhSmpmw0z
	 uFboBh+Q7H7YQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6963BD8C962;
	Fri, 26 Jan 2024 00:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: tcp_ao: set the timeout to 2 minutes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170622782740.1412.14331334936328499348.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 00:10:27 +0000
References: <20240124233630.1977708-1-kuba@kernel.org>
In-Reply-To: <20240124233630.1977708-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, 0x7f454c46@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 15:36:30 -0800 you wrote:
> The default timeout for tests is 45sec, bench-lookups_ipv6
> seems to take around 50sec when running in a VM without
> HW acceleration. Give it a 2x margin and set the timeout
> to 120sec.
> 
> Fixes: d1066c9c58d4 ("selftests/net: Add test/benchmark for removing MKTs")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] selftests: tcp_ao: set the timeout to 2 minutes
    https://git.kernel.org/netdev/net/c/39b383d77961

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



