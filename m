Return-Path: <linux-kselftest+bounces-44561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D341CC2746E
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 01:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A18B34CC1B
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 00:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F17D1E8320;
	Sat,  1 Nov 2025 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClhxTfRG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8412FF69;
	Sat,  1 Nov 2025 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761957634; cv=none; b=GuF8Yx746nRoxDp/3Y4sfEK9YVruJZu6XEvwV02MzC/QmOEn9QY8x+mtoUiINKzMu1Dc42PHctopHZprVykJ9E0PPoNq8ZNGEk15oDhwvIvvQMcLztzdfAxPO8iZSShlJF3HZAXNB9AOk9absElpgT9oE2y09heZRDb8uOl3ems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761957634; c=relaxed/simple;
	bh=xiQx6/881cU78uFhXhS74bAfiIuaICLK9/dR7PYCwOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kp9O1AVkSvHREMm9xwJjqi70EW68Q0yvsdwSUC8u9ztKc4WML0T8ja375iAmPilwndiUaJjFHMrOhseS3zxaB47RSGPehc814qNRfz6MGhSXdt1T4usiBQYhhM9Gyl6aBqi6iH3txwzyWKVH2yWTcT1hhJelgTF3N0wtDoHUCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClhxTfRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F326C4CEE7;
	Sat,  1 Nov 2025 00:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761957633;
	bh=xiQx6/881cU78uFhXhS74bAfiIuaICLK9/dR7PYCwOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ClhxTfRG20GQuQtD9Od4hFdTKNQIWbLDx6wxmBpL3G9T6o/cizPshdFJ3SiO7JdHu
	 Qa3gXrXTzw10CFQI9AzEPqearElUsQdVFS8Ihxyo5ZQp1oC50kGhnh+v7WL9//K3C7
	 1Q8E6MlVYKuFH84r/LY0/ylGnbdUNNYfXH/925HyW9fGd5xqV6izHYkWSmoIm7NoiQ
	 34oUeWND8COlh7KhN8Y1JS5+Z5UvrBUQQeDYFiArqi/jEtIqSbfT3yTcWo+2u3TDaY
	 yiYOts0hNLtS/MgCdAJgrLk0BEmA6nJoW6JtstChmIVeOu/vbDhtMH68qXExR1KyTD
	 N+aefWLldTPgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE783809A00;
	Sat,  1 Nov 2025 00:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests/net: fix out-of-order delivery of FIN in
 gro:tcp test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195760949.680160.10649710611348544601.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 00:40:09 +0000
References: <20251030062818.1562228-1-anubhavsinggh@google.com>
In-Reply-To: <20251030062818.1562228-1-anubhavsinggh@google.com>
To: Anubhav Singh <anubhavsinggh@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, willemb@google.com, lixiaoyan@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 06:28:18 +0000 you wrote:
> Due to the gro_sender sending data packets and FIN packets
> in very quick succession, these are received almost simultaneously
> by the gro_receiver. FIN packets are sometimes processed before the
> data packets leading to intermittent (~1/100) test failures.
> 
> This change adds a delay of 100ms before sending FIN packets
> in gro:tcp test to avoid the out-of-order delivery. The same
> mitigation already exists for the gro:ip test.
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests/net: fix out-of-order delivery of FIN in gro:tcp test
    https://git.kernel.org/netdev/net/c/02d064de05b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



