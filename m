Return-Path: <linux-kselftest+bounces-28100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA85A4CE49
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 23:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AB0188C4A9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BBF2356B2;
	Mon,  3 Mar 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSYAPZZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60C1DFE1;
	Mon,  3 Mar 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040999; cv=none; b=gtaNRKCVW/YSIgd69sfvv3HvvobdMnwfzxrzAaYEVRUZGynKj+UbfAWh13vEhtaLRdxI8PHjOksL5OmsTJ9ATAPDVwiMtg4/HguM5eZCumvVaEIU37xqwmAOcMyorBZiSzThrU+czr8Nt8KMV7dCB0kYzburGj5FZ3NT1nPdWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040999; c=relaxed/simple;
	bh=bkKPQ1+aiG1teab/DAAAQme9s+I+A36ytQ7sln9PR8o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lfv+MoshvUA9/XYYZDtAQiAfP0wu5N/45B0fOSB5F1GVFSzjaIXhj1HTOZ+qF95wm508t62/w0D6cWkuHOLlXD0/Jjm5CkrR/H89SYY+4x/N8L6GxKmFuk1GZYN46wvMWUgpF3M2aCOPlHv75wx05bk8Ht07qoDLvv7pClvBbNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSYAPZZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB408C4CED6;
	Mon,  3 Mar 2025 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040998;
	bh=bkKPQ1+aiG1teab/DAAAQme9s+I+A36ytQ7sln9PR8o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uSYAPZZ28oBsjc2EOl6zT8rCHAt7gxktN7etVU93yhYRI4+QrdXVUfw1RnNINiYNo
	 Yk1BTdAiEOH2t/XDNlApeKeIPq7Na6ak08AcR0C//+q6S1uRDgNCNyHsS4kfT4Fk6b
	 4mGQ+HOBNZdvhvPh4H6OsvN2IGRfeCS5lMnGXYU+jYlAkXfnhqJIoxGr0xTfaU3+CT
	 SrzZC2q94rIbg07HMIbB50MgL5lBA24HrvtMKHi13vDfn0WU6E712rMhsRKnF6F1ns
	 K2/TZz2FCE0wyPZTu6B6g8FycHXVcp0T0Jg5EYRNhdsePLqwP01K52I+FITZtpOZuq
	 FSMljipK3/aGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2B3809A8F;
	Mon,  3 Mar 2025 22:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/10] selftests/bpf: Migrate test_tunnel.sh to
 test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174104103150.3737563.4806214679115746999.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 22:30:31 +0000
References: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
In-Reply-To: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
To: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 03 Mar 2025 09:22:48 +0100 you wrote:
> Hi all,
> 
> This patch series continues the work to migrate the *.sh tests into
> prog_tests framework.
> 
> The test_tunnel.sh script has already been partly migrated to
> test_progs in prog_tests/test_tunnel.c so I add my work to it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/10] selftests/bpf: test_tunnel: Add generic_attach* helpers
    https://git.kernel.org/bpf/bpf-next/c/6829f3c51baf
  - [bpf-next,v2,02/10] selftests/bpf: test_tunnel: Add ping helpers
    https://git.kernel.org/bpf/bpf-next/c/7289e59a7667
  - [bpf-next,v2,03/10] selftests/bpf: test_tunnel: Move gre tunnel test to test_progs
    https://git.kernel.org/bpf/bpf-next/c/08d20eaa0727
  - [bpf-next,v2,04/10] selftests/bpf: test_tunnel: Move ip6gre tunnel test to test_progs
    https://git.kernel.org/bpf/bpf-next/c/1ea01a806e4c
  - [bpf-next,v2,05/10] selftests/bpf: test_tunnel: Move erspan tunnel tests to test_progs
    https://git.kernel.org/bpf/bpf-next/c/0ecd1e9d3237
  - [bpf-next,v2,06/10] selftests/bpf: test_tunnel: Move ip6erspan tunnel test to test_progs
    https://git.kernel.org/bpf/bpf-next/c/cae41f74b778
  - [bpf-next,v2,07/10] selftests/bpf: test_tunnel: Move geneve tunnel test to test_progs
    https://git.kernel.org/bpf/bpf-next/c/d89542d2534f
  - [bpf-next,v2,08/10] selftests/bpf: test_tunnel: Move ip6geneve tunnel test to test_progs
    https://git.kernel.org/bpf/bpf-next/c/8d8609430576
  - [bpf-next,v2,09/10] selftests/bpf: test_tunnel: Move ip6tnl tunnel tests to test_progs
    https://git.kernel.org/bpf/bpf-next/c/680a75248df7
  - [bpf-next,v2,10/10] selftests/bpf: test_tunnel: Remove test_tunnel.sh
    https://git.kernel.org/bpf/bpf-next/c/c8d6d78cea6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



