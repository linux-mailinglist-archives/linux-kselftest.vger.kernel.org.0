Return-Path: <linux-kselftest+bounces-14379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7830A93F59C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 14:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94E0B20A83
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D650C1482E1;
	Mon, 29 Jul 2024 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8W7sDZM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F7145FE1;
	Mon, 29 Jul 2024 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256835; cv=none; b=frUwPXhsa97Mu8pl4yW2UaEM7jq6Gx23HcUOryXGaaQ9aZ1rno/unkpym+5LRpdFY9K8CnPXMpU83HNSem9XiesqomQNQ5J3VJFl6W4mNbSsa3YIIhtgYDqytqz1G4vYQlFd4mk1qc8QtSLuL/oMoXC/pbvufkhRbP35jEG0XZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256835; c=relaxed/simple;
	bh=wHsh5WQSdcrSRUcV1G75PxkF61eDMM6o20gIC6vEWX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bf0ICUyH5pSxhg3Cn+VdQGPpnwXeSAktClyWbvn49pwsrjcFj33LpcSTFLKzhPVgRLtw0xyeyfdaU4tfl7y05RxlspLydLkrxmRs4+hKkxab5g5GTl9rTGotxbjKlU3dn5ESOxOBZ1+Oow957SwD35mB3PMnJM61MMTZBezlm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8W7sDZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29672C4AF0A;
	Mon, 29 Jul 2024 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722256835;
	bh=wHsh5WQSdcrSRUcV1G75PxkF61eDMM6o20gIC6vEWX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k8W7sDZM60ZCVGHOLK4qBFnCXNn7y+ah5GB3OKiZNFyt7FYwfbgqO8ryokXlCc1WT
	 MtpKs9n1RWBgtxLHfJbNIdQuK02OVq/94HBEb4A4HO62v9u2JcEWIJomcGMeh5OMDL
	 TlAbt8R/3M+C6LitbJ1sYCiM78PYtHlh6Qyx5xeSBEGZ9LB1mxlh3+2dwN8Rzp7Nne
	 qvDHCBbz78qmLyJ0ilKj9o5TcxIiybdShk0Vmb5RnuGXjuMii7GqUq6heqLEdZN7ha
	 QJXgzOsB9pOc4gG5uMnbvTUQ/MIhiajStIm3eX5nhV/IteirVeYVeKxyQUak3tbtK1
	 lLKE3y7XR/5HA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19C17C4332D;
	Mon, 29 Jul 2024 12:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: fix signal endpoint readd
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172225683510.11158.15615122490002292811.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 12:40:35 +0000
References: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
In-Reply-To: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
 liujing@cmss.chinamobile.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 27 Jul 2024 11:03:58 +0200 you wrote:
> Issue #501 [1] showed that the Netlink PM currently doesn't correctly
> support removal and re-add of signal endpoints.
> 
> Patches 1 and 2 address the issue: the first one in the userspace path-
> manager, introduced in v5.19 ; and the second one in the in-kernel path-
> manager, introduced in v5.7.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: fix user-space PM announced address accounting
    https://git.kernel.org/netdev/net/c/167b93258d1e
  - [net,2/5] mptcp: fix NL PM announced address accounting
    https://git.kernel.org/netdev/net/c/4b317e0eb287
  - [net,3/5] selftests: mptcp: add explicit test case for remove/readd
    https://git.kernel.org/netdev/net/c/b5e2fb832f48
  - [net,4/5] selftests: mptcp: fix error path
    https://git.kernel.org/netdev/net/c/4a2f48992ddf
  - [net,5/5] selftests: mptcp: always close input's FD if opened
    https://git.kernel.org/netdev/net/c/7c70bcc2a84c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



