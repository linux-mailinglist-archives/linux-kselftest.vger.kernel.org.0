Return-Path: <linux-kselftest+bounces-44774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C5CC33826
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 01:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E043A5F4A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 00:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A165D22FE0D;
	Wed,  5 Nov 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvEGlh9U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CCF34D396;
	Wed,  5 Nov 2025 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303689; cv=none; b=FA4W8/0vkGpPNpqJRP7tHLKIE6py/gbrTE0h2Ze1krWWoqloH1BDXiWsgc3c3NOkliGqQn6di9IkwWHEC3U3vu78Q52ONrjQyd7RRW2W5rXBm4TxjL0ld/Wsrxqv3WsnXPx2AdAJBs0MM3vjgWOePj7wxaFBhwCHg94q509iq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303689; c=relaxed/simple;
	bh=hUdQ8XRuP4ZBbUv7bDFNV7qCPPD1JefMdtZdnxWjraA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DW0nvThGfALaPLGAwdpn5Vl7u/NQfNuiO8QU8vwMiqmcpFFDB7bTdXOkO7np9y0T4f1OZAj9fyYf7Tj6fwSI5pncs+Y1iGIF0WXWeMMRfLA427DJszI1KQKzwk9+m/9caTRCRDGyhfu6nKTuUj8FUPnDJOYr0V+NkL3yb5ojNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvEGlh9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E835C4CEF7;
	Wed,  5 Nov 2025 00:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303687;
	bh=hUdQ8XRuP4ZBbUv7bDFNV7qCPPD1JefMdtZdnxWjraA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pvEGlh9UW20vstKql4/xpmryNKumj2hSDGRL2pvI3bA5VULfZRiP4Yoi+5pEZZhwL
	 PGmseipdQsauexbYagQAtw9H6RtbeNs69VqxZp/cyuWXPLXFCMCqlaZeR1sc3IWQJB
	 4ux4PA99p4gm9nB/la6y3ekAJU2I0VV6WAhmrLBdMxveNJwrvm45SyuPkbK2SI8JWp
	 hp9ZbFjPQkyA5CAsaxhBGFXDd4XqpURIcZfE6b13RyAqp+9Mi2w3lBJzZomvAExEtE
	 mpeQg9J0KFoel0iofyrmpSpWOemdCfAhspQ2O+OKIoykfB/R+Q3NiBVgzzeZ83LGSY
	 ESBuYy4f+7OJQ==
Date: Tue, 4 Nov 2025 16:48:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jan Stancek
 <jstancek@redhat.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?= <ast@fiberby.net>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>, Petr
 Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <20251104164804.540a9b8d@kernel.org>
In-Reply-To: <aQnG8IYsY3oyYekf@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
	<20251029082245.128675-3-liuhangbin@gmail.com>
	<20251029163742.3d96c18d@kernel.org>
	<aQnG8IYsY3oyYekf@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 09:27:12 +0000 Hangbin Liu wrote:
> On Wed, Oct 29, 2025 at 04:37:42PM -0700, Jakub Kicinski wrote:
> > On Wed, 29 Oct 2025 08:22:44 +0000 Hangbin Liu wrote:  
> > >        -
> > >          name: dst
> > > -        type: u32
> > > +        type: binary
> > > +        display-hint: ipv4
> > >        -
> > >          name: src
> > > -        type: u32
> > > +        type: binary
> > > +        display-hint: ipv4  
> > 
> > This will be annoying For C / C++, and you didn't set the max len 
> > so I think we'll also have to malloc each time. Do we not support
> > display-hint for scalars?  
> 
> Hi Jakub,
> 
> I just realize that most of the address/src/dst in rt-addr/route are
> dual stack. The same with FRA_DST. We can't simply change binary to u32.
> So can we keep this u32 -> binary change?

Ah, should have looked at more context..
Yes, and in that case without the display-hint?

