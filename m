Return-Path: <linux-kselftest+bounces-13347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBCF92B263
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 10:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8363F1F231FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9E154420;
	Tue,  9 Jul 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwQg1hoD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA008153BC3;
	Tue,  9 Jul 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514431; cv=none; b=G+morYonmuBEFeNpMEk80zGJ5YF/YHpI6fUtVAvwqlp6iXTjqulAbOPuKq5+mNlVKhohwCJ/m71xif0F5VmCfxQYRbVOaP66lY2Zf1x/IrSCdit9ZPTKnBnO5D0uPcqn0Je7YWeUg3/RUNG89nuxIyMkZ178/gXAFlUhnyZcX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514431; c=relaxed/simple;
	bh=bBCdOwfQpMWDpEE7nDbKjEd17zz9lTJd8l+UG3C2kB0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FpMwnTU8oCdNzuO20YdBtF2EcLf5EMEQ2NcVkeK583tmSODTHVPDv40D5xXarPDJBHxNjTh+kdiay1eyBOOb4VnsOGlSB+IC9Tr27KCy091W+9g1ihpPqGJ+P9WNwyKIkuxIRws8j0nqTBl3L4m4MGRrLodSDcIdhdgQ74dgPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwQg1hoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C1F6C4AF0A;
	Tue,  9 Jul 2024 08:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720514430;
	bh=bBCdOwfQpMWDpEE7nDbKjEd17zz9lTJd8l+UG3C2kB0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dwQg1hoDCEKSN6VZgQZIUrleFP7jePs20Uhn01giOPCMZTNllUgssPBA+gO8Op6gL
	 2UvLETrifavSaIC7dUDY4tSTF0W1RfxxSMVJ5q2S8JU+zXnFLtTrVoEU6OKxA2z3QS
	 w1Ifo3bV3CqVSYn0zlbd4J37m/RI+nuFS8TKPTtEz+Gg5q+YZJnM8SRKTjXp1NRDoA
	 Hg+mzk61ne7U49NlNL/qfPSFFYUrV5+mKWlH1EJM73jbzwP0VguMx5N6YOwovCiF1y
	 v11Y7P7vDvmWq9ZUQkCTyRx7MJTjxjQpAl98f4+Y05OIjTaDby/99jBsfQrw/sj66j
	 RpFoa9er3Llww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88D4AC4332E;
	Tue,  9 Jul 2024 08:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] skmsg: skip zero length skb in sk_msg_recvmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172051443055.11402.15346056734858431642.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 08:40:30 +0000
References: <e3a16eacdc6740658ee02a33489b1b9d4912f378.1719992715.git.tanggeliang@kylinos.cn>
In-Reply-To: <e3a16eacdc6740658ee02a33489b1b9d4912f378.1719992715.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, tanggeliang@kylinos.cn, dsahern@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, yatsenko@meta.com,
 miaxu@meta.com, yuran.pereira@hotmail.com, chenhuacai@kernel.org,
 yangtiezhu@loongson.cn, alibuda@linux.alibaba.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  3 Jul 2024 16:39:31 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Run this BPF selftests (./test_progs -t sockmap_basic) on a Loongarch
> platform, a kernel panic occurs:
> 
> '''
> Oops[#1]:
> CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE  6.10.0-rc2+ #18
> Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018
>    ... ...
>    ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
>   ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
>  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
>  PRMD: 0000000c (PPLV0 +PIE +PWE)
>  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
> ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
>  BADV: 0000000000000040
>  PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
> Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE xt_conntrack
> Process test_progs (pid: 2824, threadinfo=0000000000863a31, task=...)
> Stack : ...
>         ...
> Call Trace:
> [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
> [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
> [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
> [<90000000049aae34>] inet_recvmsg+0x54/0x100
> [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
> [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
> [<900000000481e27c>] sys_recvfrom+0x1c/0x40
> [<9000000004c076ec>] do_syscall+0x8c/0xc0
> [<9000000003731da4>] handle_syscall+0xc4/0x160
> 
> [...]

Here is the summary with links:
  - [net,v5] skmsg: skip zero length skb in sk_msg_recvmsg
    https://git.kernel.org/bpf/bpf/c/f0c180256937

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



