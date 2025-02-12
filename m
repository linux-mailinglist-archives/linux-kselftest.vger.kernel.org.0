Return-Path: <linux-kselftest+bounces-26439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACFAA31AD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 01:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A81888DBB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB386125B9;
	Wed, 12 Feb 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIYeM9D/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB8FBF6;
	Wed, 12 Feb 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321407; cv=none; b=B/soGxeuQJ+SZ6RQGppNNcvMHJhYZSnQmIWQ3r7QVM1gnKrKIdGmY5u0SIgXeEHzwlaffUAuEe6RvUgC55Sg7Nx1yailNg4M9lHd8W1DtCX911lWioVeYd7u0z/PZxA9aSN3X37hwa/GIUNUAJpk6w9eWziEcxBQW3T8JCgvsEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321407; c=relaxed/simple;
	bh=mC7Q3/O7Z/cIOat5QkYiQnYlJ5lqq8d2vDS7X8MEJVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Od81sbupAnbCeU9c/7zQy2IEbAuU8Oxd690q1OaVzumKidkFN+k3YA8yYNwDxxlGBmKowFH7TDwmNX1CnXb6sC6scK/3ymhXsBnV/93WEv2YcD0k+d1X0wXGrZ6RTnzXL2DezH8KLLDupEOexASm4bef9X/tcojyxQ22xG9o7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIYeM9D/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E070EC4CEDD;
	Wed, 12 Feb 2025 00:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739321405;
	bh=mC7Q3/O7Z/cIOat5QkYiQnYlJ5lqq8d2vDS7X8MEJVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pIYeM9D/PYAAnPPlWlIDGCkdHnjcG+7hAzUGTlPgbKBvs7c2NntWQz/SA9YK3MVcI
	 GhrEHpCKmRPRCHFN8LYWJSckNU91dOelUpUUw752O9AFDhF0S9AeAWxh8aiVqukFLC
	 y6HITN12z+6CvINyMMvUR5dwNdB4FrQO4OA0MBvLV7Wr84qazewofEGJK95VGFjMXW
	 00uOy3J7FmTXpz0my93lMQVaEJsM0mRZ+S2N0Wdewi4cfHUeSFx6e84ZMtiIgzWe1x
	 v+m45tVa5zI1OrQzvDkWKWqzkb/TgbW9eG9JwtmWNfdyXtgo11jd0TC/JCiYv4fBIA
	 qPc0xzHcg7dZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB883380AAFB;
	Wed, 12 Feb 2025 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] selftests/bpf: Define SYS_PREFIX for powerpc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932143379.54159.8891352448653328324.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 00:50:33 +0000
References: <7192d6aa9501115dc242435970df82b3d190f257.1738302337.git.skb99@linux.ibm.com>
In-Reply-To: <7192d6aa9501115dc242435970df82b3d190f257.1738302337.git.skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com,
 andrii@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 31 Jan 2025 12:35:21 +0530 you wrote:
> Since commit 7e92e01b7245 ("powerpc: Provide syscall wrapper")
> landed in v6.1, syscall wrapper is enabled on powerpc. Commit
> 94746890202c ("powerpc: Don't add __powerpc_ prefix to syscall
> entry points") , that drops the prefix to syscall entry points,
> also landed in the same release. So, add the missing empty
> SYS_PREFIX prefix definition for powerpc, to fix some fentry
> and kprobe selftests.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] selftests/bpf: Define SYS_PREFIX for powerpc
    https://git.kernel.org/bpf/bpf-next/c/650f20bbd9d1
  - [v2,2/2] selftests/bpf: Select NUMA_NO_NODE to create map
    https://git.kernel.org/bpf/bpf-next/c/4107a1aeb20e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



