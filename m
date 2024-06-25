Return-Path: <linux-kselftest+bounces-12704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8991E916D7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 17:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4666928EF48
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7376816FF36;
	Tue, 25 Jun 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngFQLq1H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625B169AE4;
	Tue, 25 Jun 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330629; cv=none; b=dEaFVMXP2tkEqbsveI0H8t6W9QZhNZwYD2r3Rqf+fU6aOA63G2OckHWRzeunXo0nV+UollbEOBD2k4xavUJsZTWKEOUkoyW/MFjUqozSp5F5iM5SY9aX3InVlxB6+vYwI7TSfdDciyGHdiMvkplyIiqie2Eov55H1HNwdEwu3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330629; c=relaxed/simple;
	bh=Mix5r5R2/Tn4EDBwTAiE8pSBL0Zhkpu7IRc3aKgd5QY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rgRmTnFxGJ8hIS6Ry69KzeJOkTTy7mA1LKbAKC7JbE0LWhWVPrw/9B/iwc34RnFgp6eLz6TBTYtg1hJkMWrvP/9p0xePzplgteK/cDVms/H9H4fhXzB6gVbRVEYl/yVNZkz09m1xS3k2KdMu8qy9Coxh4jRzCSGr/3hyuMwZFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngFQLq1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC8E8C4AF0A;
	Tue, 25 Jun 2024 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330628;
	bh=Mix5r5R2/Tn4EDBwTAiE8pSBL0Zhkpu7IRc3aKgd5QY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ngFQLq1HFtEkZqjgfYin1JzZ+sQWxmRhIRDg8SWEjp5MDlc9tJm+ePI1EGT/b9G46
	 nk/JkVlUZv3DhQ7WCm724BrhoN20OGVKs/XN2texdn5Bd+1W06TzaDSbpP4HpB7rDw
	 8nNG9M/4uogxYnH3Fbd/cHrDtDhQNkq2VcfLtj76kELXLr4yYv8ViTUQAtu2h5n8xn
	 IzrYc+n5BHEUzhxv/eHZyyRQy9dK11zYXuVKUeLnw5+LY2CWMucobhtEwGQgZOUtDN
	 gFBwXavdY/7iTNpdkUGCPDh6smkxI+QjY7Jzs3sUmCmnQBKQuf+IMxBVC/XfdHCE6L
	 SgB4Pcr526efw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEB2AC43638;
	Tue, 25 Jun 2024 15:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: remove unneeded IP_GRE config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171933062871.13323.17119507002483608528.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 15:50:28 +0000
References: <20240624055539.2092322-1-yujie.liu@intel.com>
In-Reply-To: <20240624055539.2092322-1-yujie.liu@intel.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jun 2024 13:55:39 +0800 you wrote:
> It seems that there is no definition for config IP_GRE, and it is not a
> dependency of other configs, so remove it.
> 
> linux$ find -name Kconfig | xargs grep "IP_GRE"
> <-- nothing
> 
> There is a IPV6_GRE config defined in net/ipv6/Kconfig. It only depends
> on NET_IPGRE_DEMUX but not IP_GRE.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: remove unneeded IP_GRE config
    https://git.kernel.org/netdev/net-next/c/c4532232fa2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



