Return-Path: <linux-kselftest+bounces-40660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343A2B41077
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 01:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B43F162151
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD728137D;
	Tue,  2 Sep 2025 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGMAmvIZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8143281355;
	Tue,  2 Sep 2025 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854029; cv=none; b=g+g6a2e9a8PmHYUsvAmf+fazEp7GqzO7hbW0g0mUMz+RBX9fh1pNFf0xG4CUiCV0i/43tiTCsbnIK8HaK6mJymymKDN0KMDrP0G735F47SLCN9BIykygsc+aF1f2ja0ya4aEmU5F75lcIJ/9m37sqwsLMRl9x7aDVeBmZ55FBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854029; c=relaxed/simple;
	bh=ldKXHRIdtC8D8CKjW2kgvIiONDfw78+RUUmAdaFbfNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iTQDTiQH6uK/1dbUpkAvCLeC/qKneyxQkT0wwdzGrSdYj62zrtX4xu1zbf1X6kSaDHcV7JykVjCMjH3WSQzWJBl5dUPPZLvwnzT4n1DChvT5ZbD7A81q2jVhpJYGhiOFsfKN0iNb/xu1YMljpgSzlM5vvSoVAqyLsZyx/o//+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGMAmvIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88621C4CEED;
	Tue,  2 Sep 2025 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854028;
	bh=ldKXHRIdtC8D8CKjW2kgvIiONDfw78+RUUmAdaFbfNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CGMAmvIZodvrESv2U1qIkC4+9WI6Sp2gdKtpuTTaXLRV/53Ql5EkActtppPKNDQXW
	 S9zqzZcUby42omJy6qCOqztqH0rUQqIIRmtztC3mez8u0RVplppEHrfCqpyByvFO50
	 uMTsCKN2Ippxm5VtOsiy89Ux+uDJpnV0Ozl+yJCWcSoILmHUpW3sdM8TTrKT8oFuc7
	 KxOME3dpTBjGPTKqYLUNZ2JV0XJ/xrN/fsdiLr7C5pU4p7u5iJy0alvIiiZ3IsCxVK
	 HGpkIx7HhfqMMfHfmJk2UMEix8ipkf9iv3VOQzu2r0neVM77Q/xrb35CdyqQ/SkrEx
	 8GbcjEf/+aH3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C42383BF64;
	Tue,  2 Sep 2025 23:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: selftests: clean up
 tools/testing/selftests/net/lib/py/utils.py
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685403374.461360.9565964060103955887.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:00:33 +0000
References: <20250901-fix-v1-1-df0abb67481e@debian.org>
In-Reply-To: <20250901-fix-v1-1-df0abb67481e@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 01 Sep 2025 03:00:07 -0700 you wrote:
> This patch improves the utils.py module by removing unused imports
> (errno, random), simplifying the fd_read_timeout() function by
> eliminating unnecessary else clause, and cleaning up code style in the
> defer class constructor.
> 
> Additionally, it renames the parameter in rand_port() from 'type' to
> 'stype' to avoid shadowing the built-in Python name 'type', improving
> code clarity and preventing potential issues.
> 
> [...]

Here is the summary with links:
  - [net-next] net: selftests: clean up tools/testing/selftests/net/lib/py/utils.py
    https://git.kernel.org/netdev/net-next/c/23313771c7b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



