Return-Path: <linux-kselftest+bounces-38475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5C9B1D9E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DF11896FE1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECEC1A2390;
	Thu,  7 Aug 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndMOndCF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A583A14;
	Thu,  7 Aug 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576523; cv=none; b=MnF9k7fmmV63mQR4PAgRbXaC7PXeltwztvjqzIVS2FBjjhGdmHsifGpxhj/YeeVqg6LChGeLcHb3OHrPa+o0BTL0Ysxs9GjzS4YJly/ANrpQyUBW9Awi+Kk2aFYagm4J8hjIJxOWaI3aguoWlvL+TzHp2qNCQ6tZ/U1nwktiWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576523; c=relaxed/simple;
	bh=dNa1Bny7iZ1EGEiI7VWML96Y5Ny6rNbeqmObEt5JvqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bs2JZNb7lrsIa3DLq9cC+3a9iK1GYuX7bDcp4WGg9RNLYVKl4rzqM0vnYuFEUKLtHJgigly2UFRgls7IF35pK69tdkNWPtnlN2d/ewbWA1BP6cHOdlAd9/rbU3RAsLUsJGLxohTlm4hOjJn1cJd6JU+OboTFt1YozZBs7PL/OJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndMOndCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF8AC4CEEB;
	Thu,  7 Aug 2025 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754576522;
	bh=dNa1Bny7iZ1EGEiI7VWML96Y5Ny6rNbeqmObEt5JvqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ndMOndCF1jWP98uGYI8uwuZTPvoRBUGkNZ7MJlthypDVWbWaqD5Ip3/YaqNZWdAi7
	 pAsrS3bgW/rVTdXma/79ooLYOWfZbfDlsDNkv8XCu8GV4hGPbt6mEEteV39XiwNX2u
	 Qu5dPMxB3o5zYz0j/A61bNdXH9vACHIuoqKl7iE6bW3Zx7yQy2L/OuKdMTfjtLwyXQ
	 FLdRK19bQXSF3It/rkgVriZZN6d9jqGDsPouuDP5U1I76H7Qh1fO5vyuhRAfDAsOxO
	 M1FA8Ob3fSmaIQiwaUd7jFzEPcIUy9cOZhbJG24PLa2ozjqOy6PojcrMAWxdMtsm42
	 1XlBXSaYXpJ9w==
Message-ID: <da46ad00-910f-4eb1-9b74-14bd76fc8910@kernel.org>
Date: Thu, 7 Aug 2025 16:21:53 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: BPF selftest: mptcp subtest failing
Content-Language: en-GB, fr-BE
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 Mat Martineau <martineau@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Geliang Tang <geliang@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 mptcp@lists.linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
References: <b1f933f6-545d-4f2e-a006-4e5568656c38@oracle.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b1f933f6-545d-4f2e-a006-4e5568656c38@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Harshvardhan,

On 07/08/2025 05:50, Harshvardhan Jha wrote:
> Hi there,
> I have explicitly disabled mptpcp by default on my custom kernel and
> this seems to be causing the test case to fail. Even after enabling
> mtpcp via sysctl command or adding an entry to /etc/sysctl.conf this
> fails. I don't think this test should be failing and should account for
> cases where mptcp has not been enabled by default?

It looks like the test is failing because it expects MPTCP to be enabled
by default. Or, said differently, it doesn't expect the kernel to be
modified without adapting the corresponding tests :)

> This is the custom patch I had applied on the LTS v6.12.36 kernel and
> tested it:
> 
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index dd595d9b5e50c..bdcc4136e92ef 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -89,7 +89,7 @@ const char *mptcp_get_scheduler(const struct net *net)
>  
>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>  {
> -	pernet->mptcp_enabled = 1;
> +	pernet->mptcp_enabled = 0;
>  	pernet->add_addr_timeout = TCP_RTO_MAX;
>  	pernet->blackhole_timeout = 3600;
>  	atomic_set(&pernet->active_disable_times, 0);

First, I have the same question as the one I asked to RedHat devs: do
you still need to keep MPTCP disabled by default? If I remember well, on
RHEL side, they started to do that when they backported MPTCP on a
previous stable version, as an experimental feature. They left it like
that later mostly for internal process reasons I think. But honestly,
today, it no longer makes sense to do that and annoys users: all other
Linux distributions enable MPTCP by default without patching the kernel
like you did.

If you don't want to revert this patch, I guess you can modify the BPF
selftests in 'prog_tests/mptcp.c' to set 'sysctl net.mptcp.enabled=1' in
each netns created by the test. But again, not changing the default
kernel behaviour sounds like a better solution.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


