Return-Path: <linux-kselftest+bounces-13198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC83927458
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 12:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D7D1F24AE4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5E61ABC4E;
	Thu,  4 Jul 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niGz4OCW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28E12D76E;
	Thu,  4 Jul 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090103; cv=none; b=o3DNLEndYW5NJ/AfqNvoG3altGRZzIt6k6Ipkp8/yg4FYGeHQarXXKf81cLsXL5Mh0LCuJLYiaLYayGJnTFxeiDVeN/67r/XVqCwusifM59AcnVYppWkoYZ9ISaJwbWCVBhSDwvxQEkiN287UTpgEZxb9ADin/xazlE5BqUjwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090103; c=relaxed/simple;
	bh=pHmfRCuwMzlTf/SrE8es8VdRuWYaIyylTLdUsdR6xLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgEQJCX0RksSYtu1PKYinHIFkbbgEXLj73ZNITzh8S/KLMKLaEXfpcPqs8vfKXXCc+hzeJcEZ92Ss+TlEW/8zmw6cj1xEWR59nb3wBf5/ur9PnK6RS/9txfMZqE3DLuHwDLFcPLIHnWUKUorHOwjGYi+UdODAiRk0ZsI9+G08kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niGz4OCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AF3C3277B;
	Thu,  4 Jul 2024 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720090102;
	bh=pHmfRCuwMzlTf/SrE8es8VdRuWYaIyylTLdUsdR6xLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=niGz4OCWan6TmdGNbh4XQ0HcPjIRNC72+MnRyLIhpBlXcx4v6kKZdY+pjNbrVN+GV
	 Y/9FpOYd95L9uAa96tuiMG0goT/ESAYBJoAnpiWI9ns71EY0Usp79wmviPbclw9piG
	 44SgCxQEderNIWjG0ZwZXaEIJv/9xVfioAqDYk4FnrmOi+EVIZ6K+YkoD7XUEvaeYX
	 xLHa/TemmerjJsGkV6cMcg0ruVr21IHyCbz06IL7az4d0+jDGHcbhyAqcWZyyoTJdq
	 Ngm1TK710+QujknQOMzllWzH3Ipd64kgQK/OtoI48pALQr8oum2Hlv85Z7/zr4z0WJ
	 K0ivdQu/rs28w==
Message-ID: <08f925cd-e267-4a6b-84b1-792515c4e199@kernel.org>
Date: Thu, 4 Jul 2024 12:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add mptcp pm_nl_ctl link
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
 <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-2-ebdc2d494049@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-2-ebdc2d494049@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

@BPF people: this new tool doesn't compile on the BPF CI [1]. Can I have
a hand to find the best way to fix this please? (see below)

[1] https://github.com/kernel-patches/bpf/pull/7296

On 03/07/2024 20:57, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a symlink to MPTCP's pm_nl_ctl tool into bpf selftests,
> and updates Makefile to compile it.
> 
> This is useful to run MPTCP BPF selftests on systems with an old version
> of IPRoute2. This tool can be used as an alternative to 'ip mptcp'.

(...)

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e0b3887b3d2d..204269d0b5b8 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -144,7 +144,7 @@ TEST_GEN_PROGS_EXTENDED = test_skb_cgroup_id_user \
>  	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
>  	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
>  	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
> -	xdp_features bpf_test_no_cfi.ko
> +	xdp_features bpf_test_no_cfi.ko mptcp_pm_nl_ctl
On the BPF CI, we have such errors:

   mptcp_pm_nl_ctl.c:20:10: fatal error: 'linux/mptcp.h' file not found
     20 | #include "linux/mptcp.h"
        |          ^~~~~~~~~~~~~~~

On my side, I don't have any issue, because the compiler uses the
mptcp.h file from the system: /usr/include/linux/mptcp.h

I suppose that's not OK on the BPF CI, as it looks like it doesn't have
this file there, probably because it still uses Ubuntu 20.04 as base,
which doesn't include this file in the linux-libc-dev package.

When I look at how this 'mptcp_pm_nl_ctl' tool -- and all the other
programs from that list -- is compiled (V=1), I see that the following
"-I" options are given:

  -I${PWD}/tools/testing/selftests/bpf
  -I${BUILD}//tools/include
  -I${BUILD}/include/generated
  -I${PWD}/tools/lib
  -I${PWD}/tools/include
  -I${PWD}/tools/include/uapi
  -I${BUILD}/

It will then not look at -I${PWD}/usr/include or the directory generated
with:

  make headers_install INSTALL_HDR_PATH=(...)

I guess that's why people have duplicated files in 'tools/include/uapi',
but I also understood from Jakub that it is not a good idea to continue
to do so.

What would be the best solution to avoid a copy? A symlink still looks
like a workaround.

In the other selftests, KHDR_INCLUDES is used to be able to include the
path containing the UAPI headers. So if someone built the headers in a
seperated directory -- INSTALL_HDR_PATH=(...) -- KHDR_INCLUDES can be
overridden to look there, instead of ${KERNEL_SRC}/usr/include. Would it
be OK to do that? Would it work for the CI without extra changes? Or do
you still prefer a copy/symlink to 'tools/include/uapi' instead?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


