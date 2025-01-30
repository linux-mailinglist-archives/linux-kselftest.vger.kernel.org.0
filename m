Return-Path: <linux-kselftest+bounces-25415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D64A22BAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 11:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FD83A859F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28C1BBBDD;
	Thu, 30 Jan 2025 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNGCKl4S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49759185955;
	Thu, 30 Jan 2025 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233351; cv=none; b=AGuNKJx9hNEQvxR/4VRw94NQoPBzlMZ7MfL2+EPWLbL7nYFne7Yc0rIsg7t/WUwKYp216yusR1ib7UTZEs2uFGyiQVlXyFuPJU2Ri9PlRZHjCSLa1HSc6auG95Oz8RR/F95uKnD989rrc92eHt9xJorQrFs5pTYVK54ZJx0kWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233351; c=relaxed/simple;
	bh=8JZcVpcGWcqfEFuX82FHVX+6WV6k8ISLrVwBtu4Esoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3ILwKm0eNaJbMUgLxE5iZDi12ekqbIM78+WEEcRr0umgka8EH9N6GZfy9JATlcJDNbcVTaaM9SBFHfgKXiFayKHT6mX8Xni+eSYUwMjcNODuqHTZMPk2HhNPfVEV2eIllODFaNzg4y4ByINBMeHrd0O0mQBwhuPuyhwX7HmLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNGCKl4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F456C4CED2;
	Thu, 30 Jan 2025 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738233350;
	bh=8JZcVpcGWcqfEFuX82FHVX+6WV6k8ISLrVwBtu4Esoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNGCKl4Sjf3cTNpyQiwFUw2Q3xlNGEDvKTlicGmu2Ukyk/MM4owz71fGRPSFLcAPj
	 PsfbxL+RHQpcU6tkfw6qJdOMuRO2XjjmP9ysl/vjbIedHUxox9K94sWLnFuvDYebPp
	 UJYA8EafEC6WqJwfUhqfkONziANCiVG23iQB+oFS8PsR+ZK0B4dfPovqfhkf06fsOK
	 gU2FIQypX8wdGbVUa8Sh3NFN7ICgLrQ8CWUWcjAYq+zn1qvywja5oTZBE0yzIZtJC4
	 PmhXCtsiyBRI9ZINKXMLR9DCdXeNs1i2Is9cU0/Gjkn0gX/IbSkNI/WVqOE+Fsy3ZL
	 89+xFPl/bprrQ==
Date: Thu, 30 Jan 2025 10:35:44 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rdunlap@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 1/8] netconsole: consolidate send buffers
 into netconsole_target struct
Message-ID: <20250130103544.GE113107@kernel.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-1-12a0d286ba1d@debian.org>
 <20250128161128.GB277827@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128161128.GB277827@kernel.org>

On Tue, Jan 28, 2025 at 04:11:28PM +0000, Simon Horman wrote:
> On Fri, Jan 24, 2025 at 07:16:40AM -0800, Breno Leitao wrote:
> > Move the static buffers from send_msg_no_fragmentation() and
> > send_msg_fragmented() into the netconsole_target structure. This
> > simplifies the code by:
> > - Eliminating redundant static buffers
> > - Centralizing buffer management in the target structure
> > - Reducing memory usage by 1KB (one buffer instead of two)
> > 
> > The buffer in netconsole_target is protected by target_list_lock,
> > maintaining the same synchronization semantics as the original code.
> > 
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netconsole.c | 29 +++++++++++++++--------------
> >  1 file changed, 15 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..1a78704681184673f5c1ba8ae665e46751384293 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -137,6 +137,8 @@ struct netconsole_target {
> >  	bool			extended;
> >  	bool			release;
> >  	struct netpoll		np;
> > +	/* protected by target_list_lock */
> > +	char			buf[MAX_PRINT_CHUNK];
> 
> nit: buf should also be added to the Kernel doc for this structure.
> 
> ...

Hi Breno,

With that fixed feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>


