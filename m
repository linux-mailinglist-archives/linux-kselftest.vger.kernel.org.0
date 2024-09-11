Return-Path: <linux-kselftest+bounces-17746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE3B97551B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 16:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5791C22A2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5A192B96;
	Wed, 11 Sep 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQx8Y9FY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF857DA79;
	Wed, 11 Sep 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064311; cv=none; b=qy1DIeH7BwmxPAnb3oVEEgv41RPyhiDxV58+pPzi2174F8z4rnoNGxP1eTCiBmp+pikMeQrNKC4QSNs1c7Ltt1KN/lQ662MUm0JjItTBatHkcwzOXtMaLkW8mwzepq0dI+sUfAi+jt42NER06XlZcPrzOR8ui4IcQT0xdh60X/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064311; c=relaxed/simple;
	bh=iXEnj6dkhqKycbpJiOxMa4MmN2ml4Z0wD0WNs5FiKOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5TR88pEglv4wTvj9y38nw4s8j/6sPiFAjmH+pJNkRmi2NUWoY9/PQUnEp7w4te/COv1vqViIyVNVBmz9tCQY4k/rhnZHML1Jc/Wk0Zx4PXgbDDO4vAPWQIZulTCkWSeE93Byu+CM2jjO7OD4Thn0PiS8glah6CIa2n81BvPJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQx8Y9FY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390FAC4CEC0;
	Wed, 11 Sep 2024 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726064311;
	bh=iXEnj6dkhqKycbpJiOxMa4MmN2ml4Z0wD0WNs5FiKOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQx8Y9FYq25Qh5IgkLhY6n4hU6sOkdRiC0runQfhoy9P/pbRJv2z6/oOr0YfvH71b
	 2ovAWT2fQ0hgnllmxNtiJusqD3n7rsODkYluNvwd9CfKZWaw8MfbmIMrWrRxZWL9rr
	 eIkcj8wEvl90nsFE75qKpjo7I8ehvKVHf+ZnZ7p36p0VoTw5Fk106tPGvYS6raBmKw
	 AD0Gtd1kJ/vKNt2LsvixpqryV1ooIIK2OgsoLSjPCPRtd4Q7EP+T+QDtxCkTEcJsXV
	 v1SpGzoQjn1R+oWvzZ/e4KdoXmOxHPVpPeeMuJHy/NPviqxy7Eu4KUkxSIpIKn5Yxw
	 JfS0SMg7FO07A==
Date: Wed, 11 Sep 2024 15:18:24 +0100
From: Simon Horman <horms@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
Message-ID: <20240911141824.GZ572255@kernel.org>
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>

On Tue, Sep 10, 2024 at 08:10:35PM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> test_xdp_features.sh is a shell script allowing to test that xdp features
> advertised by an interface are indeed delivered. The test works by starting
> two instance of the same program, both attaching specific xdp programs to
> each side of a veth link, and then make those programs manage packets and
> collect stats to check whether tested XDP feature is indeed delivered or
> not. However this test is not integrated in test_progs framework and so can
> not run automatically in CI.
> 
> Rewrite test_xdp_features to integrate it in test_progs so it can run
> automatically in CI. The main changes brought by the rewrite are the
> following:
> - instead of running to separated processes (each one managing either the
>   tester veth or the DUT vet), run a single process
> - slightly change testing direction (v0 is the tester in local namespace,
>   v1 is the Device Under Test in remote namespace)
> - group all tests previously managed by test_xdp_features as subtests (one
>   per tested XDP feature). As a consequence, run only once some steps
>   instead of once per subtest (eg: starting/stopping the udp server). On
>   the contrary, make sure that each subtest properly cleans up its state
>   (ie detach xdp programs, reset test stats, etc)
> - since there is now a single process, get rid of the "control" tcp channel
>   used to configure DUT. Configuring the DUT now only consists in switching
>   to DUT network namespace and run the relevant commands
> - since there is no more control channel, get rid of TLVs, keep only the
>   CMD_ECHO packet type, and set it as a magic
> - simplify network setup: use only ipv6 instead of both ipv4 and ipv6,
>   force static neighbours instead of waiting for autoconfiguration, do not
>   force gro (fetch xdp features only once xdp programs are loaded instead)
> 
> The existing XDP programs are reused, with some minor changes:
> - tester and dut stats maps are converted to global variables for easier
>   usage
> - programs do not use TLV struct anymore but the magic replacing the echo
>   command
> - avoid to accidentally make tests pass: drop packets instead of forwarding
>   them to userspace when they do not match the expected payload
> - make sure to perform host <-> network endianness conversion on constants
>   rather than packet parts
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

...

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_features.c b/tools/testing/selftests/bpf/prog_tests/xdp_features.c
> new file mode 100644
> index 000000000000..bcb36a2d2767
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_features.c
> @@ -0,0 +1,446 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/**
> + * Test XDP features
> + *
> + * Sets up a veth pair, and for each xdp feature under test:
> + * - asks the tested interface its xdp capabilities through bpf_xdp_query
> + * - attach and run some specific programs on both interfaces to check if
> + *   announced capability is respected
> + */

Hi Alexis,

This is neither a full review nor an issue that needs to block progress.
But, FWIIW, the comment above is not a Kernel doc, yet starts with '/**'.
I suggest that it should start with '/*' instead.

...

