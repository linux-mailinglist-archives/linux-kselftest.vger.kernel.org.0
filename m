Return-Path: <linux-kselftest+bounces-24806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D0A1734C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 20:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725F5169142
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C01EF0B1;
	Mon, 20 Jan 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufSSqq3N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE91EF09E;
	Mon, 20 Jan 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402611; cv=none; b=DyH/m+eCdq5EXQwd5qmE4HhjXzuHPYtWBmgTVh7yFosDV9vW5YRtrA+ANmy2eOMU5+bEM1KF35+/Fxz5rOkNSg7lQL5eL5+6VMmd7Wwx1s2cJMSSa89z2Kof944HDw3w703jU2s5iLUzjDEe9nCZ4trrdr6j0Gfrbl7de+RxlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402611; c=relaxed/simple;
	bh=x614/xJdx2OSlbfxrVkToIm0touq3X0gYVVuia71pTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bu7le6plEV0/XEjzhzmAGPp7M4UloW/oPTkHdD0GGHeSBSI/dolEHQZFN/rUGHp6VXiUgo3WtPG0Ib72dg91Ba/lpneVIWmd+sms/E4BWeRlG7myMmtieUgOqopaAIFrapK4Rnv9B4Il815FNINTH5FNJt+2kD602UhGOHWsiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufSSqq3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC75C4CEE0;
	Mon, 20 Jan 2025 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737402610;
	bh=x614/xJdx2OSlbfxrVkToIm0touq3X0gYVVuia71pTc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ufSSqq3Nm/R97Ftzrc75vrPmTAoo7d9oFFIBzPWfVyBsRpogbJVg+dGPJaqpL42ng
	 tpuAgkwibb+5KG/+/vgs4GD6AI5G5YlRytp6AXk/Eff0jXbxkZcbGyJP+ntq6FZ8N/
	 VrpjEoF8dUTVmaqH6LoVemehphsR7EgYMhPFccn7ufXwxe11NDHnvBzRIjZwJ/Rvg5
	 OVNQShnGy7Ixr+cR+lMQGYpcK/nw7CUkdGTfMY0Zb/AgSB/mnp0JlBo7uTlozId/hp
	 1BYrjiix22ciyn2KETAQIgex3KPfqYbbKnceHMM08WmzXONrH7Jv9f+gLQVTHbutgA
	 Sff7gHqlbs58A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFC4380AA62;
	Mon, 20 Jan 2025 19:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V3] selftests/net/ipsec: Fix Null pointer dereference in
 rtattr_pack()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173740263424.3632610.2742835658564337830.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 19:50:34 +0000
References: <20250116013037.29470-1-liuye@kylinos.cn>
In-Reply-To: <20250116013037.29470-1-liuye@kylinos.cn>
To: liuye <liuye@kylinos.cn>
Cc: horms@kernel.org, kuba@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 09:30:37 +0800 you wrote:
> From: Liu Ye <liuye@kylinos.cn>
> 
> Address Null pointer dereference in rtattr_pack.
> 
> Flagged by cppcheck as:
>     tools/testing/selftests/net/ipsec.c:230:25: warning: Possible null pointer
>     dereference: payload [nullPointer]
>     memcpy(RTA_DATA(attr), payload, size);
>                            ^
>     tools/testing/selftests/net/ipsec.c:1618:54: note: Calling function 'rtattr_pack',
>     4th argument 'NULL' value is 0
>     if (rtattr_pack(&req.nh, sizeof(req), XFRMA_IF_ID, NULL, 0)) {
>                                                        ^
>     tools/testing/selftests/net/ipsec.c:230:25: note: Null pointer dereference
>     memcpy(RTA_DATA(attr), payload, size);
>                            ^
> Fixes: 70bfdf62e93a ("selftests/net/ipsec: Add test for xfrm_spdattr_type_t")
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net,V3] selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()
    https://git.kernel.org/netdev/net-next/c/3a0b7fa09521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



