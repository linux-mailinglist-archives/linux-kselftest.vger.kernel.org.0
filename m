Return-Path: <linux-kselftest+bounces-32697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43605AB07C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 04:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B349E4A4D0A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 02:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932D243370;
	Fri,  9 May 2025 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlgpKb6+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C6243364;
	Fri,  9 May 2025 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746756589; cv=none; b=tmkIZZbrqhp/0uXzvgh8isXJDdvyLo178kmFCbEPv92hP1GRzC2vyDIdWLc04CaOqwD/JQ41nudGVcMIFi9UJqS+5lFWt3P7KhD2BfdGbbEqf8ara3C+rtE4bohj/RdVv4Sng3FFY7+U3Ifj5SGGtWeOAaZx/pt4Up/jkudBMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746756589; c=relaxed/simple;
	bh=Nw3tvNV6vNYghJobc30sLj2/9M7f/JD4gTmnVtEykeM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G1Q8Zx/c980XU6/765l6G714vcU2QgHOaihP7jG/m0hGc+82RREi4N8aBmrVxg1AcQyW79LALHjWNMwVWWrlYc4ucQnVpGOb2GQBjj6ZjZ2G1C4q6mQ43ip1sZ5yvPBdRtDS3HMt1eiNB/tXjNeMS1IHhMbhdQk0SpU3z+JRKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlgpKb6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9921C4CEEF;
	Fri,  9 May 2025 02:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746756588;
	bh=Nw3tvNV6vNYghJobc30sLj2/9M7f/JD4gTmnVtEykeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZlgpKb6+Gv6Y3LWPc2ZvzR3Ys+2FlCgMW5nZ02aPov1OCiocHd4SEojfAIRaAy8v4
	 SgENdL812p7nO7idv7DOULHWwGHSaA2vlJaWeentH5Re3TMO9HS3/t8YYOxAo2Gkdq
	 FFzQthCTFos9ZXfknWSEi+JB0B/IANMvpInKmNZoFedrqK6tKvMF4KKqhs2pNo+DYN
	 2V6w8l10NCqAx7PvVZRlaKyspdgXQzi69rRGR56vla10CGTF2ss8fzByYSbLZ9dnxj
	 JvLIFe8b4h8i/O+2LsE0jW6PouU+gSKyBSHRORzhwN/vVCDsoVnx5mkf6A9RM9eXQz
	 Qw8xoBU6xCoBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B05380AA7D;
	Fri,  9 May 2025 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net-drv: remove the nic_performance and
 nic_link_layer tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174675662725.3101596.2831056851468401975.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 02:10:27 +0000
References: <20250507140109.929801-1-kuba@kernel.org>
In-Reply-To: <20250507140109.929801-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, sdf@fomichev.me, mohan.prasad@microchip.com,
 dw@davidwei.uk, petrm@nvidia.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 May 2025 07:01:07 -0700 you wrote:
> Revert fbbf93556f0c ("selftests: nic_performance: Add selftest for performance of NIC driver")
> Revert c087dc54394b ("selftests: nic_link_layer: Add selftest case for speed and duplex states")
> Revert 6116075e18f7 ("selftests: nic_link_layer: Add link layer selftest for NIC driver")
> 
> These tests don't clean up after themselves, don't use the disruptive
> annotations, don't get included in make install etc. etc. The tests
> were added before we have any "HW" runner, so the issues were missed.
> Our CI doesn't have any way of excluding broken tests, remove these
> for now to stop the random pollution of results due to broken env.
> We can always add them back once / if fixed.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net-drv: remove the nic_performance and nic_link_layer tests
    https://git.kernel.org/netdev/net-next/c/d97e2634fbdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



