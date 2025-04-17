Return-Path: <linux-kselftest+bounces-31063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E1BA91E87
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF5246473C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB27422422B;
	Thu, 17 Apr 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTwdbrmV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523384D2B;
	Thu, 17 Apr 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897577; cv=none; b=BKdSom44jUB+xOqszNVUgK9dfSM13lvqESxu7/VTaL+PLb17n0UsRwiINZi8CVeewdCPjhsBgLLF0AHGFK5HW0B/lH7d5T2W/FX+gM6SnJnlhWwnrYeRZGDJUHBHQFd3PrINdRG/Lz3lA2YYV9RqRPIkuNJMrPsWfPidQcIFSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897577; c=relaxed/simple;
	bh=Jp3P1IDKrogJGTyaRjCD0IYiY+Sdkq83T+tFKxCJJQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SE16Eiul40UqpIwMGttoebrHgzUIHlqaHdRpgZtLBXg+OA3fIvgbPS2sOMIkQ1cfokQJD+SLwqnG/zexZXBg9jzEw+styEm8TRdHUIlSNwGfmsV3JamFMhfSo+N1wSbqSsHRIC7HkNZncuqqvS1X0BRP5I9vHTiTfortEouiQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTwdbrmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA693C4CEEA;
	Thu, 17 Apr 2025 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744897577;
	bh=Jp3P1IDKrogJGTyaRjCD0IYiY+Sdkq83T+tFKxCJJQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MTwdbrmVnx/M2TbvYbZ1GVcbtAT0j+KoA5FAy3SJuooWpGRktgfCWNigxhu9BEAp6
	 /5lMiXr2O9F6XsfL2P8GppZp/cknJHc5pg77zkVv1rCK8c2o8VdBJOz3YfGDtMP3+0
	 GYL0SHYq9V8X/mH58MQAi4h8urcpYfwblYninyUILl8B8fya2kbFTJA0H4rnbCjwp4
	 ZpI9QH4ppUDY1tZ/dV4fsDty1hXctTShuEpmCwzIrHilcBGNG/JoVTeNFcBEGnji8K
	 nU0fRLK2sJACJwDkK8aaE04rYAjGxoOk2ktwDuFFKfNKYjmCgGWL3eHiLf1iILyxJe
	 OMUvaQvq2Dr3g==
Date: Thu, 17 Apr 2025 06:46:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org (open list),
 linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
 bpf@vger.kernel.org (open list:XDP (eXpress Data
 Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID
 is non-zero
Message-ID: <20250417064615.10aba96b@kernel.org>
In-Reply-To: <20250417013301.39228-5-jdamato@fastly.com>
References: <20250417013301.39228-1-jdamato@fastly.com>
	<20250417013301.39228-5-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 01:32:42 +0000 Joe Damato wrote:
> Test that the SO_INCOMING_NAPI_ID of a network file descriptor is
> non-zero. This ensures that either the core networking stack or, in some
> cases like netdevsim, the driver correctly sets the NAPI ID.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  .../testing/selftests/drivers/net/.gitignore  |  1 +
>  tools/testing/selftests/drivers/net/Makefile  |  6 +-
>  .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
>  .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
>  4 files changed, 113 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
>  create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c
> 
> diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
> index ec746f374e85..71bd7d651233 100644
> --- a/tools/testing/selftests/drivers/net/.gitignore
> +++ b/tools/testing/selftests/drivers/net/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  xdp_helper
> +napi_id_helper

sort alphabetically, pls

> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 0c95bd944d56..47247c2ef948 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -6,9 +6,13 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
>  		 ../../net/net_helper.sh \
>  		 ../../net/lib.sh \
>  
> -TEST_GEN_FILES := xdp_helper
> +TEST_GEN_FILES := \
> +	napi_id_helper \
> +	xdp_helper \

like you did here

> +# end of TEST_GEN_FILES
>  
>  TEST_PROGS := \
> +	napi_id.py \
>  	netcons_basic.sh \
>  	netcons_fragmented_msg.sh \
>  	netcons_overflow.sh \
> diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
> new file mode 100755
> index 000000000000..aee6f90be49b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/napi_id.py
> @@ -0,0 +1,24 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_eq, NetDrvEpEnv
> +from lib.py import bkg, cmd, rand_port, NetNSEnter
> +
> +def test_napi_id(cfg) -> None:
> +    port = rand_port()
> +    listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']} {port}'

you need to deploy, in case test is running with a real remote machine
and the binary has to be copied over:

	bin_remote = cfg.remote.deploy(cfg.test_dir / "napi_id_helper")
	listen_cmd = f'{bin_remote} {cfg.addr_v['4']} {port}' 

> +    with bkg(listen_cmd, ksft_wait=3) as server:
> +        with NetNSEnter('net', '/proc/self/ns/'):
> +          cmd(f"echo a | socat - TCP:{cfg.addr_v['4']}:{port}", host=cfg.remote, shell=True)

Like Xiao Liang said, just host=cfg.remote should work.

> +    ksft_eq(0, server.ret)
> +

