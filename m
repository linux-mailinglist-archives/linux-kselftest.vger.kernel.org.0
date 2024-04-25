Return-Path: <linux-kselftest+bounces-8876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEAA8B2899
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5E0B2624F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D91514E1;
	Thu, 25 Apr 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTW12+t+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112C39AFD;
	Thu, 25 Apr 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071443; cv=none; b=X0/ifnDfokSO7d2WgfFxI2ZG2VT7Hec801e2G2+4qmf+VJI2P+TxTDyMFc0pD9/5LAgZOABdEPkOQeDKEp7kz+vlFKi6BtOed8hX7SFwlffOenTDhnCnBZNCrWVe0Q/Y9GfE4mVe+Yg2RiskXr5WTBE1KpYQO2gwMuxghWHtgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071443; c=relaxed/simple;
	bh=buOoKEjni+oARMwAh56lrnBKnbiKr0HbCoHxCGjEv/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLLjmrTYOTAjNI+oXOuFSIXuyZsZ1CTTZTnNP8Zu0iKCySKx9oRYIHOM8C+YAXtWjCJk5GkfzUi8GfrBjx4PtleR3F/2kw0Ptz4+tqdmJtO1frSThD5lxaNefwVm9fpr6V+Ck6R36WhALQ+GS7HbEYeiKl6Jr3eEFHtdkGt0vqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTW12+t+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4BCC113CE;
	Thu, 25 Apr 2024 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714071443;
	bh=buOoKEjni+oARMwAh56lrnBKnbiKr0HbCoHxCGjEv/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTW12+t+Tey9sqns5FjqBaXBfGS3KkQyLUGfQa2GGz798r2KHGnn9GOKYJ2lzRAS4
	 6LeFJEC4fxzDJnJ1tnyIyndDCCT7pYckow33mQi2GWaBP2npvVDe99hPMt2MuO34BS
	 CrXsea6D9ZERdmpJFbsvLQXZ7usDgzwEyCvQzgV9S94d3ZrnKAR1mneNlylNo1ca03
	 yJo474jUmVlNyFOc8UDtJwDIFDOBMq+2NwyYGHKrFwTOJW2ljJBN/xuSO3ZiE83708
	 YJlN4cSmaoAmubaNGhJ35uKnXUNIY9rJREKyHEfEUNfPrFUxmUbnTwgg/yWmiAhCuC
	 dmLrkirRblW5w==
Date: Thu, 25 Apr 2024 19:57:19 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dev@openvswitch.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [ovs-dev] selftests: openvswitch: Questions about possible
 enhancements
Message-ID: <20240425185719.GV42092@kernel.org>
References: <20240424164405.GN42092@kernel.org>
 <20240424173000.21c12587@kernel.org>
 <20240425082637.GU42092@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425082637.GU42092@kernel.org>

+ Aaron

On Thu, Apr 25, 2024 at 09:26:37AM +0100, Simon Horman wrote:
> On Wed, Apr 24, 2024 at 05:30:00PM -0700, Jakub Kicinski wrote:
> > On Wed, 24 Apr 2024 17:44:05 +0100 Simon Horman wrote:
> > > I have recently been exercising the Open vSwitch kernel selftests,
> > > using vng,
> > 
> > Speaking of ovs tests, we currently don't run them in CI (and suffer
> > related skips in pmtu.sh) because Amazon Linux doesn't have ovs
> > packaged and building it looks pretty hard.
> > 
> > Is there an easy way to build just the CLI tooling or get a pre-built
> > package somewhere?
> > 
> > Or perhaps you'd be willing to run the OvS tests and we can move 
> > the part of pmtu.sh into OvS test dir?
> 
> Thanks Jakub,
> 
> The plot thickens.
> We'll look into this (Hi Aaron!).

Hi again,

I took a look into this.

openvswitch.sh does not appear to have any dependencies on Open vSwitch
user-space. My understanding is that, rather, it makes use of
tools/testing/selftests/net/openvswitch/ovs-dpctl.py to talk to the Kernel
using Netlink (which is also what Open vSwitch user-space does).

My brief testing indicates that for this the only dependencies
when running on Amazon Linux 2 are python3 and pyroute2.

I think that it should be possible to port pmtu.sh to use ovs-dpctl.py.
This would require some enhancements to ovs-dpctl.py to handle adding the
tunnel vports (interfaces).

As an aside, to run the Open vSwitch tests in pmtu.sh the openvswitch
kernel module is needed. So I think it would make sense to add
CONFIG_OPENVSWITCH to tools/testing/selftests/net/config.

That would mean that tools/testing/selftests/net/config also has all
the requirements to run openvswitch.sh. If so, we probably wouldn't need to
add tools/testing/selftests/net/openvswitch/config or otherwise do anything
special to configure the kernel for openvswitch.sh.

