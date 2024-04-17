Return-Path: <linux-kselftest+bounces-8270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED28A8D36
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 22:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2BC1F22B0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F664597B;
	Wed, 17 Apr 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkJ1tHT2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339F79D8;
	Wed, 17 Apr 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386798; cv=none; b=KwNoiLReZRou3Hw0FMXGQBcRfmX9LYF8varODuW806oZt4Bp3GjW0YrFSB9Rit1FDmNNCOYMGb1Q9z79iiVK81bQH9BLs9V4jyfbOxucu4HJkYQ9MR5l0iZdvJdFdI9TlppYj4TKFuKrDj823nmMTlE3FAv6jNxsbRj7+2sAHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386798; c=relaxed/simple;
	bh=vpW2uBcFnTTkU4Vdy3ReQVcKp2u1xZV+wBorG7RxKjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neTCyl00IJdlz1MUNgXpsKMFOTcTKnJ9Y0ziFqNAiffFGvNYhi+HMo2HuYeld1zfbzxijgkKQxfvhVryvrb9YmZBqUwNidysmcF9j6M2zi14ru/JuZHit0F9RPKau7qzoECaH4m/FJ//2gnqpHS9VYVxgqOAwIeatRDaeRN9mZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkJ1tHT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6943BC116B1;
	Wed, 17 Apr 2024 20:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713386797;
	bh=vpW2uBcFnTTkU4Vdy3ReQVcKp2u1xZV+wBorG7RxKjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RkJ1tHT27y+k0lu2QQRUrGTpEPA5UU3iWd9URd2ZdTybNiuCSoZJcWvzIScLEJTo3
	 j2PHHyRu4FLB7fZoCfA2IziVIfmuO8kBmqRWrcMfkjT0kR6w4Wo1zZ42afTut8q4NE
	 H4KxdWsQUxkRcixhNeIf0xLD2kViqQ3efDUTiKxw+v8SifzNUCBsDSOYfRgAEHSXDF
	 xsECzz55hNl+R/no/eoZhtY9gEai/b9oJ7oFZQ2khaHbGdCNs8B+/tHeQaYr2Widzb
	 D8yF16M1VOyUYZa0O/DnxSIKz43pjAF944uhasya9+85A4NRFg8oRuuMKg4J1UFUo5
	 NTNgavSRXsFZg==
Date: Wed, 17 Apr 2024 13:46:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] selftests/net/tcp_ao: A bunch of fixes for
 TCP-AO selftests
Message-ID: <20240417134636.102f0120@kernel.org>
In-Reply-To: <CAJwJo6Yw4S1wCcimRVy=P8h0Ez0UDt-yw2jqSY-ph3TKsQVVGA@mail.gmail.com>
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
	<20240416072809.3ae7c3d3@kernel.org>
	<CAJwJo6Yw4S1wCcimRVy=P8h0Ez0UDt-yw2jqSY-ph3TKsQVVGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 19:47:18 +0100 Dmitry Safonov wrote:
> 1. [ 240.001391][ T833] Possible interrupt unsafe locking scenario:
> [  240.001391][  T833]
> [  240.001635][  T833]        CPU0                    CPU1
> [  240.001797][  T833]        ----                    ----
> [  240.001958][  T833]   lock(&p->alloc_lock);
> [  240.002083][  T833]                                local_irq_disable();
> [  240.002284][  T833]                                lock(&ndev->lock);
> [  240.002490][  T833]                                lock(&p->alloc_lock);
> [  240.002709][  T833]   <Interrupt>
> [  240.002819][  T833]     lock(&ndev->lock);
> [  240.002937][  T833]
> [  240.002937][  T833]  *** DEADLOCK ***
> 
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/537021/14-self-connect-ipv6/stderr
> 
> 2. [  251.411647][   T71] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock
> order detected
> [  251.411986][   T71] 6.9.0-rc1-virtme #1 Not tainted
> [  251.412214][   T71] -----------------------------------------------------
> [  251.412533][   T71] kworker/u16:1/71 [HC0[0]:SC0[2]:HE1:SE0] is
> trying to acquire:
> [  251.412837][   T71] ffff888005182c28 (&p->alloc_lock){+.+.}-{2:2},
> at: __get_task_comm+0x27/0x70
> [  251.413214][   T71]
> [  251.413214][   T71] and this task is already holding:
> [  251.413527][   T71] ffff88802f83efd8 (&ul->lock){+.-.}-{2:2}, at:
> rt6_uncached_list_flush_dev+0x138/0x840
> [  251.413887][   T71] which would create a new lock dependency:
> [  251.414153][   T71]  (&ul->lock){+.-.}-{2:2} -> (&p->alloc_lock){+.+.}-{2:2}
> [  251.414464][   T71]
> [  251.414464][   T71] but this new dependency connects a SOFTIRQ-irq-safe lock:
> [  251.414808][   T71]  (&ul->lock){+.-.}-{2:2}
> 
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/537201/17-icmps-discard-ipv4/stderr
> 
> 3. [ 264.280734][ C3] Possible unsafe locking scenario:
> [  264.280734][    C3]
> [  264.280968][    C3]        CPU0                    CPU1
> [  264.281117][    C3]        ----                    ----
> [  264.281263][    C3]   lock((&tw->tw_timer));
> [  264.281427][    C3]
> lock(&hashinfo->ehash_locks[i]);
> [  264.281647][    C3]                                lock((&tw->tw_timer));
> [  264.281834][    C3]   lock(&hashinfo->ehash_locks[i]);
> 
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/547461/19-self-connect-ipv4/stderr
> 
> I can spend some time on them after I verify that my fix for -stable
> is actually fixing an issue I think it fixes.
> Seems like your automation + my selftests are giving some fruits, hehe.

Oh, very interesting, I don't recall these coming up before.

We try to extract crashes but apparently we're missing lockdep splats.
I'll try to improve the extraction logic...

