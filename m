Return-Path: <linux-kselftest+bounces-9045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A14F8B5D4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36711280D1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D435128373;
	Mon, 29 Apr 2024 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jUUeOwpn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB607FBD3;
	Mon, 29 Apr 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403558; cv=none; b=EFVAGSMstlafnVOYvXn+uRMCBxYakfAiuq4fKXX5l1tG9HFvgOx8f70SQ/1N4bzpUZEUCDjYVYj4aJ0NL+pc7rbfyncR6K33B7QBq6yoJ/U54yar7RDD4T3w0o/yHhMg1rQZ2YuFf1JQyTxuMzVewslp4Ku91NuPcjF0pbnX7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403558; c=relaxed/simple;
	bh=ZVxJKYP+touyonHV7KQke7urhxIGqPBITIBNmuvq3pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPXWemgkZhyNcA2FrwCWZ/PHl03xWqf41iF6lvMSMX9VsDoGT2QhWF95ZaX8b/swqI1Ot3CVPV8W3FUtcefSRdnT2ioCzrXtm5WMQyEh34F/yi7wm7UnxIV6U9GNVEppMoxtc6/JIxYMxzInbjXtEWbcFGvaJc3LxKn6TdN16aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jUUeOwpn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jBcmhTC6agLFryCb3cNSxgm7WEP3k3IfBuHndh2TBNg=; b=jUUeOwpnpfHL34hJofDh9diA4X
	3y+lGm8dl5INi2YPxioW/pJ4/jxtO6esFeFSfn4vKs/6GnDQdnE/yk+NtuZa//PWKP4JnhDrss76L
	IgvQbxAX4+BaILC3lYtLrBzZgRmn4CqIrHSytFVFpFMfOHoOCcKRWTVFigDmCz3ILgpo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1Sg9-00EGTH-58; Mon, 29 Apr 2024 17:12:29 +0200
Date: Mon, 29 Apr 2024 17:12:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 6/6] selftests: drv-net-hw: add test for memory
 allocation failures with page pool
Message-ID: <3e332c1d-b767-48f2-8307-0d037921773f@lunn.ch>
References: <20240426232400.624864-1-kuba@kernel.org>
 <20240426232400.624864-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426232400.624864-7-kuba@kernel.org>

On Fri, Apr 26, 2024 at 04:23:59PM -0700, Jakub Kicinski wrote:
> Bugs in memory allocation failure paths are quite common.
> Add a test exercising those paths based on qstat and page pool
> failure hook.
> 
> Running on bnxt:
> 
>   # ./drivers/net/hw/pp_alloc_fail.py
>   KTAP version 1
>   1..1
>   # ethtool -G change retval: success
>   ok 1 pp_alloc_fail.test_pp_alloc
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

If i'm reading the traffic generator correctly, this test runs for 24
hours. Do we want some sort of warning here about the test duration?
Some sort of alive indication very minute?

     Andrew

