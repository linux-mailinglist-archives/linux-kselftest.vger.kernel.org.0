Return-Path: <linux-kselftest+bounces-40438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B86FB3E603
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 15:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C183AF51F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85630F538;
	Mon,  1 Sep 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zyle+fcC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB97E2327A3;
	Mon,  1 Sep 2025 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734613; cv=none; b=FpJ+sAn5o5A4YUOlF7SqvG6GCJbxqH/5AEyPceeapqZ028zuQ/GxcvwaGvJDyT54hGIWLs8p7AtOv5qSR2aA/y0OnwybB40lv30XV4VowVFtW2jofiUWiQ/+ocjZwlslJLUjjTbiV+kWI3+oIeHRgb/uv0nFrLNgZlKoHlfnhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734613; c=relaxed/simple;
	bh=jGIDM6obL+9eY84QltDCoL1pALb6doR94h6nUuX618I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giK6xaOrdBLUhPZaDFWnBnMw3ZQ0gNSrurklxOlCWKHK7LbA0adS7p62sVJITSlfyn8yP9jrjDBSowmFMr2ABUk8pCreYL30w1I8tS7s0quW6PidJYrIPWbGGaKeaEnjDTaYfvlSs8tdLHtoIgVLyB7XNeRCr7bEru75xPgx3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zyle+fcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47170C4CEF1;
	Mon,  1 Sep 2025 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756734612;
	bh=jGIDM6obL+9eY84QltDCoL1pALb6doR94h6nUuX618I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zyle+fcCf79Ug4opxaUokSYrLVFoQCkEIBgyqYG6oZ1S05muuk5IOnI5KFm+YNbSq
	 G/Wi69fFjkml9tCGkwWOikDE6T+L7gY+WWH9vB5kMk/JQrYNgll52do5eRFncN4V0p
	 Syf6WHjA1HO+j2IDtyRrzKsfDu+2Ytl5wTMIZ5f1wRdT/YmmBBrIPf42O4ZUmmHfCU
	 6XMm1ajOV8vzh4f3u+F8V6P+j1PUHqemt8tbM02WD0gLpD9Jv2+dPr8ppJTFx4/OEy
	 4eF/5S5m1iVIGCVCLeDoA3a0dKqG8qQLdNIIHI5agdI8IFJAiedn+HhtLVz0YKc/+W
	 +heRGDXpSdauw==
Date: Mon, 1 Sep 2025 14:50:08 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, ecree.xilinx@gmail.com,
	gal@nvidia.com, joe@dama.to, linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: rss_ctx: use Netlink
 for timed reconfig
Message-ID: <20250901135008.GC15473@horms.kernel.org>
References: <20250829220712.327920-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829220712.327920-1-kuba@kernel.org>

On Fri, Aug 29, 2025 at 03:07:11PM -0700, Jakub Kicinski wrote:
> The rss_ctx test has gotten pretty flaky after I increased
> the queue count in NIPA 2->3. Not 100% clear why. We get
> a lot of failures in the rss_ctx.test_hitless_key_update case.
> 
> Looking closer it appears that the failures are mostly due
> to startup costs. I measured the following timing for ethtool -X:
>  - python cmd(shell=True)  : 150-250msec
>  - python cmd(shell=False) :  50- 70msec
>  - timed in bash           :  45- 55msec
>  - YNL Netlink call        :   2-  4msec
>  - .set_rxfh callback      :   1-  2msec
> 
> The target in the test was set to 200msec. We were mostly measuring
> ethtool startup cost it seems. Switch to YNL since it's 100x faster.
> 
> Lower the pass criteria to ~75msec, no real science behind this number
> but we removed ~150msec of overhead, and the old target was 200msec.
> So any driver that was passing previously should still pass with 75msec.
> 
> Separately we should probably follow up on defaulting to shell=False,
> when script doesn't explicitly ask for True, because the overhead
> is rather significant.

+1

> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/rss_ctx.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> index 9838b8457e5a..3fc5688605b5 100755
> --- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> @@ -335,19 +335,20 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
>      data = get_rss(cfg)
>      key_len = len(data['rss-hash-key'])
>  
> -    key = _rss_key_rand(key_len)
> +    ethnl = EthtoolFamily()
> +    key = random.randbytes(key_len)

Is the update to the generation of key intended?
It's not clear to me how it relates to the rest of the patch.

>  
>      tgen = GenerateTraffic(cfg)
>      try:
>          errors0, carrier0 = get_drop_err_sum(cfg)
>          t0 = datetime.datetime.now()
> -        ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))
> +        ethnl.rss_set({"header": {"dev-index": cfg.ifindex}, "hkey": key})
>          t1 = datetime.datetime.now()
>          errors1, carrier1 = get_drop_err_sum(cfg)
>      finally:
>          tgen.wait_pkts_and_stop(5000)
>  
> -    ksft_lt((t1 - t0).total_seconds(), 0.2)
> +    ksft_lt((t1 - t0).total_seconds(), 0.075)
>      ksft_eq(errors1 - errors1, 0)
>      ksft_eq(carrier1 - carrier0, 0)
>  
> -- 
> 2.51.0
> 

