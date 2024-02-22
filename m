Return-Path: <linux-kselftest+bounces-5255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E285EE47
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 01:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36677283187
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA710A0A;
	Thu, 22 Feb 2024 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="clEL9H+/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAC928EF;
	Thu, 22 Feb 2024 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562895; cv=none; b=YegFKcwefqMCInzdhM99QFk465yu/QcgFB5X3VbAzIYKiyOl5q8w59bFlZaMgrgmo+Ri7x6M25pnuaWk2+Slw7J3JKmbHwH8ZDewdPnab+kUomA8ciLnBwrVVc68tFPwj64V9yWg2B4hBYNCCDTbrErBYNMWccmp4vJOKfIlbNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562895; c=relaxed/simple;
	bh=XI8ydxcy9WrRVyKDmwdrI04D8A6JcSoF6++PWlX5+V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H55ZHgaE77Sh23qHufGc+SooUPlbyo+h6f4gFEavN8+yQXZNEai05yGMcBCW632BG0iIycuu7T2R22t8BVkYk4ct5YVvYoLNLz9dFyCMEFFzYYohp5gGl1IBVxgFBAI9jf5XdtwnhunRjiY8y+dwOVBBKjCErVER6F2P+1hp82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=clEL9H+/; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=mT+tca9auPHS8Y/lU5QKQsbY2Tk2BeA5WfwDxORVpa4=; b=clEL9H+/ScDXJiqQr9ZrGcrVn7
	IrktAY3+15JIHSY6qq0TCcBxLVSbw5w3P53J0jCIw/R9HsN58oHIEPhYK2lmGri5A4LF0jcSVi3R4
	s7vCEInKo5tT6zl+hcHgaIn5L7H/b/KyDuUvDoZNY2siIpTVfs9Lk1YbIo3DeMmlf6WEr/gnNx+eq
	Z+5sapTuPABKRk0THMuL6e1H4p+5DQFnXNiJSB1vJtjOy1fsMXmW+Ks5hxcRfSrib8hcaS/eFcRti
	bnRVCiPgz0/yOXqFCOUJ53JYo0QFhOMLmxw6V1i1fYze3Xy/3pF7j2WR6iyZZzkyg9xB5TTugFL/G
	rOPOsjnQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcxFq-0055i2-09;
	Wed, 21 Feb 2024 18:48:02 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, shuah <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 17/31] ntsync: Allow waits to use the REALTIME clock.
Date: Wed, 21 Feb 2024 18:48:01 -0600
Message-ID: <3275980.aeNJFYEL58@camazotz>
In-Reply-To: <830b0788-35e6-4cbd-b195-254d434ba0cd@app.fastmail.com>
References:
 <20240219223833.95710-1-zfigura@codeweavers.com>
 <20240219223833.95710-18-zfigura@codeweavers.com>
 <830b0788-35e6-4cbd-b195-254d434ba0cd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 20 February 2024 01:01:59 CST Arnd Bergmann wrote:
> On Mon, Feb 19, 2024, at 23:38, Elizabeth Figura wrote:
> > NtWaitForMultipleObjects() can receive a timeout in two forms, relative or
> > absolute. Relative timeouts are unaffected by changes to the system time and do
> > not count down while the system suspends; for absolute timeouts the opposite is
> > true.
> >
> > In order to make the interface and implementation simpler, the ntsync driver
> > only deals in absolute timeouts. However, we need to be able to emulate both
> > behaviours apropos suspension and time adjustment, which is achieved by allowing
> > either the MONOTONIC or REALTIME clock to be used.
> >
> > Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> 
> I understand that there is no practical problem in building
> up the API one patch at a time in the initial merge, but
> it still feels wrong to have an incompatible ABI change in
> the middle of the series:
> 
> > @@ -35,6 +37,8 @@ struct ntsync_wait_args {
> >  	__u32 owner;
> >  	__u32 index;
> >  	__u32 alert;
> > +	__u32 flags;
> > +	__u32 pad;
> >  };
> 
> If this was patch to get merged at any later point, you'd have
> to support both the shorter and the longer structure layout
> with their distinct ioctl command codes.
> 
> If you do a v3 series, maybe just merge this patch into the
> one that introduces the struct ntsync_wait_args. Overall,
> you could probably have fewer but larger patches anyway
> without harming the review process, but other than this
> one that is not a problem.

Oops, yes, that does feel wrong now that you point it out.

I'll squash this in v3, assuming there's a need for one.

--Zeb



