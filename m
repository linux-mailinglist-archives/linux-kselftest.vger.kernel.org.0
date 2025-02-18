Return-Path: <linux-kselftest+bounces-26819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398A4A3903D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 02:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B4E3B3D20
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8958B482EF;
	Tue, 18 Feb 2025 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDq8FG4r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF12AE74;
	Tue, 18 Feb 2025 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841616; cv=none; b=AgAO07TGwLCrLCOC3D2w7d2eZv8WekNOgNcHpgGSCHlKrNKUXKVmlF1C4Mcav7zOWUsyKTyNFxRrCKdTd0uzQ00kAmL9eT1l0MHC1jwM7v4FA7ysJq4ou0+K9NGW/YoYnJ4EVF5WFZn7arDaZ+H6FfDHyR7vEgn58gupnJH2f0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841616; c=relaxed/simple;
	bh=Khz7tl3u5dbiKnhDsJZFV1wZh3kwVGNNXQZRygEfelo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UaDKBv/e3T40WdvFc7rOKlLp3IHBJqRTOa7MOdC1Pif5s87dVqbOeZVJJ3sP4YhPSbXDNZ/kyfjCdVZa/UgPs2IaD7RSnjPfOXTBCh3QV77wFFB/XCo0Nm3FSbVYMjo0P/84ib+KVkyEW/Z+fctmpsEd9LOWPbgdJR5kxrEOgig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDq8FG4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9AFC4CED1;
	Tue, 18 Feb 2025 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739841615;
	bh=Khz7tl3u5dbiKnhDsJZFV1wZh3kwVGNNXQZRygEfelo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GDq8FG4rRDiREHlguc/XgQXPosvQjCQLnQloC+JKAU0qZiIT/6qG4NVGMoBBe7xZt
	 VfzQutpv/hwEnvQkU40XRt05ztYmMEyF9MFxYluvrzvT5xzdoG4lim5BIAj+06B1JZ
	 807V5A9zULuEttj0oQNr1D2xqqezR6WDmoszFLpuaofvuRQ7siKqTVVboukhX0e7A9
	 uNbZ8KjIYm/J0NdOkU/PQR7Yrvb5XGPm9nhVRyhcehaBQjn9eHnbk0EqhoFvwu76kr
	 +dCX5hzBAI6Nm9BVsmvvVFEaOv7CFPrGX95Ht7FxvXCgxYyHvnoo9c3siJYYQdMJU4
	 RTRe28jK/u7iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD1380AAD5;
	Tue, 18 Feb 2025 01:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/3] netdev-genl: Add an xsk attribute to queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173984164576.3591662.3668006598092128301.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 01:20:45 +0000
References: <20250214211255.14194-1-jdamato@fastly.com>
In-Reply-To: <20250214211255.14194-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, stfomichev@gmail.com, horms@kernel.org,
 kuba@kernel.org, ast@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 daniel@iogearbox.net, danielj@nvidia.com, davem@davemloft.net,
 dw@davidwei.uk, donald.hunter@gmail.com, edumazet@google.com,
 hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mkarsten@uwaterloo.ca,
 almasrymina@google.com, pabeni@redhat.com, shuah@kernel.org,
 sridhar.samudrala@intel.com, sdf@fomichev.me, xuanzhuo@linux.alibaba.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 21:12:28 +0000 you wrote:
> Greetings:
> 
> Welcome to v8. Minor change, see changelog below. Re-tested on my mlx5
> system both with and without CONFIG_XDP_SOCKETS enabled and both with
> and without NETIF set.
> 
> This is an attempt to followup on something Jakub asked me about [1],
> adding an xsk attribute to queues and more clearly documenting which
> queues are linked to NAPIs...
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] netlink: Add nla_put_empty_nest helper
    https://git.kernel.org/netdev/net-next/c/a127c18462ea
  - [net-next,v8,2/3] netdev-genl: Add an XSK attribute to queues
    https://git.kernel.org/netdev/net-next/c/df524c8f5771
  - [net-next,v8,3/3] selftests: drv-net: Test queue xsk attribute
    https://git.kernel.org/netdev/net-next/c/788e52e2b668

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



