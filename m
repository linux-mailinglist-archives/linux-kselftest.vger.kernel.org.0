Return-Path: <linux-kselftest+bounces-36233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322F6AF077C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 02:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C173AFA45
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42615155A30;
	Wed,  2 Jul 2025 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JifGZeb8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D6154457;
	Wed,  2 Jul 2025 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417396; cv=none; b=E8B39sCRF5DbZBqCqPkt9PUpIR4fHAamcH1oBQjvwsvzV+rD6Os9B5Qwf6GKcfCSlnss0JuilbM86+t7nt7G45WeKdG4AbgXN+p5nVqvFcMmJYuHphJuKiM4dMU1JIDeumClGSUbXQCASpti/BR03zfYSnnGwfYTzzNFOzaQWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417396; c=relaxed/simple;
	bh=i4IHwHq/3wg1ZQvXxvqKvRzM0pghjy7/syd4suAgdMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rpw9X4NkezHVGTVKEVM+todxtpHbP/7SrDTm7jx1XQ/nEWdsdstcgLfQmPv1dg7pkPY4PbobwnsdfBOIWphW+BWKbx+t1D2W+wcWXf9Kgj5JYBNxE7nVdrbyDbUrcK73ipxoKYBxr8vCGy2olkdB+oSpv336JdKe18RZpN1AeJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JifGZeb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E54C4CEEB;
	Wed,  2 Jul 2025 00:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751417395;
	bh=i4IHwHq/3wg1ZQvXxvqKvRzM0pghjy7/syd4suAgdMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JifGZeb8rkNeonxKtfMFX+ae0AG4e3qlXRu+ioIcfUbAK7pVP2kKyuWyiTlYG5EPB
	 TOPqL33RT2jiPLSRANAA3UnD/lOLGoxk5/IJVt5sjeLabNOTAd5LmxELoLdxmgdi+a
	 7SL8jYp/2Aw0p+Rh7Ar+x8pHTDZWZ3/w2yba6MwiyBDADDffY6tehfO+liZHH3PnGz
	 p7qjoxphXNARRSAq8MIQ1xcQ6E4u13ZM6SoFN9z+SJMuKRIIF1xef2DmlDOgP/TKc4
	 t7k+Qcj44K4ziBNiL99QJPeR0GqS/Z05Vp7xszCVaPA15z1sg2wvxd5tqOyuhQvZoI
	 EO8Yo1rPc4/Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE77383BA06;
	Wed,  2 Jul 2025 00:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/tc-testing: Enable CONFIG_IP_SET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175141742024.160580.1452957244773705615.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 00:50:20 +0000
References: <20250630153341.Wgh3SzGi@linutronix.de>
In-Reply-To: <20250630153341.Wgh3SzGi@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, shuah@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 17:33:41 +0200 you wrote:
> The config snippet specifies CONFIG_NET_EMATCH_IPSET. This option
> depends on CONFIG_IP_SET.
> 
> Set CONFIG_IP_SET to be enabled at part for tc-testing.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/tc-testing: Enable CONFIG_IP_SET
    https://git.kernel.org/netdev/net-next/c/131e0a1123e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



