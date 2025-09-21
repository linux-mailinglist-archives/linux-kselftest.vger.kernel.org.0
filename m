Return-Path: <linux-kselftest+bounces-42031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3CB8E321
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C70C16AE88
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05512750FB;
	Sun, 21 Sep 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SiLXF84u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E4274666;
	Sun, 21 Sep 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479199; cv=none; b=IX+zBrxvIt9qbSTMMbJdySGOPPllJc9OVnvA65Rxl3BxEgDq5V5iW2dUgVEVKNxrflYuCJ5NcV1o5WfjMsBqGDhPCr0mfRIlYXZnTBdLmZrB73orZfRA8Vlg0VjAD9gDQEK+bo4hHMmqCQskSPlp8cdATIu3QF6uW8QY/NDI6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479199; c=relaxed/simple;
	bh=QXSeu2WytESQlQTkLgYKHrixkheQCq3k1bXCbILkUkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf8u9CU7+VO70WqYtVn94B0z8mH2jUpSL0McA3Xvr6zz/NRpDmorlsNhlmr7xqvnAtDW6VoRUY3Q9lvHJYj6UejgHJuOT8/F75nyfUGYo/fEbd4g2dp7vlsjf/nZfy4BLYcfrc8RX2FP18JCNCyGPwHzqptuXQTY5FYvGHoFwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SiLXF84u; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758479195;
	bh=QXSeu2WytESQlQTkLgYKHrixkheQCq3k1bXCbILkUkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiLXF84uJ0cUlIgVvdme+rvvump7e0qFUDt78/BvjcglFbOXDjhwbf7kipCnvhAIg
	 VGQRuIzId+t3NRqqzGLa+NAnfmlI0tetXYU3BkaQ9zT7rj+SuTHj6sv5a9h6IZHdTN
	 7DmNwSVHcqA5pgtPDP0FiJtt95XJFiFofNN0isbQ=
Date: Sun, 21 Sep 2025 20:26:35 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <70421908-6300-4df2-a54c-2dca03e8184e@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
 <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
 <20250921171323.GC28238@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921171323.GC28238@1wt.eu>

On 2025-09-21 19:13:23+0200, Willy Tarreau wrote:
> On Sun, Sep 21, 2025 at 07:05:24PM +0200, Benjamin Berg wrote:
> > This also ties to the question of the other mail. I prefer "errno" not
> > to be available if it is not actually safe to use. UML does use threads
> > in some places (and may use it extensively in the future). The current
> > "errno" implementation is not threadsafe and I see neither an obvious
> > way nor a need to change that. By setting NOLIBC_IGNORE_ERRNO any
> > unsafe code will not compile and can be changed to use the sys_*
> > functions to avoid errno.
> 
> That's the point I disagree with because here we're not using errno
> more than printf() or dirent(). Why fix dirent() to build without errno
> and break perror() ? Why not also break printf() then ? All of this must
> be consistent. We're unbreaking some arbitrary functions and breaking
> other arbitrary ones, that's not logical.

printf() is already broken. So by breaking perror() it would have been
consistent :-/.

> I'm totally fine with saying that errno shouldn't be defined when building
> without errno, but all functions must continue to be defined. perror() is
> used to print an error message, it's a valid use case just as printf() and
> should remain.
> 
> If we disable perror for this, then we must also disable usage of printf
> for consistency (and I don't want this either).

Then let's also fix printf(). Benjamin, do you want to add this to your
series? It should be consitent with the perror() fallback.


Thomas

