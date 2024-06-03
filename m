Return-Path: <linux-kselftest+bounces-11123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC48D881C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 19:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF6B2849EE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4C13776A;
	Mon,  3 Jun 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1Cuo7J1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82F28382;
	Mon,  3 Jun 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436433; cv=none; b=WziCHoqP17BHzZHCa3RG/ZwpBFqsy9IKg3GrvWDGOToSPs7e5UQ0irJhJlg9euykwrHowyju/RKaE8x+V9SOiCIEUP1CmUf//dyq2njXcPPfUdgeDdqjGYdWx9ovF/swIDj+kWf5Hm3FlYFiP56d9I0aMGeXLnPyTWGR+UbWylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436433; c=relaxed/simple;
	bh=FoURyDPuzko2n+Ilmi4+Mdy9Jz/CXQLqOKqIY4qMQjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MNjHIk1IJfYoXZFnqJeVzZSigG9dWg1OUPL8JJu67hLYgiz0Frz3multw7ekJs4YmPR2UFaqJ31usGtVFPex92Qf+TY98Y6oHkTyDxCMGU4VVc+EQhCcohitC23uT36A9ZTsV59PIQ+fJwirRRG75c33hlEUn4HknmKljcsDF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1Cuo7J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96B4EC4AF07;
	Mon,  3 Jun 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717436431;
	bh=FoURyDPuzko2n+Ilmi4+Mdy9Jz/CXQLqOKqIY4qMQjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U1Cuo7J1d8ChoXYcaqX3iMHMXmn3VbzxeqaOvCT/6HJWiJd3iIxLb4QOLeDAdmqr5
	 Q9Y9ERCzKWcukfKGGdx036U3AU3aqTQj6GCoqhU4ypn8QmbUklgtW7jvD/dpPa8y+j
	 b58n3PImXSYytAGnBKLPn58OdBmfYhqf1JJsjJFwVjw1y3DOvlek6dDvdPd7wMVtJw
	 Ci1ODKi9W7n6YZY2yrRe6w4ezBUdBO6l5MItoims7HrtBhoygqzW8CNxlQKy/sv6NI
	 qpJoMD/yg30K992bjdReWZlxEYeUJaARouyXLK3hTEHx4gFopdk6BWqk6pohk9JbUg
	 Gq/zvS5Jw18wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B360C32766;
	Mon,  3 Jun 2024 17:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/8] fixes for test_sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171743643149.23091.13857795050492444996.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 17:40:31 +0000
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1716446893.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 jakub@cloudflare.com, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 23 May 2024 14:49:56 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patchset contains some fixes and improvements for test_sockmap.
> 
> 3-5: switching attachments to bpf_link as Jakub suggested in [1].
> 1-2, 6-8: Small fixes.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/8] selftests/bpf: Fix tx_prog_fd values in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/d95ba15b9784
  - [bpf-next,2/8] selftests/bpf: Drop duplicate definition of i in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/a9f0ea175948
  - [bpf-next,3/8] selftests/bpf: Use bpf_link attachments in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/3f32a115f61d
  - [bpf-next,4/8] selftests/bpf: Replace tx_prog_fd with tx_prog in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/24bb90a42633
  - [bpf-next,5/8] selftests/bpf: Drop prog_fd array in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/467a0c79b551
  - [bpf-next,6/8] selftests/bpf: Fix size of map_fd in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/dcb681b659f2
  - [bpf-next,7/8] selftests/bpf: Check length of recv in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/de1b5ea789dc
  - [bpf-next,8/8] selftests/bpf: Drop duplicate bpf_map_lookup_elem in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/49784c797932

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



