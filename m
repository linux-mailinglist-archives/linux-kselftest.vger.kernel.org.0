Return-Path: <linux-kselftest+bounces-16463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF7B96184D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 22:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA131C22DD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB18156676;
	Tue, 27 Aug 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTQeOecc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC413CFB8;
	Tue, 27 Aug 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788831; cv=none; b=hin1G6KYwhxSmIIrNzpE1UCPhpmZaV7lCCBMpbymwk/Cst6x8kxtexNa4OLVENX7kLjF1qKlF0GkTerh6gF0pICgCnDdPwTQUoDRwR2P7T9RvsBb/RnML5/7jGkFX1vewDm95OAixrNFHYk5yZOxNdvARQ5DWCe9X9HMTe1ZX00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788831; c=relaxed/simple;
	bh=QuRznfQG10kbX4QJtTbbGu3sZ5smNYTiZxgfQW4QnHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SdQ8yZl5O5qgEDbzpvbKJRChoxEeifMv5TOOJLfb6Nad6mC7eo/8Uf+8/ZHg+13y/g+GzF1pc8lVE+VyitFdBtavRozo0hvH/uFYHDdJXxGE6x1aLZKnMx1zumxzobsEdIaaehFfOEDWtiCd0id1F45aerAqS0R8PYFtMpSRz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTQeOecc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F00C5676C;
	Tue, 27 Aug 2024 20:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724788830;
	bh=QuRznfQG10kbX4QJtTbbGu3sZ5smNYTiZxgfQW4QnHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XTQeOeccivc1VeH5yy3WXHahTTwoWyExCtRKZDofrpXRG6A2m8hr4m0aSbnfDJeAQ
	 aT1sMMFcrMFOndViKhcPcK5c5zSbduDWaOfGtNNWOBelTm1PT3Ywxn+N8RQji6qcNg
	 MIEdr0QHWDLliMd8MlkU9dQzeSts4Moh/VeSg63J75XQhNC5rf8T05Ruq1H1ptik+R
	 kWOsI8WubtTd2tW48338nbXModryLsaUCD3IRGRb5HN+KzhaeMEe4yWExrc/IgR+Ps
	 9TljvgYx2aK2Pch+LykJQMO0XVdRtI3JEoqJANcDJsoMOER3dplxzri1jyZpekCrm3
	 7lfWhgiS+LEeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9273822D6D;
	Tue, 27 Aug 2024 20:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: forwarding: no_forwarding: Down ports on
 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172478883076.749473.11205211795753884311.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 20:00:30 +0000
References: <0baf91dc24b95ae0cadfdf5db05b74888e6a228a.1724430120.git.petrm@nvidia.com>
In-Reply-To: <0baf91dc24b95ae0cadfdf5db05b74888e6a228a.1724430120.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, vladimir.oltean@nxp.com,
 linux-kselftest@vger.kernel.org, shuah@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 18:25:37 +0200 you wrote:
> This test neglects to put ports down on cleanup. Fix it.
> 
> Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/no_forwarding.sh | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [net-next] selftests: forwarding: no_forwarding: Down ports on cleanup
    https://git.kernel.org/netdev/net/c/e8497d6951ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



