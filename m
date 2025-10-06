Return-Path: <linux-kselftest+bounces-42786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FB1BBF337
	for <lists+linux-kselftest@lfdr.de>; Mon, 06 Oct 2025 22:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55A13BFA1C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9402D8DB1;
	Mon,  6 Oct 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFncaIqP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F9226D14;
	Mon,  6 Oct 2025 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782882; cv=none; b=YAfDjJUGuTYWR88Q0O/hopTRAgUEQq21PZ5o1s7ys6K6SML+uwnv4b8vL+6ZIFwlf/uqT7hIkfM6VFgjrQlkTfOZ1oZ2YyWEgwbDad6i365UUs3qjbm0ppvaj4JdybeY42/H/pR3T4ImqKpZzdC5GYPDh0FE5MBfuaD9PQhOIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782882; c=relaxed/simple;
	bh=d+y6omQk0t67tX/0s0nTa0zg+8eiPBRJp5qGjl+9eR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZivMo0lCwCBlp4s0FOLhC2+yDSOnZ+lwPT2WgrY/llBoDq/4njEK/ljnVEhTUfewD2VtoEVqkK48zHlbO3sZo4AbfG7muXWG+EBNZXBdXmOS6eQBvsbiOVrBqxgmpP6CJVUpwDByfHpxGJufms/zQDWLTO83cEpCWjVVJ4Wtw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFncaIqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5C1C4CEF5;
	Mon,  6 Oct 2025 20:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759782881;
	bh=d+y6omQk0t67tX/0s0nTa0zg+8eiPBRJp5qGjl+9eR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tFncaIqPIbKIR1EH8d7lKTAUDLkPpsXRz5lJlXkAMODPVsRFAZKh/n1jTXa0rWrwB
	 klVi7DuqOhkRFWPEzlvvNABZZeBLKFqc5ZzD6VupCYVrakbB2BERykS828bHrOYyfn
	 zpSwjYNYHgUoRfpm3jvVSjPaxGn07hyYa5V2vXonA09EzvndR029apYw1FRGBcx4C2
	 yzthcuz3Wx84VTABIsygz+I3NFXO+beYg9VTBLkioNPvaz4z7SrnIRVUOUwr3rGP+o
	 Enacn2nH7BUyWrWuzUfYqOoZHywO+V4JnbRsMvu05fLY8j31vRrZ/D4TG6LX918+D9
	 bo2suM1Lek9nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA339D0C1B;
	Mon,  6 Oct 2025 20:34:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net repost] selftests: net: sort configs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175978286999.1522677.4107409489422965360.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 20:34:29 +0000
References: <20251003205736.1019673-1-kuba@kernel.org>
In-Reply-To: <20251003205736.1019673-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, phil@nwl.cc,
 matttbe@kernel.org, fw@strlen.de, antonio@openvpn.net, jv@jvosburgh.net,
 shuah@kernel.org, kuniyu@google.com, martineau@kernel.org,
 geliang@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 sd@queasysnail.net, razor@blackwall.org, idosch@nvidia.com,
 yongwang@nvidia.com, jiri@resnulli.us, danishanwar@ti.com,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Oct 2025 13:57:36 -0700 you wrote:
> Sort config files for networking selftests. This should help us
> avoid merge conflicts between net and net-next. patchwork check
> will be added to prevent new issues.
> 
> Acked-by: Phil Sutter <phil@nwl.cc>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Acked-by: Florian Westphal <fw@strlen.de>
> Acked-by: Antonio Quartulli <antonio@openvpn.net>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,repost] selftests: net: sort configs
    https://git.kernel.org/netdev/net/c/2aa74c625897

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



