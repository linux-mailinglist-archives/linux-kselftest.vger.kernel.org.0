Return-Path: <linux-kselftest+bounces-33330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28839ABC281
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31BF3B2486
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C382284694;
	Mon, 19 May 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc8fA1Li"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1B1DFE22;
	Mon, 19 May 2025 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668756; cv=none; b=L3sSesTccjd9TztmNLBXwWbTCR4hb5R/XiFV4FGbMeTeYSgdj3oA8WGL9Y3z4LG777eYnjRy2fRNkzBfsKnpEuMg8grXLSdqL96LjbmtAfGW36iqS0HH+HPf4M2hrgbxRGYGJ/diYioNkUJCZ74x5rC/4HEk6NwIRTxGOBgBhMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668756; c=relaxed/simple;
	bh=4tnw/GOnyp/wGsToNM+Be3NYiUD7rBZknoRXx2SXI3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J32SwQidFnLzHgCoCdVMxfYrKsQtEUvfuYrGMqEf+z3BK3tikzQzY+hZdI5+17AUmM7HXFDBC1CRLzOR3Tc/8JEn/JklLKrtwBjp1bxm42UdQDV6RayG/8tor2l47hYg4UFpcb2hCiuCkdfhmabgoIvVzFo4gvxyjBIsmEVl4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc8fA1Li; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74267c68c11so4075612b3a.0;
        Mon, 19 May 2025 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747668754; x=1748273554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+emslHoCU5RmFqNigSZdlIqxALju1pUT/JzNEfIJsDM=;
        b=Jc8fA1LiprhowOS6SwQO9uNCtxCBEHKYumhc1ChNTOuhbWR2MJG9I+JdQZUUJLzOxN
         8nfQGrV7zFSPKNs3g53xHlCNY26YCNocIW5SUsXNszyn+7Zs+l7TdkXlHfFpmJSBPyHt
         ys4PlaANZKlgLWBBj66bPd/zH5x742y9i3YL3/ke+ygs+UzsAQzyPMfeyyJJkh+kLx3x
         tvG6bPuoxbe3kKLPW+Ow0J3ZxlAeKuGgMFsjcGjCj1/06V1E0lncT4B8RDVdspZXoUWe
         81qjnm0ONZbSaXXoRn4crnZ3EzRXiiT0AiodP5lP8Pw1cQH9FA9LT0EunUt9Bsx20vhW
         /CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747668754; x=1748273554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+emslHoCU5RmFqNigSZdlIqxALju1pUT/JzNEfIJsDM=;
        b=UNmTQveRSFMqCcL1LIzpTBUdYxqfKmUjyMuMx3rrIG6hi8ONd62LGFZKiSAtNrACQO
         +LVjKVOIt2Tqlv0YbVuPTDnX9VHRDEz6XOTM1XYa6dxLdBZqOCuOh1ygWKbw/swpOlZJ
         755x2iLRBRdNOHkveKH5ekQvLThf3hcpxV+Pjd1rLjXSwQ/PDZagudTBq3xwtuvWtl09
         KHLiYx+KDE11zxbHSDILsFvWRhvId5TBTF2tGvF1If9biPBQqcnAKCPO1bKUg29hKPT7
         g4UFjkzKNgymBokuqV6IYFmwYX5Of8+J1gvgLFPtgxKYxE4BGfZUsPtfcToEcPe8x9KC
         36Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWeTAwsjf7xB06GtOMZiT+b379sqQcOGqHTwsUJqKNFL+mtnTYi9Nnd5GMMI3/Ocdyc40z746umkg4MPek=@vger.kernel.org, AJvYcCX9PxuI9xEeCd/kIcC+8Iey7eB8kIr4Wv67hZ9nwML5drJfju1bbYpB2LevfaAtCQeGD8lZrD5GKzxAQxh/TCYN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwuv5aiMemKpU4I9lRwtEfd8wggaCNh2tq213MFCs8BJ386I0W
	GZtesZ7+Sr8rYOQuSZfKGAUMnoZGzLEwRT2uE/41/HCDWEZHNUHNYRsV6tjA
X-Gm-Gg: ASbGnctiwAZcoFyQBZcqhdmRTfINnVJhHzUhRSi11eygnEcOIgV3790efE3AzCVNSoH
	1He1/P+TDyrk2To3yPoxueUBjzM7in10fcVjsrpKmaRtDne4haJpBpy3NU0yf/d3tVGVrTsQROb
	cMy1Zxa7Xl3PiwfT8FLGrcV5uClLuRP3SCY512PQBpef1uAAEDXjXEyO40ae6tAtNfxDqRG0Pve
	InypYC5EeKEAvNWhtY0g9ioAnr6JdPIClj3zrEbI0C3wnTQIQo0hkb5q0ioGqDyzPwcMtwi5iBP
	w68CIpUGMjiC/P07ocqiGeHa4V0YzFpSPbKV0W+syp+oAOgLzmyjfKBEqJgz3fD99PsyyEzwDdB
	ZOpjwLFBtqT3g
X-Google-Smtp-Source: AGHT+IF7zkTI3p1YKmscGwixD5Hofg4MzwEzPdNZVKI+KnKkrVKP1my/RPkWg02ZP1FPVdT+CfkSHQ==
X-Received: by 2002:a05:6a00:4106:b0:736:ff65:3fcc with SMTP id d2e1a72fcca58-742acd50712mr20056657b3a.16.1747668754117;
        Mon, 19 May 2025 08:32:34 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a973a261sm6363144b3a.84.2025.05.19.08.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:32:33 -0700 (PDT)
Date: Mon, 19 May 2025 08:32:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
	shivajikant@google.com
Subject: Re: [PATCH net-next v1 5/9] net: devmem: ksft: add ipv4 support
Message-ID: <aCtPEBmBFvM-bA_i@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519023517.4062941-6-almasrymina@google.com>

On 05/19, Mina Almasry wrote:
> ncdevmem supports both ipv4 and ipv6, but the ksft is currently
> ipv6-only. Propagate the ipv4 support to the ksft, so that folks that
> are limited to these networks can also test.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  .../selftests/drivers/net/hw/devmem.py        | 33 ++++++++++++-------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> index f5d7809400ea..850381e14d9e 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -18,30 +18,36 @@ def require_devmem(cfg):
>          raise KsftSkipEx("Test requires devmem support")
>  
>  
> -def check_rx(cfg) -> None:
> -    cfg.require_ipver("6")
> +def check_rx(cfg, ipver) -> None:
>      require_devmem(cfg)
>  
> +    addr = cfg.addr_v[ipver]
> +    if ipver == "6":
> +        addr = "[" + addr + "]"

I think you can add [] unconditionally, no need to special case v6.

> +
> +    socat = f"socat -u - TCP{ipver}:{addr}:{port}"
> +
>      port = rand_port()
>      listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
>  
> -    with bkg(listen_cmd) as socat:
> +    with bkg(listen_cmd) as ncdevmem:
>          wait_port_listen(port)
> -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.addr_v['6']}]:{port}", host=cfg.remote, shell=True)
> +        cmd(f"echo -e \"hello\\nworld\"| {socat}", host=cfg.remote, shell=True)
>  
> -    ksft_eq(socat.stdout.strip(), "hello\nworld")
> +    ksft_eq(ncdevmem.stdout.strip(), "hello\nworld")
>  
>  
> -def check_tx(cfg) -> None:
> -    cfg.require_ipver("6")
> +def check_tx(cfg, ipver) -> None:
>      require_devmem(cfg)
>  
>      port = rand_port()
> -    listen_cmd = f"socat -U - TCP6-LISTEN:{port}"
> +    listen_cmd = f"socat -U - TCP{ipver}-LISTEN:{port}"
>  
> -    with bkg(listen_cmd, exit_wait=True) as socat:
> +    addr = cfg.addr_v[ipver]
> +
> +    with bkg(listen_cmd) as socat:
>          wait_port_listen(port)
> -        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}", host=cfg.remote, shell=True)
> +        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {addr} -p {port}", host=cfg.remote, shell=True)
>  
>      ksft_eq(socat.stdout.strip(), "hello\nworld")
>  
> @@ -51,8 +57,13 @@ def main() -> None:
>          cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
>          cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
>  
> +        if "4" in cfg.addr_v:
> +            ipver = "4"
> +        else:
> +            ipver = "6"

If we have both, we prefer v4, can we do the opposite? 

