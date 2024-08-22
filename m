Return-Path: <linux-kselftest+bounces-16041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00595B2AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3503D1F220E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 10:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3617E009;
	Thu, 22 Aug 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gst5Os8m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123115C13A;
	Thu, 22 Aug 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321675; cv=none; b=bcZyuZzp6ArKwbq3GVEzBb+9pcfTqX4UWvjuYu6q2sw6EZWXfF5kz6+OKnioF2jwE0B+snCom7SEMEQocPXIq9/CjUv4bftP2QXa1ONLocOsGe3Ee8Xl0lxAZdBvxZPKG/RRwyMBi+35B/2YKne/WH3cQaEQ+cqlIX+vTFRrKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321675; c=relaxed/simple;
	bh=lFwC47VuSVk5zb05nD3Q9n5viwBQLOrGGxMDSpCSlYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfYjLfazGFp0X9xZhHkm2IfTnUBpgGGXXzAAmZo4txfhU8YfoMR/ubcFbTpGmpGUgrHTko0YI0jKktvFZQr64ogZgCZlejGw+1XZpz0HWd8mhOLnAdUArVSa+dBuAMeh7ehJbc0rJb32jq8cVZc9+IPAdPeOxE8aZCuFRjzqUsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gst5Os8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4978AC32782;
	Thu, 22 Aug 2024 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724321675;
	bh=lFwC47VuSVk5zb05nD3Q9n5viwBQLOrGGxMDSpCSlYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gst5Os8m+BeXtNJzb4+XKS6whOZfPgQchtuvF8o80edWfbLMcERwB/cYWHv7HbHdh
	 2rrxNUzb5zV4zpzZO3yyZmJ1zJYSPsNzdrIJwyPDahD3o1B3bFAkNPgWQAgxvYgp7t
	 PnKxNpECQnKqxcfQTc8t2tnrdSZmeTqZch7aLCbWh14El2JXgWjdTMisHoNdSoT9Mc
	 dzO/z560BnSDKAS5Z01ApEcG3TXbY66U4p+6DeWnekqpX/fnrSFrGdEtPxx5xWM0wx
	 8S7bvSGJr9ZaUTfK1u2gTjyTJuEds5heOR5zzlTrn89Qg3R3SWUKcuAWO3B7lN8rjl
	 t2gHf2VDF0NSA==
Date: Thu, 22 Aug 2024 11:14:30 +0100
From: Simon Horman <horms@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] selftests/net: Open /proc/thread-self in
 open_netns()
Message-ID: <20240822101430.GJ2164@kernel.org>
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
 <20240815-tcp-ao-selftests-upd-6-12-v3-4-7bd2e22bb81c@gmail.com>
 <20240821191133.GG2164@kernel.org>
 <CAJwJo6Yj_Zqwg9Z7sJvj8UZE6z7gAq+Y0p0K5Oz8s+CYMwzFow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6Yj_Zqwg9Z7sJvj8UZE6z7gAq+Y0p0K5Oz8s+CYMwzFow@mail.gmail.com>

On Wed, Aug 21, 2024 at 10:44:30PM +0100, Dmitry Safonov wrote:
> On Wed, 21 Aug 2024 at 20:11, Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Aug 15, 2024 at 10:32:29PM +0100, Dmitry Safonov via B4 Relay wrote:
> > > From: Dmitry Safonov <0x7f454c46@gmail.com>
> > >
> > > It turns to be that open_netns() is called rarely from the child-thread
> > > and more often from parent-thread. Yet, on initialization of kconfig
> > > checks, either of threads may reach kconfig_lock mutex first.
> > > VRF-related checks do create a temprary ksft-check VRF in
> >
> > nit: temporary
> >
> >      Flagged by checkpatch.pl --codespell
> 
> A-ha, b4 has this b4.prep-perpatch-check-cmd git setting:
> https://github.com/mricon/b4/blob/37811c93f50e70f325e45107a9a20ffc69f2f6dc/src/b4/ez.py#L1667C20-L1667C43
> 
> Going to set it and hopefully, it will help avoid spellings/typos in
> future, thanks!

--codespell is very handy for that :)

