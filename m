Return-Path: <linux-kselftest+bounces-44544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1B7C263D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 17:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67043BBA26
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0807C2E6CD5;
	Fri, 31 Oct 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkKGO8nY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AEE22FDFF;
	Fri, 31 Oct 2025 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929103; cv=none; b=IqABLGMls5XJbPZlblc/Zix48IDkiRu/lTsbE4sC/VEku7Plva/vqlX1d5+BspXjYHdROLkO9DnzztTNSBlh1U17SE2OlBTX0lrTF4tlwwI1hrq1XGajQJxn1v0IRcUjEbtclDYA1h98wb/x7tROdtZc4SKxRu6SFGGFuIghOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929103; c=relaxed/simple;
	bh=uIS7zBDWfdQJx8qntBb7S24DkB/hxR9MvYC9OYo5Ts8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HjA1ikuTHfScfNmELpiKRndhKZSXJrEJnMovDrYm/DZ5k5Rdes79T0NmRiCcTJhjf4MACI+B7TQhOAKXVx4GMxtwgn1w3tN6CDKYXf2FaC+WoIl7WEnJmyqSRsJP36aSLdGGiS11iYMl0qet/uQPsBQvV80qw+V1HFXzf+KpJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkKGO8nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B00C4CEE7;
	Fri, 31 Oct 2025 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761929101;
	bh=uIS7zBDWfdQJx8qntBb7S24DkB/hxR9MvYC9OYo5Ts8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QkKGO8nYWsTjGv6z3slYoUbqY0KF1Bv0AjmWKUrPfmipdru12VXcU/QGY8wurh7uJ
	 XlkcH8XeM5J+jkX3LBdio98aaWdtM8oo1xSJCF5pBm0ugWoGkr9jusDL92GWCSN+r7
	 76ATEboGLngKG1SA9GwqxTCE1jqaOKc9OrVJIrD8pIQ+X/Ky5DwxsK7rPSot3+WI6d
	 mftswOZtmwrI09FTyAgHY0zlW79MPgPFqtG+2or/ngeA2idt/TAX2/Z3sSuf5U80F8
	 q5sbCY37TgUYOcpT5OCW5hKL+NL0T3vKhWaoe5v23iRfGzrwpViJFZqtXvSbuqQkK9
	 3+caJoTbvej+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F1D3A8256F;
	Fri, 31 Oct 2025 16:44:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176192907800.534773.1083705735783093321.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 16:44:38 +0000
References: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
In-Reply-To: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
To: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 31 Oct 2025 09:04:36 +0100 you wrote:
> Hi all,
> 
> The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
> are defined in xksxceiver.c. Since this script is used to test real
> hardware, the goal here is to leave it as it is, and only integrate the
> tests that run on veth peers into the test_progs framework.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,01/15] selftests/bpf: test_xsk: Split xskxceiver
    https://git.kernel.org/bpf/bpf-next/c/3ab77f35a75e
  - [bpf-next,v7,02/15] selftests/bpf: test_xsk: Initialize bitmap before use
    https://git.kernel.org/bpf/bpf-next/c/2233ef8bba81
  - [bpf-next,v7,03/15] selftests/bpf: test_xsk: Fix __testapp_validate_traffic()'s return value
    https://git.kernel.org/bpf/bpf-next/c/cadc0c1fd79c
  - [bpf-next,v7,04/15] selftests/bpf: test_xsk: fix memory leak in testapp_stats_rx_dropped()
    https://git.kernel.org/bpf/bpf-next/c/d66e49ffa020
  - [bpf-next,v7,05/15] selftests/bpf: test_xsk: fix memory leak in testapp_xdp_shared_umem()
    https://git.kernel.org/bpf/bpf-next/c/bea4f03897c0
  - [bpf-next,v7,06/15] selftests/bpf: test_xsk: Wrap test clean-up in functions
    https://git.kernel.org/bpf/bpf-next/c/e3dfa0faf1f7
  - [bpf-next,v7,07/15] selftests/bpf: test_xsk: Release resources when swap fails
    https://git.kernel.org/bpf/bpf-next/c/f477b0fd75f5
  - [bpf-next,v7,08/15] selftests/bpf: test_xsk: Add return value to init_iface()
    https://git.kernel.org/bpf/bpf-next/c/e645bcfb16ea
  - [bpf-next,v7,09/15] selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
    https://git.kernel.org/bpf/bpf-next/c/f12f1b5d14b0
  - [bpf-next,v7,10/15] selftests/bpf: test_xsk: Don't exit immediately when gettimeofday fails
    https://git.kernel.org/bpf/bpf-next/c/3f09728f9080
  - [bpf-next,v7,11/15] selftests/bpf: test_xsk: Don't exit immediately when workers fail
    https://git.kernel.org/bpf/bpf-next/c/5b2a757a1619
  - [bpf-next,v7,12/15] selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
    https://git.kernel.org/bpf/bpf-next/c/844b13a9ff54
  - [bpf-next,v7,13/15] selftests/bpf: test_xsk: Don't exit immediately on allocation failures
    https://git.kernel.org/bpf/bpf-next/c/7a96615f2e2d
  - [bpf-next,v7,14/15] selftests/bpf: test_xsk: Isolate non-CI tests
    https://git.kernel.org/bpf/bpf-next/c/75fc630867bb
  - [bpf-next,v7,15/15] selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework
    https://git.kernel.org/bpf/bpf-next/c/d1aec26fce25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



