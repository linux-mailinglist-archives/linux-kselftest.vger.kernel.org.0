Return-Path: <linux-kselftest+bounces-45828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA599C674D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 05:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09A8B4E1523
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 04:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2475727467B;
	Tue, 18 Nov 2025 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwOBy0RD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDBE221FD0;
	Tue, 18 Nov 2025 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763441774; cv=none; b=vGjHEoOas8RVQ+9Jarc12t6dOB6D+DIqLlu/eKfabW6AnANkw03cnq+FMteyTBn1KbtfEXY2NGiYifbhnuwupqm+j1qvTmxRR94+PpB1Y4Rl2UVGKeqwIaozzvpJ2ZPpRh8UjGyWlo8YA91pwZxjDQV86aryhUU2z3cSsdrjwmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763441774; c=relaxed/simple;
	bh=UbNzKg3uO0uP2IczEzdW7mQjK4HHNlIxBA54klakpZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKk78CF3gkDE4YiRmtzTHUwxTP0NA+XtBuLxjbzqYDe12vtWF/K+0IfsG3Z+L45d41k3u37YmKbr43ZhwVtAnQe0KxtQAokpHsbhb21v0wtx2ybBjDR4NJysma66O3lE26qYoisXSquCAhrYBAQ4yJ1dV7qlNR1shxfsTpi/UcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwOBy0RD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCEBC2BCB6;
	Tue, 18 Nov 2025 04:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763441772;
	bh=UbNzKg3uO0uP2IczEzdW7mQjK4HHNlIxBA54klakpZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bwOBy0RD1GaGBd63LX2pWQye6t2DELEiPjj+ZJLLGhC99O6dYvtN+uGRKH3nRlMLE
	 bPoDOH0/XFYglrq0YiX9rStdT67o6rKHuVOTQ5HVedIMyij2cKYFXbQGZCCITzwP8v
	 tPH+LpD92aiPna0eNzCCWB4You2rdDn+2MNJ9H2YnKZaDWpS3/aYFuAxqnZaZALhd5
	 xn4YQC+ajNt4fdCd5zwMje9lgjtYtSDjPjT5gVMAd4184RO3VzG6hRS9ZbvCqzgCXN
	 ecfjwgin7EbBhtgf61wy/lNNu8qVBq3E7R5WUKfWYoVHvXS6ErddLwPuj91YjQ0883
	 C4ja4wfJdRckg==
Date: Mon, 17 Nov 2025 20:56:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, sdf@fomichev.me, krakauer@google.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] selftests: drv-net: convert GRO and
 Toeplitz tests to work for drivers in NIPA
Message-ID: <20251117205609.4b0fa035@kernel.org>
In-Reply-To: <willemdebruijn.kernel.31c286e47985d@gmail.com>
References: <20251117205810.1617533-1-kuba@kernel.org>
	<willemdebruijn.kernel.31c286e47985d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 21:11:31 -0500 Willem de Bruijn wrote:
> > Note that neither GRO nor the Toeplitz test fully passes for me on
> > any HW I have access to. But this is unrelated to the conversion.  
> 
> You observed the same failures with the old and new tests? Are they
> deterministic failures or flakes.

Deterministic for Toeplitz - all NICs I have calculate the Rx 
hash the same as the test for at least one of traffic types. 
But none of them exactly as the test is expecting.
One IIRC also uses non-standard RSS indir table pattern by default.
The indirection table will be a trivial fix.

For HW-GRO I investigated less closely I mostly focused on making sure
netdevsim is solid as a replacement for veth. There was more flakiness
on HW (admittedly I was running inter-dc-building). But the failures
looked rather sus - the test was reporting that packets which were
not supposed to be coalesced got coalesced.

BTW it's slightly inconvenient that we disable HW-GRO when normal GRO
is disabled :( Makes it quite hard to run the test to check device
behavior. My current plan is to rely on device counters to check
whether traffic is getting coalesced but better ideas most welcome :(

> > This series is not making any real functional changes to the tests,
> > it is limited to improving the "test harness" scripts.
> 
> No significant actionable comments, just a few trivial typos.

Thanks!

