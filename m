Return-Path: <linux-kselftest+bounces-14751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E380994662C
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 01:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F34C28356B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1113BAF1;
	Fri,  2 Aug 2024 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqipLHvR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531413B787;
	Fri,  2 Aug 2024 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641445; cv=none; b=o1KcGe3/aIvVvtHJa7LBn17cvDhFSlVQQjkb3icO8yZT4HQLIXnAAwDZmL1GXjN0E6S9ySqCGDcI5EK3OHvLncCV8SqrorBUtBtAfXPzGgeJuw2F4Sp9lv0Lr/GotktcIlcUHSw26jTKsSxeVGXxv0hhfz86ZGJYwRsrN0X58PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641445; c=relaxed/simple;
	bh=I+J2ZJubhqM4/6lC1N9itlCIEmFUPT8RxOu3m37k0zM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rs4niL5aSCjTzR3kLXU2wFgkKuL+L3x8QLCLt1TYC2NInIVTIdY8f5YhGX2QIreJ878hpYa8Ssj456S3MJ8avhgQSf6UsW/Uu3UcBo5u1bXswUYLSBsJU00L3BHIyK9gkX+W1xp1Ahu+IJB/skdeggvOyn8nvM6uaKEb8qi5uFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqipLHvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93FC8C4AF16;
	Fri,  2 Aug 2024 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722641444;
	bh=I+J2ZJubhqM4/6lC1N9itlCIEmFUPT8RxOu3m37k0zM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NqipLHvR3AIEdP3qV7Zhvy1YcGccKJkKIUJOw54n2Xtz5OE7Gqz2ZtV8R1isrf3Va
	 uz0sUp5q0j3evPHT8SpbDznfHCCtKkPd8xdZcOTcG1/uEVMw0VTfj5e+kvnF3NkRTB
	 FAz+WBTmC0MUdlVd43MEB4FF/tAuDAZF9AdV77shs/Yl0zXteFqvd7Zb4pOI67uird
	 cQHvW3HvVl1HOuWmfq/vLXBQqCy3YMXMTE5vQW1fh3kBzk8HdZXknpJ/fXFT6ojimA
	 84EkKPQYoQU/NVbA1Bjjv8MQDmPI4NrH2s4tkoTNGWdWksQLyWc1GymJ6Scj6JffTJ
	 t0pjnzEGZyqOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A71AD0C60C;
	Fri,  2 Aug 2024 23:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/3] selftests: net-drv: exercise queue stats when
 the device is down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264144456.25502.12472337921834867363.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 23:30:44 +0000
References: <20240802000309.2368-1-sdf@fomichev.me>
In-Reply-To: <20240802000309.2368-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, jdamato@fastly.com,
 petrm@nvidia.com, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Aug 2024 17:03:07 -0700 you wrote:
> Verify that total device stats don't decrease after it has been turned down.
> Also make sure the device doesn't crash when we access per-queue stats
> when it's down (in case it tries to access some pointers that are NULL).
> 
>   KTAP version 1
>   1..5
>   ok 1 stats.check_pause
>   ok 2 stats.check_fec
>   ok 3 stats.pkt_byte_sum
>   ok 4 stats.qstat_by_ifindex
>   ok 5 stats.check_down
>   # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] selftests: net-drv: exercise queue stats when the device is down
    https://git.kernel.org/netdev/net-next/c/ab1000976cc7
  - [net-next,v3,2/3] selftests: net: ksft: support marking tests as disruptive
    https://git.kernel.org/netdev/net-next/c/f87930683481
  - [net-next,v3,3/3] selftests: net: ksft: replace 95 with errno.EOPNOTSUPP
    https://git.kernel.org/netdev/net-next/c/a48395f22b8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



