Return-Path: <linux-kselftest+bounces-7094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A865C8971BB
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 15:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3C41F21432
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5B148820;
	Wed,  3 Apr 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0Ht68c0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8723146D65;
	Wed,  3 Apr 2024 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152539; cv=none; b=XgZ/x8FGwRCoippCjzWqpCnLAklHx3NESmoGPLFHcouGTnBWw/a1zIUMUPhq/7rSXdLPfc8TfUYmYPZVHRp/0lifwgtJ9FGinQmmhXrnkYqKxc581E5YG/gavhQ1OJhkntmArbIsxbmqzScSMhCcdkFguYBTkn1KSZNBrd5wZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152539; c=relaxed/simple;
	bh=Vzy9ZlpuuEXY5ZbA8rwr0HVBPjQPNwAXukzBrsZIt8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qpqy8BjPnoW1Q6CrT2CwCijeFVjJkl438H7indSXH47g9R6ntpZu9+p9VaebsP5Fe9ZR3FoL81DJo2kCWhMDjZsN96Ru8IJL9VzuZcPNBy+ptm13rVaN2JQYyn+IvOO6YmeSUoZGUwpjbHbcKun3N3ihM8ugQdITsRTEnIYbvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0Ht68c0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF7DC433F1;
	Wed,  3 Apr 2024 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712152538;
	bh=Vzy9ZlpuuEXY5ZbA8rwr0HVBPjQPNwAXukzBrsZIt8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k0Ht68c0g94ZLGxmgz3RaUImhsQXz4/qzMdP2KOhFmbI4obv6Q2CxdcC6gvxDm4n8
	 5UJcoZi3zRw909XeR+bl3Zj/21X7Keu9vGOU1iBaVsQSVJRO07z896dJehw2bwcYBd
	 XZzQUS+8aNjTf14eN1ha8fyaJSUL8q2vdA8cAFk0JO8PMV4tfpd2S0Mg542gZFlq6o
	 TrpQYV7QdUHZRoAbzMaHAjKNr2vSqNDLpSEc0Oc3r7jnXsf4lWNhOJZ2g7BNMzO+cZ
	 erC5G2ikzCZbSiNYzc/ZQMId3iVOK8KZkL/OnOtCEX5OD5VmIhgqH7sw90SdTpltj5
	 e+d8IX4PdZoYw==
Date: Wed, 3 Apr 2024 06:55:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
 <donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Message-ID: <20240403065532.1f2a072d@kernel.org>
In-Reply-To: <87y19uhhhx.fsf@nvidia.com>
References: <20240402010520.1209517-1-kuba@kernel.org>
	<20240402010520.1209517-8-kuba@kernel.org>
	<87bk6rit8f.fsf@nvidia.com>
	<20240402103111.7d190fb1@kernel.org>
	<8734s3idys.fsf@nvidia.com>
	<20240402163649.4fdc2d3b@kernel.org>
	<87y19uhhhx.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 10:58:19 +0200 Petr Machata wrote:
> Also, it's not clear what "del thing" should do in that context, because
> if cfg also keeps a reference, __del__ won't get called. There could be
> a direct method, like thing.exit() or whatever, but then you need
> bookkeeping so as not to clean up the second time through cfg. It's the
> less straightforward way of going about it IMHO.

I see, having read up on what del actually does - "del thing" would
indeed not work here.

> I know that I must sound like a broken record at this point, but look:
> 
>     with build("ip link set dev %s master %s" % (swp1, h1),
>                "ip link set dev %s nomaster" % swp1) as thing:
>         ... some code which may rise ...
>     ... more code, interface detached, `thing' gone ...
> 
> It's just as concise, makes it very clear where the device is part of
> the bridge and where not anymore, and does away with the intricacies of
> lifetime management.

My experience [1] is that with "with" we often end up writing tests
like this:

	def test():
		with a() as bunch,
		     of() as things:
			... entire body of the test indented ...

[1] https://github.com/kuba-moo/linux/blob/psp/tools/net/ynl/psp.py

Nothing wrong with that. I guess the question in my mind is whether
we're aiming for making the tests "pythonic" (in which case "with"
definitely wins), or more of a "bash with classes" style trying to
avoid any constructs people may have to google. I'm on the fence on
that one, as the del example proves my python expertise is not high.
OTOH people who prefer bash will continue to write bash tests,
so maybe we don't have to worry about non-experts too much. Dunno.

