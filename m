Return-Path: <linux-kselftest+bounces-7766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AC8A264E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A153B2135C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B651E2233B;
	Fri, 12 Apr 2024 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QvuJDJQY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6291B95B;
	Fri, 12 Apr 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902572; cv=none; b=LHl4P8lMaaiz2j2yQxB8Ut97QxnOm7379D8/menHIKB+gPLTJNsHgUvnRiLCnyiHqo43lXblTDQiyhySQI50dqU9ZSU0wTv7lVF1fzcfqyaymXN/rz22ShcTaG0czDK07hLXCaB3G03GlCtNuxgGTC0xsLPc4eamuRFfbe2DY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902572; c=relaxed/simple;
	bh=9eQMxiafHll+DiH3/C8+rB0CEgq99HCS6lNIP6dzKx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD1nRgfDAJazd0ZnqUNUhoyLGbfEE4WFEq529GgTBz1S/PeQ6J6kqIutanoX4gUWWKazAF0s1tVc52tUgu2MIIA4cfi+rKgqClHPTJuh4UgTs0uPcSL9qCVlBgqSRLS1zdHc/rkL5lV0x45+m+sLYS0Pu/PJ73Q21DdLx9ixg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QvuJDJQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C990C2BBFC;
	Fri, 12 Apr 2024 06:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712902571;
	bh=9eQMxiafHll+DiH3/C8+rB0CEgq99HCS6lNIP6dzKx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvuJDJQY8WGntppmdP4fgc8Qvksv1g81oIXeT5FLOXWg5hmN8h6pR7cGEKeqYxKIo
	 lLP4mIs4WGguK6Huha4l0KITsm+NsODwMqAhgJ5HqPzVW5gbu6IgxfpBRjeqr61LzH
	 gOaad1saorXuoVXrs3eGLb1Cwi5sMJSzXSTuAXN8=
Date: Fri, 12 Apr 2024 08:16:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 04/30] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Message-ID: <2024041254-that-laurel-30f9@gregkh>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
 <20240329000621.148791-5-zfigura@codeweavers.com>
 <2024041111-handsaw-scruffy-27f3@gregkh>
 <25522541.6Emhk5qWAg@camazotz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25522541.6Emhk5qWAg@camazotz>

On Thu, Apr 11, 2024 at 07:33:07PM -0500, Elizabeth Figura wrote:
> > Rolling your own lock is tricky, and needs review from the locking
> > maintainers.  And probably some more documentation as to what is
> > happening and why our normal types of locks can't be used here?
> 
> Definitely. (Unfortunately this hasn't gotten attention from any locking
> maintainer yet since your last call for review; not sure if there's
> anything I can do there.)

You only seem to have cc:ed one of the "LOCKING PRIMITIVES" maintainers
on this patchset, not all of them, which might be the reason why it has
been ignored :(

Perhaps change that for the next version of this patchset?

thanks,

greg k-h

