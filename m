Return-Path: <linux-kselftest+bounces-12954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C208691C9A0
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 01:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE1E1F23483
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABD4823DD;
	Fri, 28 Jun 2024 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0oFgDG9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1696BA53;
	Fri, 28 Jun 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719617856; cv=none; b=iPt1Vv6uqeIT2bzRQk4E05A1tQPKfdh7cA0nsz4YzO6chMpt/73t1wwzDHlXCfL3GZa30iL9pBzAXMADukVA+mil93BOj2lGqOZ4rzfuFazwBeeGEiEyhcqwDR8bHY+SDKgylN9BR0wRM2PSrhPzzmZQ3GDMwWyv3KiFAC5Bcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719617856; c=relaxed/simple;
	bh=ka4qv5fSLX3tQEYbDwggV9HujoAfjXbpNQOaFpCPECo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nj8biq7Kib5gHy+DqdV8Bk84CJkcrucvI1JGGJ0RwSqvo1slMg1G7M0uUNYVRu3OvksyM1S6q8jOsZ2/uWoYfk0cwZ9Y41QlNhaLSsUay/FYQsmErj6sbhIssGwTaSphQDW2pQBeyZUnVeBSO3A5UAekk3lYXATMOIDpMMqBhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0oFgDG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E2AC116B1;
	Fri, 28 Jun 2024 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719617855;
	bh=ka4qv5fSLX3tQEYbDwggV9HujoAfjXbpNQOaFpCPECo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k0oFgDG9PKaaq9/wANCyXCMDwZ+ICzZdRmfEoFgfF+4nASNyYPGFm1l9DIAuJ0ljs
	 SUGMjQjClDN6P/mH3WCnt94IAJq6vQvX35Q6J7H77WX66F3E9MajKKyGvN8HX6sptF
	 xfztLrilYfG4/2VnfS4V2uMSK4DsnqfpcWGJx7ZRxKjLnxj/Xa9ilbmJ4q3IQw7Qn5
	 PV+VfMU7x9b+id9XUwnKhGs3/Mni3yvO/te2apIEdS0N0GSGER4xWgSTBbenNCCbrF
	 SMT03PaOgc/JmINaYpZ7ghvzqvM4LmTkw++La5CmtYs4kozY19xC0N4KqyHqodW88D
	 5A/EeDE67CiZA==
Date: Fri, 28 Jun 2024 16:37:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v3 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240628163733.08077094@kernel.org>
In-Reply-To: <f7th6ddx7ty.fsf@redhat.com>
References: <20240625172245.233874-1-aconole@redhat.com>
	<20240628081526.66a6b5c6@kernel.org>
	<f7th6ddx7ty.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 14:04:09 -0400 Aaron Conole wrote:
> > I also added the OvS tests themselves, and those are not passing, yet:
> > https://netdev.bots.linux.dev/contest.html?test=openvswitch-sh
> > Could you take a look and LMK if these are likely env issues or
> > something bad in the test itself?  
> 
> I saw that.  I was looking for a place in the nipa repository where I
> could submit a small fix, because I noticed in the stdout:
> 
>   make -C tools/testing/selftests TARGETS="net/openvswitch"
>   TEST_PROGS=openvvswitch.sh TEST_GEN_PROGS="" run_tests
>   
> and I think the TEST_PROGS=openvvswitch.sh is misspelled (but it seems
> to not matter too much for the run_test target).

:o that's a weird bug, whatever is echoing back the input from the VMs
stdin to stdout is duplicating 74th character?! but as you say looks
like the VM gets the right input, it's just the echo.

> From what I understand, there are two things causing it to be flaky.
> First, the module detection is a bit flaky (and that's why it results is
> some 'skip' reports).  Additionally, the connection oriented tests
> include negative cases and those hit timeouts.  The default is to
> declare failure after 45s.  That can be seen in:
> 
>   https://netdev-3.bots.linux.dev/vmksft-net/results/659601/91-openvswitch-sh/stdout
>   ...
>   # timeout set to 45
>   ...
>   # TEST: nat_connect_v4                                                [START]
>   # Terminated
>   # Terminated
> 
> This is showing that the timeout is too short.
> 
> I have patches ready for these issues, but I didn't know if you would
> like me to submit config 

config meaning make OvS built in? We have a number of tests using
module auto-loading, I don't think there were major issues with it.
(well, the rebuilding of modules is a bit questionable with vng,
but we do 'make mrproper' between each build to work around that).

> and settings files to go under net/openvswitch,
> or if you would prefer to see the openvswitch.sh script, and
> ovs-dpctl.py utilities move out of their net/openvswitch/ directory.  If
> the latter, I can submit patches quickly with config and settings (and a
> small change to the script itself) that addresses these.  If you'd
> prefer the former (moving around the files), I'll need to spend some
> additional time modifying pmtu and doing a larger test.  I don't have a
> strong opinion on either approach.

Since we talked about it a while back I gave in and implemented support
for combining multiple targets in a single runner. So it doesn't matter
any more (barring bugs in NIPA), up to you.

