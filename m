Return-Path: <linux-kselftest+bounces-37054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D29CCB010D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 03:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C351B1C26EE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 01:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1805881741;
	Fri, 11 Jul 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9cUChS1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451BA55;
	Fri, 11 Jul 2025 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197389; cv=none; b=fpEzXAyr4/RuGuUbX7u7edo4SbVKrMEgsJVfqYB93UoKT/JPXRP01c2bsKnaG2McudhStPSnOWB4d+hcZlLmPqmW/9uVMkXhd8mD59zrCKGiQNMP8aUzMxbNX0eaMDhEuX7FHKuSs3ygdrvNEvliPJLxlpLK6tDGU8b2Sa0mHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197389; c=relaxed/simple;
	bh=KhAptPm5ErKi3Ah7j2GOUDAyeUzgBT4bjyIoQgcQQVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sO9ri5B/LZW2+b2MgewKmGs41MNSnhB8gfDeDYu2OiUhpPIMJBUgK15v/inL7YZ1tcTyaxvrnoZ6aAAOY+LD1e4GVGQ9Joq+vzfxGM8VMnpMkndGbBdhZtZxiPs+R2RWk95RWqmuc6dHyrJTZRsdFBhkqDx5Ka6udTkzxdHgdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9cUChS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B49C4CEE3;
	Fri, 11 Jul 2025 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752197388;
	bh=KhAptPm5ErKi3Ah7j2GOUDAyeUzgBT4bjyIoQgcQQVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q9cUChS1feolpGmpQYTKA505T9jr8HQvgkVAuB84Wrz9cH93Xs5b3jr9PkRe9gzdK
	 kL2C4Hz7QDLu+voL6Dk0x3lrR2cNlsOyrhgGl8rp3ErDTQRPEyZm2gCrwCqdFAMmXF
	 nfLVh1X/ixAjNXyABZulGNj3USoCvtByesXbdlylBzevfkClibGDcZ+oJte0NfKnCs
	 yWjGkbQUDhQAHeBkqjjSRqi38lL/g2JXe1yOiPZAfJ9F047ZUWP4DP+6M5izsXMsuM
	 f0AGELaxpaRR8z4Wsn4ja2uWa+F8Y1TaBso1PHWJIcf1zQ4TKTH3FwheZUzm4yBN7+
	 GhJNRYAYSy1tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD0A383B266;
	Fri, 11 Jul 2025 01:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: lib: fix shift count out of range
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219741051.1728628.4929143730980082069.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:30:10 +0000
References: <20250709091244.88395-1-liuhangbin@gmail.com>
In-Reply-To: <20250709091244.88395-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, petrm@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Jul 2025 09:12:44 +0000 you wrote:
> I got the following warning when writing other tests:
> 
>   + handle_test_result_pass 'bond 802.3ad' '(lacp_active off)'
>   + local 'test_name=bond 802.3ad'
>   + shift
>   + local 'opt_str=(lacp_active off)'
>   + shift
>   + log_test_result 'bond 802.3ad' '(lacp_active off)' ' OK '
>   + local 'test_name=bond 802.3ad'
>   + shift
>   + local 'opt_str=(lacp_active off)'
>   + shift
>   + local 'result= OK '
>   + shift
>   + local retmsg=
>   + shift
>   /net/tools/testing/selftests/net/forwarding/../lib.sh: line 315: shift: shift count out of range
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: lib: fix shift count out of range
    https://git.kernel.org/netdev/net/c/47c84997c686

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



