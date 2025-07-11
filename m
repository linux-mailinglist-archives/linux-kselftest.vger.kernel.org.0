Return-Path: <linux-kselftest+bounces-37115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 644D1B01E55
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747831CA6B51
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45372DC34A;
	Fri, 11 Jul 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tub4Oe9N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="66i0xz+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C12D838C;
	Fri, 11 Jul 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241905; cv=none; b=bQ+9mV9/dwyVa0gws4TsRWMx6p4pHsZTN9z0E8lzui49X0HGfNUSSgqeZZNL8O/XGL3qvo0/XKDHwYywr9Tj7J3FZwmuMSHIxMRTkn6NxPMLABAEXZHS+PLQ/N02dRIRmqsC1AirwXUB+4SgdpKHWfSe9VDRJSUQxzBmEb1N7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241905; c=relaxed/simple;
	bh=P3jJvx7kkJzGYrGr7kYLYTxDV9iv4WkdaAW5T7pDdlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5p2GyOr0gxcgJQEUEgYPcsejLspccqaXphTMuwI3CutdcKk5R2KGBQxNKic5YmjNui4dH0VkH6R7UCBK2mkgXps4PTXSfwy1XBVujXDU2pUyatxQ62Vrilt3B580gbAcmIeu2uaCEFuDy+tjyJeTB33Lm2gtwqQDc1205kXHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tub4Oe9N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=66i0xz+F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 15:51:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752241901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfBc84rpX+rOpaSC3ax0AwjFfciBGxk0wD+STiI9Dhw=;
	b=Tub4Oe9N6OeAZHfDfzT57/OVRehm4h5JjiWVYI9Nmg4iHM54zcgmWR4vwT3+bvxwB3K44z
	Bx53zieDYDz800TKU4W3bchfxjSZ2bsGMK2fMSof0twPiIPkgM8OBe2ny2CMGH5cv0Fh8o
	fx4nevvjuXqxarozLZifK+2jSGCzjRWzgdnDZwutG2VOQVFp4gEQSdjs7gqJ8ojVLqjFew
	AMItV6q6GJ+8X9JDzWPUWoSc8tfvdT1DN57zAQ1y+MAWbVMzP7frnFL0JTE44WtwtDP+C3
	CszgmrNT0SK5DsWGnDlU7sNPv150lMkZ35RF4Hc0IqMw/RcvCIGKR6dofkY7ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752241901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfBc84rpX+rOpaSC3ax0AwjFfciBGxk0wD+STiI9Dhw=;
	b=66i0xz+F/0L36sY+PBuF3ts1Cw8VONS1Cn6DG3glGrey3RKJSaaHK+psKNbqd7s5HYSE4w
	TYr5/XIDhakl5FCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 0/3] module: make structure definitions always visible
Message-ID: <20250711155016-f403d5b2-478d-4666-913d-45318cdaa3cf@linutronix.de>
References: <20250711-kunit-ifdef-modules-v2-0-39443decb1f8@linutronix.de>
 <175224114462.57001.15162198119283395382.b4-ty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175224114462.57001.15162198119283395382.b4-ty@samsung.com>

On Fri, Jul 11, 2025 at 03:39:04PM +0200, Daniel Gomez wrote:
> 
> On Fri, 11 Jul 2025 15:31:35 +0200, Thomas Weißschuh wrote:
> > Code using IS_ENABLED(CONFIG_MODULES) as a C expression may need access
> > to the module structure definitions to compile.
> > Make sure these structure definitions are always visible.
> > 
> > This will conflict with commit 6bb37af62634 ("module: Move modprobe_path
> > and modules_disabled ctl_tables into the module subsys") from the sysctl
> > tree, but the resolution is trivial.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] module: move 'struct module_use' to internal.h
>       commit: bb02f22eaabc4d878577e2b8c46ed7b6be5f5459
> [2/3] module: make structure definitions always visible
>       commit: 02281b559cd1fdfdc8f7eb05bbbe3ab7b35246f0
> [3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
>       commit: dffcba8acea3a80b3478750ac32f17bd5345b68e

Thanks!

FYI If you apply a patch you need to add yourself to the Signed-off-by chain.
And Link tags are nice. For example:

b4 shazam --add-my-sob --add-link

