Return-Path: <linux-kselftest+bounces-2630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BE5823A11
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 02:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5761F26250
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B081D;
	Thu,  4 Jan 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRtIML8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2037B;
	Thu,  4 Jan 2024 01:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5797C433CD;
	Thu,  4 Jan 2024 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704330625;
	bh=1/AcE2yNiKq2VOJf4UWVULUFGIR5FL0yTpn0dYOMgV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pRtIML8yJvY8OrrCkOnGvbT4HFeyvhgWt/McrcCuYortNS2fFJMA+1mrOZRZtIpb2
	 JJ7WF3QqGf8SOtz5SQnLzI/S5i7lGRG+0gqyRweAS9SBY5t8b6arhq3ZVeGsIymVKC
	 hbO1MPXLpvorBRhu0BQaJvTV4XCigzV8XlOHzpx455IcGcqBVjzn+cFQ1S9L1xPxah
	 TMxnX91dINhsKuQba88LpxZlvb6jeZxiuTfeMj+k729PyvHSCvKq1+H909xATZUS2K
	 CLh78iDD/Pcc6JiSdGS41Ob/pMycuFCFxBMOI/S0xf1bmP15hmXxHxXf7tKudr9iMb
	 OnxAnQOu+qoLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F772C43168;
	Thu,  4 Jan 2024 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] selftests/net: change shebang to bash to support
 "source"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433062564.12007.6147887260840109226.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 01:10:25 +0000
References: <20231229131931.3961150-1-yujie.liu@intel.com>
In-Reply-To: <20231229131931.3961150-1-yujie.liu@intel.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: netdev@vger.kernel.org, liuhangbin@gmail.com, pabeni@redhat.com,
 dsahern@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkp@intel.com, oliver.sang@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Dec 2023 21:19:31 +0800 you wrote:
> The patch set [1] added a general lib.sh in net selftests, and converted
> several test scripts to source the lib.sh.
> 
> unicast_extensions.sh (converted in [1]) and pmtu.sh (converted in [2])
> have a /bin/sh shebang which may point to various shells in different
> distributions, but "source" is only available in some of them. For
> example, "source" is a built-it function in bash, but it cannot be
> used in dash.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] selftests/net: change shebang to bash to support "source"
    https://git.kernel.org/netdev/net-next/c/05d92cb0e919

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



