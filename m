Return-Path: <linux-kselftest+bounces-9031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C50F8B5C3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4E51F2254E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA5E80058;
	Mon, 29 Apr 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ash2DRyD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16247E0E8;
	Mon, 29 Apr 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402930; cv=none; b=sU7XRliZDMY+zriYrA/5Y9XKoEm5wvxqIdXqW2yIVA5Qr3q5/tetF3yq4u+25kLLf8BAA+jnZf3a+rLa/JrGpCSViNQQ12tWjitAWaZ6Qluher/m8ykrWQBtYRGIdDD6JEYsqEJ+K5hbDnWtMk8IdaPgoTyVPR69ykyGjZ5IZUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402930; c=relaxed/simple;
	bh=uXR2C2zdCLSmD0RP0XnuR32Du5EyvSSAy0wrm3IQp6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwtav7sy/RUqQnqUQeZujqO1JELpuIeDDnCE0aZGIo16TBkP+TvmueSYNEoKKnaOKjR4geI86Q0QQyk/liMRREF7VijLes5dtZM/qt9YjlBnsN9S+81I7gBlX+iSAgpmqD3xyp1ceBix3vDkcb/Pjrw6fj1+Xig0GMHxM3Fg8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ash2DRyD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I5imaSlytIgQxMA+frMHaOvS86c3yZoGnlyXDQjIMhU=; b=Ash2DRyDdKuOEDjdwMXEIJXrAw
	fv5bH5PaLkfyqGbBTSzStqqngil/XDPHFGuQS18L1q1UE4r3Kn50wk9o2i/I1tJ2SHDytgdE/Z+SE
	1aRIlbwywpiz3ZL+CN629zHTKCVHbl7aTHeqVIhkupRE2A9wdCHFYgGI3CIg2CZbjVYY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1SVv-00EGK1-Vi; Mon, 29 Apr 2024 17:01:55 +0200
Date: Mon, 29 Apr 2024 17:01:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 0/6] selftests: net: page_poll allocation error
 injection
Message-ID: <f59287a5-99ba-4f37-8019-b176f0307ec3@lunn.ch>
References: <20240426232400.624864-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426232400.624864-1-kuba@kernel.org>

> I'm not super happy with the traffic generation using iperf3,
> my initial approach was to use mausezahn. But it turned out to be
> 5x slower in terms of PPS. Hopefully this is good enough for now.

How important is PPS? In order to get 'Maintained' status, automotive
vendors are going to want to test their 10Mbps T1 links.

	Andrew

