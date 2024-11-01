Return-Path: <linux-kselftest+bounces-21274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D727E9B8966
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 03:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC3A282ED7
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572E143C7E;
	Fri,  1 Nov 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmD0neIM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9913C683;
	Fri,  1 Nov 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428828; cv=none; b=ibt9gXhT4qg+SYly88JOjwF6oZjOUH8B+6C7jyz6cGnYEQlOB9OdMEn8jQMewRwO1NmiAXoUgIKfOBXbyKNCbxfQH4gXeDj84RO0p2aVhWyJflVuWtagTcHLR/PgzmGUp6SioOSbl39gTJstm0j/lHcrFf815vZrLAV2HsX1msY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428828; c=relaxed/simple;
	bh=CSRTLhoMbwexzjO0o/Bh2vRZG/0Sml2LmspRJ2nfgOQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XQZKTB1VK/Y0qoij4T3x1GZU4OoW6fKmSDElTe0ANlnTCqF8gwMR250ekXWp9nHPDsgguJTPUlkOf7muLa6/373nuPAtLMy7ENw/1ZbR+aM/GMqjKu2NEQytTEHCeIpqhneoe2P43FPRVf2z4f5LUZrnX26A8Ge6wZPql1z7/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmD0neIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC42C4CEC3;
	Fri,  1 Nov 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730428828;
	bh=CSRTLhoMbwexzjO0o/Bh2vRZG/0Sml2LmspRJ2nfgOQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AmD0neIM5ADRYswtkNAIH2tnWo1eTpfUUdCNq2ACdJPZsRgQnH4XO446Tpm506uaP
	 G8CI9qghNFJJXUGwH5TfppvEE6nfYFF1AlxDK9hlN6V7Xm6B1LG1745x15Qf4kgygZ
	 HFD/VANIFp7KNpzBwDhvTreCaMVzUY0Gz4yJPIFlP//mAFmuk0eYjrUn4jHi4snOzQ
	 8+WMy/vOkZecXNlRoDGQJJEi5kCiei88sG1UIWN66mjmfUPCRvoAze+nTrZlVwlC93
	 U6ct2+3F23ODA8sXIlISB5wNqdpgaJ1qAr2H0imHi6tk6BGJqgEvWlQXVMWCxrI94Z
	 LSYlQNNBZp00A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D41380AC02;
	Fri,  1 Nov 2024 02:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] selftests/net: Fix ./ns-XXXXXX not cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042883624.2159382.15735456409601012440.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:40:36 +0000
References: <20241030005943.400225-1-lizhijian@fujitsu.com>
In-Reply-To: <20241030005943.400225-1-lizhijian@fujitsu.com>
To: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Oct 2024 08:59:43 +0800 you wrote:
> ```
> readonly STATS="$(mktemp -p /tmp ns-XXXXXX)"
> readonly BASE=`basename $STATS`
> ```
> It could be a mistake to write to $BASE rather than $STATS, where $STATS
> is used to save the NSTAT_HISTORY and it will be cleaned up before exit.
> 
> [...]

Here is the summary with links:
  - [v3] selftests/net: Fix ./ns-XXXXXX not cleanup
    https://git.kernel.org/netdev/net-next/c/d3774a4b21e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



