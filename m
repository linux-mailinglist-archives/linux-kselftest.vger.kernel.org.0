Return-Path: <linux-kselftest+bounces-18081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDA897B22E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E3F1F2AAF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB118DF78;
	Tue, 17 Sep 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XHGBX7qQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871BC15AAD9;
	Tue, 17 Sep 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587350; cv=none; b=F7O4Om/IjebAkZpd1erNYKDRnv8CwcnPRNNWI8SltTrstOfOLafSuoKpqOyCkO0+QqM6sF22aAgmKKtW7W6iKIkR95UsBIyVECTRIC5NWRZ35QnfImz3E0fgSQee3RYhBIuMaaWZCTJpWDAkb6JCwE+WJzRuNyQ+A+R981dqZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587350; c=relaxed/simple;
	bh=El7jjbeiEte2ayD0VD5nCDv8efS5EYCFmVZ8IBQzuHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAjYs1KiY42aJ4m27X7t1gEhn64zXwmnaLTU9YPO7E4Gf8oatBUgjQZd3VL4MEXKFkoJxJ+UemRnDXdf3BObnpeIWvKO06vxrVDs8ZJRZYBQqszwMG0LpukJ4MdofpqFv2pF1KR7AOQM5YAMn6YgVAas0Wz7MjydTTv2Ltj0ifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XHGBX7qQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=KItZZjLiu68ZljtV87wrQZyiZjEeXWy1hmUi99R0+x0=; b=XH
	GBX7qQC46v55EzYeFZX0b4lGySH5Y+JY98xXOS5ca/Na39RS7HODWmtPhasvY944I1AZ9Rixntwg5
	1UQgAtA2tY8xDoToq58kFtvT+H9ev4DZdf79HGY7fRgv0FTyHozB4xbxu+CTeTNUPgHdsrRvZJx9T
	A3mfhTPpG3bKFaE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sqaEu-007eMe-If; Tue, 17 Sep 2024 17:35:40 +0200
Date: Tue, 17 Sep 2024 17:35:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohan Prasad J <mohan.prasad@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, brett.creeley@amd.com, rosenp@gmail.com,
	UNGLinuxDriver@microchip.com, willemb@google.com
Subject: Re: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest
 file for basic tests of NIC
Message-ID: <5c8779db-31c4-4b93-986a-bd489720fa4b@lunn.ch>
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

Thanks for reworking this.

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
> +
> +def get_ethtool_content(ifname: str, field: str):
> +    capture = False
> +    content = []
> +
> +    """Get the ethtool content for the interface"""
> +    process = ethtool(f"{ifname}")
> +    if process.ret != 0:
> +        raise KsftSkipEx(f"Error while getting the ethtool content for interface {ifname}")
> +    lines = process.stdout.splitlines()
> +
> +    """Retrieve the content of the field"""
> +    for line in lines:
> +        if field in line:
> +            capture = True
> +            data = line.split(":")[1].strip()
> +            content.extend(data.split())
> +            continue

Since you have batteries included python:

ethtool --json enp2s0
[sudo] password for andrew: 
[ {
        "ifname": "enp2s0",
        "supported-ports": [ "TP","MII" ],
        "supported-link-modes": [ "10baseT/Half","10baseT/Full","100baseT/Half","100baseT/Full","1000baseT/Full" ],
        "supported-pause-frame-use": "Symmetric Receive-only",
        "supports-auto-negotiation": true,
        "supported-fec-modes": [ ],
        "advertised-link-modes": [ "10baseT/Half","10baseT/Full","100baseT/Half","100baseT/Full","1000baseT/Full" ],
        "advertised-pause-frame-use": "Symmetric Receive-only",
        "advertised-auto-negotiation": true,
        "advertised-fec-modes": [ ],
        "auto-negotiation": false,
        "master-slave-cfg": "preferred slave",
        "master-slave-status": "unknown",
        "port": "Twisted Pair",
        "phyad": 0,
        "transceiver": "external",
        "supports-wake-on": "pumbg",
        "wake-on": "d",
        "link-detected": false
    } ]

You can use a json library to do all the parsing for you.

> +def get_speed_duplex(content):
> +    speed = []
> +    duplex = []
> +    """Check the link modes"""
> +    for data in content:
> +        parts = data.split('/')
> +        speed_value = re.match(r'\d+', parts[0])
> +        if speed_value:
> +            speed.append(speed_value.group())
> +        else:
> +            raise KsftSkipEx(f"No speed value found for interface {ifname}")
> +        duplex.append(parts[1].lower())
> +    return speed, duplex
> +
> +def verify_link_up(ifname: str) -> None:
> +    """Verify whether the link is up"""
> +    with open(f"/sys/class/net/{ifname}/operstate", "r") as fp:
> +        link_state = fp.read().strip()
> +
> +    if link_state == "down":
> +        raise KsftSkipEx(f"Link state of interface {ifname} is DOWN")
> +
> +def set_autonegotiation_state(ifname: str, state: str) -> None:
> +    content = get_ethtool_content(ifname, "Supported link modes:")
> +    speeds, duplex_modes = get_speed_duplex(content)
> +    speed = speeds[0]
> +    duplex = duplex_modes[0]
> +    if not speed or not duplex:
> +        KsftSkipEx("No speed or duplex modes found")
> +    """Set the autonegotiation state for the interface"""
> +    process = ethtool(f"-s {ifname} speed {speed} duplex {duplex} autoneg {state}")
> +    if process.ret != 0:
> +        raise KsftFailEx(f"Not able to set autoneg parameter for {ifname}")
> +    ksft_pr(f"Autoneg set as {state} for {ifname}")
> +
> +def verify_autonegotiation(ifname: str, expected_state: str) -> None:
> +    verify_link_up(ifname)
> +    """Verifying the autonegotiation state"""
> +    output = get_ethtool_content(ifname, "Auto-negotiation:")
> +    actual_state = output[0]
> +
> +    ksft_eq(actual_state, expected_state)
> +
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
> +                    break
> +    else:
> +        raise KsftFailEx("No link modes available")
> +
> +def test_autonegotiation(cfg) -> None:
> +    autoneg = get_ethtool_content(cfg.ifname, "Supports auto-negotiation:")
> +    if autoneg[0] == "Yes":
> +        for state in ["off", "on"]:
> +            set_autonegotiation_state(cfg.ifname, state)
> +            time.sleep(sleep_time)

One thing you could do here is look at "advertised-link-modes". You
would expect it to list a single mode, matching the speed/duplex
you requested.

	Andrew

