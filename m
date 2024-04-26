Return-Path: <linux-kselftest+bounces-8901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AED8B3109
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 09:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B64128182B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAFE13AD09;
	Fri, 26 Apr 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHiQmS3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8013A898;
	Fri, 26 Apr 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115128; cv=none; b=MDEQL7x+G1r4sMgTVNjryyeDQtoJSyuaZv/Wwpzg40LLh1HeqQ//oprex+Y4TnxjmUTqZIlZHhsXq/+kNAE7pMGcJGHcUhlliVQ9o1SOl9NWeaOtWuST+2VcPKNbzWvDYVk9imRzD/OrWD68vjNYS2lLM7HstXpp4nOBiFpi1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115128; c=relaxed/simple;
	bh=F0iG2wx60KVc6Z76DVrQ1R2rFXUk0p5yuCUgEIyadF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aveAYS/Mnh+0QUsow6PmqrTLvVLCjM+GIpLAvrjjAT7tfrq4hs/EWMCCpTF/1AV6WuGtP86whQbDOjFNX22S+t3NQ7FLBQQ+KVgrb9f/9X7z4V24bao04kKJqzdxVS47gkfYnIYwb/LPX3PjA01x5iJNRDMCV2g6X/Pdyte1v5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHiQmS3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9BBC113CD;
	Fri, 26 Apr 2024 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714115128;
	bh=F0iG2wx60KVc6Z76DVrQ1R2rFXUk0p5yuCUgEIyadF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHiQmS3mZcG7Yzh+VpPEdThNyAnZJFFV/Ew4XQ8qPa8xVYCT8vhmPhO6F6g3utfl/
	 2ppTGYsWoL33ilZP6We57FkeXcTVcYpHuDimWP//oLe7wWOvTiLo9sm4ZiW0+lPTI/
	 d13WGsLAtE4yk3boD2C1Cf8F28qXIpUQd4uj9ApYw0gvAvyD3f33LY1nlCgdWQm+pN
	 SsVAI7fUvT9dKb6PEqRu9zAug+VAmjGFSFXKh6i+0aiwDufsj3v8XRoTWqPl4qApW0
	 Dmytm9V9pNl6m2OuHzIfPYzarNTIk+SIWYPiMbV0W1398eUJebN69Iw3SxeljEyyKw
	 BLcd0VF3ShJeQ==
Date: Fri, 26 Apr 2024 08:05:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dev@openvswitch.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [ovs-dev] selftests: openvswitch: Questions about possible
 enhancements
Message-ID: <20240426070524.GW42092@kernel.org>
References: <20240424164405.GN42092@kernel.org>
 <20240424173000.21c12587@kernel.org>
 <20240425082637.GU42092@kernel.org>
 <20240425185719.GV42092@kernel.org>
 <20240425122151.1d5efcc2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425122151.1d5efcc2@kernel.org>

On Thu, Apr 25, 2024 at 12:21:51PM -0700, Jakub Kicinski wrote:
> On Thu, 25 Apr 2024 19:57:19 +0100 Simon Horman wrote:
> > openvswitch.sh does not appear to have any dependencies on Open vSwitch
> > user-space. My understanding is that, rather, it makes use of
> > tools/testing/selftests/net/openvswitch/ovs-dpctl.py to talk to the Kernel
> > using Netlink (which is also what Open vSwitch user-space does).
> > 
> > My brief testing indicates that for this the only dependencies
> > when running on Amazon Linux 2 are python3 and pyroute2.
> > 
> > I think that it should be possible to port pmtu.sh to use ovs-dpctl.py.
> > This would require some enhancements to ovs-dpctl.py to handle adding the
> > tunnel vports (interfaces).
> > 
> > As an aside, to run the Open vSwitch tests in pmtu.sh the openvswitch
> > kernel module is needed. So I think it would make sense to add
> > CONFIG_OPENVSWITCH to tools/testing/selftests/net/config.
> > 
> > That would mean that tools/testing/selftests/net/config also has all
> > the requirements to run openvswitch.sh. If so, we probably wouldn't need to
> > add tools/testing/selftests/net/openvswitch/config or otherwise do anything
> > special to configure the kernel for openvswitch.sh.
> 
> That sounds great, for simplicity we could move the ovs files down 
> to the .../net/ directory. It'd be cool to not have to do that, and
> let us separate tests more clearly into directories. But right now
> every directory has its own runner so there's a high price to pay
> for a primarily aesthetic gain :(

Understood. Let's work on getting the Open vSwitch portions of pmtu.sh, and
openvswitch.sh into a little bit better shape. Then we can consider moving
the contents of tools/.../net/openvswitch/. It would certainly be nice to
have the Open vSwitch tests run automatically.


