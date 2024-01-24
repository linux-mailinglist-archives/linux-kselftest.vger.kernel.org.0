Return-Path: <linux-kselftest+bounces-3479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F583B1BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 20:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FB01C21513
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE87131E37;
	Wed, 24 Jan 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roPiC3kj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF512FF86;
	Wed, 24 Jan 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123073; cv=none; b=FRbTLxvI7+x36ot72P8GsB3RSFJ245MVZoQbsYyT95GpPSahZTQr7Aq3QGB3oSpCIZWIwCgxau0/5z3NAnNSx5GpYdtAvp05LClk0JMqA/CLCW4kWQQwndr50SUDVX8j6leFvBTld9A4MQeSURih0qfmNTEja40pvKD8LWHbbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123073; c=relaxed/simple;
	bh=of1oTW1JzvLQNNZXy9oaZis6Ni23ookIZw9VErs4lEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNb2osw/Jog6+V0lnKq/FbWtrToDjL5n4SkavIsdo+0pjYkpanaNZxcLI+TQdiwvb1AM4WdJ0PQ23ZD+ttZ3kKa9LOM/mTuoHyW+SQn4gJVSsQa3Z826vvsW1RChlmNMS09oVGLFBIUTJYiCrBx7YcCr6ycv7W4vZfrcK5jbhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roPiC3kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D58C433C7;
	Wed, 24 Jan 2024 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706123073;
	bh=of1oTW1JzvLQNNZXy9oaZis6Ni23ookIZw9VErs4lEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=roPiC3kjWXq5GHptPY15Wa4Hh55qwJHZ6Ocd5YG/QHMERvVLs680MC5Zkg6fTPoDi
	 EU0owtZpJ5rcar6vRmarTTv0aq6V+tqYXkBEfz1va5UplLqFhvN2lIE/W+g3b85faL
	 91ppMn2nVlkzb/tQpnk7d/Pd+/m4tehYqgar1M/I54hXSrYW+uXpXKObL5QJxhiPag
	 B2PAo53DbdSwOnM9w9FuKT+TOw/qLLMeT89r2YCikICnxbrs4W/QtJb36U3Q9ly+NQ
	 DssWGsvMy71kDXk5ykpr9zd2/UAHBZ3v79HJX1ll+TBYQIXOaJpreEXKrX/O8U3L4n
	 8QwYQYnklZ1ag==
Date: Wed, 24 Jan 2024 11:04:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Mohammad Nassiri
 <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/net: A couple of typos fixes in
 key-management test
Message-ID: <20240124110431.3c3eba9a@kernel.org>
In-Reply-To: <1ad64e3d-5252-4aaf-82be-5162edd1e781@arista.com>
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
	<20240118085129.6313054b@kernel.org>
	<358faa27-3ea3-4e63-a76f-7b5deeed756d@arista.com>
	<20240118091327.173f3cb0@kernel.org>
	<a9a5378d-c908-4a83-a63d-3e9928733a3d@arista.com>
	<20240124071229.6a7262cc@kernel.org>
	<1ad64e3d-5252-4aaf-82be-5162edd1e781@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 17:46:10 +0000 Dmitry Safonov wrote:
> >> Thanks!
> >>
> >> I'll send a patch for it in version 2 (as I anyway need to address
> >> Simon's feedback).  
> > 
> > Hi Dmitry!
> > 
> > I put TCP_AO and VETH in the config and the tests seem to fail with  
> 
> Thanks for wiring it up and for https://netdev.bots.linux.dev/status.html!
> 
> > selftests: net/tcp_ao: rst_ipv4
> > not ok 1 # error 834[lib/kconfig.c:143] Failed to initialize kconfig 2: No such file or directory
> > # Planned tests != run tests (0 != 1)
> > # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:1  
> 
> Hehe, yeah I wanted to detect kernels with !CONFIG_TCP_AO, to SKIP the
> test, rather than FAIL it, which this lib/kconfig.c does.
> But from a glance, I think it's failing in your run because there are
> checks with and without TCP_AO, but I didn't think of checking for
> the hashing algorithms support.
> 
> I think what happens is has_tcp_ao():
> : strcpy(tmp.alg_name, "hmac(sha1)");
> ...
> : if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tmp, sizeof(tmp)) < 0)
> 
> Could you check that what I suppose is failing, is actually failing?
> [dima@Mindolluin linux-master]$ grep -e '\<CONFIG_CRYPTO_SHA1\>' -e
> '\<CONFIG_CRYPTO_HMAC\>' .config
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_SHA1=y

FWIW the config used is uploaded with the results. If you click on 
the remote it should take you to a location like this:

https://netdev-2.bots.linux.dev/vmksft-tcp-ao/results/435369/

and there should be a config file in there. 

> If that's the case, I'll  add the detection for hashing algorithms to
> lib/kconfig.c (together with a patch for
> tools/testing/selftests/net/config).
> And also heads up for key-management.c - that tries a bunch of hashing
> algorithms to check that the work and that the key rotation between
> different algorithms works:
> 
> : const char *test_algos[] = {
> : 	"cmac(aes128)",
> : 	"hmac(sha1)", "hmac(sha512)", "hmac(sha384)", "hmac(sha256)",
> : 	"hmac(sha224)", "hmac(sha3-512)",
> : 	/* only if !CONFIG_FIPS */
> : #define TEST_NON_FIPS_ALGOS	2
> : 	"hmac(rmd160)", "hmac(md5)"
> : };

I was stuck in a meeting and I started playing around with the options 
for TCP-AO :) I added these options now:

CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_RMD160=y
CONFIG_IPV6=y
CONFIG_TCP_AO=y
CONFIG_TCP_MD5SIG=y
CONFIG_VETH=m

And it looks much better! There are still some failures:

https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-01-24--18-00&executor=vmksft-tcp-ao

I added VRF so that should hopefully take care of the MD5 skips
on the next run. But the failures of the rst-ip* tests don't look 
like an obvious config problem.

