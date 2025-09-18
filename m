Return-Path: <linux-kselftest+bounces-41811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC46CB83451
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 09:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9989018958C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 07:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88642E7651;
	Thu, 18 Sep 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAcRJFa3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A472D9EDD;
	Thu, 18 Sep 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179423; cv=none; b=HbAOe/8LftTh4oFn3sZ5Ja5c6D5BNpp6+ZvDpF8d2S1ivXQbbktTU/be5LaOI+Q/bdXT5RMRtuPYaC5/WYy80hVni8l0Ms+SOIw3irXklf8GqM3X/xfjuVgPclFLjLZQ2RQIUgVTj2YQ5wX4KOuGb65xT0Na2BNP9e+iAKbBQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179423; c=relaxed/simple;
	bh=LiZ93zvkp46r1toaeBlfPU0LVdOnahqMwxuP9qT0VbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VOjWaT/4HFlTRvVpJM8ewHjwq182xxmjlHJ3D/PkDJR5Y5whC1cPHQwAsMgkCpiDu1ncczoLlf/0hu+hsAi3N6r2JvQBp6Rk2tYl0qIz9VvqZ9hOkZPnKKt6qtOR/1u9FWCKd+8/J1BqKm6jNxXZZSYojomP7Wjudz2Pxqzn53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAcRJFa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAD7C4CEE7;
	Thu, 18 Sep 2025 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758179423;
	bh=LiZ93zvkp46r1toaeBlfPU0LVdOnahqMwxuP9qT0VbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EAcRJFa3bQoSQApRP9ELx2FiJsWkDJnzr89P3MBFar0LWXpefnMRpWvSWwUQVY/5Z
	 c41KamhzcbsKSFtQRb69l7QY1dJeaOdmnjsO96MuYYPZsWWfr+aouZcqxCUzMjGFAI
	 6aGntNq0J/uGCseQNtzCb9v6XCQyjhDuW/LPGLz2dW080uXwdwf7iP9bYn0cd6hY4t
	 lvXgT3ZDEUID/BSuqviQtWiFpAT1FdtQaISvweU7RE4QoU7shSe4x3f0XBMBbQhUwR
	 eiF0MSS1mfLoZIfDVnx9Fv6eeOTOFSVMgazX6+w2EfgkWy6MtFEtm3xwQba9Xd1xYC
	 X8eAhKZ4e7ykQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF5739D0C28;
	Thu, 18 Sep 2025 07:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v19 net-next 00/10] AccECN protocol patch series
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175817942351.2297937.1388609037846556434.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 07:10:23 +0000
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: pabeni@redhat.com, edumazet@google.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
 liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Sep 2025 10:24:24 +0200 you wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Please find the v19 AccECN protocol patch series, which covers the core
> functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
> and AccECN failure handling. The Accurate ECN draft can be found in
> https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28, and it
> will be RFC9768.
> 
> [...]

Here is the summary with links:
  - [v19,net-next,01/10] tcp: AccECN core
    https://git.kernel.org/netdev/net-next/c/542a495cbaa6
  - [v19,net-next,02/10] tcp: accecn: AccECN negotiation
    https://git.kernel.org/netdev/net-next/c/3cae34274c79
  - [v19,net-next,03/10] tcp: accecn: add AccECN rx byte counters
    https://git.kernel.org/netdev/net-next/c/9a0112774455
  - [v19,net-next,04/10] tcp: accecn: AccECN needs to know delivered bytes
    https://git.kernel.org/netdev/net-next/c/a92543d59762
  - [v19,net-next,05/10] tcp: sack option handling improvements
    https://git.kernel.org/netdev/net-next/c/77a4fdf43c5e
  - [v19,net-next,06/10] tcp: accecn: AccECN option
    https://git.kernel.org/netdev/net-next/c/b5e74132dfbe
  - [v19,net-next,07/10] tcp: accecn: AccECN option send control
    https://git.kernel.org/netdev/net-next/c/aa55a7dde7ec
  - [v19,net-next,08/10] tcp: accecn: AccECN option failure handling
    https://git.kernel.org/netdev/net-next/c/b40671b5ee58
  - [v19,net-next,09/10] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
    https://git.kernel.org/netdev/net-next/c/fe2cddc648f0
  - [v19,net-next,10/10] tcp: accecn: try to fit AccECN option with SACK
    https://git.kernel.org/netdev/net-next/c/e7e9da850a46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



