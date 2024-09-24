Return-Path: <linux-kselftest+bounces-18323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6F984B95
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 21:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395931F207C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 19:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7513013774B;
	Tue, 24 Sep 2024 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q4BowKfu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6DA41760;
	Tue, 24 Sep 2024 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206275; cv=none; b=g/aSp1UXnzoC5qX9NCPyLSucoz7Riw9fg9rLpXMB12oUteyiJcFmssHv+cM0iEh4MPWc7lekwz1a8b7rWBXmrmUstqNuMuEsG5SlA9aqM74RUsUrrIll7YnVQX1jJuh7Bh0HFH4OmgA/w5P8MG0khQmMlBVANTL+rIulpPa6gOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206275; c=relaxed/simple;
	bh=+hkrFnzPkG+ywdEBjiCvkztP4lCmaL/j0+der7ip1Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/0VcfdOY2gJZzTvOge7DzaZHaMcXVtcGLJwlyjR4KQf/1Qn0RzZOP3TamVleRQE6CI3EZHB16n8o9+A9dd0RrPHlU81BDN2+d+oPaRFe86iSmvipywjZYo2tQ1dt1W8stPzGjejC1RQCDg8osO1Nsb+1zi5XNzdYtVc9qhxABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q4BowKfu; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BE4A1C0002;
	Tue, 24 Sep 2024 19:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727206264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hx9ijB/BeFH58Wl3KyZd01fz1nRSpYeFNRZgq1sY8/A=;
	b=Q4BowKfuEvANoRMib4RBgpIIvoeE+/BiSiBqXHCbbRMgbs33cXSYCGz+8K8tnJjED48Ude
	7hd7TKrIMBpmls9h69WF7KTDCGg5+etuX5A37clj29x49b/UCPYUrhCeP9VcYEPTUUJ3kq
	b5W0hu0p14S3qVrF9b9Wf+vIHmdPrbJcUHZORGVtCS2n4H+d/C20tr5oBFlx+c4swXArq7
	Pob1kmxitcdtFLQkRc31edwJK9eWG2PhFnA1D47v8gPRqohnU37PeHGhnQ1r8EoyQXBdR2
	uFsHEGrY4f9zYCQ/mZkDotIwM4qeQOcCy6RPk6+OgrphWFYCoqhcCrJouZ1xjw==
Date: Tue, 24 Sep 2024 21:31:04 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Joseph Jang <jjang@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"avagin@google.com" <avagin@google.com>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	Matt Ochs <mochs@nvidia.com>, Koba Ko <kobak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftest: rtc: Check if could access /dev/rtc0
 before testing
Message-ID: <202409241931048861ee5b@mail.local>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-3-jjang@nvidia.com>
 <202406201937464fc96b1c@mail.local>
 <8c92ef18-6648-4348-9008-4f646d8b6956@nvidia.com>
 <05f24dbb-cfe6-4a75-9382-273c9c734b22@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f24dbb-cfe6-4a75-9382-273c9c734b22@linuxfoundation.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

On 24/09/2024 10:05:43-0600, Shuah Khan wrote:
> On 9/23/24 23:37, Joseph Jang wrote:
> > Hi Alexandre,
> > 
> > Thank you for looking at the rtc patch.
> > I saw you Acked the [PATCH 2/2], not sure when could we see the patch
> > in kernel master or next branch ?
> > 
> > Thank you,
> > Joseph.
> > 
> 
> Please don't top post. It is hard to follow the thread.
> 
> > On 2024/6/21 3:37 AM, Alexandre Belloni wrote:
> > > On 23/05/2024 18:38:07-0700, Joseph Jang wrote:
> > > > The rtctest requires the read permission on /dev/rtc0. The rtctest will
> > > > be skipped if the /dev/rtc0 is not readable.
> > > > 
> > > > Reviewed-by: Koba Ko <kobak@nvidia.com>
> > > > Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> > > > Signed-off-by: Joseph Jang <jjang@nvidia.com>
> > > 
> > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > 
> 
> Alexandre, I can take this patch through kselftest. Might have
> slipped through my Inbox or the assumption that this will go
> through rtc tree.

I assumed this would go through your tree, this is why I didn't carry
it.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

