Return-Path: <linux-kselftest+bounces-19495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A44999A4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 04:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511491F22C6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 02:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803941F130C;
	Fri, 11 Oct 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHQTTVyc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2A2A1D8;
	Fri, 11 Oct 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613228; cv=none; b=KoA+Se3PuGnM6MvPTnR9n7u8UGyzFCq+uwqBQu63jPvxaaQzvXTLKI43ycJ6V9lcQ3fEIqN5RPGTVVH7c6QTMbBe1EiLF5R/yTFxTAUzC8bmaf0oeiYAS6PrEqc0QJ90FZvxBxcNX+FsKFWpaVBEIgFi8ZK78KksagJ7GQaiLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613228; c=relaxed/simple;
	bh=BBCPUiilRxNaKUZk0ARhoG87zVRMvCR97JhmH9GA2mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X7xa+ejmCxSv4d4o3ViHGcBoL8cATS4UX21AvwwZn8EInO0Z2aTod0bhn+HCeusVwbbljIwU/sFU1EORaW6Dkq28m+tKshcWoWPPdTHwfUSEYp6+Jl3S9WMPKrmph8/rIXBRdNVxfjehz3GrcERzi1lUKk6YKyPOnK1CWXC4Q30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHQTTVyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD34CC4CEC5;
	Fri, 11 Oct 2024 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728613226;
	bh=BBCPUiilRxNaKUZk0ARhoG87zVRMvCR97JhmH9GA2mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AHQTTVycoY0jSq/R9GBvJFOsUFkqTVDEV6/P9Ct6VYkuBY1lb4cpdl5RcfMZO8fk6
	 TVAoEPIbKjuWjoNeFRK9osultg3PePEXpUSrV+1+5k2N/Q5aeuzRBzkRjF+Uw+cryD
	 5sZpb9AeeGhIQv6fyPTKH/5hV84FDAuSMkJb9sHLtV+5Ap0AublJ0qbLv7wD6iiSNy
	 87QLwm7SFcPRJG1oqJSa6Bf700RJcGJ+9sBIl2h4buWgI4BkBF2/SeAkwO4/0IyIJx
	 69Hi9a1TK1JZ9JsAwpZiyBsQ0v1X/yIwhFAh3dFxSqNdpyEgI+Ms81AEkJiHX4KUAy
	 CS8UFOxE90Pdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAA3803263;
	Fri, 11 Oct 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Removed redundant fd after close in
 bpf_prog_load_log_buf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172861323124.2249999.1690995583380984322.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 02:20:31 +0000
References: <20241010055737.4292-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20241010055737.4292-1-zhujun2@cmss.chinamobile.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, mykolal@fb.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  9 Oct 2024 22:57:37 -0700 you wrote:
> Removed unnecessary `fd = -1` assignments after closing file descriptors.
> because it will be assigned by the function bpf_prog_load().This improves
> code readability and removes redundant operations.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/log_buf.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - selftests/bpf: Removed redundant fd after close in bpf_prog_load_log_buf
    https://git.kernel.org/bpf/bpf-next/c/ba4fb3b3f7d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



