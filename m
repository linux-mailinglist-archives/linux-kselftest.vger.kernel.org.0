Return-Path: <linux-kselftest+bounces-23923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1985DA01A29
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 16:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6243A220C
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BDB1487C5;
	Sun,  5 Jan 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU2Dppsq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12EAF9C1;
	Sun,  5 Jan 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736092554; cv=none; b=Ede0YEXJZ6QgjkQrSG0e98oKkFgjRgOm7UVUq4Aq6sELaK7kim48SzaB/hoIV6TdOENonPgaz7gRSCYte7+QIeLrhkGDGzIj2dEJwFKSaJMMlASdSsxPw4eNaT8FtYwnPGqqi4odt4Wflk6vQUxJR2Q210Cge18cf3CSq4H+Cjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736092554; c=relaxed/simple;
	bh=vHiyfqbbiMv27ceQHkYUTpJyBV3Jr00owhby3UcZeA8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=biaOD9HIP2iC5WrPs6pvxdmI5dui+jKPsTp0jYCEoMowSGx+hXJQKacbR+8uYHKDHiIvyNBbcq4OCKgfnslD9oBtMutvGFbLgAtnfROioPKagFCIwbndcg5rebpX6WU27XcPFRuMjf1Kt6XSgw3ZJAAqAlnkvGtc5/GEokVZFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LU2Dppsq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6c3629816so694749885a.1;
        Sun, 05 Jan 2025 07:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736092551; x=1736697351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjBzssZLOeeCrtTzTNVMOIQiCtnHfR58sCjKytPf3C4=;
        b=LU2Dppsq8jpZllcaLnjlD5TnbSHwMzdJImQTL83AP0dRD0YRW66GnEqvb/R10D7W4e
         tVI90mvAUIijXo65Yf7UVS9I/OHjriqVd40IXIx4MSIehsnGVzqxEHi5914QSZ16k+Lu
         6FEz+R/YAYjia6JqM+B0+5BbDXCrPdDzL3+vtw0ah6pGUWG96MDyWwTRH9HobP3bRdJ6
         RLl4nqMq/Po7gXXSIT3wkn2mJ6TRGLYm+RoBh3LYgz63b4ojPR1oN8j03qqXiossNV/H
         Csexk1wjzVi9qfoCuPFjO4+RKhwyrFvcRAvfs4NzzRzeATr7eSd/cyXKamJXLf1Enhgi
         iFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736092552; x=1736697352;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QjBzssZLOeeCrtTzTNVMOIQiCtnHfR58sCjKytPf3C4=;
        b=FqpesMvLAiOD8OCQSaiUFSTCW/Sam/lfHW4uHYZ9ZD4Oo2bLXfsG2wgxq+zjFdTJIU
         /NiiNUVhj4zquurm8s5z6UTkt+vo2tQe4mumnMfgkM4iyt043XuXaJt4776Ri+kwNihr
         g8vaJXHt8QO9KkgIE0wAQ0b9TUQ1ydq3STtym7R01W2DWf6JedK77Tn/26ctxswc/lHJ
         JPy3gCHszNdSmt18a2ojjp7I+CGgMHjhk1g2hoZL7f7L8FH1w1mGCIDTKfohpv+0U4Id
         SYqIAFJhggPgAPJaOSiC9GqoN+0VbzjDCDC1Rtvj2sQc7xDvHB0n4WRcCpDrlj13f27N
         ySYA==
X-Forwarded-Encrypted: i=1; AJvYcCXQQ358/vsUnXDTRv0mzyUc7EY/QBLHYxZVja1QgZfH/R3QxzfihxvlgBv2YNMY5edhkoimCq9Nge3Fp/O00uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRkSPI2TyXaASTp/wszINHpOQiUDMIoDB0qKLpSNlRQ4ZX+hdY
	iox+qa5/kNun1fRHLWVh/Z3vLM9ykaVxDmgYyWu7ol/zW/Jk8uVz
X-Gm-Gg: ASbGncsIt7IPK45XzNEUx/vkvKaNj93VNbgMyKjumcnU/CMuFraKIvLKTHF/weWcDEm
	B1Pz9P7k0Cscuk0GmrOVpqXQXKWd1BEYeWQ1ooMzlzODVOcsJuGgyhE6rtXx5pVj3uj0g/WK49s
	xn7Bmki797xs1+thYqfQUO+KWcMue2DQTD3J8DN8CDpa4AdNMC3ipnTkE22p73VlTi+tnJaghYC
	sEDNv1ECS76WvCW/he4uLVLTIDMKJRdRKlcW6IuO5TWuMjvCo+7iEBfNExbEsEUZa2AJ9V5ub5y
	x6M0brVs7O6KhKYL1kFQ+ciRDzJb
X-Google-Smtp-Source: AGHT+IFInoUEVT+deoVMV6E0TFL9nHB+V+AsVTKQ5lXyd8G9Kp9J2jLwhlwPNfaXi3ek0nQxTAwIkQ==
X-Received: by 2002:a05:620a:1911:b0:7b6:ce4c:69d2 with SMTP id af79cd13be357-7b9ba7abfa9mr10459220885a.36.1736092551613;
        Sun, 05 Jan 2025 07:55:51 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac30e816sm1433833885a.64.2025.01.05.07.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 07:55:50 -0800 (PST)
Date: Sun, 05 Jan 2025 10:55:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <677aab862c9b3_15102629427@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250105011525.1718380-1-kuba@kernel.org>
References: <20250105011525.1718380-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: test drivers sleeping in
 ndo_get_stats64
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
> Most of our tests use rtnetlink to read device stats, so they
> don't expose the drivers much to paths in which device stats
> are read under RCU. Add tests which hammer profcs reads to
> make sure drivers:
>  - don't sleep while reporting stats,
>  - can handle parallel reads,
>  - can handle device going down while reading.
> 
> Set ifname on the env class in NetDrvEnv, we already do that
> in NetDrvEpEnv.
> 
>   KTAP version 1
>   1..7
>   ok 1 stats.check_pause
>   ok 2 stats.check_fec
>   ok 3 stats.pkt_byte_sum
>   ok 4 stats.qstat_by_ifindex
>   ok 5 stats.check_down
>   ok 6 stats.procfs_hammer
>   # completed up/down cycles: 6
>   ok 7 stats.procfs_downup_hammer
>   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Two tiny comments, neither cause for respin.

> +@ksft_disruptive
> +def procfs_downup_hammer(cfg) -> None:
> +    """
> +    Reading stats via procfs only holds the RCU lock, drivers often try
> +    to sleep when reading the stats, or don't protect against races.
> +    """
> +    # Max out the queues, we'll flip between max an 1

s/an/and/

> +    channels = ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> +    if channels['combined-count'] == 0:
> +        rx_type = 'rx'
> +    else:
> +        rx_type = 'combined'
> +    cur_queue_cnt = channels[f'{rx_type}-count']
> +    max_queue_cnt = channels[f'{rx_type}-max']
> +
> +    cmd(f"ethtool -L {cfg.ifname} {rx_type} {max_queue_cnt}")
> +    defer(cmd, f"ethtool -L {cfg.ifname} {rx_type} {cur_queue_cnt}")
> +
> +    # Real test stats
> +    stats = __run_inf_loop("cat /proc/net/dev")
> +    defer(stats.kill)
> +
> +    ipset = f"ip link set dev {cfg.ifname}"
> +    defer(ip, f"link set dev {cfg.ifname} up")

unimportant: could reference ipset here too, as in below.

> +    # The "echo -n 1" lets us count iterations below
> +    updown = f"{ipset} down; sleep 0.05; {ipset} up; sleep 0.05; " + \
> +             f"ethtool -L {cfg.ifname} {rx_type} 1; " + \
> +             f"ethtool -L {cfg.ifname} {rx_type} {max_queue_cnt}; " + \
> +              "echo -n 1"

