Return-Path: <linux-kselftest+bounces-28193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8EEA4DA04
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 11:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90457172680
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 10:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833DB1FDE06;
	Tue,  4 Mar 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZhF1WPB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B01FCFC2;
	Tue,  4 Mar 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083599; cv=none; b=sFsYSyIgABNMf7F6k7qH4ZoY7h1tBR8+PrkpUdGlOxsJU1uBnP6hopAuS43/mFOFsjDH1QVoOs5OJ6hqSW0/fw9tU8qHNsUDuozhXwxI1P05vAYJFpTMHVbWm1Gt338l4qXsViKwOeY7Xxunb+6b/mjDMemamt5wK6fj07LmX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083599; c=relaxed/simple;
	bh=UE2pwi8o/Z6BXeK0+hDRapUdyRJJHQ7+IiwgluOIIFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QWyPexJxdMwHNm/TJRDR16ri4HVEH9csJeS1FY3Fx8pgRBLN6Z80JIPzFRvPvhPsaKQFv6wRlNtVbXKS2tosw30NMDQzzTcqUQZhf0avRVuPnid8UzjXTZt+mRGQ/aGXpzu7Jg2wW8PkV0sEt+DbFHNgYYXZeFzgmxMUuvcLhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZhF1WPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CD8C4CEE5;
	Tue,  4 Mar 2025 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741083598;
	bh=UE2pwi8o/Z6BXeK0+hDRapUdyRJJHQ7+IiwgluOIIFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LZhF1WPB4LBHqfQOf+1gkgrKlLZOsLHq+WMzJd7ROiJutjZsisrSAAG3pZEwC9XAM
	 cde5XRgx34j4iEfYy0wAvMetxGi8E00m2i3FTrdw8hVvcrvF09I08/cqk124inF9Al
	 cmm7GQSrQM3JYgEo5f98vxB0H2C5Hu/shLX/I/ulqh2gXhsBZXYloommIQS5F9U8uq
	 ZH6bRSbgRD9SNgzc6r5KPYo66euMpUtAPeoXS0Aawk6F7XliEG4+pVLFvNHdIUlJQ8
	 LXRkQJvcYqjcyZE4aUKLco113W4bw+MvGktwBbRMYh89jc08pamnGS2sS/xDKSjQ7b
	 SK+uhGrO11v+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE113380AA7F;
	Tue,  4 Mar 2025 10:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/8] Some pktgen fixes/improvments (part II)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174108363151.83393.7758476435815986527.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 10:20:31 +0000
References: <20250227135604.40024-1-ps.report@gmx.net>
In-Reply-To: <20250227135604.40024-1-ps.report@gmx.net>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 pchelkin@ispras.ru, arnd@arndb.de, namcao@linutronix.de

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 27 Feb 2025 14:55:56 +0100 you wrote:
> While taking a look at '[PATCH net] pktgen: Avoid out-of-range in
> get_imix_entries' ([1]) and '[PATCH net v2] pktgen: Avoid out-of-bounds
> access in get_imix_entries' ([2], [3]) and doing some tests and code review
> I detected that the /proc/net/pktgen/... parsing logic does not honour the
> user given buffer bounds (resulting in out-of-bounds access).
> 
> This can be observed e.g. by the following simple test (sometimes the
> old/'longer' previous value is re-read from the buffer):
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/8] net: pktgen: fix mix of int/long
    https://git.kernel.org/netdev/net-next/c/90b856ae3528
  - [net-next,v8,2/8] net: pktgen: remove extra tmp variable (re-use len instead)
    https://git.kernel.org/netdev/net-next/c/7d39e01803bd
  - [net-next,v8,3/8] net: pktgen: remove some superfluous variable initializing
    https://git.kernel.org/netdev/net-next/c/80f6c198dfd5
  - [net-next,v8,4/8] net: pktgen: fix mpls maximum labels list parsing
    https://git.kernel.org/netdev/net-next/c/2b15a0693f70
  - [net-next,v8,5/8] net: pktgen: fix access outside of user given buffer in pktgen_if_write()
    https://git.kernel.org/netdev/net-next/c/c5cdbf23b84c
  - [net-next,v8,6/8] net: pktgen: fix mpls reset parsing
    https://git.kernel.org/netdev/net-next/c/4bedafa7474e
  - [net-next,v8,7/8] net: pktgen: remove all superfluous index assignements
    https://git.kernel.org/netdev/net-next/c/21d0d99aebbd
  - [net-next,v8,8/8] selftest: net: add proc_net_pktgen
    https://git.kernel.org/netdev/net-next/c/03544faad761

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



