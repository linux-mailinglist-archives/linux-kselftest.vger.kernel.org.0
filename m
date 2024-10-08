Return-Path: <linux-kselftest+bounces-19305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3387995B88
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 01:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6FF1F25682
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F99E218598;
	Tue,  8 Oct 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz2jQeBA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4B1C579B;
	Tue,  8 Oct 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429630; cv=none; b=eUxIK/9RLR5aKbVrvv34LEFOpoaCbu03El32ArrkuOWIFe2fTLaPLhQb+Wa0N7xAyk5YbXLBXdCmIxDaVY5UkFpFuBA20E6iyaPdIdzjXPXs7dVy02lISVnHEk9o+r3QvDGRWuRwb9am9K4YNliCgK+8ui4CJgJvETuMbCM478o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429630; c=relaxed/simple;
	bh=gjP3PSk/8LDMW7TAgiKJjaolpQaTnxyv0/CynDlLUDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lnxhfpe+xpTxSRF+aQCuSq8RzzEI3EP9mHAT+gNLKLSuc4CYHVdDJMaovsqh23oq/wtkFFANMkQUXSfuUSCONLP53Ut4rwujaGp1TtraxnGiY+E7eD3EGbyHhUImgM1uH2i6AT2O5MoWvPo75dPvWK+yDMwCtpGOWTQ3+/2m7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz2jQeBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84802C4CEC7;
	Tue,  8 Oct 2024 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728429629;
	bh=gjP3PSk/8LDMW7TAgiKJjaolpQaTnxyv0/CynDlLUDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iz2jQeBAvKW7tNKt+M9EwAwCQ6FjLoOyw9IaDr8/0ribGBVT67sE34TX/HwxZgGnw
	 ESqldbLWzCBsKuytVZQjnbguSFXRZokSKJSrVUS03Lq/i+1zE6a27mwV5B4pDMDqHB
	 QSdBV3cz13VUJzwuz4h9l+N+Swu3vznSW2N+cM+hOXnxvqcsUWZDXj+h8DZpCJm2WB
	 mHsI6mPWpTTG8Lw1TWnZLhZbxL9QkdXTRumFCz3CnrDVuIJ15KC9CxG/lunCE/2v0F
	 DupQ5Bb3P765DlVQ6LYiX7G0CUeVkxc0IWN/Yhz+lk1as/PCpHRhxtrsP8huv16M8I
	 u+IIpKACZMFxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF023A8D14D;
	Tue,  8 Oct 2024 23:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] selftests: mlxsw: Stabilize RED tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172842963373.718280.1959244087109322428.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 23:20:33 +0000
References: <cover.1728316370.git.petrm@nvidia.com>
In-Reply-To: <cover.1728316370.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, amcohen@nvidia.com,
 idosch@nvidia.com, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Oct 2024 18:26:04 +0200 you wrote:
> Tweak the mlxsw-specific RED selftests to increase stability on
> Spectrum-3 and Spectrum-4 machines.
> 
> Petr Machata (5):
>   selftests: mlxsw: sch_red_ets: Increase required backlog
>   selftests: mlxsw: sch_red_core: Increase backlog size tolerance
>   selftests: mlxsw: sch_red_core: Sleep before querying queue depth
>   selftests: mlxsw: sch_red_core: Send more packets for drop tests
>   selftests: mlxsw: sch_red_core: Lower TBF rate
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] selftests: mlxsw: sch_red_ets: Increase required backlog
    https://git.kernel.org/netdev/net-next/c/870dd51117cb
  - [net-next,2/5] selftests: mlxsw: sch_red_core: Increase backlog size tolerance
    https://git.kernel.org/netdev/net-next/c/8fb5b6073456
  - [net-next,3/5] selftests: mlxsw: sch_red_core: Sleep before querying queue depth
    https://git.kernel.org/netdev/net-next/c/787f148cec34
  - [net-next,4/5] selftests: mlxsw: sch_red_core: Send more packets for drop tests
    https://git.kernel.org/netdev/net-next/c/7049166e51bc
  - [net-next,5/5] selftests: mlxsw: sch_red_core: Lower TBF rate
    https://git.kernel.org/netdev/net-next/c/501fa2426b5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



