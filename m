Return-Path: <linux-kselftest+bounces-45322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC92C4E9AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AF074E4930
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEA82F83A3;
	Tue, 11 Nov 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JcJl+CJh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9IGNsPs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05BC2F744C;
	Tue, 11 Nov 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872519; cv=none; b=ap3Gh8rOkh95uSUwwdOt9CZvdmLwlxkEfq3EvhbidmGSxqIo8JgDYq78VPCX0yMS12LFnl70e+0dcVb1bHvzSHXJk3Q5kduCQwtAoAUuxgSCOJVAnqyO/+x7G8J69hR/ONk69EXnA8cBOOZlkRcW4kVZARI1KjEWrbcDpIQijRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872519; c=relaxed/simple;
	bh=6hxKLi5KMK2mN8WcG3bKxQc1aQh3HnXBktDwGvJi+Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmX+u1JAbQGddSiJmzEFCK0tvUsOCPBfg8SqDWKoTvN2lkyOP+RZtIHLOdzqiZvK4BEr33Tqrv3a+MTtlgDDwqT3F5FEjyo6kU6JaUQV7DnmXgNoQqLahUzvDisoyzhbkIZ3v/Q0zce5ItwXq9++6W4zsF666wC4WhsOeA5eLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JcJl+CJh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9IGNsPs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 15:48:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762872516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCCKg93cGCcqIONXwxyjmi/exlXpoyeDoeIn0cJClEo=;
	b=JcJl+CJh7u64ICjD+x6LP2ssSqm+7t0KMa/ocbg3sHVZV9/AWVsLh0zKZwT0czj/UTLv6N
	pQ3z/3gYHyneXY1WbB+HkB+0BLiUIyqFlDdTFhtM+djjMdNSiwujI6bZzcDRQ5ds911M9j
	K5hDCtvem4OTWOFTCrBNkso3FmOYihlu5/mnKAZnl2o1IXLEJLsoyP8kj26e0ghvviEGNy
	Ls91dgOrwhdtZRg94DpvJx01Clo67b53+kv2MHFhZF29KzeuG6SSTYiMSPRuvX90ZzW9JM
	bXiEWpELy4HfPscHkUCZmKa4xJ85WoG2N5b6KSN0lBafu6YJEajtF1xg2sNfTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762872516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCCKg93cGCcqIONXwxyjmi/exlXpoyeDoeIn0cJClEo=;
	b=i9IGNsPssXxHs4SLlDwA1dH7YhqX4jCqupk33YFys2Q59mvaIjVx3E7yUNytGQ9D3T7I+x
	bgzRnoHdFXB+30CA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/10] selftests: vDSO: Introduce vdso_types.h
Message-ID: <20251111154707-688de414-990f-45cd-9184-a4e997ed0769@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
 <20251111-vdso-test-types-v1-2-03b31f88c659@linutronix.de>
 <3bdfd610-ec7a-4f3c-ba9f-ec48eecc0835@app.fastmail.com>
 <20251111143006-574bc2a5-fb0f-400e-babd-764ff7e17e3a@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251111143006-574bc2a5-fb0f-400e-babd-764ff7e17e3a@linutronix.de>

On Tue, Nov 11, 2025 at 02:47:34PM +0100, Thomas Weißschuh wrote:
> On Tue, Nov 11, 2025 at 01:45:56PM +0100, Arnd Bergmann wrote:
> > On Tue, Nov 11, 2025, at 11:49, Thomas Weißschuh wrote:
> > > +/*
> > > + * UAPI headers from the libc may be older and not provide these.
> > > + */
> > > +#if KERNEL_VERSION(5, 5, 0) > LINUX_VERSION_CODE
> > > +typedef __kernel_long_t		__kernel_old_time_t;
> > > +
> > > +struct __kernel_old_timespec {
> > > +	__kernel_old_time_t	tv_sec;
> > > +	long			tv_nsec;
> > > +};
> > > +#endif
> > 
> > Doesn't this also need to define __kernel_old_timeval, which you
> > refer to below?
> 
> It was added in 4.17, so it is present in the 4.19.88 headers my musl
> ships with. I can add it for completeness.

Given that __kernel_old_timeval has an architecture-specific override on SPARC,
I'd rather leave out a custom fallback until we really need one.

(...)


Thomas

