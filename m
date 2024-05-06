Return-Path: <linux-kselftest+bounces-9524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625FC8BD1F1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939931C22B67
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D06155A53;
	Mon,  6 May 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="o2fWO0P7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5662155A4E
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011049; cv=none; b=KoXM7le+zX7VEc0BhgdvIVH/cW8r9mkiqSfyTwYEDp8UMiqZKi7RG5NHJzDJtJyDOHJ6FZ6UaZ2Ogz6rwIH2z1EW5WmqA2q6BlYz+AhEWtdlVK40X/dzUrY/rY3NnGuXYHPyOMfxqnOmPnNEqL2HqbKT6TysUpiEjkPjs8FXmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011049; c=relaxed/simple;
	bh=iiKrYKylxLJGKkdodAnRvX5ipn2c1qK7DHCqWXkLqMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKeqtlNZD8sqeWbTZvFdeuIfnWFxXZusWGW6uk/JZn0Z34bV8nGb3ekNMXIXuZ4/iWczOgg/6gGC3qPoWIfRXdjAZn3JYf732Mm/QT/tmSVZJkfnYodPD8gb1+pikyXV9ievOv00WPB3emzeLIOGDAc/Ult2BOWNiidDg3EyHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=o2fWO0P7; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 517d0a94-0bc1-11ef-93a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 517d0a94-0bc1-11ef-93a8-005056abbe64;
	Mon, 06 May 2024 17:57:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=RUHm1EWr1K/7L/9ocw0nmD0PbDFVhkil+phJ070GL4Q=;
	b=o2fWO0P7FvqbEG/2cJ180+MP80HbMrtRuNbEML9KheS4F7idO9tbdqnWyUeem/9buafR2onUCZTz2
	 YorC4i1exN684EXZdi+V/MYLmaRVqxYj1H4BbHYl0RS/fkXF3Sgi5WuQH5hrHaQ1aReh13drCBHt5k
	 UZUGlF3aPjk10HL8=
X-KPN-MID: 33|/Ph3iBiQzufTV4TSUee1KZp+q26aevXSrQGrnCyXEi8ZSlgUNTjH+xt/TX00Qj2
 YUphs9Gquhk2zkw9fcqcXHazx/PX1p7W3bpmbRrNBtzI=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|kNFyKwD6mBehpBEBTeKAMu+IAPoxC0+39Qm5wKamm0JqDcEu6s5sQcd7CJhaRz2
 +VNFkBc2XQfM3lHNGIjGmRQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 53dd6200-0bc1-11ef-8793-005056ab7447;
	Mon, 06 May 2024 17:57:24 +0200 (CEST)
Date: Mon, 6 May 2024 17:57:23 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <shuah@kernel.org>, devel@linux-ipsec.org
Subject: Re: [PATCH net-next v3 0/2] fix icmp error source address over xfrm
 tunnel
Message-ID: <Zjj94y2JW4uPg_Iz@Antony2201.local>
References: <cover.1714982035.git.antony.antony@secunet.com>
 <ZjjczzsSz6wwUHd5@hog>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjjczzsSz6wwUHd5@hog>

Hi Sabrina,

On Mon, May 06, 2024 at 03:36:15PM +0200, Sabrina Dubroca via Devel wrote:
> 2024-05-06, 09:58:26 +0200, Antony Antony wrote:
> > Hi,
> > This fix, originally intended for XFRM/IPsec, has been recommended by
> > Steffen Klassert to submit to the net tree.
> > 
> > The patch addresses a minor issue related to the IPv4 source address of
> > ICMP error messages, which originated from an old 2011 commit:
> > 
> > 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
> > 
> > The omission of a "Fixes" tag  in the following commit is deliberate
> > to prevent potential test failures and subsequent regression issues
> > that may arise from backporting this patch all stable kerenels.
> 
> What kind of regression do you expect? If there's a risk of

For example, an old testing scripts with hardcoded source IP address assume
that the "Unreachable response" will have the previous behavior. Such 
testing script may trigger regression when this patch is backported.  
Consequently, there may be discussions on whether this patch has broken the 
10-year-old test scripts, which may be hard to fix.

> regression, I'm not sure net-next is that much "better" than net or
> stable. If a user complains about the new behavior breaking their
> setup, my understanding is that you would likely have to revert the
> patch anyway, or at least add some way to toggle the behavior.

My hope is that if this patch is applied to net-next without a "Fixes" tag,
users would fix their testing scripts properly. Additionally, another piece
of the puzzle for a complete fix is "forwarding of ICMP Error messages" 
patch that is in the kerenl 6.8, which is new feature and applied via 
ipsec-next.

-antony

