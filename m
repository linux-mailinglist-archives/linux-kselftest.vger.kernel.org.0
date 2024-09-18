Return-Path: <linux-kselftest+bounces-18106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FF897BC02
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5CDB26B1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 12:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B549187FE6;
	Wed, 18 Sep 2024 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ddJsP2Z+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574C178381;
	Wed, 18 Sep 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661510; cv=none; b=hrxPtL9mSnZMt53ziz5v/dhzjRCniqcSsQieTlTiLvR5zhGR3gwTor56WpXqtpB3E7HECQAQ6pW7Nb2MnzX0I6Z3std6OYDj4tIlXM8StbJIr8+wfxK6iFCXCFOm7yewQ1slpzKAgGf+ptMxOzWYFWVci5dXpkWOaa0c+i1raQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661510; c=relaxed/simple;
	bh=/QsTjJoYenShG9PJNSPFQ4FfJIi56Ky0k8jSlUse4mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWMLFehqh+J1AX7il2NuTX0Ip9oUQIafE1lk58nLTyWZqDG+wQIG2xpD5wQFHOZ51097v2WwEolG6dPJn1YcJZry3ak8IMA5RUdFLH8P9T2X/1rFnYVTBuLOoX/5OMbBjgYnUi/m0sFUUdKPqwVWbLFy3M6c19yRvrC9ESPcXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ddJsP2Z+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UpUYg/WfCwK7y06BoIrQ4fudX6e5dL/vUjmnreainso=; b=ddJsP2Z+i5igVirSeQgYSDwzjH
	3IidX4Qcm4qxQlAvFaHUEjYjWNRHHjy+7MhM3KPdzHzRKsvt4vjzzk6j7o+inCymgxOIyDhv8bQKS
	SlK8KWl6KdX/zsAe4r1Ynj/jt6CjXRHC36PsUD0c8ru7GqWpaPmV94owZCo/wdg0liVU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sqtX5-007iFr-11; Wed, 18 Sep 2024 14:11:43 +0200
Date: Wed, 18 Sep 2024 14:11:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohan.Prasad@microchip.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, brett.creeley@amd.com, rosenp@gmail.com,
	UNGLinuxDriver@microchip.com, willemb@google.com
Subject: Re: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest
 file for basic tests of NIC
Message-ID: <7dd8fada-0079-4429-89c0-4949302dbac4@lunn.ch>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
 <20240917023525.2571082-2-mohan.prasad@microchip.com>
 <0dd4130e-b06e-42e1-8f36-2589c18c4762@lunn.ch>
 <DM6PR11MB4236FE8CEF8EC610B2525EF283622@DM6PR11MB4236.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4236FE8CEF8EC610B2525EF283622@DM6PR11MB4236.namprd11.prod.outlook.com>

> > So i don't think this is a valid test. To really test autoneg off, you need to
> > configure both ends of the link.
> 
> I will change the implementation to configure both the ends of the link appropriately in the next version.

That would be good, but it does make the test and the test setup a lot
more complex. I would suggest keeping such two target tests
separate. Also, look to see if there are other such tests using two
targets, and keep the basic configuration the same, IP address
configuration, how to SSH between them etc. I'm not too familiar with
the test framework. Maybe this is all a solved problem and there are
helpers to use?

	Andrew

