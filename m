Return-Path: <linux-kselftest+bounces-18082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832CE97B267
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 17:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305621F27922
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AAA17C233;
	Tue, 17 Sep 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yp0KccK4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398317A5B5;
	Tue, 17 Sep 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588094; cv=none; b=r7PdW5uqOzcvMScQswGXa+h2zo/0SbgwwxkIW2ccoXWbm2khjLHB+7Ml3iRHd0y/1tx30FwB3EkFRvqQ7H81ihMjo+ifSMdj+rMXZJfTNH7JB3thmhBBjf15VZqbkxTNHk442VLChdPtYlIZt0rxqiuvWhTabNftmdngcwyycrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588094; c=relaxed/simple;
	bh=wWqROD6qcHokgdNu/9AlLVF4rcb4Pi5b1hsxQzY5g3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRIs/3XZE38vM1YHxRjHTAPlE/06vhvlfPD/Bo4FcDufwNah1L+3u2HkJ5HYV0oZ/iNeX/XMDZ0UnZqSBImWah2ycZxNYYHF6hgsb6KFs1g3iBgCrhG0bp3JRs/dlrImC8GkgwUj/Znfm1ZzaU8SKTHx793GjDH4CejCrsD2wP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yp0KccK4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bAoyUvkAsfQlTAHAYyOlMpPkrrtyy44CkCXbJXOgOCA=; b=Yp0KccK4VPf/xJb8r6115b+h67
	aZmUK1PHomRcpMXpqfU6D4GllC2Y523LRlHMpAojlXNFB2MYGfpqzJl0OEyjkfMOwe2aWblSkeWWj
	PBAkQSafaTQLd2c+IP9HqBPehbeodzY6zy1JYartfar5k1/NbwCmRS4eo379o+DWNz8U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sqaQy-007ePY-Hg; Tue, 17 Sep 2024 17:48:08 +0200
Date: Tue, 17 Sep 2024 17:48:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohan Prasad J <mohan.prasad@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, brett.creeley@amd.com, rosenp@gmail.com,
	UNGLinuxDriver@microchip.com, willemb@google.com
Subject: Re: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest
 file for basic tests of NIC
Message-ID: <0dd4130e-b06e-42e1-8f36-2589c18c4762@lunn.ch>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
 <20240917023525.2571082-2-mohan.prasad@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917023525.2571082-2-mohan.prasad@microchip.com>

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
> +            verify_autonegotiation(cfg.ifname, state)

If i'm understanding this correctly, you test with autoneg off, and
expect the link to come up. That only works reliably if the link peer
also has autoneg off, and is using the same speed/duplex.

What i guess is happening in your test setup is that the link peer is
failing autoneg and defaulting to 10/Half. But i don't think that is
guaranteed by 802.3. There are also a small number of devices which no
longer support 10/Half, they are likely to default to something
higher. This is especially true for datacenter NICs, they may start at
10G and go up from there.

So i don't think this is a valid test. To really test autoneg off, you
need to configure both ends of the link.

	Andrew

