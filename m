Return-Path: <linux-kselftest+bounces-4289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC384D7FB
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 03:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99989285A36
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 02:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E01BF24;
	Thu,  8 Feb 2024 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqrpW2Ky"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1351E87C;
	Thu,  8 Feb 2024 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360714; cv=none; b=AgC/CWRnc77NUNVNkDbdYaMDpSDoiJ+NViqTvaW6iy5htxRtTj4JGQvIHKjLOsljLSUdbgHIFUY9TgtPUQFZch5v6tZ1QbCOgNZWHxIchUZYGaxAM+rd5jv0CLaZX/Drxdd9Y2eYqRvzvbUfC4vxlB/sOPLOQSHFtO/LY2gBMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360714; c=relaxed/simple;
	bh=TRaK+eMQCgRIoTXtRmkqh5DXPH76+QbURKzIzXE3nww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxIN04uO0xbExALpctCAZR/f/CQUM7qCaKIUIsNP0yPeGPkgwBPMQvQ5diGLTVtQzbiGLT0MMWtahrMLyh8MakODB3sSiM3EYvJCllr9haGmeOINM1DNwGg3neMb5UOxrKAp5nw9oHnn4237m1D4lr7GVO8Dmb2B0l+SE89/Zfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqrpW2Ky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AFDC433F1;
	Thu,  8 Feb 2024 02:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707360713;
	bh=TRaK+eMQCgRIoTXtRmkqh5DXPH76+QbURKzIzXE3nww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qqrpW2KybprtlIUQFgeMU9Q/WudL2U1indKfsmGWOYhYBREMaFULy14pH1XgegCpw
	 YQM3+t2n7j0ZoAwnhCRsqcJY9uXk02ktrIqPEAfqgG4wKwWEJ231sGZu3a9EFTL/Ag
	 gHiMvKb9IOqLcUWEA6vpekyIOBpaPf/R2w9LtNwHYTpFPnNKUhmkgFEVcWihBLTR71
	 L6VMVprsxpG8jHKlDzTrqrVYTra7GFgvBBhA6BE/yUQX/CfudUcFp0g1uqBQoCUXaD
	 Xpk19kUFc1recipdxjQlnN6xT98O0qdYxVKhc1nGueAQf65Qyi1/Uaiwlz6v4zzbdd
	 Crk+Dt10Z5eTQ==
Date: Wed, 7 Feb 2024 18:51:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Willem de
 Bruijn <willemb@google.com>, Coco Li <lixiaoyan@google.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: cope with slow env in gro.sh test
Message-ID: <20240207185151.4ea8a342@kernel.org>
In-Reply-To: <20240207184252.5d7327fa@kernel.org>
References: <117a20b1b09addb804b27167fafe1a47bfb2b18e.1707233152.git.pabeni@redhat.com>
	<20240207184252.5d7327fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 18:42:52 -0800 Jakub Kicinski wrote:
> On Tue,  6 Feb 2024 16:27:40 +0100 Paolo Abeni wrote:
> > The gro self-tests sends the packets to be aggregated with
> > multiple write operations.
> > 
> > When running is slow environment, it's hard to guarantee that
> > the GRO engine will wait for the last packet in an intended
> > train.
> > 
> > The above causes almost deterministic failures in our CI for
> > the 'large' test-case.
> > 
> > Address the issue explicitly ignoring failures for such case
> > in slow environments (KSFT_MACHINE_SLOW==true).
> > 
> > Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note that the fixes tag is there mainly to justify targeting the net
> > tree, and this is aiming at net to hopefully make the test more stable
> > ASAP for both trees.
> > 
> > I experimented with a largish refactory replacing the multiple writes
> > with a single GSO packet, but exhausted by time budget before reaching
> > any good result.  
> 
> It does make things a lot more stable, but there was still a failure
> recently:
> 
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/455661/36-gro-sh/stdout
> 
> :(

Ah, sorry, I missed the v2. That must have been between v1 and v2.

