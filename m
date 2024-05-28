Return-Path: <linux-kselftest+bounces-10797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873448D260A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFE81F25825
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 20:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB917921D;
	Tue, 28 May 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi3TfS6n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22C178367;
	Tue, 28 May 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928785; cv=none; b=s8jORvo0CwIGwtxuHkZ9t0UGt2Sizs6olAupOUJuH1cxazbjJMrGe/MVUwKCdFW/JAMij1OxDChJxpGNwG39ZmDcp1TQ04QRCqjX+pnxwRrgWjqJ+Zmen+pPR7Y7Y33fI11dwS/gvTmxmfy8bxh33Noqc9vATk3b2+ITX1vdI7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928785; c=relaxed/simple;
	bh=TYVTZRo5nmWuVil17NvbOhNOtCCN39UJ3GSfUpEf2Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnwK5+LTwV0zGPZ6qLZRUNB4AfXFCuIE2TuM7XRxOaX4hEaP7Kd2/b79psgtWRhS3j0h8VWG1J/xs6cAs4tPZi/1jwwF6/1WdeNJFJz4FN/SSnZ801hX+Qea938XmTpSj0QlbUmXjF537JLmzfz4OI9XwiOZCG+YG9IXaJkXlWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi3TfS6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB83C4AF0B;
	Tue, 28 May 2024 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716928785;
	bh=TYVTZRo5nmWuVil17NvbOhNOtCCN39UJ3GSfUpEf2Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gi3TfS6nO9fVTFbBaL9hvY0iPBl28dMsspFOqKFZHE6fxs/jbXH6vXbqE4760N7YP
	 yizxJJhNBN92oZIHHXx4PXWA2P2ZhLAAl7o3BKPb8uiEdQ5+t9wnPyMZie7FWaTOUb
	 98CkaLSTrhQ6/aEQxlQkOszM/yYY29E3BYvWhsyPs4LDnWAzqH8NfbkgHdY8JQKSaW
	 EN2mOX+YtZPExFC1tjlTAIokrFRePZzTJjrUbeNjvVf86S6rINQ8EnuHMtByvEgPMC
	 uL7C8Cj/HMMaf7n9TMijwN8XV72lZbFsfLaW0atfAkv9fAKeWhdESHogO3oqcXpoTJ
	 w1tdlHjnhNCvw==
Date: Tue, 28 May 2024 13:39:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	zhujun2 <zhujun2@cmss.chinamobile.com>,
	Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev,
	dev@openvswitch.org, Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/net: suppress clang's "variable-sized type
 not at the end" warning
Message-ID: <20240528203941.GD2680415@thelio-3990X>
References: <20240527213641.299458-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527213641.299458-1-jhubbard@nvidia.com>

On Mon, May 27, 2024 at 02:36:41PM -0700, John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftest
> 
> ...clang warns that "a variable sized type not at the end of a struct or
> class is a GNU extension".
> 
> These cases are not easily changed, because they involve structs that
> are part of the API. Fortunately, however, the tests seem to be doing
> just fine (specifically, neither affected test runs any differently with
> gcc vs. clang builds, on my test system) regardless of the warning. So,
> all the warning is doing is preventing a clean build of selftests/net.
> 
> Fix this by suppressing this particular clang warning for the
> selftests/net suite.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Changes since the first version:
> 
> 1) Rebased onto Linux 6.10-rc1
> 
> thanks,
> John Hubbard
> 
> 
>  tools/testing/selftests/net/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index bd01e4a0be2c..9a3b766c8781 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -6,6 +6,10 @@ CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
>  # Additional include paths needed by kselftest.h
>  CFLAGS += -I../
>  
> +ifneq ($(LLVM),)
> +    CFLAGS += -Wno-gnu-variable-sized-type-not-at-end

For what it's worth, the main kernel has -Wno-gnu because there is
little point in warning about the use of GNU extensions when building
with '-std=gnu...'. It may be worth doing this anywhere that uses a GNU
standard in the selftests but I guess it depends on how noisy things
are.

> +endif
> +
>  TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
>  	      rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
>  TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh ip_defrag.sh
> 
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> -- 
> 2.45.1
> 
> 

