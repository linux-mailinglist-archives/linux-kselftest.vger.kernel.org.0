Return-Path: <linux-kselftest+bounces-18083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D624297B26E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 17:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E381F252DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5E4173336;
	Tue, 17 Sep 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="I4U91Ttz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200A16FF26;
	Tue, 17 Sep 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588584; cv=none; b=eBsTKnd/e5rsFoDpvU/LHAVjVOIzwyI7C5Vss8hRt0Rk2PNgZJO06T+7TwlYDU81ffqmof8Kr68gD1QBSGjjWTgs3FJma8G6veapggih0gwAjJfRzp6UQD8hgIijcc/aOdWsEAjBMe4cCBZbt6g4ZqpKhzPDJkbSD7siME8Ag5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588584; c=relaxed/simple;
	bh=Jo2eKSgQ0IqppsjldOTNLFaP8k2leUetI4DMHIRZGLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBU8KOfu4gql8R5jP8gKoIdIsxaqqPTGHuGTgAc71jKEMHeWXao90OQYdjd4W2jOxLuQ/XzcC8ux9BzUz7fd3Fm+Zy0mFdL8x7Ut7xLxxosdgf36Hi44RCPaiba7Caoe36E3PxLNP3JImpdUMGpL7oeasVqgWDtyIIJPIVok5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=I4U91Ttz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=lCw6BM9+RLcntSOeMSifj0iIlStXDWnH9nlDvO169Z4=; b=I4
	U91Ttzldev8b5wRW/67cAObRApvurAVfPJZV07m7wwfNWYSnWUX4VnisNm6VMFw7vPk0W5+tX9ziv
	mT34Hwzh8Tdvh0ELQ8oGxYFSaTucim5WnmMmgjlotUUgBlaj8YXgzpNr3J5v5qRS4Rx05tPo5f+6A
	7QrdpaN2YjjV748=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sqaYr-007eRo-E1; Tue, 17 Sep 2024 17:56:17 +0200
Date: Tue, 17 Sep 2024 17:56:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohan Prasad J <mohan.prasad@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, brett.creeley@amd.com, rosenp@gmail.com,
	UNGLinuxDriver@microchip.com, willemb@google.com
Subject: Re: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest
 file for basic tests of NIC
Message-ID: <1ad4656f-eb3f-4ecb-9e5d-5846f4f6c3e6@lunn.ch>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
 <20240917023525.2571082-2-mohan.prasad@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917023525.2571082-2-mohan.prasad@microchip.com>

On Tue, Sep 17, 2024 at 08:04:07AM +0530, Mohan Prasad J wrote:
> Add selftest file to test basic features of a NIC driver.
> Tests for link modes, auto-negotiation are placed.
> Selftest makes use of ksft modules and ethtool.
> Add selftest file in the Makefile.
> 
> Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../drivers/net/hw/nic_basic_tests.py         | 145 ++++++++++++++++++
>  2 files changed, 146 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index c9f2f48fc..9f105227c 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -10,6 +10,7 @@ TEST_PROGS = \
>  	hw_stats_l3.sh \
>  	hw_stats_l3_gre.sh \
>  	loopback.sh \
> +	nic_basic_tests.py \
>  	pp_alloc_fail.py \
>  	rss_ctx.py \
>  	#
> diff --git a/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py b/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
> new file mode 100644
> index 000000000..27f780032
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
> @@ -0,0 +1,145 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +#Introduction:
> +#This file has basic tests for generic NIC drivers.
> +#The test comprises of auto-negotiation, speed and duplex checks.
> +#Also has tests to check the throughput
> +#
> +#Setup:
> +#Connect the DUT PC with NIC card to partner pc back via ethernet medium of your choice(RJ45, T1)
> +#
> +#        DUT PC                                              Partner PC
> +#┌───────────────────────┐                         ┌──────────────────────────┐
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#│           ┌───────────┐                         │                          │
> +#│           │DUT NIC    │         Eth             │                          │
> +#│           │Interface ─┼─────────────────────────┼─    any eth Interface    │
> +#│           └───────────┘                         │                          │
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#└───────────────────────┘                         └──────────────────────────┘
> +#
> +#Configurations:
> +# Change the below configuration based on your hw needs.
> +# """Default values"""
> +sleep_time = 5 #time taken to wait for transitions to happen, in seconds.
> +test_duration = 5  #performance test duration for the throughput check, in seconds.
> +throughput_threshold = 0.8 #percentage of throughput required to pass the throughput
> +
> +import time
> +import os
> +import re
> +import configparser
> +import json
> +from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_eq
> +from lib.py import KsftFailEx, KsftSkipEx
> +from lib.py import NetDrvEpEnv
> +from lib.py import cmd
> +from lib.py import ethtool
> +
> +"""Global variables"""
> +common_link_modes = []

Software engineers have a dislike for global variables. In this patch,
it is not even used. Please consider replacing it by passing it as a
parameter, or turn the code into a class and make it part of self.

> +def test_link_modes(cfg) -> None:
> +    global common_link_modes
> +    link_modes = get_ethtool_content(cfg.ifname, "Supported link modes:")
> +    partner_link_modes = get_ethtool_content(cfg.ifname, "Link partner advertised link modes:")
> +
> +    if link_modes and partner_link_modes:
> +        for idx1 in range(len(link_modes)):
> +            for idx2 in range(len(partner_link_modes)):
> +                if link_modes[idx1] == partner_link_modes[idx2]:
> +                    common_link_modes.append(link_modes[idx1])

You can use the power of python here.

        "supported-link-modes": [ "10baseT/Half","10baseT/Full","100baseT/Half","100baseT/Full","1000baseT/Full" ],
	"link-partner-modes": [ "10baseT/Half","10baseT/Full","100baseT/Half","100baseT/Full","1000baseT/Full" ],

convert the list into a set, and then use 'and'.

	common_modes = set(josn['supported-link-modes']) and set(json['link-partner-modes'])

	Andrew

