Return-Path: <linux-kselftest+bounces-9440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18CF8BB7BA
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 00:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE1F1C216F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 22:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975D92C684;
	Fri,  3 May 2024 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOIwXnRy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F19339A1;
	Fri,  3 May 2024 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776581; cv=none; b=Wo/aDCS9eDNNshRAUh57NwbfXcMTGSQ/ewwVoOZeMvT+e4rxFI1ul7AnfQvJ/2RJ5jBcM88UB+gWzF99QEK8mwl+3przOXwJWarsrO/Jm+SWr3NdTq3dvW7ktM/DSaVpuppVWW7BFqKxGBf7HRBI3odsn6G+eeivTX6JKmFPFjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776581; c=relaxed/simple;
	bh=M+9Kg7/l2eYoa4JWzNR42f+5vfPaSwqcb+iR450hv2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdA3SWMUaAsgv9B3ibvbIo3RH5lH1rzyt17hRRBPhlbNM4aq5evu1u1gwg9E2ciO9kEo72Sl9K8xQTQz85NV48WGchdn3JKUZ8GDrmqkm82Mwb79oBmb2T1Neecgy8vseRoOAbKAIxsEERDnYz+6kre5SMu+EU2/B9PMvoKMrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOIwXnRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D627C116B1;
	Fri,  3 May 2024 22:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714776580;
	bh=M+9Kg7/l2eYoa4JWzNR42f+5vfPaSwqcb+iR450hv2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WOIwXnRyhbEKfyuqZt+JLTk0EulLi6KB/8IMk3R91gqvxsdgYqAsKRTMtwwbSmU1R
	 Dcw/StaVjPGzo6IkExptBc6LH1kIrs+HPi+5LxLcPQQURpxqlQC7Gw35rcbaPR+/Za
	 lcawY15BQdUMHbo7Al+MoLdDd6oylCshCMIye/B6rYQ6D2D+0PWFjp1D05UkcNXrwQ
	 PQ6Lihtzxc5jBGIjAEETCobAaIW6YyCAGDfvFLs+lO+CS4J2lWXNQq2K7rCjYB5dLI
	 qicoFaI0PvEP8K24dlyBFOYvKy9Q5taA3npqvgc5SIre/iVhtERcHEfVy40pM/QwJi
	 hKPl3uYknfPqw==
Date: Fri, 3 May 2024 15:49:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next] selftest: epoll_busy_poll: epoll busy poll
 tests
Message-ID: <20240503154939.79f7c878@kernel.org>
In-Reply-To: <20240502212013.274758-1-jdamato@fastly.com>
References: <20240502212013.274758-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 May 2024 21:20:11 +0000 Joe Damato wrote:
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -84,6 +84,7 @@ TEST_GEN_FILES += sctp_hello
>  TEST_GEN_FILES += csum
>  TEST_GEN_FILES += ip_local_port_range
>  TEST_GEN_FILES += bind_wildcard
> +TEST_GEN_FILES += epoll_busy_poll

"GEN" is for files which are built for other tests to use.
IOW unless there's also a wrapper script under TEST_PROGS
(or the C code is itself under TEST_PROGS) this test won't
be executed by most CIs.

FWIW here's how we run the tests in our CI upstream CI:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

>  TEST_PROGS += test_vxlan_mdb.sh
>  TEST_PROGS += test_bridge_neigh_suppress.sh
>  TEST_PROGS += test_vxlan_nolocalbypass.sh

> +static void do_simple_test(void)
> +{
> +	int fd;
> +
> +	fd = epoll_create1(0);
> +	if (fd == -1)
> +		error(1, errno, "epoll_create");
> +
> +	do_simple_test_invalid_fd();
> +	do_simple_test_invalid_ioctl(fd);
> +	do_simple_test_get_params(fd);
> +	do_simple_test_set_invalid(fd);
> +	do_simple_test_set_and_get_valid(fd);

You don't want to use the kselftest_harness for this?
No strong preference here, but seems like you could
pop the epoll_create1 into a FIXTURE() and then the
test cases into TEST_F() and we'd get the KTAP output
formatting, ability to run the tests selectively etc.
for free.

tools/testing/selftests/net/tap.c is probably a good example 
to take a look at

