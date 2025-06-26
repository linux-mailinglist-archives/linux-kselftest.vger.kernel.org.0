Return-Path: <linux-kselftest+bounces-35939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8785DAEA91C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 23:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0F61C40CC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7E8260584;
	Thu, 26 Jun 2025 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AAeP/cuK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vjAoGFqf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4693725FA2A;
	Thu, 26 Jun 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975002; cv=none; b=thRoG7co5v3+R9uImH8wv/8dekrAr8lP9jnQvXshZL6SLmmkCQnF2VMchF9NXUKqARSC50UX0PxBi4mqu/3eRgw/HzfUmF4JdwumEmbnM3+xgmb+IaH2uktZ1LvP60Mq9Vg+E+zJ6vnoylIaqX9wRr0AjE4wPoE5YzyuBE7+66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975002; c=relaxed/simple;
	bh=w4LB5IVBoNq8vucSbKbHBP/jocVrfObuHVEudF1BwRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ftuNpgSk/PArZJqN1ScyoFf9mfYdFO6re3wC7fpLWbx25JUKBB1D9w4H5DajKhdmethQ7MNEiWGVU8Wy7slfbGgD0XLtGyNfLf4xqoNBwWrQGxmC6aMDUcFVKBOg4pOjlgqYNrduQoEjzH++/e+I/m2dhx0s5O7lC3qsVARWEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AAeP/cuK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vjAoGFqf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750974999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RtgbyxoI+EsUygN4LGfgqt+wkR/WkYOJEHURHPuEX8E=;
	b=AAeP/cuKKrxYrD8EJYdwaWAs5WFF4XtUXRfsrRthkMul3Kd7I+aV6Kqm7IwXZoId4Z8eIR
	DNiS3CaEnrTcw/yKVQP6Uf8+tmF8EvmjSVek4ltsTUZygF/0soD6X05xdbOsSrekXebiJt
	LvOtVlBSQ4uRYOucxDVI1Orf4SEdkpQhbtyKVkD1GUO7p5UzglVNibygu3JClLddLvL0jt
	ByvtznSSPu8sot09sLqp2kPLDVQjPlJMNR+U6aM0nKKL6q8iJFWe0r7qqM/JwDMkNjIRek
	3SMgyffOdWcPwnFurTmrsGnuqiwYNlXOQvlUXdhCt/pYGRZRjcMT4mqOXgJ5VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750974999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RtgbyxoI+EsUygN4LGfgqt+wkR/WkYOJEHURHPuEX8E=;
	b=vjAoGFqfFnb4siZ0WHDWTTZ/lvvTKWXKQeMdmSS19cggaorpsaFN2Qkma4OwRa0QYud4cL
	YpUjBQL8BmAeREAA==
To: Terry Tritton <terry.tritton@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Wei Gao
 <wegao@suse.com>
Cc: ttritton@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Terry Tritton <terry.tritton@linaro.org>
Subject: Re: [PATCH] selftests/futex: Convert 32bit timespec struct to 64bit
 version for 32bit compatibility mode
In-Reply-To: <20250609131055.84547-1-terry.tritton@linaro.org>
References: <20250609131055.84547-1-terry.tritton@linaro.org>
Date: Thu, 26 Jun 2025 23:56:38 +0200
Message-ID: <87jz4yp3op.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 09 2025 at 14:10, Terry Tritton wrote:

> Futex_waitv can not accept old_timespec32 struct, so userspace should
> convert it from 32bit to 64bit before syscall in 32bit compatible mode.
>
> This fix is based off [1] 
>
> Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]
>
> Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
> Signed-off-by: Wei Gao <wegao@suse.com>

This Signed-off-by chain is broken. See

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

and the following chapters.

Thanks,

        tglx

