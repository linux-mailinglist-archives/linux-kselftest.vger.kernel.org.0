Return-Path: <linux-kselftest+bounces-31443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6FCA997E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 20:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8CD4A2BA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE628E5F2;
	Wed, 23 Apr 2025 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urV/TSvq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0B28BABA;
	Wed, 23 Apr 2025 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432992; cv=none; b=s327jKM0v9wkM7R1grq/yqshFWlD6imtw0es1d8Skz5KQX8JbAO3xybCtIU7qR50fRe7T8dOGBoKSVTO4DZO88whwIR5YCW3yfDiIIaMkS84Gejafo7Qm16pWOgu/Ul+pSzs/PQySWOsjTS+PM8gQUD26+Vq2zvYtV6yDVZpB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432992; c=relaxed/simple;
	bh=RReBdPMcE9SDpIbtu6uKovd5n+T3FuJGV0zcFaRD2WQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ziyyd0W3sqJRDRVsoGkla8uRbxiC2OF4WC9aIZ6ZOf++1oYvjDNmT/jGKbH95IjTLda5hltgJ6bfVDXP1ngcabpiZDdJ4wKgTi/XV1KfkNf9F41ACNYiwcgIcZMgrNqlGlXh+5IjWzX0fzSt9CsO2ZJEyU3UIlK5haHbA7JQ38U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urV/TSvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD775C4CEE2;
	Wed, 23 Apr 2025 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745432991;
	bh=RReBdPMcE9SDpIbtu6uKovd5n+T3FuJGV0zcFaRD2WQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=urV/TSvqRVJt3e7O7/GiOobiZevqEe6tBp1hLQqTsh8UX5Nhzoc2IC4SCfJVb9At1
	 Gpf73boqIuDReA5ETLNb6IRdmLR/f0KA/ReJvMcS4bwUmKJkAhTrodWu8fPwsQU5Zh
	 HC8bgSmWaLITIFxMU0cVTwUzYAeXGs5Xp38461dUwZJy3PQEtM8IDD9S0YrrAAmXmt
	 OcWI+ZB4Z6fRXjsdH2EebOi63lDK5gUJcKuDZszOnVaRnkkEQ1UMGXskX5PmlvHGUY
	 Pw8fS5pSGJQgUhnidB2VrHS5vc7fTMBNMonryrjIfV6kSpKDWKao9yZt+U+bKAW7AN
	 ZKpIBOo+hm5og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCC380CED9;
	Wed, 23 Apr 2025 18:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: Allow access to const void pointer
 arguments in tracing programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174543303025.2731730.15635932606525248538.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 18:30:30 +0000
References: <20250423121329.3163461-1-mannkafai@gmail.com>
In-Reply-To: <20250423121329.3163461-1-mannkafai@gmail.com>
To: KaFai Wan <mannkafai@gmail.com>
Cc: alexei.starovoitov@gmail.com, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mykolal@fb.com, shuah@kernel.org, memxor@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 23 Apr 2025 20:13:27 +0800 you wrote:
> If we try to access argument which is pointer to const void, it's an
> UNKNOWN type, verifier will fail to load.
> 
> Use is_void_or_int_ptr to check if type is void or int pointer.
> Add a selftest to check it.
> 
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Allow access to const void pointer arguments in tracing programs
    https://git.kernel.org/bpf/bpf-next/c/1271a40eeafa
  - [bpf-next,v4,2/2] selftests/bpf: Add test to access const void pointer argument in tracing program
    https://git.kernel.org/bpf/bpf-next/c/4c0a42c50021

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



