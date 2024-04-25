Return-Path: <linux-kselftest+bounces-8848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AECD8B1BF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 09:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C581F2303D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 07:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931EE6CDC1;
	Thu, 25 Apr 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxEbHlTZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8526EB4A;
	Thu, 25 Apr 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030401; cv=none; b=ZARGfsWkHWtDFIo2XHlwcDv+o48BiHQJrGWcLkkcE+keMiGsPEQQ1pifHNB+zunx9w2RUkIodxaXQ4rrFvGC6EvBZu7cQxuNuP86NoS1r6iqx87c9VHydBXJv8+BUJFScIkuwAqh0RB2nYzXv9/73FrBaEWCMMa9CmGJViIH4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030401; c=relaxed/simple;
	bh=IvDFJUyMXiZoCo3+3WAO6o6mM1VGEGQ/JIWJuBcDiww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjXdHWzqGY3aWCgT6ZPsNnqQ8dSN6igSSO+SNra9UqHglbtB1FH6S5J7ub1dMhbQGRU6WoTShA78zJqPS+IjBg5mBcAkYv1P7T73HTreXSCL9UW5Dt/WaeOyIE8IXcUdKOpw//LpxcKvIYF6T/6PXTiSpquR//GHL+EkVFLQmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxEbHlTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664DBC113CC;
	Thu, 25 Apr 2024 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714030400;
	bh=IvDFJUyMXiZoCo3+3WAO6o6mM1VGEGQ/JIWJuBcDiww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxEbHlTZpkqN3noZ8+q1aOqtL9WoUhJp6u9GrZ2/UfHErnHsXpJdNBl3wJAawuHo3
	 duH2DK+B6BiCibp3F7TQmgvrslQ98lqIwuHxG39LLez2NaDnTfE9ByWIw/4+5hk1Z0
	 ReIzcNQvMKTWffr48hGdkeSZNjDgYyOo/iDCQ3gTN5H6EEBhjhHe6MV3aFW5zMJsD2
	 DqRWMVlsFywKVpFCWATdXPZ0IlRXrkCV9ZnFGB0ArAqw3cr9LRoIDNVtAePLi+mi47
	 a8eyS3hEDWjUE//wC5SovyW7JOFOWTsAIYBcy7ymmazi90mZbCpGLIMcxpKRADxeYT
	 uCHX9sNjHpfpg==
Date: Thu, 25 Apr 2024 08:33:17 +0100
From: Simon Horman <horms@kernel.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Aaron Conole <aconole@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	dev@openvswitch.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [ovs-dev] selftests: openvswitch: Questions about possible
 enhancements
Message-ID: <20240425073317.GS42092@kernel.org>
References: <20240424164405.GN42092@kernel.org>
 <20240424173715.GP42092@kernel.org>
 <ZilIgbIvB04iUal2@f4>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZilIgbIvB04iUal2@f4>

On Wed, Apr 24, 2024 at 01:59:29PM -0400, Benjamin Poirier wrote:
> On 2024-04-24 18:37 +0100, Simon Horman wrote:
> > On Wed, Apr 24, 2024 at 05:44:05PM +0100, Simon Horman wrote:
> > > Hi Aaron, Jakub, all,
> > > 
> > > I have recently been exercising the Open vSwitch kernel selftests,
> > > using vng, something like this:
> > > 
> > > 	TESTDIR="tools/testing/selftests/net/openvswitch"
> > > 
> > >         vng -v --run . --user root --cpus 2 \
> > >                 --overlay-rwdir "$PWD" -- \
> > >                 "modprobe openvswitch && \
> > > 		 echo \"timeout=90\" >> \"${TESTDIR}/settings\" && \
> > >                  make -C \"$TESTDIR\" run_tests"
> > > 
> > > And I have some observations that I'd like to ask about.
> > > 
> > > 1. Building the kernel using the following command does not
> > >    build the openvswitch kernel module.
> > > 
> > > 	vng -v --build \
> > > 		--config tools/testing/selftests/net/config
> > > 
> > >    All that seems to be missing is CONFIG_OPENVSWITCH=m
> > >    and I am wondering what the best way of resolving this is.
> > > 
> > >    Perhaps I am doing something wrong.
> > >    Or perhaps tools/testing/selftests/net/openvswitch/config
> > >    should be created? If so, should it include (most of?) what is in
> > >    tools/testing/selftests/net/config, or just CONFIG_OPENVSWITCH=m?
> 
> I noticed something similar when testing Jiri's virtio_net selftests
> patchset [1].
> 
> drivers/net/virtio_net/config includes virtio options but the
> test also needs at least CONFIG_NET_VRF=y which is part of net/config.
> 
> Whatever the answer to your question, all config files should be
> coherent on this matter.

Yes, agreed. That is the main reason I'm asking about this.

> [1] https://lore.kernel.org/netdev/20240424104049.3935572-1-jiri@resnulli.us/
> 
> [...]
> > 
> >   5. openvswitch.sh starts with "#!/bin/sh".
> >      But substitutions such as "${ns:0:1}0"  fail if /bin/sh is dash.
> >      Perhaps we should change openvswitch.sh to use bash?
> 
> I think so. A similar change was done in
> c2518da8e6b0 selftests: bonding: Change script interpreter (v6.8-rc1)

Thanks, this one seems straightforward.

