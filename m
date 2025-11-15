Return-Path: <linux-kselftest+bounces-45683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F1EC5FDA5
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 03:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CD57F2415A
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11C51F5846;
	Sat, 15 Nov 2025 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8fkXKSi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5F1F4181;
	Sat, 15 Nov 2025 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172151; cv=none; b=N/xJ0/7LneWOVTkVw8ufBqt5LR16YjJZVu09u3x0Oubem++XTQ94SrYqnrOBTajhYpveNV2/+Zydklal1cByunIE9gJw8hA/x7H95bsIylGkay7Q1ZAeKrbOsPvCo2599lNRbwxLja6GxEbQx9VJtsAEVsfo8bw7RKl2m8H467Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172151; c=relaxed/simple;
	bh=MrqtXu1PfQZ/Xh4kMTsJ3p1OceqkLnLj1+0ueHPBrrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bh3S30wV6fH0txrrtYj9liGYQYM2rdp0ovoY0FoA8xmUqqGAbRHN+UkNvKWue1Rcc5Io1+GUtb5fPUV8BKJS44zw3TTrQXeUhS3hSlodtt6Ix23nc0N2LourJvNf5gIYXBcYvDzEBo7ajsdSZQEe/5lD7meUrXzBnvhmqdHQc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8fkXKSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDAFC4CEF8;
	Sat, 15 Nov 2025 02:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763172151;
	bh=MrqtXu1PfQZ/Xh4kMTsJ3p1OceqkLnLj1+0ueHPBrrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p8fkXKSilClmZhI25mW1bAQ4Q8cktJxXroIBkATsOVw0EAhibqpsMt15Ww4x15GOG
	 1HCLk7BL5Zzmz772SJJfGcnKxEiQ3DdwJ++vNL8BuWHfCC0uW0rpgF2L+s/5DDquB5
	 KNVcwAXeBfSJED6qKszJmDfgD4BgGT7vTr73kfWHmM7v2yzmo+c4ZfxQ0yrvzebfkS
	 r2a1TSh7zfC94Qfu5nEmXrspdjSheBj8k1++1iDnLmuI60fBJiVUK+3OvJQzI5kV9E
	 6hoeW4mLjvSn4ytYrZujq4juY5p43O79tIn97YWayvYPRXefI91FNnfE+oU8O0/iWV
	 PNDi7+vPqzjuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9C3A78A62;
	Sat, 15 Nov 2025 02:02:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: xdp: make the XDP qstats
 tests
 less flaky
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317211974.1905277.17045988476387943436.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:01:59 +0000
References: <20251113152703.3819756-1-kuba@kernel.org>
In-Reply-To: <20251113152703.3819756-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 ast@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 07:27:03 -0800 you wrote:
> The XDP qstats tests send 2k packets over a single socket.
> Looks like when netdev CI is busy running those tests in QEMU
> occasionally flakes. The target doesn't get to run at all
> before all 2000 packets are sent.
> 
> Lower the number of packets to 1000 and reopen the socket
> every 50 packets, to give RSS a chance to spread the packets
> to multiple queues.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: xdp: make the XDP qstats tests less flaky
    https://git.kernel.org/netdev/net-next/c/eca8b8fc74cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



