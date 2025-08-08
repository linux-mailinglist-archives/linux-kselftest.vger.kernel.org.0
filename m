Return-Path: <linux-kselftest+bounces-38551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466A4B1E707
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 13:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F29583F03
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 11:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3651D5CDE;
	Fri,  8 Aug 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJSB7VOg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a7DINRg4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4382236F4;
	Fri,  8 Aug 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651823; cv=none; b=oOV/lzTbdLExCGLGwWJ8eFq4CLcVgfyKBSCvGP0WjbiisUVMS1e+S0odXgvTB6CsvpOnhbdbwHdXSAXBHeEGjBUNy/uaRWVB8fIfzX/5Qqs0klnOlyyO3Vo0NJVW9BYV8zaoVfNb1wFEsUpgi3pC5uFFrYiOqWB+BnDTvGReuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651823; c=relaxed/simple;
	bh=VTOwBMbL51oC50wYleO8Huxw+V8+AQlx/lTeCPCUB5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfydY83ulVDcrFn6ThPXC7QAD+BuMIr4mXkn8TLXerCf+dOT1cDTKerCFw8ThonkFXWHP4nJXSVQCikXkI0pJwXdZXn+RjhZHilB8vR824xQHfqA/A8S4CeoOHzmm8hLTNHgEYoJKcFEZdNRvo461TrsuU0GqHf+0OfthBvFPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJSB7VOg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a7DINRg4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Aug 2025 13:16:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754651819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGOtuzrGbUvU8ompcVQZf5xUA2g72tUbR2cNWX9Rr8M=;
	b=rJSB7VOg9EmnyoodH0FO+IdQCDzMfN38T/d4ocghqi8imsqF68qCVE72a4DsQmgsSc/HeD
	NYxJ/FeQvg+sR7F7XUrrU8Yl/NePgGZ4W40HNmaE0yXBNOVQTXpqnSdk8MmYAs0bmQGTyw
	vtFLSsSZG6WwXmYiQ7BRz2usfElK9437y2/SKJdVo+zNgW8Uvr+RfC8k0OTmk88iKr+qFz
	bsMJ4u/LoUdJIWcZ0F6VEYkwxNQUZ/alL+51QYjGNedqpG2edbScTGCOHYerXYSSpj4NSM
	6gfiEydoTG78Zs3rzLrVKD/No9wAnern5sctSsnQShuWa3X7FT4lchQte3OE4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754651819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGOtuzrGbUvU8ompcVQZf5xUA2g72tUbR2cNWX9Rr8M=;
	b=a7DINRg4j1paJ9PR9f9ahNAmwCZQB0xQlPhsn1j9t/o0xVgU6x3fJAmqa0b9ULTqK/GJNW
	bLKJ2PkRTdMug2Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: selftests/futex: issue with -g option help text
Message-ID: <20250808111658.QePsK6gQ@linutronix.de>
References: <2e01e85c-a833-4725-8a62-156c737422eb@gmail.com>
 <20250808105435.PYwBvZ-6@linutronix.de>
 <358d6fae-80be-469c-a8d9-c4e786781a65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <358d6fae-80be-469c-a8d9-c4e786781a65@gmail.com>

On 2025-08-08 12:01:49 [+0100], Colin King (gmail) wrote:
> Hi,
Hi,

> > 
> >     Test global hash instead instead private hash
> 
> Surely:
> 	Test global hash instead of private hash

Thanks.
There must be an issue with my keyboard.

> > 
> > ?
> > 
> > > Colin

Sebastian

