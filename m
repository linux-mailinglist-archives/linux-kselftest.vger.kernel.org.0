Return-Path: <linux-kselftest+bounces-28679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BFEA5B074
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 01:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C6F17013F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 00:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731D62222C9;
	Tue, 11 Mar 2025 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJOb4IHl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BA1CAA8D;
	Mon, 10 Mar 2025 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651200; cv=none; b=Je1J+TfH2Mq0V/GKzXbpa2V2+hz4ZurbkApvlKzTr0rSJXIoFA0w6gURlfMDNsQB/IRRAIukz6kD0wBfYIo6jf/qYs62o8ahE3Axy3zhop3LBglloLIxPxn/H2pegso4+NWUsksWEHBEJE4Av/ZpN2f8tnv4xGnI+Dfn7uLQu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651200; c=relaxed/simple;
	bh=CJ7jTSxee4pxv4sjymxB6XfJRq88ZKOOdxIoYQUNPTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mc0RrMuHKnSx48VJBVcK4CXicWCJyRWbA+shrFWWcRg8W9C1l+rL55RlI6CsL03IBvGpocCX+nZO3EiK0FG+tjKbaf4OoEMQpAzqIFq7rl0W26fAqSLAIu6bTHgak8rLYUeRnfToy7bb1EweCSws6dFHkuh3q9FW+jegKJIJj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJOb4IHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6914C4CEE5;
	Mon, 10 Mar 2025 23:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741651199;
	bh=CJ7jTSxee4pxv4sjymxB6XfJRq88ZKOOdxIoYQUNPTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rJOb4IHlJt22B1UmAe05Pka8ARNc28gUIpTeQxb1dhmLdikArXXgaUQyBR8pEABGx
	 EIzN/jen8xtGgmxy81bIyVCl1qAF0dMwdaJzKQIcBdMHxbG4a8JFdK6OUUI0Ug68CH
	 qXGHNGf61WlRkDIQumDX7TgdSMjAYqgS5jHFmzuoFHJsWJL7sbL9lLO1h/kznHwb7N
	 wxt3INZxY3ivhn2bEYskujaBvSyD3Tkak/L8Rq4+2uogyFtSjC3bU94WzFq545lnCg
	 anMyQ3N1uJ0iAeRERNmwMJT4XJkZI2FeVGrEA8eTJgvnztjWfPKn/QYw94kdNMMg5L
	 RKDx75X9CsAHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE7F380AACB;
	Tue, 11 Mar 2025 00:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Convert comma to semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174165123376.3738644.9187639852892920480.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 00:00:33 +0000
References: <20250310032045.651068-1-nichen@iscas.ac.cn>
In-Reply-To: <20250310032045.651068-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 aspsk@isovalent.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 10 Mar 2025 11:20:45 +0800 you wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Convert comma to semicolon
    https://git.kernel.org/bpf/bpf-next/c/233732b289f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



