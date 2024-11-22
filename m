Return-Path: <linux-kselftest+bounces-22451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C119D604E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4102826B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30870834;
	Fri, 22 Nov 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xFGrWXUQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ISzpGTE9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BCE2AF12;
	Fri, 22 Nov 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285988; cv=none; b=irI6YEnvhlX9eZq2Kn0XVejqCM9kkkpJeA1pEf9yzkdpOwKBU2Db3JrdLn0GV/NZ9zlGjbd3qvv3FJGr2keTL9BTNMw0gvLuxl7AfO3NrPK2elJ6+oPSg72ksRdZ+3Wf7r33ZJBbM60ylrbadlZYe3BMHpoeSOHUz/C5CFS5tmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285988; c=relaxed/simple;
	bh=IoDKRnm6WI+kdxViKQuAgc5d+iwGCPkelkn80sMLbCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rYx7Jgm4mH4qbPaSCj2REDtmklZCjuUA2L+/jRMvLmlcMuTG7FpUA1egQJY1xd/J+i9esAQrxkn/+byOW/urYzqL49Q8c3I9GYaQIWCr7oDA/CIfyOzTRoemj3zYFD6LUJRW+swMz0KQU8vsoCbEjZc74FA08qygv8y7grOXYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xFGrWXUQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ISzpGTE9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732285984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoDKRnm6WI+kdxViKQuAgc5d+iwGCPkelkn80sMLbCM=;
	b=xFGrWXUQRtLSCrkA4+jB5McK+fc2ei9LNfjucr/AOHnXMasQ/RSfa2xg6ofp7EcRhjuIsE
	c8nh0S5rqX/cNoY1c8O4gWpuB/V3nKfKsO1XGPr+okq3CZvG8DMQFL3bq8938WApddknXj
	0msNhpcMIlpBD/XA2CQIj9HhFpC0zAqhKh0HmXFF82jF/cz6dFQWIw5p43apFJaOOeKp+S
	SnoV/OdHL7lxdrOtsviHlAeNqAgpn3/B3Kx19lEgSZE7g0qkErtYoNFFSysre1rQDypVwY
	bio1OjJj0CmXBMA1JnhP9NaHcesf5X/ktA4sVUd0oJFId74yaKaSxz1nuy29QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732285984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoDKRnm6WI+kdxViKQuAgc5d+iwGCPkelkn80sMLbCM=;
	b=ISzpGTE9sqvt2j4CvPbt1iG3MKj6GaQ4Y40WcVgaIn2YH75wmM1cMEtfURRTYoaKM+yKRc
	QxAmxADBLYp2FxBg==
To: David Gow <davidgow@google.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Brendan
 Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Yoann Congal <yoann.congal@smile.fr>, Alice
 Ryhl <aliceryhl@google.com>, Randy Dunlap <rdunlap@infradead.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, Jens Axboe <axboe@kernel.dk>, Mark
 Rutland <mark.rutland@arm.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH printk v1] printk: ringbuffer: Add KUnit test
In-Reply-To: <CABVgOSmn6EqcRZ+Rc047OJ5SQ9xdThuaUaPx40UgWgN+AjBfMA@mail.gmail.com>
References: <20241121145034.123367-1-john.ogness@linutronix.de>
 <CABVgOSmn6EqcRZ+Rc047OJ5SQ9xdThuaUaPx40UgWgN+AjBfMA@mail.gmail.com>
Date: Fri, 22 Nov 2024 15:39:03 +0106
Message-ID: <84v7wf49uo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi David,

On 2024-11-22, David Gow <davidgow@google.com> wrote:
> It's a little unusual for a KUnit test -- particularly since it is
> time-based and uses lots of threads. This isn't a problem, but it's
> definitely a good thing that it's marked as slow. Additionally, KUnit
> doesn't track any extra threads spawned, so it requires a bit more
> care.
>
> There are a couple of issues (e.g., it crashes on non-SMP systems, a
> potential race, etc) and some minor suggestions below. In short, it'd
> be a good idea to move some of the initialisation and checks into the
> main test function, rather than the helper threads.
>
> Equally, it looks like there are a bunch of variables shared between
> kthreads =E2=80=94 do these need to be checked with READ_ONCE()/WRITE_ONC=
E(),
> or made volatile, or something?

Agreed.

> In fact, I'm not sure why there's a separate start_test() and
> test_readerwriter() function -- or indeed, a separate kthread? Am I
> missing something, or could everything start_test() does be done from
> the main test function/kthread?

You are not missing anything. It is definitely awkward, mostly because
it was taken from parts of my own personal testing software. I will
implement all your suggestions. Thanks for the detailed review!

John

