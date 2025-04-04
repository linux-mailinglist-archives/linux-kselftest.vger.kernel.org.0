Return-Path: <linux-kselftest+bounces-30107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC3BA7C048
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 17:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA897A763F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 15:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993871F4CBE;
	Fri,  4 Apr 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrtgJ9Ac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFC1F3BA8;
	Fri,  4 Apr 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779401; cv=none; b=KgXfhA+STQsvEcj3f/HcLo0MX5PvmvXnBOONW+vyK3WDcjHqyWxl46nF6LgPBE1gHunGq0k1PkksylTHn24Z/ar2tHEpveAtwIDeiRrEaMFQkb+fQny4DKXDW/R841Ro8DOExr5nJ+aPtjJXv4rnlpqHA40ZtWIsQCRXUXiIHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779401; c=relaxed/simple;
	bh=sDPN2D8Pe6j8ExmFXItnsjC/cU6uK22VXq7RMLWfit8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=odiUZzVtr1gN+jIyTI06eN0800NfeJv1hZ9EFGkYmVLGPYo+/kQuuIMNAdM2R+FD1ingxdESYS19vvbq/tYi39hXs9RB4DUmOWSf7Lk6WcBH1U1SYZlQN0Rmze4mnWyIPWSbUk2GD4DLuJHKfi8ts7+D1ACbpSf4iq32eIG7M2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrtgJ9Ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA38C4CEE8;
	Fri,  4 Apr 2025 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743779400;
	bh=sDPN2D8Pe6j8ExmFXItnsjC/cU6uK22VXq7RMLWfit8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PrtgJ9AcJq9r11kE8HJp9u+X7D0GjnW34uXnnwsVqPtSz2btZ4KzH0WZ8w2Wo26ck
	 /S0odGjySOUiD2s6vOWdBz7kaC7VVpeumRGp4iGllrb+06/0drGsOExo5nqODKqLKK
	 aZJHc+VNGVnLv81rUxr0sxQHXj/F6rlWrEY17R7ANj9QncepGtUEE5I/ocwQuym2yb
	 Jo6tB7inhlCF+h5xswANJVyd9ztXDiNK6T9UlSCeZoFen0pGg4H5ZrmAd8+X0fgZfo
	 IZrCcaFlhpUcUGFuCpMyumWYXV0B+rYx8jTjeGzex6K7mKQ1lqRXF3pOJDZtr2dlo0
	 8T49SAiGv3UrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D993822D28;
	Fri,  4 Apr 2025 15:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: amt: indicate progress in the stress test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174377943775.3293273.1597978921457398361.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 15:10:37 +0000
References: <20250403145636.2891166-1-kuba@kernel.org>
In-Reply-To: <20250403145636.2891166-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ap420073@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Apr 2025 07:56:36 -0700 you wrote:
> Our CI expects output from the test at least once every 10 minutes.
> The AMT test when running on debug kernel is just on the edge
> of that time for the stress test. Improve the output:
>  - print the name of the test first, before starting it,
>  - output a dot every 10% of the way.
> 
> Output after:
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: amt: indicate progress in the stress test
    https://git.kernel.org/netdev/net/c/94f68c0f99a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



