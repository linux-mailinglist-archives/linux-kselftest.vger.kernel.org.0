Return-Path: <linux-kselftest+bounces-22598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055749DB4CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 10:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80ECDB22FB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418BE15749C;
	Thu, 28 Nov 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFM5wIYj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10596145B3E;
	Thu, 28 Nov 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786222; cv=none; b=N0Whkz5xmeUo3yN2n+GEeU0+3Fi3y4FYJbvK3MRL3npM/WDKVgIv668Y9YUozKA7otc9Prsx7RBL/fNN/3uFjaOuh6YBOaa9ZbxEh8hpbgPx9zfzgXoMuj5X30ZN7LAZGb4IeoxvFsSRvMk9yK/LuTKWgwanjvhuP0vwiqeWzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786222; c=relaxed/simple;
	bh=BHAS7wdFzoXKET3fu9FOUzRGSasESdSnjvqa51c3yAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CuQEkk90LgANGMis5Y1vNzRTt+VN9Srp0HwQuBfNXvX3j1zRVwfVyVucEGKk1Rtuu5gqhU8H8bB4kxAp4q3I0PkZuoqogS4oT6os3AcjTL20RI00dziEZVmXWyVh5eOGJ2/2+r84K/TC27g6llNVBiJZx0gZFiVOnjOk9P9h2GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFM5wIYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6A5C4CED2;
	Thu, 28 Nov 2024 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732786219;
	bh=BHAS7wdFzoXKET3fu9FOUzRGSasESdSnjvqa51c3yAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KFM5wIYjOhtQNHnHCLUT78fuuKjAhDIUbE7jSNmPGNvIV08TNh2xL8IKb0wpXwhnW
	 9FkapxJEmAV1LogxRwH0T8PlIE7BDmUqm+cG4o3A7hfU9SOBsFG8E+GcX7SZzIyd7x
	 D9ORL1+Ag6yVKkEcWyfRMbctCeT9FNC6DGmULLUL0Pk9zsUJ6jXuGsM1j0IOf3wM+w
	 MqJ7dMIWRW/6J2iPLUmAkzthBLtQtLLCMujg5A3QYx0fNNA4CT62mqE13kR7htYJb5
	 powv/u9Q5jUz/3AreA5UDbYwh7hZDy4vnd28xHo3XvB8Zp+U0VuS05FDGGyiK46926
	 Y/NZTnh1js67w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2F0380A944;
	Thu, 28 Nov 2024 09:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: rds: move test.py to TEST_FILES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173278623250.1676038.14465582848718256111.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 09:30:32 +0000
References: <20241124073243.847932-1-liuhangbin@gmail.com>
In-Reply-To: <20241124073243.847932-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, allison.henderson@oracle.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, vegard.nossum@oracle.com, chuck.lever@oracle.com,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 mheyne@amazon.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Nov 2024 07:32:43 +0000 you wrote:
> The test.py should not be run separately. It should be run via run.sh,
> which will do some sanity checks first. Move the test.py from TEST_PROGS
> to TEST_FILES.
> 
> Reported-by: Maximilian Heyne <mheyne@amazon.de>
> Closes: https://lore.kernel.org/netdev/20241122150129.GB18887@dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com
> Fixes: 3ade6ce1255e ("selftests: rds: add testing infrastructure")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] selftests: rds: move test.py to TEST_FILES
    https://git.kernel.org/netdev/net/c/663a91747553

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



