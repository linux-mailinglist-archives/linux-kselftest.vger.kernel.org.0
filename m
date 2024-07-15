Return-Path: <linux-kselftest+bounces-13726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA704931431
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 14:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D21B2140C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E0E18C168;
	Mon, 15 Jul 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsgwRnix"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827413B295;
	Mon, 15 Jul 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046464; cv=none; b=p4FvUlGqzUmeu1TMvoMdJex/Sz8focgZnA0fNJwfNgLz/ZqVX8DH22Xx4oQ5mZ8Z3Co3DCXI5xD3V5PTF+vMjx2w0+OMvRvYJ25tj/zUT/aDHUme+MiMFDgdNjADnLmOM7+Kk11G+CbywVj86GM2t/gVuKabqprZzlMgAqqNS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046464; c=relaxed/simple;
	bh=OydOCMejKpJcg79tQCcz01EkeqMAe0rOO+MxhxkGudM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2uBm7UXYqBzL4dBzOdbFa2cKH4wWCJHQ/aVsLUSt/ZxJxZ9WDZEsM6UddPbZ5O68TPIP0Y+q6d2xc11oAu2biDIuOihpYRreTyujH22ZX2FNFhAvVjSa8RFJBr/ebujlFUK+2+meNxcgEM+PnSDw24uEsdUoLZfEusLSjnvRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsgwRnix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FD3C32782;
	Mon, 15 Jul 2024 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721046464;
	bh=OydOCMejKpJcg79tQCcz01EkeqMAe0rOO+MxhxkGudM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsgwRnix/92vzUvhsVv0wv1BuX/ZlDDvUQn8PQo9Wi3/SQSD10ETwPZTf8rNemh0B
	 d36jxtTg34q2UgNg4dBj2GhfxCuiIJBkS6PKZdioZ9S7t2QHLj+ayxE3FFfNZX7ggZ
	 sy8NuKizDNaX/4mpjTY4cViCH8y6PxMrQp8XgWifeqG+zn1Tmv+7VWXuIvIn6xVmPY
	 Kao0IXhFfmHjwMdr2dFM6fKhfnAz4oA2IX4Kx+kfYPjHTY6W6M27QzyTVUeIuKOYJ4
	 ySncMAmw9sEezUeTWw0URqON07YGmoIqXKIOUYIYGU3wSWsN4hMRyFOfhgwk+Yacgc
	 WXjiXxP2k5+uA==
Date: Mon, 15 Jul 2024 13:27:37 +0100
From: Simon Horman <horms@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	ebpf@linuxfoundation.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: integrate test_xdp_veth into
 test_progs
Message-ID: <20240715122737.GA45692@kernel.org>
References: <20240715-convert_test_xdp_veth-v2-0-46290b82f6d2@bootlin.com>
 <20240715-convert_test_xdp_veth-v2-2-46290b82f6d2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715-convert_test_xdp_veth-v2-2-46290b82f6d2@bootlin.com>

On Mon, Jul 15, 2024 at 11:53:45AM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> test_xdp_veth.sh tests that XDP return codes work as expected, by bringing
> up multiple veth pairs isolated in different namespaces, attaching specific
> xdp programs to each interface, and ensuring that the whole chain allows to
> ping one end interface from the first one. The test runs well but is
> currently not integrated in test_progs, which prevents it from being run
> automatically in the CI infrastructure.
> 
> Rewrite it as a C test relying on libbpf to allow running it in the CI
> infrastructure. The new code brings up the same network infrastructure and
> reuses the same eBPF programs as test_xdp_veth.sh, for which skeletons are
> already generated by the bpf tests makefile.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> The new code has been tested in an aarch64 qemu instance:
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> I have also checked that some minor alterations in the network
> configuration (altering the redirect map, or not loading one of the xdp
> programs) make the test fail.
> 
> On my testing setup, the test takes a bit more than 3 seconds to run on
> average.
> 
> Changes in v2:
> - fix many formatting issues raised by checkpatch
> - use static namespaces instead of random ones
> - use SYS_NOFAIL instead of snprintf() + system ()
> - squashed the new test addition patch and the old test removal patch
> ---
>  tools/testing/selftests/bpf/Makefile               |   1 -
>  .../selftests/bpf/prog_tests/test_xdp_veth.c       | 211 +++++++++++++++++++++
>  tools/testing/selftests/bpf/test_xdp_veth.sh       | 121 ------------
>  3 files changed, 211 insertions(+), 122 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index a7932bead77d..2864a0dc04d5 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -117,7 +117,6 @@ TEST_PROGS := test_kmod.sh \
>  	test_xdp_redirect.sh \
>  	test_xdp_redirect_multi.sh \
>  	test_xdp_meta.sh \
> -	test_xdp_veth.sh \
>  	test_tunnel.sh \
>  	test_lwt_seg6local.sh \
>  	test_lirc_mode2.sh \
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> new file mode 100644
> index 000000000000..3ffeb411c131
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * Create 3 namespaces with 3 veth peers, and
> + * forward packets in-between using native XDP
> + *
> + *                      XDP_TX
> + * NS1(veth11)        NS2(veth22)        NS3(veth33)
> + *      |                  |                  |
> + *      |                  |                  |
> + *   (veth1,            (veth2,            (veth3,
> + *   id:111)            id:122)            id:133)
> + *     ^ |                ^ |                ^ |
> + *     | |  XDP_REDIRECT  | |  XDP_REDIRECT  | |
> + *     | ------------------ ------------------ |
> + *     -----------------------------------------
> + *                    XDP_REDIRECT
> + */

Hi Alexis,

A minor nit from my side.

The comment above starts with '/**' but otherwise it is not a Kernel doc.
It's probably best if it's a networking-style multi-line comment instead.

/* Create 3 namespaces with 3 veth peers, and
 * ...
 */

...

