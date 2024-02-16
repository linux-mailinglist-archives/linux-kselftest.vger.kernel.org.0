Return-Path: <linux-kselftest+bounces-4872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2EE8583FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 18:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29702281A3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F04130E47;
	Fri, 16 Feb 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdTyIlkF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD412FB31;
	Fri, 16 Feb 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104026; cv=none; b=ofp1ArGivld8sLelx2/Q1Yahw5afAPtfew84Yw+4dBqOPsC2gnyJtK6jnsdAGG4sV0QQukhTq5TZoO5b23phOMJOo/nI6uhZT3D2PobSOuxwLyeizrtyD2dtlRnV1L/IZjgPyjhyrhNXgnsPbvwEPjXsIaSsSihOfRzRguqUe68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104026; c=relaxed/simple;
	bh=8DCxioTSQAbCL2w8t8Wo0mPMDi8xtgenwxPfpVXNezU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u9YfZwpjjpOmIDyujAF7n6d1sjOwhW79v4DzYe901rTFKxcQx8DqopF+skG1jUoezGaR25y7yLkBh6HHNrdj3tIkpFS/BoTeyR+++SCm8m6bVjALI0kiJcM6Op3rtPEVg1Iav48STBap9Ip29vctHpp7Hu3u7lBnB4mKSahJAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdTyIlkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A6C1C433C7;
	Fri, 16 Feb 2024 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708104025;
	bh=8DCxioTSQAbCL2w8t8Wo0mPMDi8xtgenwxPfpVXNezU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SdTyIlkFD0mamipzQgenp7kFUq+xjF1lcx6lKd7w4x6LeL8baRyYe0CiO/VhAsuxc
	 aS6DwTkpjtLJO8EWuKlRlUG4Agxr3Y6+WV0pTjqkDef5bOwhyRUzbnWLj35oWtIjOI
	 93eKbnENQcTvVRN7YUcF1SA5KPIKRl8dJDpTSn7ma3o/XMK9t4OULJ+EuYN+OgaIza
	 ZTes8kHtIkoxh4Hyte4YLLPUEVtR86nNgr4ud7SeSPKUgwHoIe8KVR3A0/3rjrlU/m
	 fC08qTNcmGe+Kumn/zyEEHFU/gZsQVH2XlCYn3C+K+0ZZFm4dtjhTf1em2MCU6CdzU
	 dxaJRNRPp8FXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B77FD8C97F;
	Fri, 16 Feb 2024 17:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests: bpf: Remove empty TEST_CUSTOM_PROGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170810402550.3129.12516651246134620322.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 17:20:25 +0000
References: <20240216-bpf-selftests-custom-progs-v1-1-f7cf281a1fda@suse.com>
In-Reply-To: <20240216-bpf-selftests-custom-progs-v1-1-f7cf281a1fda@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 16 Feb 2024 09:42:45 -0300 you wrote:
> Commit f04a32b2c5b5 ("selftests/bpf: Do not use sign-file as testcase")
> removed the TEST_CUSTOM_PROGS assignment, and removed it from being used
> on TEST_GEN_FILES. Remove two leftovers from that cleanup.
> 
> Found by inspection.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests: bpf: Remove empty TEST_CUSTOM_PROGS
    https://git.kernel.org/bpf/bpf-next/c/7648f0c91eaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



