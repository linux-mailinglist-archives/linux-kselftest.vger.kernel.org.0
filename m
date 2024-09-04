Return-Path: <linux-kselftest+bounces-17105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A48096B081
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 07:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86441F250E5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 05:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96460824BB;
	Wed,  4 Sep 2024 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tC7qrY3v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66B1EC00B;
	Wed,  4 Sep 2024 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725427829; cv=none; b=O/K9GbtDw0X05qFy2iwia6WgwjMZeL64NkUBr/r0GVwXJUT6R5nuMhsjdKpgwuVNq8KalFE6Re4ozGPs75wB81+tmGchO5lB1Opr08bxD7NSIFtj3OG1LEW+DETwj/qiU0LKv/yTU+13fy8l0T4dzQITh51/8Ta7w7ln4Uuxuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725427829; c=relaxed/simple;
	bh=5tLuH2VDlAzZsIq6hm90Ox7/alE802MSDyZ0YgLbYpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN0bBe07k8jD6D8Q+n8n+hbxfhAPUN0ZjLaZl4K1lZiKFOZtmqhhOvKCApKoN/pscoGAlN703NBVkZk2NkyaEeI4EWNVSHosgKGq5YT4FgYqbvwbpH17K200JN5N7cjVMBT8J/LFtn2zn8BNdTGhfGOMSoAl0aGOK+/aDfZZlWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tC7qrY3v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6RTRBhAVgKcFZfMMAYRxw7reG2ZJQUyh/CZkw5Ux0+I=; b=tC7qrY3vJQL7F7RJxEVDsIM7gt
	2qngwfqnnAMKLl/4mGMyORD1cNgxu02/L4Ryf/s4jtUB9d8Gj8k0E7AhSiBOovwNUiaU9QApjG4qR
	Fvc10wUYnHgcpGrMm9HIJYIOEaY3Te46vsVZc31V1prC2f8yTVS2b+kU1zZkeFDxspmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sliay-006UmC-CS; Wed, 04 Sep 2024 07:30:20 +0200
Date: Wed, 4 Sep 2024 07:30:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohan Prasad J <mohan.prasad@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	shuah@kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, horms@kernel.org,
	brett.creeley@amd.com, rosenp@gmail.com
Subject: Re: [PATCH net-next 0/3] lan743x: This series of patches are for
 lan743x driver testing
Message-ID: <7cbdcb2b-37d8-45b6-8b4e-2ab7e7850a38@lunn.ch>
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903221549.1215842-1-mohan.prasad@microchip.com>

On Wed, Sep 04, 2024 at 03:45:46AM +0530, Mohan Prasad J wrote:
> This series of patches are for testing the lan743x network driver.
> Testing comprises autonegotiation, speed, duplex and throughput checks.
> Tools such as ethtool, iperf3 are used in the testing process.
> Performance test is done for TCP streams at different speeds.

What is specific to lan743x? Why won't the autoneg test work for any
interface which says it supports autoneg? Is duplex somehow special on
the lan743x?

Where possible, please try to make these tests generic, usable on any
NIC. Or clearly document why they cannot be generic.

	Andrew

