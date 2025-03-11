Return-Path: <linux-kselftest+bounces-28704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725D6A5BC5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 10:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B72167239
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9A7225A20;
	Tue, 11 Mar 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p82H1PgP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C057222587;
	Tue, 11 Mar 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685678; cv=none; b=nr1sAncs6y0RCCDqB0ZdcVJAkUwPn4CCJ7P4PGKfvnGH+gew5t7tMUvq+XSa6fwYgNh5f2tk6i2K7CNg79UtH7ub9ukXst2j2kVzxq3X7ZBlBy4m0nURrZtyYltrtMXkRsralRxgjjzfvkQqQn4Oyl0FByBA24Bqn3GfDxKuAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685678; c=relaxed/simple;
	bh=XRKCyt/Tfv0J4lpbV3XtVDrpXUwvQkibP63iFu88V4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQvJQRpz65Soun2sJMriVZlVMjb6wmV6hRS6sHzs1Jjt84M1+7dN5D/spt6f4yHbGhjrYPPm7FuJBsaOwN+jldhEuRrspdOjbxBP51rOb5S/QmazoFzcUZybGpM2ORM5RFtBiDC5bkJX/7sH50E60FS1/83s7zVrCc41fSJuRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p82H1PgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49879C4CEE9;
	Tue, 11 Mar 2025 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741685677;
	bh=XRKCyt/Tfv0J4lpbV3XtVDrpXUwvQkibP63iFu88V4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p82H1PgP5y89hp8jAKkzsSMGQErzsiq8O/JRgaCcTbgr1HWQKtNLy4KyPH/u6eNY2
	 i7guE5/dHZAsqTGYqrjrl++e/6Y++OMJmjM+z9PfaXa+5mSdJlFWi03GqWdOYqLoAA
	 yd+OyEOfVWZba++4ek/ZbURADrhB/KHy7Fl+winQ7p39tB9/HpRQmBz6SYxshrWXKz
	 oDRmm51d4Geb7C385uPUqGTXo7/b+Rge8Z5ERmooRtN4EGIfJ8K+mP/b5nIEIVvxAa
	 Vo+heOkPxH+jDSIl5P1xpl10SmY9TrIWl1cr24pdM1WtqnQuzC1lFHlxIz0KGJRWKA
	 xj/cF6qIIyATg==
Date: Tue, 11 Mar 2025 10:34:31 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 net 1/2] bonding: fix incorrect MAC address setting to
 receive NS messages
Message-ID: <20250311093431.GH4159220@kernel.org>
References: <20250306023923.38777-1-liuhangbin@gmail.com>
 <20250306023923.38777-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306023923.38777-2-liuhangbin@gmail.com>

On Thu, Mar 06, 2025 at 02:39:22AM +0000, Hangbin Liu wrote:
> When validation on the backup slave is enabled, we need to validate the
> Neighbor Solicitation (NS) messages received on the backup slave. To
> receive these messages, the correct destination MAC address must be added
> to the slave. However, the target in bonding is a unicast address, which
> we cannot use directly. Instead, we should first convert it to a
> Solicited-Node Multicast Address and then derive the corresponding MAC
> address.
> 
> Fix the incorrect MAC address setting on both slave_set_ns_maddr() and
> slave_set_ns_maddrs(). Since the two function names are similar. Add
> some description for the functions. Also only use one mac_addr variable
> in slave_set_ns_maddr() to save some code and logic.
> 
> Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave device")
> Acked-by: Jay Vosburgh <jv@jvosburgh.net>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_options.c | 55 +++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 8 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>


