Return-Path: <linux-kselftest+bounces-30116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C0A7C121
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 18:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F37189E585
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701F1FECD2;
	Fri,  4 Apr 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAEp/ntu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844ADF5C;
	Fri,  4 Apr 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782398; cv=none; b=LdCXQ6kpCkqrgG32rY1NxSmUfWvMoqt6iAjBi9iitokrTP5AGLEn0TCpWIlL5fHc+Asd6wAtSEWEyWQQ0TN6ID8hzfraXf1VPRYr/vbJ5tWyZSOd/YtMYRl9t7q/UUBVy2YISmfMnoc38P1+J9CwIKGbdi4BFDmraJhFjsdxDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782398; c=relaxed/simple;
	bh=WrZEF9Yxb5ULBShRbFH48qvpHj9RvDQIE9VPe6LC7pI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bMbweDddAdHxhs/HGa34yoQYq+76gH7aW/YqoIvbjCtxTCRmn1qwhtcbNDcBrJ661hbLNnh8BjxpinneKChvRMPxVEwbcgcjT/syiR+uXt5iAGQgcvKq9e3Du6jevESlh/HFxG8vuz3U8KRwqv9CE/ZjMMVgh92kcJU8zYum3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAEp/ntu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8E5C4CEDD;
	Fri,  4 Apr 2025 15:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743782398;
	bh=WrZEF9Yxb5ULBShRbFH48qvpHj9RvDQIE9VPe6LC7pI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LAEp/ntu2bwl+Irpk6BuOuLI2cgXnKNQat2ed18ZIW5NctNUL1ZzhUd0SiXglWQhU
	 wIgNo+pKH0sDGZc3CfjfhKe1E6uLnrSyFFyYIl3nEmcFKvLiqsr900F+GMsCUafUM2
	 DSN9Sby7QD1DZoyazHYKnflfzSSO66Ayv/hTocDCBinOtlm/T1P9gOKgzbM39naJXN
	 L1UOjaY0n+Afa09d9XFzORjYckdqmIc35buJxrJshty8ZLuuq6Vq+JbSVc52McYwxi
	 37zgbu6RCMIJzQo2jfoX/8U0wTXaJ1N8Vtp20CSSmQEpFEPYwjCQEiSc5BKkPgBSae
	 0UqgzEXJK8QwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4F33822D28;
	Fri,  4 Apr 2025 16:00:36 +0000 (UTC)
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
 <174378243553.3310001.5428425724896312604.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 16:00:35 +0000
References: <20250401061546.1990156-1-nichen@iscas.ac.cn>
In-Reply-To: <20250401061546.1990156-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 peterz@infradead.org, ameryhung@gmail.com, juntong.deng@outlook.com,
 oleg@redhat.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  1 Apr 2025 14:15:46 +0800 you wrote:
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
    https://git.kernel.org/bpf/bpf-next/c/c9661394850d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



