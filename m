Return-Path: <linux-kselftest+bounces-45824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67694C66FB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0EAF4EFDB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4F131D730;
	Tue, 18 Nov 2025 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmoi7Edm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691FB2248B4
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431716; cv=none; b=APUChPW9wEOrvNjo3wDFV1BJS09AVyijlQ2XG/OsjWuY+fFiCX+Btl/n+/vlBg/BxnC5bCWMjx137/DP/pn3RuZyBEYVOZ4xTD1R8ieIz4230BaFfBpxI+rB+K+AUgRa57g7qvW+5NSO62y6PM/h2dCOTR8v/c3uKPxKi1jRYTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431716; c=relaxed/simple;
	bh=qXwpEIpzlZ4dGG6K7A4Vr0bByulmueTp/CjkvUeJ/Pk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=feIWGSspq5qxAUme7as+B82PjbEzviCEveGRgZLkobGq9dcCpbLvbQ1DQbCfhXRWiu33Z/5lDnM16szqs/XvGxd4YKMIMax9jRBumzkTTbbtGcBKI+hgw1yGxcQ0QH+ox66Rqu2Cxw7Rtv/zOct+/mwXsfzF6Ik2EBjEGHNt3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmoi7Edm; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640d43060d2so4508596d50.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431712; x=1764036512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzTVMgU3wdzvq0P5BwgB3t9pJ50J7msyIrr6ULcWtR8=;
        b=Tmoi7EdmFj2XB/QuvSn9A01Y8CXXbQ39v59eOoxvt/uFOsqpFv9tq1/CtCZ92rM5eS
         nYLLLTAU7qxi1EvkrQFQksjkix+UHoVnVIYxCru3WTQu3FSeMK9jIbFJgrjKob4El6GY
         z5QNSXXvR0TRBJlVv4dIB/980gUv36TXLwirBYRzOAvDhy3m1r9AUlvkPz+RuttE9h+v
         /sdsggrwtJez0qtiqxOFaPjFzSjYEEyj2X8npFUZe3aK1s2xaadLrPaW6KHOHRk71bmb
         mrI2EgSCueWM1X8bSxT3r6uv5eCzcSy/j6Eh3AjWyfPLrHXbQa38pT9KAWhMvQoz+2Q7
         YbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431712; x=1764036512;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzTVMgU3wdzvq0P5BwgB3t9pJ50J7msyIrr6ULcWtR8=;
        b=qn4kc9UUjPvVU4DZGt/xE+AR5uJc6bdLp6FsD54ApDP/2Zw/Z6EfElq1KZH9aKdb9k
         vR2/EAzgbW4eF7uL0RbVsptxRBACDH968zkxpz0OPYyotPfoalLU5cbRA2mN5Tofn5Yt
         5atN4BmvjoT99jw6XihG5FdbRKlQ7EHDSy9mK4Ufmnk5w2vw1ZOoavqKNrB2sIko1WGD
         ui8d9aoa6yVNmi+NmZlhdRTrJgO4LGaAODtf4lxzYddlERsS5EWP3RP6G51t+FBri8bO
         fGqWEBYRGqYv8RRTr3yiNXayQ2X19sYq0v03gJURlwbJ/+SL9DLX/9GReLrU2STDi66K
         /BJA==
X-Forwarded-Encrypted: i=1; AJvYcCUQVJadJIs0aP8oMgjEw2LwBfFjphhM3Ofjbn3tjGNB2RD3/Na1TUtOMlb1q7bFXqZC1bzYpd6W/dTlaxQ3CWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6N2vFYlHanXEnwXsfTko8G6TuHCKlD4KAoXSb8Y2+9lwI/sYq
	+aLpkZNIGTgxNft5BYkirdpJhM90CzLJTn2mqsoBTiLqUcHsQjHoQ0h6
X-Gm-Gg: ASbGncuovuK3LNMXDYIyxm8kgaz2Hpv6QitWXCfzWL8I5vu3i6oobMRi5aK8XI1TDrH
	hf+gouDELdy+6E3Xzk51MQfnGzz3hHogIE3u5wRzpC/CFOFJYwT4iRs/pfWrNyAAFvaZQW/adJz
	jqKgM+ZcdwL4BO3+9vcrju4X5FfP/wPRNLV1QZzLuXGOPcdMkZTDaZnA5VC4AFy2acmLr+8Fiwo
	fH2+91HiQWi9/85FA5Is/dkEpkSYvhtf29bhOFh7O67Xsq29XeCuNi68jXhzR4x+dnw9FRc2H7H
	sbZg+KVJM6CG94c9OuvZoKOfsWTMpoqohlPYF5xEoj4IGPrh7q4jmtxj1zLW4Z/isfNuk5dAoof
	PDGPA9iwPOnNATVHHeYNITxz2oTo/36jdz0Vau3AwM+zyHnL/6LfvkN5iYqz5L24QgJReSPCsW4
	wp/3Bpb4ZIoCvBJWS+g4Iw9/wv8MXHulMm9zj7k1iNK/ltDDmy9dbceJcKy4S7XfIskVE=
X-Google-Smtp-Source: AGHT+IFH4bligcIh6T755+/aFFIYfTESFMbPudMNJO1QXvhArzfL3mERyZH8IMpiiKXiWfUE9AvJNg==
X-Received: by 2002:a05:690e:23c5:b0:63f:9f6d:5b1e with SMTP id 956f58d0204a3-641e76ac07dmr9543197d50.67.1763431712255;
        Mon, 17 Nov 2025 18:08:32 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78821e6952bsm48029657b3.26.2025.11.17.18.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:08:31 -0800 (PST)
Date: Mon, 17 Nov 2025 21:08:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.d636696e1da5@gmail.com>
In-Reply-To: <20251117205810.1617533-10-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
 <20251117205810.1617533-10-kuba@kernel.org>
Subject: Re: [PATCH net-next 09/12] selftests: drv-net: add a Python version
 of the GRO test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Rewrite the existing gro.sh test in Python. The conversion
> not exact, the changes are related to integrating the test
> with our "remote endpoint" paradigm. The test now reads
> the IP addresses from the user config. It resolves the MAC
> address (including running over Layer 3 networks).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/Makefile |   2 +-
>  tools/testing/selftests/drivers/net/gro.c    |   3 +
>  tools/testing/selftests/drivers/net/gro.py   | 161 +++++++++++++++++++
>  tools/testing/selftests/drivers/net/gro.sh   | 105 ------------
>  4 files changed, 165 insertions(+), 106 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/gro.py
>  delete mode 100755 tools/testing/selftests/drivers/net/gro.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 7083a8707c4e..f5c71d993750 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -11,7 +11,7 @@ TEST_GEN_FILES := \
>  # end of TEST_GEN_FILES
>  
>  TEST_PROGS := \
> -	gro.sh \
> +	gro.py \
>  	hds.py \
>  	napi_id.py \
>  	napi_threaded.py \
> diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
> index 9b9be0cf8f7f..995b492f5bcb 100644
> --- a/tools/testing/selftests/drivers/net/gro.c
> +++ b/tools/testing/selftests/drivers/net/gro.c
> @@ -58,6 +58,7 @@
>  #include <unistd.h>
>  
>  #include "../../kselftest.h"
> +#include "../../net/lib/ksft.h"
>  
>  #define DPORT 8000
>  #define SPORT 1500
> @@ -1127,6 +1128,8 @@ static void gro_receiver(void)
>  	set_timeout(rxfd);
>  	bind_packetsocket(rxfd);
>  
> +	ksft_ready();
> +
>  	memset(correct_payload, 0, sizeof(correct_payload));
>  
>  	if (strcmp(testname, "data") == 0) {
> diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
> new file mode 100755
> index 000000000000..a27f8106eb63
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/gro.py
> @@ -0,0 +1,161 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""
> +GRO (Generic Receive Offload) conformance tests.
> +
> +Validates that GRO coalescing works correctly by running the gro
> +binary in different configurations and checking for correct packet
> +coalescing behavior.
> +
> +Test cases:
> +  - data: Data packets with same size/headers and correct seq numbers coalesce
> +  - ack: Pure ACK packets do not coalesce
> +  - flags: Packets with PSH, SYN, URG, RST flags do not coalesce
> +  - tcp: Packets with incorrect checksum, non-consecutive seqno don't coalesce
> +  - ip: Packets with different ECN, TTL, TOS, or IP options don't coalesce
> +  - large: Packets larger than GRO_MAX_SIZE don't coalesce
> +"""
> +
> +import os
> +from lib.py import ksft_run, ksft_exit, ksft_pr
> +from lib.py import NetDrvEpEnv, KsftXfailEx
> +from lib.py import cmd, defer, bkg, ip
> +from lib.py import ksft_variants
> +
> +
> +def _resolve_dmac(cfg, ipver):
> +    """
> +    Find the destination MAC address remote host should use to send packets
> +    towards the local host. I may be a router / gateway address.

I -> It

> +    """
> +
> +    attr = "dmac" + ipver
> +    # Cache the response across test cases
> +    if hasattr(cfg, attr):
> +        return getattr(cfg, attr)
> +
> +    route = ip(f"-{ipver} route get {cfg.addr_v[ipver]}",
> +               json=True, host=cfg.remote)[0]
> +    gw = route.get("gateway")
> +    # Local L2 segment, address directly
> +    if not gw:
> +        setattr(cfg, attr, cfg.dev['address'])
> +        return getattr(cfg, attr)
> +
> +    # ping to make sure neighbor is resolved,
> +    # bind to an interface, for v6 the GW is likely link local
> +    cmd(f"ping -c1 -W0 -I{cfg.remote_ifname} {gw}", host=cfg.remote)
> +
> +    neigh = ip(f"neigh get {gw} dev {cfg.remote_ifname}",
> +               json=True, host=cfg.remote)[0]
> +    setattr(cfg, attr, neigh['lladdr'])
> +    return getattr(cfg, attr)

