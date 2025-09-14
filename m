Return-Path: <linux-kselftest+bounces-41448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9CB56C9B
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Sep 2025 23:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF8D1898D16
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Sep 2025 21:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27232DE6F1;
	Sun, 14 Sep 2025 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6BElGVE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73569289E17;
	Sun, 14 Sep 2025 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757886007; cv=none; b=U/btRKnijs+hZBM5DZhL0i7lMvJ8njSzp/Au2oe807SKvbMPP6CqF/BEV1kKgdKgWP1IfMcURYQQRfNOd7PLwXPFNKArN+1UiOZB9GF07xIiWy8rbMjDsq4+hEFcfr5lNg3zMr7uTEfUoFZ6vDFEb+EgTHFTnnRfdylawy5zhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757886007; c=relaxed/simple;
	bh=fFoTBzYY/Y4wGukFdKJpceVN2SwaaFe6OdyADb7VuWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bVII1lY++aap1xFoLwGUezJFnZ+zypXMw9m2zVAZcFtyevGpyffV3JATJUyg+75Rfw48iB6cqJOH3/2pcKIufhe/LVGU+jEiDzppJQJxb4j7gowao4duU+5m8vtZaX+bekjJ+DIBxn7wPUaUocDk9yXdWp912jZ1LpVu92yvtaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6BElGVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D30C4CEF0;
	Sun, 14 Sep 2025 21:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757886007;
	bh=fFoTBzYY/Y4wGukFdKJpceVN2SwaaFe6OdyADb7VuWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m6BElGVEewbhw82WXRh+Q8GhAsRKkWaAmFJXK72tS6N8J0Uc7cVf5WEcbBBx9DKZR
	 7sdo4e6Owitrr2d+xY0zOZKEBm85rSuayl9FJhduDYzj0xyXU9lcS7r/Ad2bQHdNd6
	 qv3WT9xh0c+C3f6A3NAAY+asyJaObKrT+Nc3rjdgxfUysa9eLqelbhxgLoGwTT7yaU
	 L3dOM+ByhUiKPUQBf3kEEJNFADYQyExfDyYDpABqEyV9WzS2c5cVcEx/tDoSPDemAi
	 0EAndWIIO4Td88nY6YYYooiw7LyONobGnLKYzdnV0HlA4bVu3IMBCnHvvyeJhemT4d
	 51FCiqzZ3FnUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACD239B167D;
	Sun, 14 Sep 2025 21:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: dst_metadata: fix DF flag extraction on
 tunnel rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788600875.3557884.5011136723968202976.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 21:40:08 +0000
References: <20250909165440.229890-1-i.maximets@ovn.org>
In-Reply-To: <20250909165440.229890-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dev@openvswitch.org, echaudro@redhat.com, aconole@redhat.com,
 shuah@kernel.org, jhs@mojatatu.com, dcaratti@redhat.com, idosch@idosch.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Sep 2025 18:54:14 +0200 you wrote:
> Two patches here, first fixes the issue where tunnel core doesn't
> actually extract DF bit from the outer IP header, even though both
> OVS and TC flower allow matching on it.  More details in the commit
> message.
> 
> The second is a selftest for openvswitch that reproduces the issue,
> but also just adds some basic coverage for the tunnel metadata
> extraction and related openvswitch uAPI.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: dst_metadata: fix IP_DF bit not extracted from tunnel headers
    https://git.kernel.org/netdev/net/c/a9888628cb2c
  - [net,v2,2/2] selftests: openvswitch: add a simple test for tunnel metadata
    https://git.kernel.org/netdev/net/c/6cafb93c1f2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



