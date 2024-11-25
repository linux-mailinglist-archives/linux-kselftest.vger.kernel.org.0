Return-Path: <linux-kselftest+bounces-22514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CCC9D8E59
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 23:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7034285747
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 22:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFE81CB31D;
	Mon, 25 Nov 2024 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ffjzy5xt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7772190059;
	Mon, 25 Nov 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572621; cv=none; b=uDcEC1U2C6POaZ1ruLJ/v9aEjISdUBEjgO5Z6ui7B3SS+MqbpwVixTUceSmRmvXRqemBBvjobNSmTaOix8YO99CZETFlO7HJAyhQqe6lg/FynhCTPRZpLjNZVgyuKSp1Za6g1lS8eNxAIIMA9pXGDEKB6IfsKsvLidSuaT4pzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572621; c=relaxed/simple;
	bh=rWtYjNxuIiUd82EVHv+ephFxQzacj/HVMsSoNMYp/F0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IfD6I/aSsJTeC/Sc4qWQ7eE+DXXijuEt44XOmq6FMjNxUPqaChAvW61TQLu4uZ1iMm1mKF/rKERUxVTm9RxmvtHTTEt0Pn/gIOvZ392A4x+Bvch/DbOOZDPufqQv5BvsxK/2fJnZDnRXnhQxYF68Xrv4EpDrIZ8irEW+LlaiCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ffjzy5xt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0E7C4CECE;
	Mon, 25 Nov 2024 22:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732572620;
	bh=rWtYjNxuIiUd82EVHv+ephFxQzacj/HVMsSoNMYp/F0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ffjzy5xtwVIArgv67W6oLB01Lgyyu51uMo/mmJk6Qo+eMwJ8WsNSqvDuU+gCVwFj5
	 Rng1p2pq5NWrvBA2eblmt9TpbP3U5Kmk9eE/qe56soRupcC3eeyc9h2Mmm1wBRdxXq
	 VmcPWX2JEtL5bHe4qJW8vcvTmpDYybRFbxyfzRiXIgKPJ214aTAiF10bVloMIWdr6q
	 MWAFURea45kAI1ALtpEM3lPs0jMFuRHNULiNf8Xj8Ny9sUX8K4AAL37ZU6uiK3s98R
	 J3xSTkYuaNDLEehcad1PWVi39bVCBgpCXKOfn72IeFf0fwYIZvEeOqFDtHe5D8Bd7i
	 /J49Q9tw+WItw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34E9C3809A00;
	Mon, 25 Nov 2024 22:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/14] selftests/bpf: migrate
 test_flow_dissector.sh to test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173257263300.4052918.4072302246034568900.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 22:10:33 +0000
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
In-Reply-To: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 bastien.curutchet@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 20 Nov 2024 08:43:10 +0100 you wrote:
> Hello,
> this is the revision 3 of test_flow_dissector_migration.sh into
> test_progs. This revision addresses comments from Stanislas, especially
> about proper reuse of pseudo-header checksuming in new network helpers.
> 
> There are 2 "main" parts in test_flow_dissector.sh:
> - a set of tests checking flow_dissector programs attachment to either
>   root namespace or non-root namespace
> - dissection test
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/14] selftests/bpf: add a macro to compare raw memory
    https://git.kernel.org/bpf/bpf-next/c/4d43fadb7224
  - [bpf-next,v3,02/14] selftests/bpf: use ASSERT_MEMEQ to compare bpf flow keys
    https://git.kernel.org/bpf/bpf-next/c/a4368790be93
  - [bpf-next,v3,03/14] selftests/bpf: replace CHECK calls with ASSERT macros in flow_dissector test
    https://git.kernel.org/bpf/bpf-next/c/00959b217553
  - [bpf-next,v3,04/14] selftests/bpf: re-split main function into dedicated tests
    https://git.kernel.org/bpf/bpf-next/c/849a01d9be57
  - [bpf-next,v3,05/14] selftests/bpf: expose all subtests from flow_dissector
    https://git.kernel.org/bpf/bpf-next/c/e34fa9a43e8a
  - [bpf-next,v3,06/14] selftests/bpf: add gre packets testing to flow_dissector
    https://git.kernel.org/bpf/bpf-next/c/1e1351e8afb3
  - [bpf-next,v3,07/14] selftests/bpf: migrate flow_dissector namespace exclusivity test
    https://git.kernel.org/bpf/bpf-next/c/284ed00a59dd
  - [bpf-next,v3,08/14] selftests/bpf: Enable generic tc actions in selftests config
    https://git.kernel.org/bpf/bpf-next/c/69251a92c54d
  - [bpf-next,v3,09/14] selftests/bpf: move ip checksum helper to network helpers
    https://git.kernel.org/bpf/bpf-next/c/746b1cd32e1b
  - [bpf-next,v3,10/14] selftests/bpf: document pseudo-header checksum helpers
    https://git.kernel.org/bpf/bpf-next/c/89fa46c107c5
  - [bpf-next,v3,11/14] selftests/bpf: use the same udp and tcp headers in tests under test_progs
    https://git.kernel.org/bpf/bpf-next/c/c5749a3ac71b
  - [bpf-next,v3,12/14] selftests/bpf: add network helpers to generate udp checksums
    https://git.kernel.org/bpf/bpf-next/c/6cc18e3ae2a3
  - [bpf-next,v3,13/14] selftests/bpf: migrate bpf flow dissectors tests to test_progs
    https://git.kernel.org/bpf/bpf-next/c/b15f80966c04
  - [bpf-next,v3,14/14] selftests/bpf: remove test_flow_dissector.sh
    https://git.kernel.org/bpf/bpf-next/c/1d8ef56c31c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



