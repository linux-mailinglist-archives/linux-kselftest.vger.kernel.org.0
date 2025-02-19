Return-Path: <linux-kselftest+bounces-27019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F21BA3CD14
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 00:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729143B7116
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 23:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74725E475;
	Wed, 19 Feb 2025 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU1gUmcH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D91D2144C8;
	Wed, 19 Feb 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006602; cv=none; b=OIiyjugW3gQOd9zIa/Z+c/86LPZjaidQYToCFDdnOZXmXmLZMtCm/ONNgv0DtzkYYFKFsgucngK157shx5mQanUO2oaHJE84XSO79KUiE1T6UsFS7gLl0cU/DwgJT9vtzIuJbO4lGC8lPYY05Syaa/uxFRu1S4r7c3AEqzpcC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006602; c=relaxed/simple;
	bh=8oBBrsO2Q2hbr24I2v3A4+lL9lPI8diFVStP1Tt1eGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IUZ1JQ3H5hkTpLgi3xZrGcNw+JTa9mI3fzlIt7EJyjM667ObdB8J11Mug0XbbbSrNM+qqDQDMJPhjqco6NGAl1K0bg6Dh3TYUdC4yZenrKo5dm2OJ3Jpc7j6pGb0XMZmAafpt6qzgFQOEkzbFnTIqJWTSvjS/eSXufC57yyj5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU1gUmcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC40AC4CEE7;
	Wed, 19 Feb 2025 23:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006601;
	bh=8oBBrsO2Q2hbr24I2v3A4+lL9lPI8diFVStP1Tt1eGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HU1gUmcH3zsjRr6O+cDJnYBaVwqSrmjyujaE708reHzQJyuVpkYPCvNZvdMFRR4zI
	 yoEQmo/HltSGWBcrXj0aLuApT9DFz/T1k39slI9GSQTIxXVFEIfIpwXNGc8+UVMQdk
	 69mGO5IdzbExx/FHgTJFpfb2oBmSs377ZYnKCHNqAOR1SAnO78Yy0Xt+mY/jm1L3UA
	 VfHJt7QdGfxQRfQ6VJCV4lDUZ5HHPpVZbzmkbzVdM5pQJhNAQgk0gKlk6Xq3W89VJJ
	 aWT2edeWh7icT7Vx5lV4fjAMmal234U1F3JGGZrhManSH1h99rHzUKGSvooIal4GqZ
	 6XqlrDYLJN0JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716A9380AAEC;
	Wed, 19 Feb 2025 23:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: DENYLIST.aarch64: enable kprobe_multi tests
 for ARM64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174000663227.777997.10197622694803757950.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 23:10:32 +0000
References: <20250219-enable_kprobe_multi_tests-v1-1-faeec99240c8@bootlin.com>
In-Reply-To: <20250219-enable_kprobe_multi_tests-v1-1-faeec99240c8@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, mhiramat@kernel.org, bastien.curutchet@bootlin.com,
 ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 19 Feb 2025 20:41:39 +0100 you wrote:
> The kprobe_multi feature was disabled on ARM64 due to the lack of fprobe
> support.
> 
> The fprobe rewrite on function_graph has been recently merged and thus
> brought support for fprobes on arm64.  This then enables kprobe_multi
> support on arm64, and so the corresponding tests can now be run on this
> architecture.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: DENYLIST.aarch64: enable kprobe_multi tests for ARM64
    https://git.kernel.org/bpf/bpf-next/c/ac13c5087299

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



