Return-Path: <linux-kselftest+bounces-13240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A6928A2E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 15:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD741C21F05
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835314D6F9;
	Fri,  5 Jul 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8FXjAu5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AD1459E8;
	Fri,  5 Jul 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187599; cv=none; b=CFelfRbC1cSDefVfm/C2HDqo53t9O+Nn0mF6sPbO3AXLOvGwrT7EyOjMEaH/g/2s5m7eM/8dXTu3o4g7lCFWmuP9+8JnWkZwaMXk0UwH/mXZmpIR3BuHjcX/hMxkpSS1Dtqj4fDZGXvlB8y9+/BGwJHBULjlQfFyUcBtYYZ+280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187599; c=relaxed/simple;
	bh=iBo2NAMKixoHqt5brl0uZYpx2bTHZNyB5uFZzugwEy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuzvG2z2ndPUieUJfGxVtlNBLLlRFJxH8EpX9LaGWFoZ6kAcSKraneEYKRD8HfjWAogifhko7nZ1hLg9CvTAnCN6BTaQkCKBP6TMNegdO1MO5HB5e02YM/4Tk+Ly6tnXHvc5VU7ofLZ4Sypqc/lfj2fiuyLPu58XwoqJO4qzZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8FXjAu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4A3C116B1;
	Fri,  5 Jul 2024 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720187598;
	bh=iBo2NAMKixoHqt5brl0uZYpx2bTHZNyB5uFZzugwEy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f8FXjAu56BtjY10grqgpqfpORdCuT2fjGTzg3au6vdXaECIIlBU8noeHMrvI4+HRX
	 uZWM0dwiYiiuQctbLftxLXFu9qI3p1AKRuekQTtm8PpFUQpiwHWIfUArTetFhNTR6X
	 X+bpyfFbtlihRnnikyYLm3K83/DIACrykV6meSCTEFuuhLz0P3T8WcVFHL6Z63h9n3
	 qzBd9p0bSGDv8lNSC0msELTeF+4PGwttQEgpb7li/nNSUMKKrcuCV2dijWq0g8Pbau
	 wW/VqVm3hKw2yWV9AwE2JsCmb/woQfaH4owYkXzJJCM3tmQ+V086wiyedN2r9jfjIX
	 0xMARLrC9IjMw==
Date: Fri, 5 Jul 2024 06:53:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, =?UTF-8?B?QWRyacOhbg==?= Moreno <amorenoz@redhat.com>,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 0/3] selftests: openvswitch: Address some
 flakes in the CI environment
Message-ID: <20240705065316.6886f2ba@kernel.org>
In-Reply-To: <f7th6d4ne3r.fsf@redhat.com>
References: <20240702132830.213384-1-aconole@redhat.com>
	<20240705062851.36694176@kernel.org>
	<f7th6d4ne3r.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Jul 2024 09:49:12 -0400 Aaron Conole wrote:
> > The results look solid on normal builds now, but with a debug kernel
> > the test is failing consistently:
> >
> > https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-dbg&test=openvswitch-sh  
> 
> Yes - it shows a test case issue with the upcall and psample tests.
> 
> Adrian and I discussed the correct approach would be using a wait_for
> instead of just sleeping, because it seems the dbg environment might be
> too racy.  I think he is working on a follow up to submit after the
> psample work gets merged - we were hoping not to hold that patch series
> up with more potential conflicts or merge issues if that's okay.

Makes sense, thanks!

