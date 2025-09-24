Return-Path: <linux-kselftest+bounces-42160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16644B97D72
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 02:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8DEF4E06C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 00:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28F7184524;
	Wed, 24 Sep 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L07b4tkl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D12D052;
	Wed, 24 Sep 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758672034; cv=none; b=tYFnCxieLaU3BmP9pOcrQ+AyDGItukFCWhTv8ah/OzzLvcPFs/Yf2Vym76VywZE3cisEZ9rc/npbQ1q0x/Z2EKlkfz8/DlQTaacXNQ9odjFQcDCukZN62hM42sANvt/K8GIswKwz49K5tArhCF2Q9Waeciafsr69rbV52D13+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758672034; c=relaxed/simple;
	bh=hodydOGysaICJobwA4ubzUn7rdJXQNa8LAcVCjHt8P0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ikCiDVgp/xajgPmHrtGKG3jUYc2PqSqqnb/vKO9XvalANslqVb1hM6JOh1m0nJ8X+iLE3RzpoQPApAfzvkib9FsXgIjzyoLDl9O/shiY35TFUo51ewMFrcqaTaWMjhtWGhRghJOa7uy6ihxqFTXYcjWfOySUSZKHOsuMJOBVd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L07b4tkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5631EC4CEF5;
	Wed, 24 Sep 2025 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758672034;
	bh=hodydOGysaICJobwA4ubzUn7rdJXQNa8LAcVCjHt8P0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L07b4tklURHCDfK5o5f10N2yjmv6Vv5jxhJgqwli0QXZ8m1zvnM56gCJQxi8ExD0h
	 VywuTj+IMI+nyz9/BKl9rBWA3ZdhUypdxJcrN2RsbDJQE/J1MJGXFV8Y9o85RYbLWe
	 B2I4XY7061fX0H8eVmZeCk66w1Fh7cMtNMQ5lvKPZ456dnX3RUV595fEAHhDps9z+k
	 hV68y4bpBoWLhEHpgWbD1JKPwgx+0KAy5EsXF3N1esh6dzZTQZzeafB67kS0tBdZkP
	 BcAWxFRl7lopizD2lKbIUjICN11ZaasVD4k6/H52gUMbD6wDELeVHwvFfEAWSGA0CV
	 mzORbMn0U//0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710DF39D0C20;
	Wed, 24 Sep 2025 00:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: rtnetlink: correct error message in
 rtnetlink.sh fou test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867203104.1967235.15942314492809685727.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:00:31 +0000
References: <20250921192111.1567498-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250921192111.1567498-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 21 Sep 2025 12:21:08 -0700 you wrote:
> The rtnetlink FOU selftest prints an incorrect string:
> "FAIL: fou"s. Change it to the intended "FAIL: fou" by
> removing a stray character in the end_test string of the test.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  tools/testing/selftests/net/rtnetlink.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] selftests: rtnetlink: correct error message in rtnetlink.sh fou test
    https://git.kernel.org/netdev/net-next/c/f77064586026

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



