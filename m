Return-Path: <linux-kselftest+bounces-38739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B587B219B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 02:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039E8427AC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 00:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F8D2882CD;
	Tue, 12 Aug 2025 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="HhbqM+yh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3A2853F3
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957763; cv=none; b=XMmRI0ERYC1BEO7pYVs7EerNXQHvCppaHQHp1DiCohsj69EyRFTdEsbAGHeAJGrcb54xiJFk6+Z42BYBtteHEexYxHl7U5y1HKs02dpw27uZrp9Eaa3jKPwNP7CUp9ojIrzvCEbZj9okfm7Eo+aLO0mEC6JjCvQT87rK/aAO+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957763; c=relaxed/simple;
	bh=lObKFFpWe1nUswWAHXSFoQmqA4gcLgheGbmRodNzuXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDyLehBxxUjhvQyodrYUP/yIAZYGJAcyWUkPZq8s1LH929hiaQBRNnwCrb8lVPUgIzLpOkUkx0bWtGOY0II5GhJqT3mJKOJpNxX+A0EU2LSZA4VHBk+l0rbaMl0kB9NmAwuCnn7KvnETXm9VvMJlZ+mG3UWm8Iy9ZKDChyybXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=HhbqM+yh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bfd457607so4797603b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 17:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754957762; x=1755562562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0POCdQlHDdBEpMWZLVYNWiTFkyq9Hm0ip3OGGCpoX8s=;
        b=HhbqM+yhIllsQbh1uMrSUeUwNkZQAwS84nHefkZOZHHXS+VMvBF8QxzdBn3oAATHWL
         v9feAO9cOOqiAwakdJ/3IP7+Lv8uiX7s0fQ+fa6FKg4aIgwUlLpV113BGBWW1Y9ge8OX
         Tk7lbnMiZ2vXmDROLyEeZmNtkLCqEcXaTZ7VkPgrSinRzRPm/StDD/QNIErR2T51lJSw
         9I7NCt4MzYnjmKTK51yprIIcW/Cr8FMjvMRqT1Zd/BgL3SN5iSGpjfkOeFmst6L6HDz4
         LbW/nWuJKbbqtrgptD5ng/QDX2HolHkt4y/IbdJ4uXbSTXjLtuH32gdptYoYQwMe5BbZ
         3qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754957762; x=1755562562;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0POCdQlHDdBEpMWZLVYNWiTFkyq9Hm0ip3OGGCpoX8s=;
        b=GxdhqlpRNxEyR50EILL9B8a/Jl51MtQ2rrH/2n3LQGtLnuqFu6roJyvDOve1g3JsRM
         K5EouUQAQ36hsllbZi+0+1SEkeysThef5v62v9fSY9rbkerv/xKnpMxWuu6oPoIoec/x
         0aTiqC1ETNZQ7ZDtcuUREN2iND1E8/uOqOjn21fIt4EDcdzmgraA0j8+fwuITGWTTNnj
         sFuUB0BT5NP/VIorR+6ItwMppTxBv3IBqxryQPdeH50SpXC2SlLZFWH43W7zntEAY6Er
         OTaWDJYQjCsgPozYYzUjjwQAXy7dk/ChvKUju9YvnZE3AeQNxMrQr5DkEO+resTGMVf5
         Gxmw==
X-Forwarded-Encrypted: i=1; AJvYcCVp3ux0TgQgAoAlqcBjvD9jO+LU1b+DjKuH3WIO7gARfMIUdgZLYxW0ks6ohJPLchf6Katbh+VZ3hs2mFLp9tM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KOZlsa3auTXl/xbxCbc3RzruxE9E6ZigrROrMk+jcYNJi7Ak
	+cYydPwIf6yutStvrSUzkSBAnFAgvJDifP9+BogZXjGcPiYsTisCEPjS4pu/d9hrtRM=
X-Gm-Gg: ASbGncvyBmZ2YF8VdqtYFJU1Weqrt9bo3yKAmIWfbPmH4qSJ1yObz2At/yH0HrePYkW
	PKgBZ0zKNqS399IFKfk7+Z4Zre/4e6nu7PyFInoZ16bVKwQ9aCJGThpUrAUparUtjpkaOoxo7eQ
	8qTkRMaIADDlLS4BKlVtUC17AGJFUGnWKV+GMv1Tvs3zzaQRHoHSXgLkX7qPvTnZAfcm5ahixf9
	8Dpz6jUPVTKsshYrXZj/QeSJ1smL1LWjnTQ1rAo/OXasq+kY0wBFyAvN5Ql6JGx3vX+PtrTk2CP
	mWcapthYcrrQzoqquILQ3fkRjn3sJP9BwKT1SV9V6yWVpoOekusFiOuTtCv9mUViheyqPFx3c04
	FPsl3Dt3kB0UohBTlD6s8vBDFQXMPuWATYtQkufbHB8rdNpoNdhvwSeRuTfZaA7TxOwA=
X-Google-Smtp-Source: AGHT+IEb/RCypsYKRtKPrdAz57Bt/xhCKJfsciQI+T+k7MCGB9l0n4g3gmzopXU70O5IsD9Vx0fe0w==
X-Received: by 2002:a05:6a20:7349:b0:23d:d13d:8a6 with SMTP id adf61e73a8af0-2409a986831mr2184887637.24.1754957761704;
        Mon, 11 Aug 2025 17:16:01 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c6f0c862fsm5509865b3a.115.2025.08.11.17.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:16:01 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:15:58 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 5/5] selftests: drv-net: devmem: flip the
 direction of Tx tests
Message-ID: <aJqHvt0EsV6ALgiE@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
	linux-kselftest@vger.kernel.org, ap420073@gmail.com
References: <20250811231334.561137-1-kuba@kernel.org>
 <20250811231334.561137-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-6-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:13:34PM -0700, Jakub Kicinski wrote:
> The Device Under Test should always be the local system.
> While the Rx test gets this right the Tx test is sending
> from remote to local. So Tx of DMABUF memory happens on remote.
> 
> These tests never run in NIPA since we don't have a compatible
> device so we haven't caught this.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/devmem.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> index 0a2533a3d6d6..45c2d49d55b6 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -42,9 +42,9 @@ from lib.py import ksft_disruptive
>      port = rand_port()
>      listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
>  
> -    with bkg(listen_cmd) as socat:
> -        wait_port_listen(port)
> -        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port}", host=cfg.remote, shell=True)
> +    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
> +        wait_port_listen(port, host=cfg.remote)
> +        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_local} -f {cfg.ifname} -s {cfg.remote_addr} -p {port}", shell=True)
>  
>      ksft_eq(socat.stdout.strip(), "hello\nworld")
>  
> @@ -56,9 +56,9 @@ from lib.py import ksft_disruptive
>      port = rand_port()
>      listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
>  
> -    with bkg(listen_cmd, exit_wait=True) as socat:
> -        wait_port_listen(port)
> -        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port} -z 3", host=cfg.remote, shell=True)
> +    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
> +        wait_port_listen(port, host=cfg.remote)
> +        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_local} -f {cfg.ifname} -s {cfg.remote_addr} -p {port} -z 3", shell=True)
>  
>      ksft_eq(socat.stdout.strip(), "hello\nworld")

FWIW: I don't have one of these devices to test this on, but the change seems
reasonable to me, so:

Reviewed-by: Joe Damato <joe@dama.to>

