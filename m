Return-Path: <linux-kselftest+bounces-44424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E2BC20FA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7ED7425349
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0876363B85;
	Thu, 30 Oct 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8U9w3BZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F16157480;
	Thu, 30 Oct 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838786; cv=none; b=JaJVq0VHG2Gep6A1TtJDObf0gfpIbaVXMgoqD7dYPZ+pDv6UAw9fPjZorO16CafwLxldK4SVo+p6lpA5sjXsISe/EG8xecJdKGxdLbobwoYyPTSR7bxC3s2f8TazH0gO5OrBAl7kZw9CitoNA3neV05VbhjEDVXK7zvYRF3ptY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838786; c=relaxed/simple;
	bh=5jqdHhX0I4KMiLwoW0KNxN68J+JobxHWa2UkGLceI74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6dWVKn1P3i4CHp62KSagbwriKmurQv+AE1LF0/ZEy00d9olCdcYNAA3u6KlKxJPDbr3XuUVM2GGZXr0vyWla+wfjCLn3XfYOSZ+cZf5e2UOvj+JNQ1YvDOiWj668CE7Cq/zjjY924s1VnespAbk+VIVFNVSEESHayX13nm9MoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8U9w3BZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F48C4CEF1;
	Thu, 30 Oct 2025 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761838786;
	bh=5jqdHhX0I4KMiLwoW0KNxN68J+JobxHWa2UkGLceI74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f8U9w3BZPQbzFxBJtOiVVxCeZTZXtZRLy02kRyVIpZSbGCI2TOdhOBhdQzRuN5PGb
	 VEM5VJ0/61eIYAwTwIMOGQoXS/IEkckAnJhBcyXZd1yH0HP4X4wzowGvR7M+bfjTNS
	 QWvA48MrahhyPBVC2XmAu7J/X/DtALpGGa3SVGReYY+Mv2kXrrMFUxom/WDJLyehhA
	 Uzm2uQ0n3IVNfj+zwudpX+3dWs5iWD3zAeREECFiXQmmk+A3XK+bUQWVaV1rqVJ5HQ
	 gihqqXLqe1JJjN8xEOogLO0h66MlHfnQ+Bnm/YgBfkN61P8x9vQ+EJq5KHtGUcBfdw
	 LNDBNURQ1Ifew==
Date: Thu, 30 Oct 2025 08:39:44 -0700
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
Subject: Re: [PATCH net-next 3/3] selftests: net: add YNL test framework
Message-ID: <20251030083944.722833ac@kernel.org>
In-Reply-To: <aQL--I9z19zRJ4vo@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
	<20251029082245.128675-4-liuhangbin@gmail.com>
	<20251029164159.2dbc615a@kernel.org>
	<aQL--I9z19zRJ4vo@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 06:00:24 +0000 Hangbin Liu wrote:
> > Hm, my knee-jerk reaction was that we should avoid adding too much ynl
> > stuff to the kernel at this point. But looking closer it's not that
> > long.
> > 
> > Do I understand correctly, tho, that you're testing _system_ YNL?
> > Not what's in tree?  
> 
> Kind of. With this we can test both the system's YNL and also make sure the
> YNL interface has no regression.

Meaning we still test the spec, right?

To state the obvious ideally we'd test both the specs and the Python
tools. Strictly better, and without it adding tests for new Python
features will be a little annoying for people running the selftest.

Maybe the solution is as simple as finding and alias'ing ynl to the
cli.py ?

