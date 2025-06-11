Return-Path: <linux-kselftest+bounces-34634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640F4AD4795
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 03:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5763D3A844F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 00:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685A86334;
	Wed, 11 Jun 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poPdzmUi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85A81749;
	Wed, 11 Jun 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603603; cv=none; b=HIg8FCRjwZ4BXs2iw4P8XpmArFY7aik6xINazXwfGmDcnmaQ1p3lYD9d+wpoVhBS/JHqhS/YlmQSS+Y64zHjhtq9s6sgfhqoaim9slcbzR8bSkrZpyPOaGFB70g+rt2tZXWB1c6Skr3AR956ibYaQ51ihMk5RTEP6U1a3mH7AlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603603; c=relaxed/simple;
	bh=zQZnjvgyvxy/7IFKYYSdeRlbBZ/2WaOTXtJEJZjHn1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OrNcDf99MVfaQKTVIC84Xo7iEQs5gJxewrLb7AYeQTtENXhw4JWSX1SMlgfXlyiHpBFoFO/goKhVXflFCkx0YflgEtjQAbxs4SBbvm+/wZeSYlAbuj7aUOLbRESIkMkXZLv1m7P7BfoJNGxrhsQicbkA1hiOGyWOr8xUWfDOZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poPdzmUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE1DC4CEF0;
	Wed, 11 Jun 2025 01:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749603602;
	bh=zQZnjvgyvxy/7IFKYYSdeRlbBZ/2WaOTXtJEJZjHn1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=poPdzmUit8p/fFOePQ7aswAVqTT5jVXsOmakChLaWOUrM0Gji8tKz1RHgCcC1o/nV
	 clK8vEQ9e+Tj+qv9KsyCrbyTwj2ySsiIqKuT3pmBVzV33mByayX4E8Dfp8cRkC//Hw
	 pAgl9nKMzREIfAhZJrZStl3ssQrLWibrHqgwroP/VYLK3Bv0dLS2oTXhBBiFKLl+UN
	 Q2DNhvHwPNIbYUMRuwnXmuh9JfPF7BBUbEpJCutPCDCyICxwXR9I8UMOV0TRv5IZIJ
	 yPqN+HKxLOFrn+iMBVB8kQ1p/owIzWF2OBXBk29HE9BoUasw/vxMNeznNfhT+Kz1ie
	 6rWdKriS4ccmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B0838111E3;
	Wed, 11 Jun 2025 01:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: packetdrill: more xfail changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174960363325.2754897.14826876899988921929.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 01:00:33 +0000
References: <20250610000001.1970934-1-kuba@kernel.org>
In-Reply-To: <20250610000001.1970934-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, matttbe@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Jun 2025 17:00:01 -0700 you wrote:
> Most of the packetdrill tests have not flaked once last week.
> Add the few which did to the XFAIL list.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: willemb@google.com
> CC: matttbe@kernel.org
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: packetdrill: more xfail changes
    https://git.kernel.org/netdev/net-next/c/265c6ff0f8c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



