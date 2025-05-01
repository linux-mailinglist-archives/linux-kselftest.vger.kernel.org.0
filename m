Return-Path: <linux-kselftest+bounces-32100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23D4AA6501
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8294C3BD690
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 20:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBAB257447;
	Thu,  1 May 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9rTzouJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C1256C6F;
	Thu,  1 May 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746133194; cv=none; b=qKeSozWiEF+5ivO7TONq7CaE1QTp1Z1VUb6nkAqwAyPB1mQVTpMmGjKK1LVMBJGUFzCOhaquskuade2bnDHViI7C87MqKBVTX0OnBgzEKiya3c8kwjxBq244Y5uGLLdNBADeInU6tVBu7zGh1DiOLLBwyhtA/IAj0UCv0+QpGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746133194; c=relaxed/simple;
	bh=Bcl0zyNkmd9dJy6p2JPm2imjsK6MR8ZGcLLQjr0KMv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VJ3U9xPN9oin8/OcGgIYvA3U7ZonrCnDTogdIRRbnzbadq0uAS/n9aXevFyWPbnLf9U/GKF3s+Vxk2GDdw44lKsMz160/abUhSYbDio3FZAMSVOqV4DnFHAv/dUHkVQx83q5XtmkvGGudWUtn33MkEVlh2tr0Zyk6OSlEMrt0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9rTzouJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF02C4CEE4;
	Thu,  1 May 2025 20:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746133193;
	bh=Bcl0zyNkmd9dJy6p2JPm2imjsK6MR8ZGcLLQjr0KMv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d9rTzouJxYkLcvZDZBaAbNL/gYn+jjnBf3Im4bMHCxyy3RtZdp5PoV+wY5g83H1io
	 UvOU1UTwY2bgEBoqurWYsCPEY3iUVfgZGM0utNBaVG8pMXcMGVoqvTXaNMNxyEDRFo
	 8l4slfENW2Ssdxv48YvAKdG5+ScrSHEWVct7ztAXNHWpvbtVvxbAyVDuQPPpOWaGGV
	 9+0592cQvTnmkErye0nnP6RniKKYtLC490ISiWzqir8ud/rSNVhcSaNaV1DWyrI6Kk
	 8OseZ52JOUCKOxLxJUsT6ugbwAGlcAqZJOziDtbBFA/OM/QcQnzJRHu91KiEbRsglO
	 tQEFHg00nPSxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F143822D59;
	Thu,  1 May 2025 21:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Allow XDP_REDIRECT for XDP dev-bound
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174613323300.3076028.3914757479953100366.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 21:00:33 +0000
References: <20250428-xdp-prog-bound-fix-v3-0-c9e9ba3300c7@kernel.org>
In-Reply-To: <20250428-xdp-prog-bound-fix-v3-0-c9e9ba3300c7@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, mykolal@fb.com, shuah@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 28 Apr 2025 17:44:01 +0200 you wrote:
> In the current implementation if the program is dev-bound to a specific
> device, it will not be possible to perform XDP_REDIRECT into a DEVMAP or
> CPUMAP even if the program is running in the driver NAPI context.
> Fix the issue introducing __bpf_prog_map_compatible utility routine in
> order to avoid bpf_prog_is_dev_bound() during the XDP program load.
> Continue forbidding to attach a dev-bound program to XDP maps.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Allow XDP dev-bound programs to perform XDP_REDIRECT into maps
    https://git.kernel.org/bpf/bpf-next/c/714070c4cb7a
  - [bpf-next,v3,2/2] selftests/bpf: xdp_metadata: check XDP_REDIRCT support for dev-bound progs
    https://git.kernel.org/bpf/bpf-next/c/3678331ca781

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



