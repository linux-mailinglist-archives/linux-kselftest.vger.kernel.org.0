Return-Path: <linux-kselftest+bounces-14093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D70093A6F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A64282FE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491A2158871;
	Tue, 23 Jul 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTII4wux"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4E13D600;
	Tue, 23 Jul 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760034; cv=none; b=kqRa9DGSIP0u6bmr+ny/t9urZSR0vcjX59X6PbD4YGoeIU1+4JVeTwQbBcgEi5NLUDleVoOz2d6ixafpd6In4c+q5cf4QI06gzHfm1MYL0XBZrTTo8gFtbfg6h0Smf/2o5U/5/eTvmeA6DAGdffLR+L2yyv+K3xpv9l9MBaat0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760034; c=relaxed/simple;
	bh=/lpVXVUTWOYGB1S+19epnq7oRNjenOnoiCNrEtec7gI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nSOUkVnfjO6kpCkTTj2brKdVHF5TODBaIo70n1KO2uhTAQXs2sIZjGJWSjRVxWu8eRu8fE6nDHCar5CZRzGi05rdK1VX/byWclJe1V5Nk9Xg/eE3wh86PTQLFc3uKemExp1xTTD0cn0VFfBstmPvHFUWDlJZzNWiF/ruUbjQuM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTII4wux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF16AC4AF12;
	Tue, 23 Jul 2024 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721760033;
	bh=/lpVXVUTWOYGB1S+19epnq7oRNjenOnoiCNrEtec7gI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qTII4wuxp2/q//2kN+pztco+a103KF84kJHd0Or178RTzENRQ86wAXoozRTMeu+s4
	 N7mePYojpo4x9irh29ej9toStjzxPBBJGDcSq1dykkmNlP4yU6UzlEsgMeEng0DLP/
	 LAa1k69ATXLr+ZApBF1YCby3otToQiOQY6pGEcC1u6Q/XYrRrVx0tpH5WRvFlQ+bZu
	 5Fjog2zfbeOnjjsMQz1PkLLjeLlHGj2EpywX221rWFvCKx8YhH5jHAzS0+Edru9t5G
	 ifpG4nWP7Kzwep1cmKSNYrQitxt329kPxkD2Le+wEwYd7zGePZcKJJdyifI66vSbfG
	 8ftTe+9j2W3lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0E0AC4333D;
	Tue, 23 Jul 2024 18:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] use network helpers, part 10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172176003371.29079.12655588426489988512.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 18:40:33 +0000
References: <cover.1721475357.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1721475357.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat, 20 Jul 2024 19:40:02 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This set is part 10 of series "use network helpers" all BPF selftests
> wide.
> 
> Patches 1-3 drop local functions make_client(), make_socket() and
> inetaddr_len() in sk_lookup.c. Patch 4 drops a useless function
> __start_server() in network_helpers.c.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] selftests/bpf: Drop make_client in sk_lookup
    https://git.kernel.org/bpf/bpf-next/c/a81b34bb2dc7
  - [bpf-next,2/4] selftests/bpf: Drop make_socket in sk_lookup
    https://git.kernel.org/bpf/bpf-next/c/c6b30248c21a
  - [bpf-next,3/4] selftests/bpf: Drop inetaddr_len in sk_lookup
    https://git.kernel.org/bpf/bpf-next/c/5849dff3414b
  - [bpf-next,4/4] selftests/bpf: Drop __start_server in network_helpers
    https://git.kernel.org/bpf/bpf-next/c/b27a9abd2dc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



