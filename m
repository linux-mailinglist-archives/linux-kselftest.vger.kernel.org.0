Return-Path: <linux-kselftest+bounces-7601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC98A01DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 23:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BF21C218C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ECE1836E0;
	Wed, 10 Apr 2024 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgF08dYE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC31836D6;
	Wed, 10 Apr 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784030; cv=none; b=RYuYFEPh7cEgj0WkAE6n/yhe3IHEKr63M0W45R/ON1kivoatn+4nBrC5AcTpUwHaP4SNZLjlPpYqtYVxIC6pHGNMDc+dVt4sLBsiophyAcYUNF7J7uO/SfcjVb55wJiG/3JWeybUptcr2DRK6MLs4ASSJWD80d3q6E5WDuwfRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784030; c=relaxed/simple;
	bh=I8rt88j/K6xT26aoxxh7wz7o02RbdPxTDHlEEqGV5Wk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A2i0mqQPCWjiKBoiwpdkdCNcbs4SxPoz+tcrlKfj9vY22JELzUztAZJQOffk5pEZvtVeSgV83unzl719xrj+BBhpcxlefG1v8rEglQGgCiK95zpmUX3wOsBVUgucmr3plAkHN4udX+mvL+Y4Wdnh/i7EBHja3L7kBPu+rKMztOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgF08dYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B95AAC43390;
	Wed, 10 Apr 2024 21:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712784029;
	bh=I8rt88j/K6xT26aoxxh7wz7o02RbdPxTDHlEEqGV5Wk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YgF08dYEqet4XMOlNpOO/v6j/nNukHNjCwjelIgTxWKhAWAw4pV+qIPvLjBlzZhM9
	 c7Vq6gIcVvZqlhb0PtkUvKjaa65hkjZJvscPAi45oOv1xm1jvPg5pZgAuyTbbU7fO6
	 ICBnQadiz1jcTiYMYsLD/57CYpdBulpUdS4HHXo69SEwMU6tiTcmIsxzIlXwh8TnOZ
	 gejwAAdbhRoH8U2X7afHtPk/+N5MP5iMdnWtjDOv2yk7K1sNvT/UyKtBrMuP1UnvVN
	 4VQ7TklXwo83hX8jgLNai0DuvzfI5d1y+wvVXyusC9Gn8v77JaVEHq1lMTWrHJyDWT
	 W2S4vXg5QSSQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF45DC395F8;
	Wed, 10 Apr 2024 21:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] selftests: move bpf-offload test from bpf to net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171278402971.16914.2708494251817673120.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 21:20:29 +0000
References: <20240409031549.3531084-1-kuba@kernel.org>
In-Reply-To: <20240409031549.3531084-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
 eddyz87@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Apr 2024 20:15:45 -0700 you wrote:
> The test_offload.py test fits in networking and bpf equally
> well. We started adding more Python tests in networking
> and some of the code in test_offload.py can be reused,
> so move it to networking. Looks like it bit rotted over
> time and some fixes are needed.
> 
> Admittedly more code could be extracted but I only had
> the time for a minor cleanup :(
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] selftests: move bpf-offload test from bpf to net
    https://git.kernel.org/netdev/net-next/c/e59f0e93e92e
  - [net-next,2/4] selftests: net: bpf_offload: wait for maps
    https://git.kernel.org/netdev/net-next/c/fc50c698c28b
  - [net-next,3/4] selftests: net: declare section names for bpf_offload
    https://git.kernel.org/netdev/net-next/c/b1c2ce11d428
  - [net-next,4/4] selftests: net: reuse common code in bpf_offload
    https://git.kernel.org/netdev/net-next/c/6ce2b689932b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



