Return-Path: <linux-kselftest+bounces-41216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8CEB52CBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2D43AC9DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651382E88B2;
	Thu, 11 Sep 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSrKwj5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38339329F0A;
	Thu, 11 Sep 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581805; cv=none; b=kkLIK0YStXy0CE9w6r4juRkioiE5x+DIXClGbsKRMZ9u5zKque01ptRkSH/Qf15lwrP+MokWP3e9lpWxWs0eHBf6gzVG0qS3j57FzdvzD8cEYAmoxGc+3LDBJvYjJyQQf/87+tk6JCNpXqKVTm4kvRdDWMxqKiNRYdg+d16NyuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581805; c=relaxed/simple;
	bh=b3ZkVXca1i5pRnRuNF9MgQDWQNG/hIZN3GP7UyzgT1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NH7p/lVAQV7e9RyOGMJjmCrLSowiF227SsHIeLE3nkqldUHXd3LW1L5sbtV6o89BRPD+JmFZNX2zO4Org06d9lHeSxaxohiI/sOX8SPJujIufBOo0r+QY80rK6zdS4cyNjCJjJrD/YG7EPNfWIb1QaK+vSNq1/NvwddADHtxmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSrKwj5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CD3C4CEF0;
	Thu, 11 Sep 2025 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757581804;
	bh=b3ZkVXca1i5pRnRuNF9MgQDWQNG/hIZN3GP7UyzgT1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rSrKwj5rXKi5CCg9gz9X81FI6hP/asyafszIH6PlRqFk1X2ujo/Uwve+lCv/rN4HL
	 d76GXsQhgFA8thrx9phmYRk63mPfkQ4rHsi59kS+YzEKOrxDujpfMkFiao7BE5dvdq
	 cw9WST2PRHC0KfQVcbeTb2AUjEAHEujzwmQS1n8j8kAvmKCM9TGWfHVEuqFZmlbdQP
	 iz1Sz1DuXDmODYzSzu0Wv63tz4Ngi/m6qLXlrdWO8I9hb2HhhpYMDpJj+Cmq0IRy0o
	 rT6+Vgetdu9abZCTZbJRpZ/VTr4o+UJapNixsP5XxPSFkRIo7wwt9How8LIFfC7r6A
	 ojYlLMH9KaCLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0296383BF69;
	Thu, 11 Sep 2025 09:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: net: Add tests to verify team
 driver
 option set and get.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175758180751.2096638.16103651833506796423.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 09:10:07 +0000
References: <20250905040441.2679296-1-marcharvey@google.com>
In-Reply-To: <20250905040441.2679296-1-marcharvey@google.com>
To: Marc Harvey <marcharvey@google.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com,
 willemb@google.com, maheshb@google.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kuba@kernel.org, liuhangbin@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  5 Sep 2025 04:04:41 +0000 you wrote:
> There are currently no kernel tests that verify setting and getting
> options of the team driver.
> 
> In the future, options may be added that implicitly change other
> options, which will make it useful to have tests like these that show
> nothing breaks. There will be a follow up patch to this that adds new
> "rx_enabled" and "tx_enabled" options, which will implicitly affect the
> "enabled" option value and vice versa.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: net: Add tests to verify team driver option set and get.
    https://git.kernel.org/netdev/net-next/c/db1b60066686

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



