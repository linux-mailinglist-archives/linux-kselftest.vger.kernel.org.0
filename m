Return-Path: <linux-kselftest+bounces-38419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB628B1CD5D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 22:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C0B161C0D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 20:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDCC1C862D;
	Wed,  6 Aug 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8FKy+Jr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E951EA80;
	Wed,  6 Aug 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511636; cv=none; b=QgDxwJ723EQ02JJczlSZEw5BHIBFVnplkB2Aa+a5IcuYFkfwKLx0xsroVioFdfm5HR83OzXm3bfVAKJR9EQI5MrCnXy/fh/l7EG88C3+nUU8qlHuAWMHhclx8aJjnvNA7AxZeurb3zVXog0P2DtM1U9TkVb0DNs5bRX/PYeXgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511636; c=relaxed/simple;
	bh=s5Z2b74HI9MI/0XxjwGg/yU3unXf8FlOB1C/jaNAbKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXPtKaxMIgDjRQxy+tYaECi+GGXlmOyRhJ3D0SWraeThdqoV6qp04uo48HtYd/NqrMuuHiufSD7UyimqG4ShE3aaLPZJqQGDYJMGx7pq3ADPOMwYwnypinPyKy9inLXQZAPb8Mavr6eeHuMn0JGY8HX58Y3XgY771k8XcKb82v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8FKy+Jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90596C4CEE7;
	Wed,  6 Aug 2025 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754511636;
	bh=s5Z2b74HI9MI/0XxjwGg/yU3unXf8FlOB1C/jaNAbKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A8FKy+Jrk6et1gnhPu5/2vTRUeY9ZxU77v0Lisz8T4pSOsffmZIJlxe94uL/VWJ4L
	 y32dliwCzfcb+MYSexT9BMyJoET3BfRiZeBBs4BJcM0oF2be/rR+j1kN++PU5nlFx8
	 XxUP6nHo+Bbs0zoU0bHPCxWUEJBof9AhOLzygUF2lxWEuQlVL302jK3iqZglKxwW6i
	 nVROeXamoqdpZBvAAw1X/MYpaTUYDzPCAKPgNQCnTI+uoIqpPWbvjpiVN8gQnGE10j
	 51H2Hd4xra3kNCbl28RsHmxqOrpYS0hDdCyC4tcF70bGTVnBRDWX3tbPW2NTpssuV+
	 jcyKIfYUHD0SQ==
Date: Wed, 6 Aug 2025 13:20:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com,
 john.fastabend@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, will@willsroot.io,
 savy@syst3mfailure.io
Subject: Re: [PATCH net 1/2] tls: handle data disappearing from under the
 TLS ULP
Message-ID: <20250806132034.55292365@kernel.org>
In-Reply-To: <CANn89iKvW8jSrktWVd6g4m8qycp32-M=gFxwZRJ3LZi1h2Q80Q@mail.gmail.com>
References: <20250806180510.3656677-1-kuba@kernel.org>
	<CANn89iKvW8jSrktWVd6g4m8qycp32-M=gFxwZRJ3LZi1h2Q80Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Aug 2025 11:35:28 -0700 Eric Dumazet wrote:
> > TLS expects that it owns the receive queue of the TCP socket.
> > This cannot be guaranteed in case the reader of the TCP socket
> > entered before the TLS ULP was installed, or uses some non-standard
> > read API (eg. zerocopy ones). Make sure that the TCP sequence
> > numbers match between ->data_ready and ->recvmsg, otherwise
> > don't trust the work that ->data_ready has done.
> >
> > Signed-off-by: William Liu <will@willsroot.io>
> > Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>  
> 
> I presume you meant Reported-by tags ?

Oops..

> > Link: https://lore.kernel.org/tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wxDPJXfIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=@syst3mfailure.io
> > Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  include/net/tls.h  |  1 +
> >  net/tls/tls.h      |  2 +-
> >  net/tls/tls_strp.c | 17 ++++++++++++++---
> >  net/tls/tls_sw.c   |  3 ++-
> >  4 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/tls.h b/include/net/tls.h
> > index 857340338b69..37344a39e4c9 100644
> > --- a/include/net/tls.h
> > +++ b/include/net/tls.h
> > @@ -117,6 +117,7 @@ struct tls_strparser {
> >         bool msg_ready;
> >
> >         struct strp_msg stm;
> > +       u32 copied_seq;  
> 
> Can a 2^32 wrap occur eventually ?

Hm, good point. Is it good enough if we also check it in data_ready?
That way we should notice that someone is eating our data before
the seq had a chance to wrap?

