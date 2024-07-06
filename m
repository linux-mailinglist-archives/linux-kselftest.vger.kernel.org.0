Return-Path: <linux-kselftest+bounces-13264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE49928FE1
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 03:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F033E1C21714
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7346125;
	Sat,  6 Jul 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfI6cLM1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C14A19;
	Sat,  6 Jul 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720228233; cv=none; b=Cpcjh5w0advIWnvy4yFVB4br3rIiQCnAdfwcZ3EeipMmMESu74+Mw2d6FuW1B3XuI1ygLmB6SdW4ehHgbN5Xp6XbcBuG9gT+LyQfJ6mipsbbJcou29WSDUIdKAObJvy1jkYdfWHMA7Qb9BzwEHI4ZPn9n18gf+tyEm00TFilecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720228233; c=relaxed/simple;
	bh=zkCxmVfyAcZ3ameHi0iJtKJwpuGLKb+DGOkw/aensNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fFitaoj8y9hDJGVQQJTdYAytsfyed32zWYtjv1AJ8w3LFx/J2Tq6W3wD7oyv0W+alQpkREJWMmI+bx84+qD/f4O+2pO5ZOGr4WFKHuNmpGH42XGs3AuMrpP+Yjy3xfQl7fNTXknOFDHl7rvGU9s+N7b+9yqsH00Dt0wjScFoMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfI6cLM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD9F5C32781;
	Sat,  6 Jul 2024 01:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720228232;
	bh=zkCxmVfyAcZ3ameHi0iJtKJwpuGLKb+DGOkw/aensNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FfI6cLM1x64E4KFsAMKmN4ng2Xj0cJGiPYZ+qiLGU7tpjnlsQ+eiunOvsE8rJ3oYO
	 cVchYkPHgW+Und3Kqvp2/9H8GJIdk7vwYaNFMK0dF05BN/L0RjQEFQU+AJLsDudGUS
	 KqsyGa2nh+F7Y5FanmvKl+uHl2wQ1U3cQ9/7L9gDKk82SVkfYDRqmP2pq9HcO/qdRp
	 4jp+KyQ+ZLDU2gifyz5JQonqH5JxdjyidIhbOgXsTJNDkfE0/uko3Aav6TthMNU8ps
	 6qSbjFS59O2h3orpruXLO7ryOcxxQ9pSGEIlP6TrhrDkpZbiuD5arD7urEEbHTdu39
	 7xYZo8IO0glng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A51B6C43332;
	Sat,  6 Jul 2024 01:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 00/10] net: openvswitch: Add sample multicasting.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172022823267.9162.5749363663019747112.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jul 2024 01:10:32 +0000
References: <20240704085710.353845-1-amorenoz@redhat.com>
In-Reply-To: <20240704085710.353845-1-amorenoz@redhat.com>
To: =?utf-8?q?Adri=C3=A1n_Moreno_=3Camorenoz=40redhat=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jul 2024 10:56:51 +0200 you wrote:
> ** Background **
> Currently, OVS supports several packet sampling mechanisms (sFlow,
> per-bridge IPFIX, per-flow IPFIX). These end up being translated into a
> userspace action that needs to be handled by ovs-vswitchd's handler
> threads only to be forwarded to some third party application that
> will somehow process the sample and provide observability on the
> datapath.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,01/10] net: psample: add user cookie
    https://git.kernel.org/netdev/net-next/c/093b0f366567
  - [net-next,v9,02/10] net: sched: act_sample: add action cookie to sample
    https://git.kernel.org/netdev/net-next/c/03448444ae5c
  - [net-next,v9,03/10] net: psample: skip packet copy if no listeners
    https://git.kernel.org/netdev/net-next/c/c35d86a23029
  - [net-next,v9,04/10] net: psample: allow using rate as probability
    https://git.kernel.org/netdev/net-next/c/7b1b2b60c63f
  - [net-next,v9,05/10] net: openvswitch: add psample action
    https://git.kernel.org/netdev/net-next/c/aae0b82b46cb
  - [net-next,v9,06/10] net: openvswitch: store sampling probability in cb.
    https://git.kernel.org/netdev/net-next/c/71763d8a8203
  - [net-next,v9,07/10] selftests: openvswitch: add psample action
    https://git.kernel.org/netdev/net-next/c/60ccf62d3ceb
  - [net-next,v9,08/10] selftests: openvswitch: add userspace parsing
    https://git.kernel.org/netdev/net-next/c/c7815abbea45
  - [net-next,v9,09/10] selftests: openvswitch: parse trunc action
    https://git.kernel.org/netdev/net-next/c/b192bf12dbb0
  - [net-next,v9,10/10] selftests: openvswitch: add psample test
    https://git.kernel.org/netdev/net-next/c/30d772a03582

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



