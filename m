Return-Path: <linux-kselftest+bounces-6820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24050890FA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E771C2E0DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBDCA34;
	Fri, 29 Mar 2024 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxB1x4Xc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44AD5223;
	Fri, 29 Mar 2024 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672270; cv=none; b=cJDmmfF1CIJkHNsax94VJaEbazK20ZMJWhtI6Z42eOOZqOBB5qrce7P6eHqo8xiqdaoxeHi76je88LtVkAOHgQ+iIAPYByINuLYmoGr5AX5iVidsWvy8I/KEfUOHui/g6ZEgGz5BaO47qOka6C06xoJGMhxTs6FsenMhv5VKdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672270; c=relaxed/simple;
	bh=qT743jPxa1XDwbNz9fp9wTjjmM0T0DFvYjRIAeLmIPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ttQJyjxPjBq1q94wYV0p0UOV7+58CZpSw7mvIdlN3/P1HV9UFH0BGhn89y6tYaBA/5CTeQbeyofZVoesTfzl0WMaOVG1FKVlFLUbYkQ+gRO98JYLVcTtoBocQXpmCCBxB6s4cfS2bqg9CdRuA14uE77reRN+7cIjWhUxy5Z3id0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxB1x4Xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55175C43394;
	Fri, 29 Mar 2024 00:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711672270;
	bh=qT743jPxa1XDwbNz9fp9wTjjmM0T0DFvYjRIAeLmIPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VxB1x4XcveMTl4sW1vWHos+K2NAEOrk2XOeynE7/cLU3qAoIAgcn6cAoXLheUOd51
	 hkETwfxQUTvc5cTEjFCPmlbVigQc9wWvSNqifU9e25JFw9FIiUVjh/2VLziAOb8A8M
	 I6mnp7Hj++z8FUlIsD85827iKLdrucbTaUHlo7zGvQ9KHOwSMlyZ6Ppyx9w6FbffUP
	 8dYd9RoSpUR/E3ouqSloN7gny8wktxaB7WPWDwsRyEo50jpGFsdo0ZJ1zptH4F0k6T
	 dQ6JXAdzQMpPY/Zp1Vhc0/2yspuTkKCKLr5K06ru3gvmGKBX/Z17DE0H1cdCeqVjYg
	 bGtaC5SMOM/Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43318D2D0E1;
	Fri, 29 Mar 2024 00:31:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] selftests/mm: Fix ARM related issue with fork after
 pthread_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167227027.28813.3759046936061373590.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 00:31:10 +0000
References: <20240325194100.775052-1-edliaw@google.com>
In-Reply-To: <20240325194100.775052-1-edliaw@google.com>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 akpm@linux-foundation.org, shuah@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 jannh@google.com, linux-kselftest@vger.kernel.org, kernel-team@android.com,
 lokeshgidra@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-mm@kvack.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon, 25 Mar 2024 19:40:52 +0000 you wrote:
> Following issue was observed while running the uffd-unit-tests selftest
> on ARM devices. On x86_64 no issues were detected:
> 
> pthread_create followed by fork caused deadlock in certain cases
> wherein fork required some work to be completed by the created thread.
> Used synchronization to ensure that created thread's start function has
> started before invoking fork.
> 
> [...]

Here is the summary with links:
  - [v3] selftests/mm: Fix ARM related issue with fork after pthread_create
    https://git.kernel.org/netdev/net/c/8c864371b2a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



