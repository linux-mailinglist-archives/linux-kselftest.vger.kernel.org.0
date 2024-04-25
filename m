Return-Path: <linux-kselftest+bounces-8877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1F98B28FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 21:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442731F21E08
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 19:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211521514F8;
	Thu, 25 Apr 2024 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0SkhSyJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0786A34F;
	Thu, 25 Apr 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072913; cv=none; b=ajM4Ahg7ANNpJ+P6Z6qNz6pinc+PjPHxW1xhk3vwSmXd3YmkUJymBJjT6CR8E6Y5kSZmnQjewfKI8yY5y9o1yXEr6rX3XcRQbXhfZJ5+ZJgsBYioytTy2VRQT8k2nHl06g+ljIOlgfIUS5ZM/+RdID1lMV07LddfH5jvKaHRouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072913; c=relaxed/simple;
	bh=yDWNF7wo8CPDSmjDC2zihnipvbyPaXSdEzRImPOt+nY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L25eArD37oMzL3tsEH4kWRwDJ4VJHFWOzFvYhDZzKzsEWbZaH3sq4ea2fMmQo6XGGSspIzj9VO6o3dr/cL8nCC+yzBn3/WZi2KQVYI7dwbC8vfvEguTbMbjJQ+A7sD3aEwObzsAdMp2/8KvnlpNgunPTkHIaMVhHlAAXSOwY7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0SkhSyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439A8C113CC;
	Thu, 25 Apr 2024 19:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714072912;
	bh=yDWNF7wo8CPDSmjDC2zihnipvbyPaXSdEzRImPOt+nY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u0SkhSyJvV/hxh5ZWSXyjk0V3jLvBwiXn4rFk/Q8/B7YziU9NG27gOppG3K1uT2v0
	 RSWfQvOf4PZ+gY4UDAyMAVbCKsZ47qiRpwrOHzCbxywnIZz2pnVDjM0Un1ndix5h+o
	 P9/cq3dq+GLI0MdJLvkaS9cDHeNwisSNl22KuPuYThqVh/Ic8Dw/HMoSAtrzeVtry6
	 MZynlE+oelYd0PyXk2dgKmVgMdIfzQZYjxdprRapY2/XX+Nm5Do5E6lYCuMptESWCs
	 vv2FGMMvdKgmyW9QG0Zk2D7W3aewaJTZ2KVePFcGL4FdkoWxUVxOOI+gG1eucBeYWj
	 duUSatvQaC6DA==
Date: Thu, 25 Apr 2024 12:21:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: dev@openvswitch.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [ovs-dev] selftests: openvswitch: Questions about possible
 enhancements
Message-ID: <20240425122151.1d5efcc2@kernel.org>
In-Reply-To: <20240425185719.GV42092@kernel.org>
References: <20240424164405.GN42092@kernel.org>
	<20240424173000.21c12587@kernel.org>
	<20240425082637.GU42092@kernel.org>
	<20240425185719.GV42092@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 19:57:19 +0100 Simon Horman wrote:
> openvswitch.sh does not appear to have any dependencies on Open vSwitch
> user-space. My understanding is that, rather, it makes use of
> tools/testing/selftests/net/openvswitch/ovs-dpctl.py to talk to the Kernel
> using Netlink (which is also what Open vSwitch user-space does).
> 
> My brief testing indicates that for this the only dependencies
> when running on Amazon Linux 2 are python3 and pyroute2.
> 
> I think that it should be possible to port pmtu.sh to use ovs-dpctl.py.
> This would require some enhancements to ovs-dpctl.py to handle adding the
> tunnel vports (interfaces).
> 
> As an aside, to run the Open vSwitch tests in pmtu.sh the openvswitch
> kernel module is needed. So I think it would make sense to add
> CONFIG_OPENVSWITCH to tools/testing/selftests/net/config.
> 
> That would mean that tools/testing/selftests/net/config also has all
> the requirements to run openvswitch.sh. If so, we probably wouldn't need to
> add tools/testing/selftests/net/openvswitch/config or otherwise do anything
> special to configure the kernel for openvswitch.sh.

That sounds great, for simplicity we could move the ovs files down 
to the .../net/ directory. It'd be cool to not have to do that, and
let us separate tests more clearly into directories. But right now
every directory has its own runner so there's a high price to pay
for a primarily aesthetic gain :(

