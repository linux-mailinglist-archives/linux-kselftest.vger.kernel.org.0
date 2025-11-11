Return-Path: <linux-kselftest+bounces-45316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADBFC4E3B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBA33A79E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E234251E;
	Tue, 11 Nov 2025 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P60lUw92";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z7I7QV5E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB123AA190;
	Tue, 11 Nov 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868858; cv=none; b=ZMWcqNhH+A1LBA7EZQ3ObqxcT0JUXD6vmNOrD+a6XRSsM8AQ73HGfJl5uNx1nnq5/sbbHMaD++u1gTvoumQ62ijxDQtqOiZpP++mQdOWdGBnuiMQvEwsFF+lrvaoWe5QMkCPuZwqYEauIguK7utdmsYMY0zJwWlREKtaTsBwX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868858; c=relaxed/simple;
	bh=lUSSiRFxpN3en6I2kE4qTBy2cZCam+IjY5gjxWZKLW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP/V/QP/7n/qOX0nPu/cs9DtCy6h2sxyBPfpq9qGir6cSgBgMAwOW2FgASG3YjX329Sv9HYSpR+RWxJI1HV5YbQrHz6cRf1J/P1clG6IcdUhuRhL3rB54k/S79JN/szQJbF0K9EFAXeDi+HvHktF641O2bued5/2/otu5VUklxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P60lUw92; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z7I7QV5E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 14:47:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762868854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlAUUcjIbub6gJLU5xG36VHrzybTTRxYuCaV1oAko9I=;
	b=P60lUw92rf6qUFD77XLVBR+fbrKVLL0LMB3ZBuIKwTj7yPVBDvuREMlegQ7Ci46jJxN2l0
	QYVUApt6AQanNXpr2YXYY9H/DjvXPOdI8RLxHrcXIZOi+OVDO054I4liyFpN8MrdXypvuQ
	h5bNQL3Ewe8wU+D5Nkf29I6E0iKHXUZuzQFG+XEmF6UPeDrTOtt1aEt5kNzusHZv/wF499
	PgaGEZdLKAa8um8dw+3Jtpea6fKJD1bcezKx8Yf54mQRSS6DBLeYD1kR/J1iwSkGizJs1H
	AZemZ9qJPyWod1VQsMWHOljCGtBKMcb/iBd7txz4RJHnacvbqsnNf+JqQhdiHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762868854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlAUUcjIbub6gJLU5xG36VHrzybTTRxYuCaV1oAko9I=;
	b=Z7I7QV5EUPWSZNIC8FJf9cZ9ULDyp0pCd4383AF32Z7VxhsfaJuQ/VXP6TyxxuCnrjvym5
	xBKkmMVrb4UAOBAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/10] selftests: vDSO: Introduce vdso_types.h
Message-ID: <20251111143006-574bc2a5-fb0f-400e-babd-764ff7e17e3a@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
 <20251111-vdso-test-types-v1-2-03b31f88c659@linutronix.de>
 <3bdfd610-ec7a-4f3c-ba9f-ec48eecc0835@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bdfd610-ec7a-4f3c-ba9f-ec48eecc0835@app.fastmail.com>

On Tue, Nov 11, 2025 at 01:45:56PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 11, 2025, at 11:49, Thomas Weißschuh wrote:
> > +/*
> > + * UAPI headers from the libc may be older and not provide these.
> > + */
> > +#if KERNEL_VERSION(5, 5, 0) > LINUX_VERSION_CODE
> > +typedef __kernel_long_t		__kernel_old_time_t;
> > +
> > +struct __kernel_old_timespec {
> > +	__kernel_old_time_t	tv_sec;
> > +	long			tv_nsec;
> > +};
> > +#endif
> 
> Doesn't this also need to define __kernel_old_timeval, which you
> refer to below?

It was added in 4.17, so it is present in the 4.19.88 headers my musl
ships with. I can add it for completeness.

> > +typedef __kernel_time_t (*vdso_time_t)(__kernel_time_t *t);
> 
> This I think needs to be __kernel_old_time_t instead of __kernel_time_t.

Indeed, thanks. The only user assigns the return value to a 'long' and
doesn't use the pointer argument. So for now it doesn't matter.
I'll add a proper test for it.


Thomas

