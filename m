Return-Path: <linux-kselftest+bounces-12245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBCA90EAE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC83B2667A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F59142E96;
	Wed, 19 Jun 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1AOlkB5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC113FD95;
	Wed, 19 Jun 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799629; cv=none; b=It+xAISMPa9FQh5EJqV+cfuXG79sG/EFCYXKKJKk/KTDDrJf3074iK2Yu1UbkL8uK4dzQixYM9BlN+l2BjGyVSoLPDK1PwbiFGwJqrRHXtHVFAACGZjpqvUDwuPBMAZjDm947T3BKo0YVvrrls3kwbkAO7KMttfuEggwOB7eSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799629; c=relaxed/simple;
	bh=67uiRKjRxfjxp4Hfyr6l4u8S8EnHSg2ftC1VpGFi5OA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Af49ub6sHJ+0UarFx6cJky/0MEOfQit3a/k2Gz1vfloJaSiIjV0Eco+3fqsW2zrYBy5wEt1phRoZ1XB2FNuKh8fbgemSbwMz5vlgaMa44twEHiPTLrZ89UaxTog9qTnz/6lCpjId1xnvXMgcju1BRAUEs67wDcF0OnvIu/i3oGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1AOlkB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61B9DC4AF49;
	Wed, 19 Jun 2024 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718799628;
	bh=67uiRKjRxfjxp4Hfyr6l4u8S8EnHSg2ftC1VpGFi5OA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V1AOlkB57E/hyTVOMzi98x5gGkiu5B77CC9Ne+zTj4t7ENRHrjz/j5x6phGH2Z0ku
	 gqcZG4x8FkPncbvNSFeePYzAh9Ytwn07U+TG9HzsVWTT3IP5puWSpxj00bQJgQRy2K
	 PlchVpt7x2NPsSS7bLvZdigcxz3s5Z3P/23eCUMXCa52+bYGzisYkuorKAYk4veCKi
	 rsO/j3SFv9l5Pj6opP7wBY7/n+Cx3lD5v2kKdE9uO1gm4wPETGT0QIB0XvPdfdVS9h
	 JK+gzf1XE0bAyVCRXvdkaYWzGmFxBpCU+ibGvyk8n7BQowDQdx7MyFkveubIR27Lce
	 5ENSusS7BJU+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D138C4361A;
	Wed, 19 Jun 2024 12:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: openvswitch: Set value to nla flags.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171879962830.21133.9093342001596634456.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 12:20:28 +0000
References: <20240618072922.218757-1-amorenoz@redhat.com>
In-Reply-To: <20240618072922.218757-1-amorenoz@redhat.com>
To: =?utf-8?q?Adri=C3=A1n_Moreno_=3Camorenoz=40redhat=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, aconole@redhat.com, pshelar@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 18 Jun 2024 09:29:21 +0200 you wrote:
> Netlink flags, although they don't have payload at the netlink level,
> are represented as having "True" as value in pyroute2.
> 
> Without it, trying to add a flow with a flag-type action (e.g: pop_vlan)
> fails with the following traceback:
> 
> Traceback (most recent call last):
>   File "[...]/ovs-dpctl.py", line 2498, in <module>
>     sys.exit(main(sys.argv))
>              ^^^^^^^^^^^^^^
>   File "[...]/ovs-dpctl.py", line 2487, in main
>     ovsflow.add_flow(rep["dpifindex"], flow)
>   File "[...]/ovs-dpctl.py", line 2136, in add_flow
>     reply = self.nlm_request(
>             ^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/nlsocket.py", line 822, in nlm_request
>     return tuple(self._genlm_request(*argv, **kwarg))
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/generic/__init__.py", line 126, in
> nlm_request
>     return tuple(super().nlm_request(*argv, **kwarg))
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/nlsocket.py", line 1124, in nlm_request
>     self.put(msg, msg_type, msg_flags, msg_seq=msg_seq)
>   File "[...]/pyroute2/netlink/nlsocket.py", line 389, in put
>     self.sendto_gate(msg, addr)
>   File "[...]/pyroute2/netlink/nlsocket.py", line 1056, in sendto_gate
>     msg.encode()
>   File "[...]/pyroute2/netlink/__init__.py", line 1245, in encode
>     offset = self.encode_nlas(offset)
>              ^^^^^^^^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/__init__.py", line 1560, in encode_nlas
>     nla_instance.setvalue(cell[1])
>   File "[...]/pyroute2/netlink/__init__.py", line 1265, in setvalue
>     nlv.setvalue(nla_tuple[1])
>                  ~~~~~~~~~^^^
> IndexError: list index out of range
> 
> [...]

Here is the summary with links:
  - [v2] selftests: openvswitch: Set value to nla flags.
    https://git.kernel.org/netdev/net/c/a8763466669d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



