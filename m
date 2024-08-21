Return-Path: <linux-kselftest+bounces-15806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898C95922C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 03:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51A71C22284
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AAA18035;
	Wed, 21 Aug 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4DDeIsQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E991322B;
	Wed, 21 Aug 2024 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724203835; cv=none; b=JWHKZzoIVkmsjxhfI0aykx2F0za6A9I0c/PPot3jumhQpfDHOIojmBR3Z+mVAV6cxY/Tls7YORqCbfPPAaFwcco6b1kWioBaQ9tWyor1OJ1Ud92NZPs/rCg9aoPmK8O6mkQj9/cET56ApA6K8ka576ZLJLjGx/Nm7v/SZAPAUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724203835; c=relaxed/simple;
	bh=IgbRt2X/eqF3ZxBx7aI8dn140iBIsCi7/UUDBEAx9BU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mvr2gji3tCWDEX4y+/tjfgl+6OjWzK+HlsK2SSvhZW2iCPc36bmx90x4OPtzE9IS2OBUiX+Ho6Wor/JpfdfvTtxkpRudxSg/mQaah5wxlBJPIT8DUSEv6/XzLTktb+ZHzT2M7+BqOZ9jQ6+rmjLMszQhNTYCGsEtZwjjx530ogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4DDeIsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCB0C4AF0B;
	Wed, 21 Aug 2024 01:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724203834;
	bh=IgbRt2X/eqF3ZxBx7aI8dn140iBIsCi7/UUDBEAx9BU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B4DDeIsQgOkIvmVJvjgYpPgOiydDTojo+sl4F7YuyRShRCvZZCLXApGrOcxMIfh0u
	 /9pK1UY0HYaQu9y6qmHt9sYN1yLYsR3g5HTtUx/RT18/ZcAWXe8m6kebL7d5IpdWvh
	 p1CcGCg5m6SgFtqteIVwhTyUeVZi7WNCppouekDnOnWrebGs/hQOstF6OMmjKyRPWn
	 YtWBa2r2DNiOp+DLNR5IZYpSs4A6SCCBhDbJAv+ro/JpcZJGom8BH9YwK6HG7LjplY
	 SetPtlMKaO+pOPhLovv2wFyGoh3I4rTg206X1BmllHmg2y82XAX8GErsedA44gHsdi
	 YJ1UcDjJ1PmTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FAE3804CB6;
	Wed, 21 Aug 2024 01:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/14] mptcp: pm: fix IDs not being reusable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172420383401.1291081.11218145851509520450.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 01:30:34 +0000
References: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
In-Reply-To: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Aug 2024 21:45:18 +0200 you wrote:
> Here are more fixes for the MPTCP in-kernel path-manager. In this
> series, the fixes are around the endpoint IDs not being reusable for
> on-going connections when re-creating endpoints with previously used IDs.
> 
> - Patch 1 fixes this case for endpoints being used to send ADD_ADDR.
>   Patch 2 validates this fix. The issue is present since v5.10.
> 
> [...]

Here is the summary with links:
  - [net,01/14] mptcp: pm: re-using ID of unused removed ADD_ADDR
    https://git.kernel.org/netdev/net/c/e255683c06df
  - [net,02/14] selftests: mptcp: join: check re-using ID of unused ADD_ADDR
    https://git.kernel.org/netdev/net/c/a13d5aad4dd9
  - [net,03/14] mptcp: pm: re-using ID of unused removed subflows
    https://git.kernel.org/netdev/net/c/edd8b5d868a4
  - [net,04/14] selftests: mptcp: join: check re-using ID of closed subflow
    https://git.kernel.org/netdev/net/c/65fb58afa341
  - [net,05/14] mptcp: pm: re-using ID of unused flushed subflows
    https://git.kernel.org/netdev/net/c/ef34a6ea0cab
  - [net,06/14] selftests: mptcp: join: test for flush/re-add endpoints
    https://git.kernel.org/netdev/net/c/e06959e9eebd
  - [net,07/14] mptcp: pm: remove mptcp_pm_remove_subflow()
    https://git.kernel.org/netdev/net/c/f448451aa62d
  - [net,08/14] mptcp: pm: only mark 'subflow' endp as available
    https://git.kernel.org/netdev/net/c/322ea3778965
  - [net,09/14] mptcp: pm: only decrement add_addr_accepted for MPJ req
    https://git.kernel.org/netdev/net/c/1c1f72137598
  - [net,10/14] mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
    https://git.kernel.org/netdev/net/c/0137a3c7c2ea
  - [net,11/14] mptcp: pm: only in-kernel cannot have entries with ID 0
    https://git.kernel.org/netdev/net/c/ca6e55a703ca
  - [net,12/14] mptcp: pm: fullmesh: select the right ID later
    https://git.kernel.org/netdev/net/c/09355f7abb9f
  - [net,13/14] selftests: mptcp: join: validate fullmesh endp on 1st sf
    https://git.kernel.org/netdev/net/c/4878f9f8421f
  - [net,14/14] mptcp: pm: avoid possible UaF when selecting endp
    https://git.kernel.org/netdev/net/c/48e50dcbcbaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



