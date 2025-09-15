Return-Path: <linux-kselftest+bounces-41545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E362B58897
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264673A601D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 23:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9502DA776;
	Mon, 15 Sep 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4sHGg+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2ED2582;
	Mon, 15 Sep 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980211; cv=none; b=m8BiWNPDh3md/Ewq3ncA85eXyMf2nog3FHWBQPjuixT9f672/9b1fjRKwYusLSPeD64S+JNUFM+WX3E2YdXLVGhjmEFZSW/BncCO7BhyWpXmKkl9CCVsMzedBwGKjnNSZEDtYgMCiEkHG5u1iFeUq5PAHRfhmyJrcpg12H4Y16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980211; c=relaxed/simple;
	bh=vAjldiDoF72xxUnWmyHpWZ+g86vnS0E7dD3IC8oujHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Znlb45w8fOSti1QaShhTrT8FxLi48A8JnRApEkJPeVX36CF8x7BrZMOtuPQ91knxJ7TYflx7cjsGlcS8RFUsaD0a4/DkbZEg2v9Jc2WB7ueSvY3hJCp1oBAmHNX6SOARq9RyRG1ZZyPithhvedzw2Z+C/ik1/0D/He056VeZ11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4sHGg+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5188EC4CEF1;
	Mon, 15 Sep 2025 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980211;
	bh=vAjldiDoF72xxUnWmyHpWZ+g86vnS0E7dD3IC8oujHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J4sHGg+FfcsVv9DQ9BWTgjRZUG6P3IjTHerhf0ahmlVkImsZ2IWV6X/pCh91r0cs2
	 6JJtb+XBw7EOovF03v5ncjdJcn/24QUfn9zGq+xABUv/Ai74Ksp2yIss65gcTfQZl2
	 XWujHIzx3jFabHL8Guu4D9kEhgg4yRXJUSfzvq8Tf/ycDpDzqjncIIGN2LmovYKDWE
	 G+YkMM1wwbkLtfnj1K1yYTS6rDC7yqgPLqEqfxjdbsaCzaqMZzdvQJJzYAvQ6Vlypa
	 /KR+YEqaHQZ7jS5L8EzfdilpnMF3TDUjqGBRqGtE2ZfGZgsT/4ggSuejmR1nYZbS5y
	 J/tq4PFl2fvaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9039D0C18;
	Mon, 15 Sep 2025 23:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v18 net-next 00/14] AccECN protocol patch series
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798021275.532372.9930328192752349189.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 23:50:12 +0000
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
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
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 13:06:28 +0200 you wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Please find the v18 AccECN protocol patch series, which covers the core
> functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
> and AccECN failure handling. The Accurate ECN draft can be found in
> https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28, and it
> will be RFC9768.
> 
> [...]

Here is the summary with links:
  - [v18,net-next,01/14] tcp: reorganize SYN ECN code
    https://git.kernel.org/netdev/net-next/c/449144f4d5f2
  - [v18,net-next,02/14] tcp: fast path functions later
    https://git.kernel.org/netdev/net-next/c/61b2f7baa977
  - [v18,net-next,03/14] tcp: reorganize tcp_sock_write_txrx group for variables later
    https://git.kernel.org/netdev/net-next/c/c3426ba2ed69
  - [v18,net-next,04/14] tcp: ecn functions in separated include file
    https://git.kernel.org/netdev/net-next/c/30f5ca006243
  - [v18,net-next,05/14] tcp: AccECN core
    (no matching commit)
  - [v18,net-next,06/14] tcp: accecn: AccECN negotiation
    (no matching commit)
  - [v18,net-next,07/14] tcp: accecn: add AccECN rx byte counters
    (no matching commit)
  - [v18,net-next,08/14] tcp: accecn: AccECN needs to know delivered bytes
    (no matching commit)
  - [v18,net-next,09/14] tcp: sack option handling improvements
    (no matching commit)
  - [v18,net-next,10/14] tcp: accecn: AccECN option
    (no matching commit)
  - [v18,net-next,11/14] tcp: accecn: AccECN option send control
    (no matching commit)
  - [v18,net-next,12/14] tcp: accecn: AccECN option failure handling
    (no matching commit)
  - [v18,net-next,13/14] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
    (no matching commit)
  - [v18,net-next,14/14] tcp: accecn: try to fit AccECN option with SACK
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



