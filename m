Return-Path: <linux-kselftest+bounces-3612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E9283D1E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 02:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF481C20E48
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 01:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649B0387;
	Fri, 26 Jan 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9IU9pZN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D5629;
	Fri, 26 Jan 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231426; cv=none; b=S3y9XPWL2xsWMJJbvYNkpT3wdF9XLjwbz1IY0DzSkfFl4fZpmw+HExmjPTUcrvP3SrgmaXwO6zLSfvL5sr1KZMlKBs7qqwR6F9WMFneYGmAz/MArsUDr8A0iVLj17qjEvHxSxnm6Nyk0wFNuLGhK/A/lZZlCwU5a3o1jy1Cdf/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231426; c=relaxed/simple;
	bh=GyJ8DunrQPEJNnvjPqyPCJcoIDv07Sq0hp6uQeUzJv0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fyMQ1vKB8s0uMjpTYu4gEH3AlAQXxF6zdeH/wb3Bz1kRUGMvHIm+tHblHbb1RDdPRLntkcKeh3oMPknfHCpnWt0/vgoDRywGp8kqaGJUrMJGB934GcymuCU/fz6umooOVm7/QUdFrFmnxK8agp2l8A21HzbmWHw7eyuBft8oK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9IU9pZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AADEAC433F1;
	Fri, 26 Jan 2024 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706231425;
	bh=GyJ8DunrQPEJNnvjPqyPCJcoIDv07Sq0hp6uQeUzJv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M9IU9pZNgbB8N7mIDu52sE652mBFHCG2oCIxmeKwneox27QR5rOGqqX9y0AxTv3J7
	 4F6LhufZ4804BYX5+kKf4LIXR56SDj/60bGnsFQHGovwZVAO5MZGpgCcAJjLc5XsPD
	 zowbwPCx+d6L/6pCdGqFlBlTt/OjBTClYiEp0IMAmnIK5MXx+2xPiphiMy+0tl78Ec
	 l6d2k3YXrRb3Lj255nUgfNZDVcZeGW3BEvByeSUpBvOV51WjmPRF+Guq7KQ0e75K6e
	 emfbV+Atvwgm554veojdobhe8HN4N17v6ph0sG1JwSm2YXEge8PEIe1z85ZVOEHCH1
	 rVmVtmOqNy3CA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92E59DFF765;
	Fri, 26 Jan 2024 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] selftests/net/lib: update busywait timeout value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170623142559.29940.13168778322472365379.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 01:10:25 +0000
References: <20240124061344.1864484-1-liuhangbin@gmail.com>
In-Reply-To: <20240124061344.1864484-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, dsahern@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 14:13:44 +0800 you wrote:
> The busywait timeout value is a millisecond, not a second. So the
> current setting 2 is too small. On slow/busy host (or VMs) the
> current timeout can expire even on "correct" execution, causing random
> failures. Let's copy the WAIT_TIMEOUT from forwarding/lib.sh and set
> BUSYWAIT_TIMEOUT here.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] selftests/net/lib: update busywait timeout value
    https://git.kernel.org/netdev/net/c/fc836129f708

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



