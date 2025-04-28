Return-Path: <linux-kselftest+bounces-31762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74206A9EE19
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921763A83D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9626A25E81D;
	Mon, 28 Apr 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+Xef+fk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RoAGxEqF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51A859B71;
	Mon, 28 Apr 2025 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745836682; cv=none; b=EsL6qd+7wDWRtAyxXMqTxEF7p3ekwwvMUAGAGrWugzCpIgBl7P5j7yDcDAbms3F9fqPOYu406rpTh6QCeoq5MTQ4kzO9kL+SdHpq7c3Rig6AobSFQzk/9ICt8yfZ+6zHErQH/RdJ34IIY9azkPR06rrdgkW6hNzyk2xiApdU3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745836682; c=relaxed/simple;
	bh=WoZL5HEhMwBHyoarRPvzuD3TwlCDLSI3iqbnOfyvxCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCZOkBPWqJwKEkkDCIpgp5/qQK78YtAcpcJc6XVvzCf8bRkMWbNL4s4mNByRhGgzDoUMlMAd6m3arYXEMo8GyBjLu2Wxd+inHcs1GWJ+p9OS1kjthvDviW9lnM5PKTZGm1q/fq4SxG9cnAm1UuRjcfLNBVZptU+1Vpy3DuDD0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+Xef+fk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RoAGxEqF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Apr 2025 12:37:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745836678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oui8+LNRwcXO1Zn4z4VtdqdM4FZxrSBQ2h3snYKGyMg=;
	b=D+Xef+fktKbV94I67WR30FMjeSHwGPo7oWQG2cITzaJrFmlS/FljEr1RN+0rfrfhK3Xx67
	LOk3jqPXdvyVcQ5ScNzC8WwfS1EEHwEShjgIfFuSOaZGwHaBNBQvxMPOwDGVPDhEirZ8uN
	Ju4RQ2ijRdKH8sKQEdiqbUhCZgJqTJPR6SQesmr8GI813fGTk2557PiLWFC83wnUSkCxZR
	/FCqDTPC8Qv0HBv2ifMON9ulYe6hGAAnOlEnhe5exjS2GG9kSlQxttc/G4vgGqer6+cqsV
	REOedYMHHzolIh7F6GUIX/6uVO/9SMen4u8NZ0Ivyh7r88OVyhdUmMQysPMOMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745836678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oui8+LNRwcXO1Zn4z4VtdqdM4FZxrSBQ2h3snYKGyMg=;
	b=RoAGxEqFDeHcKPMOEiquHd51z6QTPJlYNbUVVca6Hszt34bHnn0RKsDfIPyIC33zK2QkW2
	uY7QoWjpkypOqZBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/15] tools/nolibc: add getrandom()
Message-ID: <20250428123554-5071c41c-5189-4087-80ca-488948365010@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
 <20250423-nolibc-misc-v1-5-a925bf40297b@linutronix.de>
 <20250426103158.GB17549@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250426103158.GB17549@1wt.eu>

On Sat, Apr 26, 2025 at 12:31:58PM +0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Wed, Apr 23, 2025 at 05:01:35PM +0200, Thomas Weiﬂschuh wrote:
> > --- /dev/null
> > +++ b/tools/include/nolibc/sys/random.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > +/*
> > + * random definitions for NOLIBC
> > + * Copyright (C) 2025 Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > + */
> > +
> 
> Note: don't forget to add your nolibc include here from the other series.

Ack. This series was sent before I got the idea about moving "#include nolibc.h".
I'll fix it up for v2.

> > +#ifndef _NOLIBC_SYS_RANDOM_H
> > +#define _NOLIBC_SYS_RANDOM_H
> > +
> > +#include "../arch.h"
> > +#include "../sys.h"
> (...)
> 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index abe0ae794208762f6d91ad81e902fbf77253a1c1..95d08e9ccf5b3be924548100e9621cd47f39e8c2 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> (...)
> > +int test_getrandom(void)
> > +{
> > +	uint64_t rng = 0;
> > +	ssize_t ret;
> > +
> > +	ret = getrandom(&rng, sizeof(rng), 0);
> > +	if (ret != sizeof(rng))
> > +		return ret;
> > +
> > +	if (!rng) {
> > +		errno = EINVAL;
> > +		return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> Just a thought about this one: in a not-so-distant past, getrandom()
> could hang forever when lacking entropy (classical problem when booting
> a headless machine having no RNG), and since a recent kernel it turned
> to "only" multiple seconds. I'm not seeing any easy solution to this,
> but we need to keep an eye on this one, and in case of bad reports,
> maybe have this test as an opt-in or something like this. Anyway the
> best way to know is to have it right now and wait for reports to
> arrive.

What about using GRND_NONBLOCK and mark the test as skipped if no entropy is
available?

