Return-Path: <linux-kselftest+bounces-8989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29588B4681
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 15:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA605B217BC
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD994F5EC;
	Sat, 27 Apr 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrOSMGl5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28F4F201;
	Sat, 27 Apr 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714225773; cv=none; b=MZGGGE6aXTDqDOcshNSkYtJeFF8CnymEc1wZEOBJOGGXtodGQ5Zy5P2HKoSLstD3ooKvR5egWD+pFZpn7Lr7x0OOXXpjdvEqvj0G4gyJCdVOHuJATAM7+ATheOfZiiymsqK/rxyZIUriMD8dDk92emgpERv8mSK2Cy6HU/ntTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714225773; c=relaxed/simple;
	bh=37TP0DViE2pTNt0k4sP7y4WhwG/6OLmWNKr0syJIxHs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uk0beUqnrG2ztL6rh6OVS7nuGHJj87d9Pa3fksEikNApCfdVHJBzSctSLlRXPIa36sklMTTfpHpvRrH3+VGys5/pxT/mIq35chuQ2LPe/E+tdnm6DXK77wHPJUrGf0f4QmgXXsewy9lnqDm7FTWcR3ENZ+zKmZYyqExHIbTQCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrOSMGl5; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c7510d1bacso1878487b6e.1;
        Sat, 27 Apr 2024 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714225769; x=1714830569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uif6sRwCq4B8viNrsdUGAHvyCJzvNgkSWnFMpuBhOpI=;
        b=NrOSMGl5Aog1EsbHChbSO/cbNa++y0t0b8LMJI0lw+X9+VbI1YwwZrRYRn4CQ18V51
         MREf7/PldjmyVTqUuClCxe3gcrAv3y4KItDqyqEgoU0pi7JXBHNRNIRffbzWNEuB7Qy1
         4zsT7xTkWJw7MaLeglh94kU71PeeLNh2m5xaA4ywQJRJ4s4lVkcDIq7Z0Oh0H7laCtwV
         9vILhgA8bQkQ9+fe5XcS6rKEJgq8hCv07aoVXysHr7fb/lNaHaYr0iUyRk8N5zLvTXkK
         5ZmnONSkNJRyp2XfbXkFbsQEyQ1bsPq4QpAJ8H8VWumcWSao2Tqo4UvkgdTjMSg8Tnv7
         6y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714225769; x=1714830569;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uif6sRwCq4B8viNrsdUGAHvyCJzvNgkSWnFMpuBhOpI=;
        b=Olmn7vMpZ+A8XYAmkgFsxj79tKKv49hex4Twv5m3cNjlrIQFQhOW6DDzteGwpkDkGz
         vr8HAz2iWIf2MVeA8onLf9RYRKOo/NXkiCY7gACl5B9dr+snJSWHUrJuYM0X2UoZMxhP
         pKBzaDCQv3eSyjgOuvr4sbyxHZWENm6RYrhu8+BLPzO6FRgK4A4pjpB5ikXqO9gt+cq3
         +CA1RAXLiTQ5ah5eTRcGFykE9B8mcpVXEzfBvcJjGOx33AFH39OaZ4IIRDn8kztNpWn/
         +5hJaHErtuGUt5YuGwaY8kiCveoEUuT4XS+3ZmEAHUpGe7BkWoVebeCoXvY6V9E5jIKP
         D2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXCtEyo5Dsnj3cO0WcL/ltpCse6sRbtN5kStXiiQSSA0rkWBnL3wAFS7vHPyyO/YWKdo3BSn9UbeknOCPpnobKK1zgCzLqNceoD9Tbn0731
X-Gm-Message-State: AOJu0Yz+O7GH454eLJ9LqV4NkF8RlRSAgBDrMZOe+YvslBv4Tp302iU9
	RcUEEpLoIPcTI3rnzO+D+fyQO+EunvBkvp5x7X4J9itG78njO4F9
X-Google-Smtp-Source: AGHT+IHGgYWNmBXVNLK0MOhie3KsIcVdcxZ1aNfnbhC+ixNnJbZpTcdheWNcGZiFgyTm27NnbZU4Vw==
X-Received: by 2002:a05:6808:2882:b0:3c8:4948:ee2b with SMTP id eu2-20020a056808288200b003c84948ee2bmr6876054oib.5.1714225769544;
        Sat, 27 Apr 2024 06:49:29 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a0d4f00b0078ee090baa3sm8829101qkl.10.2024.04.27.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 06:49:29 -0700 (PDT)
Date: Sat, 27 Apr 2024 09:49:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <662d0268e71c5_28b98529417@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240426232400.624864-7-kuba@kernel.org>
References: <20240426232400.624864-1-kuba@kernel.org>
 <20240426232400.624864-7-kuba@kernel.org>
Subject: Re: [PATCH net-next 6/6] selftests: drv-net-hw: add test for memory
 allocation failures with page pool
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
> Bugs in memory allocation failure paths are quite common.
> Add a test exercising those paths based on qstat and page pool
> failure hook.
> 
> Running on bnxt:
> 
>   # ./drivers/net/hw/pp_alloc_fail.py
>   KTAP version 1
>   1..1
>   # ethtool -G change retval: success
>   ok 1 pp_alloc_fail.test_pp_alloc
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> I initially wrote this test to validate commit be43b7489a3c ("net/mlx5e:
> RX, Fix page_pool allocation failure recovery for striding rq") but mlx5
> still doesn't have qstat. So I run it on bnxt, and while bnxt survives
> I found the problem fixed in commit 730117730709 ("eth: bnxt: fix counting
> packets discarded due to OOM and netpoll").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../selftests/drivers/net/hw/pp_alloc_fail.py | 129 ++++++++++++++++++
>  tools/testing/selftests/net/lib/py/ksft.py    |   4 +
>  3 files changed, 134 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 95f32158b095..1dd732855d76 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -9,6 +9,7 @@ TEST_PROGS = \
>  	hw_stats_l3.sh \
>  	hw_stats_l3_gre.sh \
>  	loopback.sh \
> +	pp_alloc_fail.py \
>  	#
>  
>  TEST_FILES := \
> diff --git a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
> new file mode 100755
> index 000000000000..026d98976c35
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
> @@ -0,0 +1,129 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import time
> +import os
> +from lib.py import ksft_run, ksft_exit, ksft_pr
> +from lib.py import KsftSkipEx, KsftFailEx
> +from lib.py import NetdevFamily, NlError
> +from lib.py import NetDrvEpEnv
> +from lib.py import cmd, tool, GenerateTraffic
> +
> +
> +def _write_fail_config(config):
> +    for key, value in config.items():
> +        with open("/sys/kernel/debug/fail_function/" + key, "w") as fp:
> +            fp.write(str(value) + "\n")
> +
> +
> +def _enable_pp_allocation_fail():
> +    if not os.path.exists("/sys/kernel/debug/fail_function"):
> +        raise KsftSkipEx("Kernel built without function error injection (or DebugFS)")
> +
> +    if not os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_pages"):
> +        with open("/sys/kernel/debug/fail_function/inject", "w") as fp:
> +            fp.write("page_pool_alloc_pages\n")
> +
> +    _write_fail_config({
> +        "verbose": 0,
> +        "interval": 511,
> +        "probability": 100,
> +        "times": -1,
> +    })
> +
> +
> +def _disable_pp_allocation_fail():
> +    if not os.path.exists("/sys/kernel/debug/fail_function"):
> +        return
> +
> +    if os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_pages"):
> +        with open("/sys/kernel/debug/fail_function/inject", "w") as fp:
> +            fp.write("\n")
> +
> +    _write_fail_config({
> +        "probability": 0,
> +        "times": 0,
> +    })
> +
> +
> +def test_pp_alloc(cfg, netdevnl):
> +    def get_stats():
> +        return netdevnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
> +
> +    def check_traffic_flowing():
> +        stat1 = get_stats()
> +        time.sleep(1)
> +        stat2 = get_stats()
> +        if stat2['rx-packets'] - stat1['rx-packets'] < 15000:
> +            raise KsftFailEx("Traffic seems low:", stat2['rx-packets'] - stat1['rx-packets'])
> +
> +
> +    try:
> +        stats = get_stats()
> +    except NlError as e:
> +        if e.nl_msg.error == -95:
> +            stats = {}
> +        else:
> +            raise
> +    if 'rx-alloc-fail' not in stats:
> +        raise KsftSkipEx("Driver does not report 'rx-alloc-fail' via qstats")
> +
> +    set_g = False
> +    traffic = None
> +    try:
> +        traffic = GenerateTraffic(cfg)
> +
> +        check_traffic_flowing()
> +
> +        _enable_pp_allocation_fail()
> +
> +        s1 = get_stats()
> +        time.sleep(3)
> +        s2 = get_stats()
> +
> +        if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < 1:
> +            raise KsftSkipEx("Allocation failures not increasing")
> +        if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < 100:
> +            raise KsftSkipEx("Allocation increasing too slowly", s2['rx-alloc-fail'] - s1['rx-alloc-fail'],
> +                             "packets:", s2['rx-packets'] - s1['rx-packets'])
> +
> +        # Basic failures are fine, try to wobble some settings to catch extra failures
> +        check_traffic_flowing()
> +        g = tool("ethtool", "-g " + cfg.ifname, json=True)[0]
> +        if 'rx' in g and g["rx"] * 2 <= g["rx-max"]:
> +            new_g = g['rx'] * 2
> +        elif 'rx' in g:
> +            new_g = g['rx'] // 2
> +        else:
> +            new_g = None
> +
> +        if new_g:
> +            set_g = cmd(f"ethtool -G {cfg.ifname} rx {new_g}", fail=False).ret == 0
> +            if set_g:
> +                ksft_pr("ethtool -G change retval: success")
> +            else:
> +                ksft_pr("ethtool -G change retval: did not succeed", new_g)
> +        else:
> +                ksft_pr("ethtool -G change retval: did not try")
> +
> +        time.sleep(0.1)
> +        check_traffic_flowing()
> +    finally:
> +        _disable_pp_allocation_fail()
> +        if traffic:
> +            traffic.stop()

Very cool!

Eventually probably want a more generic fault injection class.

And for both fault injection and background traffic the with object
construct to ensure cleanup in all cases.

Maybe even the same for ethtool, as ip and ethtool config changes that
need to be reverted to original state will be common.

To be clear, not at all suggesting to revise this series for that.

> +        time.sleep(0.1)
> +        if set_g:
> +            cmd(f"ethtool -G {cfg.ifname} rx {g['rx']}")
> +
> +
> +def main() -> None:
> +    netdevnl = NetdevFamily()
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +
> +        ksft_run([test_pp_alloc], args=(cfg, netdevnl, ))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index f84e9fdd0032..4769b4eb1ea1 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -11,6 +11,10 @@ KSFT_RESULT = None
>  KSFT_RESULT_ALL = True
>  
>  
> +class KsftFailEx(Exception):
> +    pass
> +
> +
>  class KsftSkipEx(Exception):
>      pass
>  
> -- 
> 2.44.0
> 



