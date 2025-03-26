Return-Path: <linux-kselftest+bounces-29834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA777A71FCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 21:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E833B4C84
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18D4253B6A;
	Wed, 26 Mar 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k35KV8C3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C314F125;
	Wed, 26 Mar 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019207; cv=none; b=YiXbfRGa9W7siMTSlvkukZZ1yw+vLf8cCmuOyQb/phRBQ5pbDx9CS+E2ISLQy/XjPqBgcVwE7Sz09bShw27PfJfyE4KB6/945vgJMVEZyHIJL2mjBjrCEKyOfezBA2TODC6Ki6p4UJUp6zqHbUHQpRPX7/TyjqJOXHmPgjlHaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019207; c=relaxed/simple;
	bh=W8zqW4dtBk6ymMiBHK3/DdV0RoQiheix8bbRh+cEjoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QElzMVouTtgbFG9LK4FhwCkkVXG3Gtq+0BafVCzVm1Jj0HbcW2eC+6Aif9G07BqW72muPk4SwvmOy4+LQjIUVE39UnlZYucpERReryWu4Lj1KNsfJfvipzOwH+4xJOWiwwOZ753j6a2Ghy16kS6iBHESVi3jNHvfi/0tj+B6GnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k35KV8C3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0F8C4CEE2;
	Wed, 26 Mar 2025 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743019207;
	bh=W8zqW4dtBk6ymMiBHK3/DdV0RoQiheix8bbRh+cEjoA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k35KV8C3WeEZg+PyXMFzeJrTJYXoRlwfbVlt4Oiufeu9mBlRxRDGfoyDIvu/UWgha
	 AkT6kTzfrXJY2epj7N/X+i0ESDPM86MLooxHhHxiP6+zEio/m92WVk9beQJmi/sbp0
	 9LXdWlquhs32em6DVmIb+RQyV+Hmkm+DyCbvhzK9nn6sBHAYLtF/u5fyfh0dAknDfU
	 2exOL6LTq+yrhivuTQVdNPiqmSKtjo4iDM2ssHtHfoXuCeIKO/bMNTonKIUKPPFnLw
	 BF2jmXR+Rs+nrJ6vi4WRKhkReX8EziNx4P55Gh0IXgpv3Q0Q9OLlX7ol3hhOgP7HiJ
	 J2+scQaPnWDAQ==
Date: Wed, 26 Mar 2025 13:00:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/7] selftests/net: Mixed select()+polling
 mode for TCP-AO tests
Message-ID: <20250326130005.0f12741d@kernel.org>
In-Reply-To: <CAJwJo6YoGz1aPv5nkJJKa05mxF-Zhc+B4U6kRw95KSduLCApaw@mail.gmail.com>
References: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
	<20250325061525.01d34952@kernel.org>
	<CAJwJo6YoGz1aPv5nkJJKa05mxF-Zhc+B4U6kRw95KSduLCApaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 19:48:16 +0000 Dmitry Safonov wrote:
> On Tue, 25 Mar 2025 at 13:15, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Wed, 19 Mar 2025 03:13:33 +0000 Dmitry Safonov via B4 Relay wrote:  
> > > Should fix flaky tcp-ao/connect-deny-ipv6 test.
> > > Begging pardon for the delay since the report and for sending it this
> > > late in the release cycle.  
> >
> > Better late than never, thanks a lot! :)  
> 
> Thank you, Jakub!
> 
> I also noticed that recently, self-connect-ipv6 became slightly flaky:
> https://netdev.bots.linux.dev/flakes.html?br-cnt=75&tn-needle=tcp-ao
> 
> Seems unrelated to select()+poll selftests changes, but rather to
> timings in the kernel:
> # # 1249[lib/proc.c:213]    Snmp6            Ip6OutNoRoutes: 0 => 1
> 
> It seems that the test relied on kernel adding a link-local route with
> a loopback interface, but probably adding the interface got faster.
> Seems like a trivial two-line fix by manually adding the link-local
> route in userspace. Though, can't reproduce that flake locally on
> thousands of runs.
> 
> Should I send the potential fix now for -net or wait until the merge
> window closes and send for -net-next?

I reckon you can send it now, maybe other maintainers will disagree
but to me test stability fixes should be okay during the MW.
You can tag it as net-next for the benefit of the build bot, 
tho we'll end up merging it to net once/if Linus pulls.

