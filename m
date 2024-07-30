Return-Path: <linux-kselftest+bounces-14414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EE2940400
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 03:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FA21F221F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 01:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B8945A;
	Tue, 30 Jul 2024 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy1F8cNF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB6A23;
	Tue, 30 Jul 2024 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722304683; cv=none; b=Wme+hSRSPYeavRdyUcbJP/arPhFYh925/SmOAgSbopFVmkufZKZEpMsMdmaBh+iAbOtIBv+TlKDvrOWShVl9egqCTsXRm+Qz7XJyNxnHdWW2uZB8w7ruUZLYWoXkdhCayFfTb7CYtwJy79vJH3FsS1dyQ2XlJtYBAuDZuKfYswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722304683; c=relaxed/simple;
	bh=2oQGt5CF3bqTfabQJ+45Y7Gca0Cw7g8NKOUKqqq3hmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATgUyU188vada9pVv/Fy5eq0eqWCYYBlO8F6KUXX5q9EO/Eqx0VgDqcfsbC2hOR+ny17nMm1blMuPYUtWVnY1wFVu435C+7l3WT1FTtZJSUeuTTmK+6985SzZwNcU0xU9xQ+t/3GQywX1W3W/ffWjyFGxIhSSodX6ICT8uPpc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy1F8cNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26508C32786;
	Tue, 30 Jul 2024 01:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722304682;
	bh=2oQGt5CF3bqTfabQJ+45Y7Gca0Cw7g8NKOUKqqq3hmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iy1F8cNFS+e59IVCkdtD/T2Jmc7WlPgjOvlpUl8vQMbt2dbVYvt6fQ4vumryvwMZw
	 HTaklt4CIOraeuz2AOxhJfiKXgTbPwqWFbRnaQZJ3WxmOppdw7oLRQcgUDGu0q/pqw
	 T2cYMT9XFCT7wPAeyvX4dy77yVJZK4V2ic3JJJ32uWK3hzEipQD0SRuqiSUYYqCBOx
	 ufZbHZsPwOIoDD5NMaYA/ZbuUVYCxf547KO32SpRUTCWYdFX36LGdcSh49sTKT52Zu
	 ABjJDpAKkhWjkz0/vwM5bt/jlHo6gasY4vs/5wBZbfEZDmZbqrLCLdKcEoqn59bN+n
	 xH2eD/9h1ndSg==
Date: Mon, 29 Jul 2024 18:58:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Shuah Khan <shuah@kernel.org>, Joe Damato
 <jdamato@fastly.com>, Petr Machata <petrm@nvidia.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: net-drv: exercise queue stats
 when the device is down
Message-ID: <20240729185801.7013ecd3@kernel.org>
In-Reply-To: <20240729221042.2700882-1-sdf@fomichev.me>
References: <20240729221042.2700882-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 15:10:41 -0700 Stanislav Fomichev wrote:
> Verify that total device stats don't decrease after it has been turned down.
> Also make sure the device doesn't crash when we access per-queue stats
> when it's down (in case it tries to access some pointers that are NULL).
> 
> KTAP version 1
> 1..5
> ok 1 stats.check_pause
> ok 2 stats.check_fec
> ok 3 stats.pkt_byte_sum
> ok 4 stats.qstat_by_ifindex
> ok 5 stats.check_down
> \# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

nit: may be personal preference but if you indent by 2 spaces
     that will neutralize the # as well

> +def check_down(cfg) -> None:
> +    try:
> +        qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)
> +    except NlError as e:
> +        if e.error == 95:
> +            raise KsftSkipEx("qstats not supported by the device")
> +        raise
> +
> +    ip(f"link set dev {cfg.dev['ifname']} down")
> +
> +    try:

The rest of this test predates defer() but I think it may be cleaner:

	ip(f"link set dev {cfg.dev['ifname']} down")
	defer(ip, f"link set dev {cfg.dev['ifname']} up")

then you don't need to try/finally.

> +        qstat = qstat[0]
> +        qstat2 = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
> +        for k, v in qstat.items():
> +            if k not in qstat2:
> +                # skip the stats that are not globally preserved
> +                continue

I think we should fail if stats disappear. I can't think of a legit
reason for that to happen.

> +            if qstat2[k] < qstat[k]:
> +                raise Exception(f"{k} ({qstat2[k]}) should be preserved but has lower value ({qstat[k]}) when the device is down")

	ksft_ge(qstat2[k], qstat[k], comment=k)
?

> +
> +        # exercise per-queue API to make sure that "device down" state
> +        # is handled correctly and doesn't crash
> +        netfam.qstats_get({"ifindex": cfg.ifindex, "scope": "queue"}, dump=True)
> +    finally:
> +        ip(f"link set dev {cfg.dev['ifname']} up")
> +
> +
>  def main() -> None:
>      with NetDrvEnv(__file__) as cfg:
> -        ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex],
> +        ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex,
> +                  check_down],
>                   args=(cfg, ))
>      ksft_exit()
>  


