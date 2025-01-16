Return-Path: <linux-kselftest+bounces-24654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E8A13D0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 15:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8F6188283E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF222B8C7;
	Thu, 16 Jan 2025 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi8CmRzb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3122B8C2;
	Thu, 16 Jan 2025 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039517; cv=none; b=dxj6Vg6U3jiWPXodrZISG8JxlhgIxCipjlXMZ/GLGMiO5yihgbkz6L4MDaX5/AB4oJDjgq9hS7zCLW4sNZ05LkE8xoybM8ac+spStrHDqjouUrGvanCcexdABXSAnjvJoscCDu2ipia3jXRElyaIJsJjFLIsBP5faNEOD2EmsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039517; c=relaxed/simple;
	bh=TiVFCV4vTQJVEsmUheRI0KBsKO4lzgyHujgevy5cSzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9ug6aPL0fiG7klah7O2UVltXmwp0zOeaOYp8ZWUXUerqOkvOyHHlz2ggbc6NvtpqFSAH2jAlGs9BLmDYVtSX6MDI6iNs6+tg4j1Gaux0uRj8sEZsv3dvwLFN7otgRKmGzi1TGmW8D1ni1/fY/obFkz27J0QKzJWMe6Ga9xPuGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi8CmRzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00D9C4CED6;
	Thu, 16 Jan 2025 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737039517;
	bh=TiVFCV4vTQJVEsmUheRI0KBsKO4lzgyHujgevy5cSzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vi8CmRzb8CBVoSUqB9HzYDg/67ZbxU0snlXxRQHkxkOeaIuAg0bEfpRVSydfKweCx
	 pK2c/wNKCpB2Ki3nInDxqoJzSOXA2uL6H0xklDARcWtm+UGM0cGvXpyHCRuiGwNMh2
	 i3h+68FtiEtir5YV1wSF7/S01/8Ko10ZpxloTYHDrUmwQoOqWldcv/KIIjKz6s4Xgz
	 9zn78g28IPrdNZcJVMNe9RQMUUoxgWH3AnbFITGlFVjljDpkW1h9cjUKcARv+SYX2k
	 y/hp9gWjorObqox6cfLA7D9cqR72e2G3vBHt4ApXyhB5WIl2dv3CMoED7tb4depLtk
	 a72unD/FeDxHA==
Date: Thu, 16 Jan 2025 06:58:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, willemb@google.com, matttbe@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/net: packetdrill: make tcp buf
 limited timing tests benign
Message-ID: <20250116065835.1cc1eaac@kernel.org>
In-Reply-To: <678904353ca7e_3710bc294ef@willemb.c.googlers.com.notmuch>
References: <20250115232129.845884-1-kuba@kernel.org>
	<678904353ca7e_3710bc294ef@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 08:05:57 -0500 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > The following tests are failing on debug kernels:
> > 
> >   tcp_tcp_info_tcp-info-rwnd-limited.pkt
> >   tcp_tcp_info_tcp-info-sndbuf-limited.pkt
> > 
> > with reports like:
> > 
> >       assert 19000 <= tcpi_sndbuf_limited <= 21000, tcpi_sndbuf_limited; \
> >   AssertionError: 18000
> > 
> > and:
> > 
> >       assert 348000 <= tcpi_busy_time <= 360000, tcpi_busy_time
> >   AssertionError: 362000
> > 
> > Extend commit 912d6f669725 ("selftests/net: packetdrill: report benign
> > debug flakes as xfail") to cover them.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Thanks.
> 
> I see that we'll still have a few flakes on dbg. Perhaps one total
> failure a day. From the following.
> 
> tcp-close-close-local-close-then-remote-fin-pkt
> tcp-ecn-ecn-uses-ect0-pkt
> tcp-eor-no-coalesce-retrans-pkt
> tcp-slow-start-slow-start-after-win-update-pkt

Argh, I missed the two above, I had the ignored cases filtered out 
when I was looking :(

> tcp-sack-sack-route-refresh-ip-tos-pkt
> tcp-ts-recent-reset-tsval-pkt
> tcp-zerocopy-closed-pkt
> 
> We'll take a look after this change whether we can make these
> more resilient. But likely also allow-list or even xfail for
> everything in dbg.

Okay.

