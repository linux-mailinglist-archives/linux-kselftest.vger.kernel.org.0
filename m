Return-Path: <linux-kselftest+bounces-18107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1F797BC59
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 14:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060F61F2535E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384141898ED;
	Wed, 18 Sep 2024 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIyueVcm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB6176FA7;
	Wed, 18 Sep 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663086; cv=none; b=qohVYSsTiuYsk7qJmV/GPKeiZYE+0gXlv+frLMleo7bvnyd87tbxXhAIVDjZWAL1oOan7/ClyzbXVPyp7HN5OqNXZUmO1qqEHJOMupexGdnLdRw4n7VgzhyJmdnL3IlX3K2YtcsS1FwGnFQW1oNY1oU2u8P7rqi+ncVqqxoA52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663086; c=relaxed/simple;
	bh=+pVQCjrOS+WDHSyf9VTvTerWzJQfOhje9X0hpJLbZ2w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gI8UZV1kXFaatWih7x0dfofTZ3G1ZYBJzCfeolYWirisb6EBt9syXlGqiqa8V/c44TBOUyPFH1/tUaPCyZCCKwWi0nwbvnPwClPN58o5qkEKIoihT3v0dk3glxawkmvGmU3N3j7UvVieQSEsV/jcjv1lNESakZLE5Y4a6OlJFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIyueVcm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a95efbaf49so396362485a.3;
        Wed, 18 Sep 2024 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726663083; x=1727267883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKhOII2wzPiXj1Ja0YUua2iCV4SCufJIEwdhDjh9HSM=;
        b=lIyueVcmYLXVsEP3wf3puUWk6vPqg8VlxBbrkag8vgF/xNkA7LNrETKRpnw3GE919Y
         8MBHrnYA+kHOPkDh/4gnP1Bk0K3+HhjoVu3GZ71qsQHa8oqvxcE9KwwXg128BNA2wL/6
         irTBfUxcGJ0HHFgwaTcqq+NjC0gBJl7JFmTj+JH9b4fNGaGWtQ28jo75s0Zuw6JzBSm8
         M9xJmQIbjOjAWzvAMviBKa73Wl/VSvVf77KXWX7ApmzU/+Q0bGeHbtAPF/VDnt0phjNL
         TjujbcKZSntFqF67vh/4mAu3XzVZI6DV83l+971PBYhcf2rLxa2b+G4q3W6gZUc62NJ1
         c7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663083; x=1727267883;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zKhOII2wzPiXj1Ja0YUua2iCV4SCufJIEwdhDjh9HSM=;
        b=E64KFiHVJSxaUrJXPBihrAg6SydaPWY9g4nSIed6rtB5CvKrC9SdWQB/sQ0l/b+DnP
         vGMbchelZA9nMSvfa6LXv0wvA8LCNaLYcw0lS9MQ6V+P5B7I62Uf9KSHqZIkxeoPxSHD
         5DacxsT9mxicvPAE8vIbP/Wv2cYlxzeZP3vFKHhF1Lb54Zm3kU2/ysRTpp/WLuXmtYbD
         8KETkCvneOJvgDeAuUsB0miPffBuGAQg3BpEq5DxdPATLz3VEnhOBB8BoZWBwcYq7O1c
         MvyTUcqulyv66hQxR4p60kkAxgnVN53GNPjCwwa/3GeVVeWAmPp6NKQXxIYyCJBu8kQR
         ti9g==
X-Forwarded-Encrypted: i=1; AJvYcCWKaAz+g0BiJx65rg131VXXn7QhcI3YSKVaw90ZFh7wE87eag3K3Q38ZSB79pgUPzr13F6ktEHwDJ7N73A=@vger.kernel.org, AJvYcCWvF43mSeAxU490pOVrroXYDWxMRYKXW7FpSiCXsxIAudpX8u0SB5TlRHUpiCAbPXO0TvYd3MiTTDhTtl655cMJ@vger.kernel.org, AJvYcCXYyfrWky8cMnSMMuKPHO+jXjIBvetkpJen5YzYHRjLK2/AIn50piYoZdzAkW4KFdfJfxTGmgTB@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGe+KQQsO05N4qx0lgOzyYU9ic4huNENJctf7cnRQs5AEKVVD
	Hkct5lvry7yZ3XrpwxZWl07j5aPqIiKDl8wXGmlMC/nEXk8gcu+3
X-Google-Smtp-Source: AGHT+IHgv89Lim0gQxfDI9Ug/kDaYNwzLbOzetDB4QbKuZuFTirvlUtsTj3cfbE9+qdkVlNN9l0lIg==
X-Received: by 2002:a05:620a:24d5:b0:7a9:b9c6:ab62 with SMTP id af79cd13be357-7ab30d349c3mr2681807185a.28.1726663083232;
        Wed, 18 Sep 2024 05:38:03 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e95bcaasm450628485a.5.2024.09.18.05.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:38:02 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:38:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mohan Prasad J <mohan.prasad@microchip.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 andrew@lunn.ch
Cc: edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 mohan.prasad@microchip.com, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 horms@kernel.org, 
 brett.creeley@amd.com, 
 rosenp@gmail.com, 
 UNGLinuxDriver@microchip.com, 
 willemb@google.com
Message-ID: <66eac9a9e3e22_29b986294c7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240917023525.2571082-3-mohan.prasad@microchip.com>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
 <20240917023525.2571082-3-mohan.prasad@microchip.com>
Subject: Re: [PATCH net-next v2 2/3] selftests: nic_basic_tests: Add selftest
 case for speed and duplex state checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mohan Prasad J wrote:
> Add selftest case for testing the speed and duplex state of
> local NIC driver and the partner based on the supported
> link modes obtained from the ethtool. Speed and duplex states
> are varied and verified using ethtool.
> 
> Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> ---
>  .../drivers/net/hw/nic_basic_tests.py         | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py b/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
> index 27f780032..ff46f2406 100644
> --- a/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
> +++ b/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
> @@ -42,6 +42,14 @@ from lib.py import ethtool
>  """Global variables"""
>  common_link_modes = []
>  
> +def check_autonegotiation(ifname: str) -> None:
> +    autoneg = get_ethtool_content(ifname, "Supports auto-negotiation:")
> +    partner_autoneg = get_ethtool_content(ifname, "Link partner advertised auto-negotiation:")
> +
> +    """Check if auto-neg supported by local and partner NIC"""
> +    if autoneg[0] != "Yes" or partner_autoneg[0] != "Yes":
> +        raise KsftSkipEx(f"Interface {ifname} or partner does not support auto-negotiation")
> +
>  def get_ethtool_content(ifname: str, field: str):
>      capture = False
>      content = []
> @@ -112,6 +120,25 @@ def verify_autonegotiation(ifname: str, expected_state: str) -> None:
>  
>      ksft_eq(actual_state, expected_state)
>  
> +def set_speed_and_duplex(ifname: str, speed: str, duplex: str) -> None:
> +    """Set the speed and duplex state for the interface"""
> +    process = ethtool(f"--change {ifname} speed {speed} duplex {duplex} autoneg on")
> +
> +    if process.ret != 0:
> +        raise KsftFailEx(f"Not able to set speed and duplex parameters for {ifname}")
> +    ksft_pr(f"Speed: {speed} Mbps, Duplex: {duplex} set for Interface: {ifname}")
> +
> +def verify_speed_and_duplex(ifname: str, expected_speed: str, expected_duplex: str) -> None:
> +    verify_link_up(ifname)
> +    """Verifying the speed and duplex state for the interface"""
> +    with open(f"/sys/class/net/{ifname}/speed", "r") as fp:
> +        actual_speed = fp.read().strip()
> +    with open(f"/sys/class/net/{ifname}/duplex", "r") as fp:
> +        actual_duplex = fp.read().strip()
> +
> +    ksft_eq(actual_speed, expected_speed)
> +    ksft_eq(actual_duplex, expected_duplex)
> +
>  def test_link_modes(cfg) -> None:
>      global common_link_modes
>      link_modes = get_ethtool_content(cfg.ifname, "Supported link modes:")
> @@ -136,6 +163,25 @@ def test_autonegotiation(cfg) -> None:
>      else:
>          raise KsftSkipEx(f"Auto-Negotiation is not supported for interface {cfg.ifname}")
>  
> +def test_network_speed(cfg) -> None:
> +    check_autonegotiation(cfg.ifname)
> +    if not common_link_modes:
> +        KsftSkipEx("No common link modes exist")
> +    speeds, duplex_modes = get_speed_duplex(common_link_modes)
> +
> +    if speeds and duplex_modes and len(speeds) == len(duplex_modes):
> +        for idx in range(len(speeds)):
> +            speed = speeds[idx]
> +            duplex = duplex_modes[idx]
> +            set_speed_and_duplex(cfg.ifname, speed, duplex)
> +            time.sleep(sleep_time)
> +            verify_speed_and_duplex(cfg.ifname, speed, duplex)
> +    else:
> +        if not speeds or not duplex_modes:
> +            KsftSkipEx(f"No supported speeds or duplex modes found for interface {cfg.ifname}")
> +        else:
> +            KsftSkipEx("Mismatch in the number of speeds and duplex modes")
> +

Do these tests reset configuration to their original state?

More high level: basic test is not very descriptive. Can they have a
more precise name? Perhaps link layer operations or link layer config?

