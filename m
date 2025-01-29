Return-Path: <linux-kselftest+bounces-25403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E299A22600
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 23:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E345F7A19D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A74C1E3DED;
	Wed, 29 Jan 2025 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY61jMRw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D29A1D9320;
	Wed, 29 Jan 2025 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738188007; cv=none; b=I8KxRgsVrQqCg0HRxaiNswqoR3ChBwj0ngWziCFask5/MHidk8ftyf5gpYSPZuinPhpLGOAFbQbnaRWXfcDK/3hIZYQXiTxVg+kxSwu3XK2r2Qo/inYJj6U9Q+7pxASv3wx5e5Gid0W37UsALTKldzqq3o1/hUmyVNKeP9S6Rr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738188007; c=relaxed/simple;
	bh=HJFCp6CCneTiAH22wqHM4Owd5WMOFA50lFeANMb2dzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qa5TuPBpx6XdB+bBU7+ao1dOhC5Dm6BIws9UEbd2Gmk5TOgJ83EGGjFPZPEWv7H3I1PnO9/uCCyfGTshYjPFZZHos0cMDyflb2ODo6xxSv6uFvYHz1PQsT1/A284JzR4wh/oIshkyXhswVUFdq/wFWJTivRnoUYV5Dj2+bwIIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY61jMRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAA1C4CED1;
	Wed, 29 Jan 2025 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738188006;
	bh=HJFCp6CCneTiAH22wqHM4Owd5WMOFA50lFeANMb2dzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IY61jMRwFcspsttzsd+sjd+E1y7o1uCTxGToBezBWg3Cr2ruHhMtufLL/igyi7tCb
	 tasXQ9SLVD95YFfY9RqKUkjx6+/JtI9cTLOM0npn+tDIbo+hhvN80yjJ5zVbAvjXGa
	 n5eJCDcSaNXk0yjqXzlosXxni9650c2mcQkugr2LTDxPFnxtd/B8LwkRm9XPPCvI7u
	 RHz+mGNAD2sebfVs8p3peji33wUPF8+C4D5nfSbm7bHqKM516a1Gl4FruJ5Btu/yHl
	 g7Ggv3+U0LK9PolqP6nDJVBlny5PkPIHSS05MpqpFk1ZJfV1uZE9PtgzD9yDwLFKro
	 i9fkMxVjVSFpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB01380AA66;
	Wed, 29 Jan 2025 22:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v9 0/5] bpf: fix wrong copied_seq calculation and add
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173818803275.439997.10383700619344985358.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jan 2025 22:00:32 +0000
References: <20250122100917.49845-1-mrpre@163.com>
In-Reply-To: <20250122100917.49845-1-mrpre@163.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 song@kernel.org, andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev,
 daniel@iogearbox.net, xiyou.wangcong@gmail.com, horms@kernel.org,
 corbet@lwn.net, eddyz87@gmail.com, cong.wang@bytedance.com, shuah@kernel.org,
 mykolal@fb.com, jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me,
 kpsingh@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 22 Jan 2025 18:09:12 +0800 you wrote:
> A previous commit described in this topic
> http://lore.kernel.org/bpf/20230523025618.113937-9-john.fastabend@gmail.com
> directly updated 'sk->copied_seq' in the tcp_eat_skb() function when the
> action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> the update logic for 'sk->copied_seq' was moved to
> tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
> 
> [...]

Here is the summary with links:
  - [bpf,v9,1/5] strparser: add read_sock callback
    https://git.kernel.org/bpf/bpf/c/0532a79efd68
  - [bpf,v9,2/5] bpf: fix wrong copied_seq calculation
    https://git.kernel.org/bpf/bpf/c/36b62df5683c
  - [bpf,v9,3/5] bpf: disable non stream socket for strparser
    https://git.kernel.org/bpf/bpf/c/5459cce6bf49
  - [bpf,v9,4/5] selftests/bpf: fix invalid flag of recv()
    https://git.kernel.org/bpf/bpf/c/a0c11149509a
  - [bpf,v9,5/5] selftests/bpf: add strparser test for bpf
    https://git.kernel.org/bpf/bpf/c/6fcfe96e0f6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



