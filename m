Return-Path: <linux-kselftest+bounces-46700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C74C9320A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 21:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0073E349EAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF172DAFCA;
	Fri, 28 Nov 2025 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tjn0gA6M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5E27280F
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764362564; cv=none; b=Ab1ACJi6pgcW0vuqbxEHJ1OhPXFj82c1hI7dFHlSpurgzRRcq0HST/0FbUIlFfeASTajrVxdYnQwsmBoSP5Bw/ya/3SX1FcR9y4diDJnRB+V8/tft6rF3orM4T7H/yzV5pf0HdvIBGCcYYXSUMbM+RpmuOpT8V+a7f0mba9+nn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764362564; c=relaxed/simple;
	bh=FdLCN53CTxUt6hfjsmo7yzH6TbLjZDUb1d/794EyTeQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ORW5JVgqPNJ9lz/4bsi/VIoEEbGlP3BklUptcMhd8xKz3cT7G/2mFraaxsBpdETiv/fsjwCKUD7u+JhtAdb9WrrWKSJEEi3q+2aVb93DN/IgUQ0Xogade60V5/kUdKh2I+lrSgjM3DPASAUwa9c2VgjhUM6ImHGZS68zOtBnCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tjn0gA6M; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78a6a7654a4so20719207b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 12:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764362561; x=1764967361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+7+Hhp2jQFXeR9sNBlLTHUXZh0f0zWtgYdAbER5ats=;
        b=Tjn0gA6MwkcWaTQZShGGeXmA2bQ3cwEAjhyWvvDOHk3ppe6kcOJC2N/j4wWbEfE7d/
         JMZxmZIo9gCL4enP1zoPEAQsWI3YCDmEKKZTdwQedjx3p1tq21fhfZyeVOonGYmg5Vmu
         Dj4G7RX0IH99vUniFFRXcpA0vIgFB9+bWZgmy65M7UhyBWEFaAtIVYf2lyT91pnYbSLy
         kLB+1khhHyHbi+5LDgist+VcP5wUBEGmjQzdnB2N3gJQBMjHcBR273phdK1aUoe4r36W
         uojqF7ejsOMH+DvScl6SqR3M1ukwJ10AIAQjPL/IbeJ9ZlYkewGwGbGMDRitHAPVHWC7
         KxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764362561; x=1764967361;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+7+Hhp2jQFXeR9sNBlLTHUXZh0f0zWtgYdAbER5ats=;
        b=kqFLECmwIQ/JkJovZT+ZoV9VbmKJ2kLJg+6Y5mF28kyu99iCgmwPSmwChJQJNDSz07
         2mglUAY5y2nWIuPE/N9gWa6nwf9sMH0XsaG/sJdvilzy6RbPAl9BYbDT6dndxuwYy5ms
         Y8k5UdTXZXJyEildz8dNRYibWpzd2SsFzWUdAuxz18VYjEFwo1oQW2nAZxnxmK0an15m
         yFBo+6dxJC8BlwTXApzIwj3osw4y2oCIgsZkYY9nfrie0OK4WDtci5z//EW19B0H2Oi5
         DzWmSYciACQIF7hk0HFSRwrf2iXO1W5sWh9AN6FATby5UMQ194YbCKx0SpI5o9tKUjug
         9+gw==
X-Forwarded-Encrypted: i=1; AJvYcCUk1RlXfVHkj7k9TISfWqHgk12IwKwETbSywn2U0iffspMNPVvhWQnihvjuV7qbXNxAva4wCGVfcLAv5Vufs2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXFNOsTBkg4cPSYhEFoCfCO01xvuWrWUd8+oCW+8bRymydWcB
	UO40BbfgBjcVu2hsg3C0Pa7cdE+iw1TaiVeodY3LiMjg87bSb9xVarKA
X-Gm-Gg: ASbGncuVJBA4A/lFy9p0Nf16/zwwtFpihUo7dhGtCTPfIc0Q3cGy937WSdj/dQ6Pk2l
	9NStg+T3rTANJyhV7t/fE3Eq8YUi9IcFDorv1hS6qeEe2dPX6IIWBY8w1j1JJ1/Tylq4yxylR+w
	emipzAkn0lE4qqpDe0c9Uul0dr+6TZaG3ci/yAkCKdtcT/NRqxAdK8kXo9FcqQLVddA2lD35Kd2
	OxSpkTmyemggYSyr9HoVros5/b27dkutjWj9h6MB4Zi0awfQ47tsLHLPw0ymXTkETs0HjY51n7K
	mUkZfAmDqyCTig+wC+xbMXSTGf/guBy0ATnpmoT7b1pfNz1fYYO9+fEeDfKDRiNtwT0kOYq0c+m
	0lcf9HJRJ8Ajp+z3W8JwdumpHE6v8B03oobsJqVHfR3GeeDv8UZOtENmtahvHmShAeBCh3aLhSn
	hVLRvaW87w9GYS7F7Yt7UkwM9tA7QTFsaNYVuv2EUSLM7coCZFfGnn+wtoCMxy+bG61mo=
X-Google-Smtp-Source: AGHT+IGlh3CaKo66q0t/WA7R/9iHG6rR3lNisWg2UxowlWp92jlr5rECxCFCgWZq1RwhOh19sYOsUA==
X-Received: by 2002:a05:690c:3690:b0:787:d4db:33be with SMTP id 00721157ae682-78a8b55fad4mr244374977b3.57.1764362561479;
        Fri, 28 Nov 2025 12:42:41 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad0d3f5c8sm18737697b3.3.2025.11.28.12.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 12:42:40 -0800 (PST)
Date: Fri, 28 Nov 2025 15:42:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.468ae2cb7a74@gmail.com>
In-Reply-To: <20251128005242.2604732-2-kuba@kernel.org>
References: <20251128005242.2604732-1-kuba@kernel.org>
 <20251128005242.2604732-2-kuba@kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: gro: run the test
 against HW GRO and LRO
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
> Run the test against HW GRO and LRO. NICs I have pass the base cases.
> Interestingly all are happy to build GROs larger than 64k.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> CC: shuah@kernel.org
> CC: sdf@fomichev.me
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/gro.py | 50 ++++++++++++++++------
>  1 file changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
> index 6d633bdc7e67..ea7070b033d4 100755
> --- a/tools/testing/selftests/drivers/net/gro.py
> +++ b/tools/testing/selftests/drivers/net/gro.py
> @@ -91,7 +91,7 @@ from lib.py import ksft_variants
>      defer(ethtool, " ".join(old), host=host)
>  
>  
> -def _setup(cfg, test_name):
> +def _setup(cfg, mode, test_name):
>      """ Setup hardware loopback mode for GRO testing. """
>  
>      if not hasattr(cfg, "bin_remote"):
> @@ -108,16 +108,37 @@ from lib.py import ksft_variants
>          _set_mtu_restore(cfg.dev, 4096, None)
>          _set_mtu_restore(cfg.remote_dev, 4096, cfg.remote)
>  
> -    flush_path = f"/sys/class/net/{cfg.ifname}/gro_flush_timeout"
> -    irq_path = f"/sys/class/net/{cfg.ifname}/napi_defer_hard_irqs"
> +    if mode == "sw":
> +        flush_path = f"/sys/class/net/{cfg.ifname}/gro_flush_timeout"
> +        irq_path = f"/sys/class/net/{cfg.ifname}/napi_defer_hard_irqs"
>  
> -    _write_defer_restore(cfg, flush_path, "200000", defer_undo=True)
> -    _write_defer_restore(cfg, irq_path, "10", defer_undo=True)
> +        _write_defer_restore(cfg, flush_path, "200000", defer_undo=True)
> +        _write_defer_restore(cfg, irq_path, "10", defer_undo=True)
>  
> -    _set_ethtool_feat(cfg.ifname, cfg.feat,
> -                      {"generic-receive-offload": True,
> -                       "rx-gro-hw": False,
> -                       "large-receive-offload": False})
> +        _set_ethtool_feat(cfg.ifname, cfg.feat,
> +                          {"generic-receive-offload": True,
> +                           "rx-gro-hw": False,
> +                           "large-receive-offload": False})
> +    elif mode == "hw":
> +        # The only way to get HW GRO but elide SW GRO is to install
> +        # a dummy XDP generic program. Disabling SW GRO as a feature
> +        # would also disable HW GRO.
> +        prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
> +        ip(f"link set dev {cfg.ifname} xdpgeneric obj {prog} sec xdp")
> +        defer(ip, f"link set dev {cfg.ifname} xdpgeneric off")
> +
> +        # Attaching XDP may change features, fetch the latest state
> +        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
> +
> +        _set_ethtool_feat(cfg.ifname, feat,
> +                          {"generic-receive-offload": True,
> +                           "rx-gro-hw": True,
> +                           "large-receive-offload": False})
> +    elif mode == "lro":
> +        _set_ethtool_feat(cfg.ifname, cfg.feat,
> +                          {"generic-receive-offload": False,

So GRO off disables HW_GRO, but not LRO? That difference is behavior
is confusing. Could we still see this as a regression and make the
ethtool HW_GRO feature equally independent from SW_GRO?

> +                           "rx-gro-hw": False,
> +                           "large-receive-offload": True})
>  
>      try:
>          # Disable TSO for local tests
> @@ -132,19 +153,20 @@ from lib.py import ksft_variants
>  def _gro_variants():
>      """Generator that yields all combinations of protocol and test types."""
>  
> -    for protocol in ["ipv4", "ipv6", "ipip"]:
> -        for test_name in ["data", "ack", "flags", "tcp", "ip", "large"]:
> -            yield protocol, test_name
> +    for mode in ["sw", "hw", "lro"]:
> +        for protocol in ["ipv4", "ipv6", "ipip"]:
> +            for test_name in ["data", "ack", "flags", "tcp", "ip", "large"]:
> +                yield mode, protocol, test_name
>  
>  
>  @ksft_variants(_gro_variants())
> -def test(cfg, protocol, test_name):
> +def test(cfg, mode, protocol, test_name):
>      """Run a single GRO test with retries."""
>  
>      ipver = "6" if protocol[-1] == "6" else "4"
>      cfg.require_ipver(ipver)
>  
> -    _setup(cfg, test_name)
> +    _setup(cfg, mode, test_name)
>  
>      base_cmd_args = [
>          f"--{protocol}",
> -- 
> 2.51.1
> 



