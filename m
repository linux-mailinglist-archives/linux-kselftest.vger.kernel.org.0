Return-Path: <linux-kselftest+bounces-24954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E3CA19845
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9CA164766
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACAD215072;
	Wed, 22 Jan 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddhWQ37B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA520FABC;
	Wed, 22 Jan 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737569800; cv=none; b=r6ryChI19rUzBBA6iVbePqFDOkzvq7g80CnQeu/vkRk8UGcZqUTzvK0INpIuuzZNTvsnPuwUJH8/I4ix9ufcTBn8/JI5OzloZ/4GfUSlLhS/1XxU70Ce0iYqz8k/j9xh7V4/LFkPQH+eSvjAr12JPC5MwmcnnycPt92E+geWoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737569800; c=relaxed/simple;
	bh=nMHBJP6DGCZ98w9FdbTFfjQ54r1wCssAZDyg9sL/Xkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lECBibNt3up5M5anmDpFug6ov8zLuhN5v8RLA5ibWCLT2hWmA2hlJNoknejJS5LrAyMam8spYyecCg5i5I11bBQN6xxGmUzTGL6wT5APLpedIxGVfVPOBg62sam34Suq1nhKfaZd8fRWKoFjOSr1fo0YcvkPhYzTEaTuBncfOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddhWQ37B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A9DC4CED2;
	Wed, 22 Jan 2025 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737569799;
	bh=nMHBJP6DGCZ98w9FdbTFfjQ54r1wCssAZDyg9sL/Xkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddhWQ37BtbypDwWu3QM7ijys8/KQsgYTPKRLtTEL/xsKFXER7lKp9RxFwd7n/JlWZ
	 9gVaV/xGHhSkRXdo0QwCP8aE2OlK9Z2k2ZVKFRmmwFWaQ8DYiVr6bHdYFElgcNSUXL
	 tsNpaUZRtjGVmxE4s98GQNzNOdPD4P9+Sus6uCaguO0fEwKXH3ywAkDIf12X6V5TAC
	 0Pr60qipMBrdpxINN/XdqHAL+rNd/agPM33AvGtwv1Di1KaZ7LTngXx6jMB/oapG/6
	 9FB4z7rMuAhV7MFcTetEZMivzr/UJZlnnTk3Bg4WAxPAm9TJirlmM/VjfZZ0ax8lvK
	 rBuFFn3M+7RRQ==
Date: Wed, 22 Jan 2025 18:16:35 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH net-next v2 0/8] Some pktgen fixes/improvments
Message-ID: <20250122181635.GG395043@kernel.org>
References: <20250122144110.619989-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122144110.619989-1-ps.report@gmx.net>

On Wed, Jan 22, 2025 at 03:41:02PM +0100, Peter Seiderer wrote:
> While taking a look at '[PATCH net] pktgen: Avoid out-of-range in
> get_imix_entries' ([1]) and '[PATCH net v2] pktgen: Avoid out-of-bounds access
> in get_imix_entries' ([2], [3]) and doing some tests and code review I
> detected that the /proc/net/pktgen/... parsing logic does not honour the
> user given buffer bounds (resulting in out-of-bounds access).
> 
> This can be observed e.g. by the following simple test (sometimes the
> old/'longer' previous value is re-read from the buffer):
> 
>         $ echo add_device lo@0 > /proc/net/pktgen/kpktgend_0
> 
>         $ echo "min_pkt_size 12345" > /proc/net/pktgen/lo\@0 && grep min_pkt_size /proc/net/pktgen/lo\@0
> Params: count 1000  min_pkt_size: 12345  max_pkt_size: 0
> Result: OK: min_pkt_size=12345
> 
>         $ echo -n "min_pkt_size 123" > /proc/net/pktgen/lo\@0 && grep min_pkt_size /proc/net/pktgen/lo\@0
> Params: count 1000  min_pkt_size: 12345  max_pkt_size: 0
> Result: OK: min_pkt_size=12345
> 
>         $ echo "min_pkt_size 123" > /proc/net/pktgen/lo\@0 && grep min_pkt_size /proc/net/pktgen/lo\@0
> Params: count 1000  min_pkt_size: 123  max_pkt_size: 0
> Result: OK: min_pkt_size=123
> 
> So fix the out-of-bounds access (and two minor findings) and add a simple
> proc_net_pktgen selftest...

Hi Peter,

Unfortunately net-next is closed at this time.

## Form letter - net-next-closed

The merge window for v6.14 has begun. Therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 3rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

--
pw-bot: deferred

