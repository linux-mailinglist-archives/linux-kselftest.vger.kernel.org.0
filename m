Return-Path: <linux-kselftest+bounces-34832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6DAAD78DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 19:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F9D18944BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5D29B8EA;
	Thu, 12 Jun 2025 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUqh8CZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0722F431F;
	Thu, 12 Jun 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748799; cv=none; b=Ys2pOwbH4iROJprY/4QItcqqNv+WVIPvRr7Cfy1zAvd1hr9sUtloeDplEPFctPCXSNGIFiRDuq+nqa0MIp9Ye/uNYy7eL3/nnxHxVLIdGDtmmw7MAYJv0VPtrpAnl23vXxdm9hP9J7ks8be+5P55kew1DhG1EXfj4pk0ElhiP8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748799; c=relaxed/simple;
	bh=HsL/G1M5bmovcZuSfCfYKfjkLeI0hmgdp3WD/9lvOGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hYBApJK0MiJguItUO5I6CpCccboia33eoUHNHIDuxsdMntX4+cPIpYnCqnPcr9qq/YxV11JFmd6iMlSk5khkKPDbAntG2uS6U4wE9RNNXcVqaDEbiq1D9e3GAmRiWpgIqHvmeOgp+x+3kmuDu8pcMGu3cK2s8kAsn5k8TCkD5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUqh8CZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B60C4CEEA;
	Thu, 12 Jun 2025 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749748798;
	bh=HsL/G1M5bmovcZuSfCfYKfjkLeI0hmgdp3WD/9lvOGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nUqh8CZdKP5boy5lHAxxsi1o9zZNVXbOKGuZxcGe87w6mVfoJBl/Hw5MV1GsVLJGK
	 4V/in0W/v1FEQQSQio9h06o7iti5n48S8dOn+i/lShpe28IIXlcjwWGehnrSAmE1G0
	 Y/h3ydexz2pd4CIZVv4efY4DKWQEZ9tQ0Tp1wy10fPVjfw3GeePjvxfQ+ZzLWBFVDw
	 1WMaVKpK9b0zIaHuWZo1p2QahkN7TzV4PbXqBnWC1BlmAgzaYUHirGQbJ/wN8k537j
	 fbtU2u8eP4yDW/4GwxjE4ah+pL1XVhWkS+OpR7CEstOobA/QVq5OWeTDB1C+yFf8Po
	 ZaCbG6h9OOaow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5439EFFCF;
	Thu, 12 Jun 2025 17:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix signedness bug in
 redir_partial()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974882850.30472.12542945135182061841.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 17:20:28 +0000
References: <20250612084208.27722-1-wangfushuai@baidu.com>
In-Reply-To: <20250612084208.27722-1-wangfushuai@baidu.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 shuah@kernel.org, mhal@rbox.co, jakub@cloudflare.com, thinker.li@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Jun 2025 16:42:08 +0800 you wrote:
> When xsend() returns -1 (error), the check 'n < sizeof(buf)' incorrectly
> treats it as success due to unsigned promotion. Explicitly check for -1
> first.
> 
> Fixes: a4b7193d8efd ("selftests/bpf: Add sockmap test for redirecting partial skb data")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: fix signedness bug in redir_partial()
    https://git.kernel.org/bpf/bpf-next/c/a59f468c4a02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



