Return-Path: <linux-kselftest+bounces-22231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 235DD9D1F04
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 05:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FE282723
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 04:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A58148850;
	Tue, 19 Nov 2024 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3emyD3o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620ED2FA;
	Tue, 19 Nov 2024 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988820; cv=none; b=nRhikR7OUCCd15RJjMJo+aUDYOuocnaAEf2EXC2PrWAt1XozFN7o7yxUNixJhBfTpD7lVP0nSMYqZi9ry0huIdvWWUxff+nfljFfw96II5bH/BQ4u3rDvcehVazbUJoMOPGfXNF7ROI17w9O2ZoodVu8cjc1CuI14lYA6RzyeiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988820; c=relaxed/simple;
	bh=cYneMGn3oJqW5FRh6O69nf0Ew12DjHQoIA3RWXGZzmo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GO3/dBcddij9Xc191QkkDOutjeIfqrmq+ZdjYGdnTUTpeL4jqVmz9RrCE4xRV0pm2xEi064dcFBXmoLr4zkUniRQekAJC6qd+nHPnzo2n5DKbh17u/9C/QYmE5SOkHmfmD/3MgEwRAtN09o8rH5aDMznHqiOp4QairE4Tjqwtx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3emyD3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C150C4CED1;
	Tue, 19 Nov 2024 04:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988818;
	bh=cYneMGn3oJqW5FRh6O69nf0Ew12DjHQoIA3RWXGZzmo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k3emyD3onkzWrUPAavclZ64Y5ZJNaw9sS5HAOxoEA5MGrAax1HO5kquvJwTeiKj6L
	 LC4WKFKD4Cs3FpDLfhN95SwLa9tcBhfCFo2nc0TKLJ3aUt6h1g/2X76mlTkchJjuHR
	 8mPaHBHLI6OjKUpqxzNx9kZE1h8b9xG2NxzSbVaWDKpvXeoXzdZKVOrfGWNqNpsBmx
	 2FyXFAjhM5qEtWJ7SzcDneP6jD2/qKp2jMwVuwr3mLyabwQzuwEO1Vrnxk8GAnpzZV
	 4agD6hoR2u6yiPO47wWLR3p72eWlGdu93zNu+CBpIt1HegFc7cb1eX81YJf2ucIYMK
	 zXxYs7+OffyRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE513809A80;
	Tue, 19 Nov 2024 04:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] bpf: fix recursive lock and add test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198882976.97799.1627971734543862873.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 04:00:29 +0000
References: <20241118030910.36230-1-mrpre@163.com>
In-Reply-To: <20241118030910.36230-1-mrpre@163.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: martin.lau@linux.dev, edumazet@google.com, jakub@cloudflare.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, daniel@iogearbox.net, mykolal@fb.com, ast@kernel.org,
 kpsingh@kernel.org, jolsa@kernel.org, eddyz87@gmail.com, shuah@kernel.org,
 sdf@fomichev.me, linux-kselftest@vger.kernel.org, haoluo@google.com,
 song@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, mhal@rbox.co,
 yonghong.song@linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Nov 2024 11:09:08 +0800 you wrote:
> 1. fix recursive lock when ebpf prog return SK_PASS.
> 2. add selftest to reproduce recursive lock.
> 
> Note that the test code can reproduce the 'dead-lock' and if just
> the selftest merged without first patch, the test case will
> definitely fail, because the issue of deadlock is inevitable.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] bpf: fix recursive lock when verdict program return SK_PASS
    https://git.kernel.org/netdev/net/c/8ca2a1eeadf0
  - [bpf,v4,2/2] selftests/bpf: Add some tests with sockmap SK_PASS
    https://git.kernel.org/netdev/net/c/0c4d5cb9a1c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



