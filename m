Return-Path: <linux-kselftest+bounces-23569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007399F7359
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 04:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664E0188C657
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 03:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6C3198845;
	Thu, 19 Dec 2024 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn0dKtyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF6192D66;
	Thu, 19 Dec 2024 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734579018; cv=none; b=qCUmbFNnxaB59x06Mq1OzRLyyVwsyts2krmDCsTu5IEyvNs9+F3cmpxV/8Y5eYn+wt7VA87dgK7eUnp4bRdIClpvo9malLUoQ1qHuaEIvzx/H8TZm3jnc+ndQdq9GZ8obALTucL3cwsbiTbm/zdw6WXrz9QpQAxstkuJ3sIZ5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734579018; c=relaxed/simple;
	bh=FFXgQmkgh31b62AF6j6pm/VwfbRUDE+1WU1nrLOpskw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t+I1o9kmmg/SHmTw/VKMdR4HMItONhMaOdnRSlatPHQhzFUhr4Z6099R0dGbgNsCuiEmajkzPzBZgP4SJNlHgWH1Kj57AQm6EMfJZkmLoIXN+Db5TpZJz0o4VDNmFaEcj3co9YlJ1tP11pcz6M3j7UisWBex2W4c3WGURRwh+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rn0dKtyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B19C4CED4;
	Thu, 19 Dec 2024 03:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734579016;
	bh=FFXgQmkgh31b62AF6j6pm/VwfbRUDE+1WU1nrLOpskw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rn0dKtydfw3qNrkIznCdWyqnVpOt3odrv3ZnxPulR/hxKJinzc2NCchkn4tJx+Z8X
	 Bgm1u+NVIlgrcrBTTUurep1MxEk26vDiaRneKy2UHxfKeyxIkFW6t6ysBNiClmIgW4
	 P8tzOHycFkb/PdvHPH++eWyd2qqbfGl2J2+5D5WheT+Vz9w+wDokg6wbuW4gjgd/Jx
	 bPqx7zfDU9cdQrMsPzqJ2IZzQrF/JRVy/g17Jb7WJa3G+e72RcNXbUIL1UNK7oCoxI
	 xByL5+Tn+RwyNAGCP1v5Ggmx4/D06IOMI2kQJnk16Wj1JDZGRxhG6BqULW9e8sMWDC
	 ro4eL/pIcPcvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 15E373805DB1;
	Thu, 19 Dec 2024 03:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: openvswitch: fix tcpdump execution
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457903400.1807897.509838240385044906.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 03:30:34 +0000
References: <20241217211652.483016-1-amorenoz@redhat.com>
In-Reply-To: <20241217211652.483016-1-amorenoz@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: linux-kselftest@vger.kernel.org, pshelar@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, aconole@redhat.com, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 22:16:51 +0100 you wrote:
> Fix the way tcpdump is executed by:
> - Using the right variable for the namespace. Currently the use of the
>   empty "ns" makes the command fail.
> - Waiting until it starts to capture to ensure the interesting traffic
>   is caught on slow systems.
> - Using line-buffered output to ensure logs are available when the test
>   is paused with "-p". Otherwise the last chunk of data might only be
>   written when tcpdump is killed.
> 
> [...]

Here is the summary with links:
  - [net] selftests: openvswitch: fix tcpdump execution
    https://git.kernel.org/netdev/net/c/a17975992cc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



