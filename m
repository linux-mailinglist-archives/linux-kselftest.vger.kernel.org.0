Return-Path: <linux-kselftest+bounces-42705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A459CBB584F
	for <lists+linux-kselftest@lfdr.de>; Fri, 03 Oct 2025 00:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229B0483997
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 22:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B09E2746A;
	Thu,  2 Oct 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGn0BDjX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EED11CAF;
	Thu,  2 Oct 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759442595; cv=none; b=il6BCFqgIQgTGuGJuCkfCzjp4POtdccXFhGzrcKnUiFzlufH+4wd1kzeYReHwWrmuxsDMt1XK6kt07y5MSuuuYoQf7BjnLfIMEXZeNewklzauaK8BvcFuyYp6PJ75Y9an3jxWIEXJCuetbM3yEZqadokhbQdWs3a0fTOzq4g1pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759442595; c=relaxed/simple;
	bh=AVL9jcYCgw/U97bcRRjd/mK+QxM7TQ6vB3uTSaCyzss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Va6I6krzFuOTalC3HpkS6ySVxjlQOytv8qSDE6gimlxKl8LzydkV2AWlLSMQXY4qWxVeeFp4ve2dWDdOJjOelzNFt7UX66Cn6O0F6aUjrIR7b03SAyAiH3PuOQ4du68Y1fW/uw0zkd96PxvlxcnUL3VG2PdIvyN20IB13+/8csE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGn0BDjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE3BC4CEF4;
	Thu,  2 Oct 2025 22:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759442594;
	bh=AVL9jcYCgw/U97bcRRjd/mK+QxM7TQ6vB3uTSaCyzss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CGn0BDjX/gvK6yuxfsQZF6+rL6qil2xxhY9r4VOeNLaYYCSL/swKfOSIH2rlNKw3Q
	 CUofTR0AaoWEhW1+mC9qiAxaMqHTD/5zg3YyXxlLTxfbssgMefwUFi6bRIF7LDmHiU
	 SSKvn6CKQ8UuW6uKXkZ80hHYx/lRScOtkDWjUyQWtLosmWZ7g3rLwegqoa/4sv+kx/
	 FBJEhkTM6yN+gnnKiSICkiIPxPhTlKLN+NDIe/U09RMS/Yjp70AXQRC5tF3UCNZJk8
	 7lK4e3kdQGMbj+MShoZA/jCDNg/2R2gs19PrzKGrkn7UH5mJDsIKnsJCUAe5LOrmda
	 HvalriLVUaF9A==
Date: Thu, 2 Oct 2025 15:03:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Phil Sutter <phil@nwl.cc>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, jv@jvosburgh.net, olteanv@gmail.com, jiri@resnulli.us,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, kuniyu@google.com, matttbe@kernel.org,
 martineau@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 fw@strlen.de, antonio@openvpn.net, allison.henderson@oracle.com,
 petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net] selftests: net: unify the Makefile formats
Message-ID: <20251002150312.5febe755@kernel.org>
In-Reply-To: <aN7RTSbXDA32J8D2@orbyte.nwl.cc>
References: <20251002013034.3176961-1-kuba@kernel.org>
	<aN7RTSbXDA32J8D2@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Oct 2025 21:23:57 +0200 Phil Sutter wrote:
> On Wed, Oct 01, 2025 at 06:30:33PM -0700, Jakub Kicinski wrote:
> > We get a significant number of conflicts between net and net-next
> > because of selftests Makefile changes. People tend to append new
> > test cases at the end of the Makefile when there's no clear sort
> > order. Sort all networking selftests Makefiles, use the following
> > format:
> > 
> >  VAR_NAME := \
> > 	 entry1 \
> > 	 entry2 \
> > 	 entry3 \
> >  # end of VAR_NAME  
> 
> A potential problem with this format is loss of context with long lists.
> While I don't think it will cause incorrect conflict resolutions,
> appending via '+=' may ease reviews of patches:
> 
> VAR_NAME :=
> VAR_NAME += entry1
> VAR_NAME += entry2
> VAR_NAME += entry3

I think this should work, FWIW. The validation script only wants 
the subsequent lines to belong to the same VAR_NAME, so we can't mix.
But we can break the chain and start with VAR_NAME += to make the name
re-appear.

> No trailing comment needed this way. Downside is '?=' can't be used.
> 
> > Some Makefiles are already pretty close to this.  
> 
> Which is a point to stick with it.
> 
> [...]
> > diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
> > index 07b7c46d3311..daf51113c827 100644
> > --- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
> > +++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0+ OR MIT
> >  
> > -TEST_PROGS = devlink.sh \
> > +TEST_PROGS := \  
> 
> Maybe irrelevant, but assignment type changes should be avoided IMO
> (there are more cases like this one).

Doesn't seem to matter right now. We can adjust the validation script
to reject := if we find a reason.

> > +	devlink.sh \
> >  	devlink_in_netns.sh \
> >  	devlink_trap.sh \
> >  	ethtool-coalesce.sh \
> > @@ -17,5 +18,6 @@ TEST_PROGS = devlink.sh \
> >  	psample.sh \
> >  	tc-mq-visibility.sh \
> >  	udp_tunnel_nic.sh \
> > +# end of TEST_PROGS
> >  
> >  include ../../../lib.mk  
> 
> [...]
> > diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
> > index 7ec7cd3ab2cc..868ece3fea1f 100644
> > --- a/tools/testing/selftests/drivers/net/virtio_net/Makefile
> > +++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
> > @@ -1,15 +1,12 @@
> >  # SPDX-License-Identifier: GPL-2.0+ OR MIT
> >  
> > -TEST_PROGS = basic_features.sh \
> > -        #
> > +TEST_PROGS = basic_features.sh
> > 
> > -TEST_FILES = \
> > -        virtio_net_common.sh \
> > -        #
> > +TEST_FILES = virtio_net_common.sh  
> 
> These seem intentional, so change to the syntax as proposed?

I think we should support single line variables.
The formatting here used spaces so I had to change it.

