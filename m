Return-Path: <linux-kselftest+bounces-16692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9996499B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 17:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4171F21944
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FAA1B14F6;
	Thu, 29 Aug 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="db//rrd4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ILsMrjwB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042911922FE;
	Thu, 29 Aug 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944501; cv=none; b=GuGYUc6FwPFKraIio2Q9Vl6hzRjIS0GgFADGJAv6jOeih7VWTWns4dQw6uApb0xb3nqtAIsGys/XAWRsWFWeepKPyc4j75cJzajnnwuncgTMB8e57VFPCEyltAEdvQiPBwpIuE7MiBfAOCB9Dv84A380mrvTIezofvf1qRGSqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944501; c=relaxed/simple;
	bh=DbPsYPIFi4EX/41vLSVolbGBRsZVjC1CslxXvbF0R34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gZp1EURmG8r/sBxiRJp6GZ4jFlVQpz60/yKIo8PMWx0tCepxDSH5Rb4qDQ7QsX73Q/EGo5uzki4h6YEihSPKzP7fEz3z3hzM1+aEo+IlcKHJ3WVJcjtmy33jYG6f7ZFtGibvIwLzc44/mS+Ki2x54wkNZOOtdzmah4EUk79sm1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=db//rrd4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ILsMrjwB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724944498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9IOPiqanlrkXTRwrDXC6/X7qlu2TRkmsqHT5x2PGcDo=;
	b=db//rrd4HOshWY9wgQ+WvFGixz5iHRVK6xDW08vLn667bGKgg8WWHM1RKZd2o6fkiZk1od
	CkNdlKUuWAaeWhWXfg44kpDRlh5G/WYR7H0uV+flGiljtuFzj+e52un82sMAiOtH2icc2j
	uytv94AuT70ivWReVunLfZv9gaowb8HhD/ltup8ISA2oU3vexyvEuSL3jWuabUyjV1SqRT
	SBcJkRPC/63wmuwC77YODLctiPQuwURqAAcvLTVwQ2hQTGvfxaOksU/GdUR6x+wBk+9Slz
	i6WuwzB++5jyEOn7O+0cu69J67yaz+F88qzV7zbR0JsC7TZAapUvtMbhUqGtPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724944498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9IOPiqanlrkXTRwrDXC6/X7qlu2TRkmsqHT5x2PGcDo=;
	b=ILsMrjwB3YT7txmAERSRyUO34jtfNmsXbwG9zSpP9yK3t4lCX1zbwRPxye1ZRX8F/cca7J
	Bg1ul3smc9BBl/Ag==
To: Gianfranco Trad <gianf.trad@gmail.com>, jstultz@google.com,
 sboyd@kernel.org, anna-maria@linutronix.de, frederic@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Gianfranco Trad <gianf.trad@gmail.com>
Subject: Re: [PATCH] Improve timer_create failure message
In-Reply-To: <20240829142515.29773-1-gianf.trad@gmail.com>
References: <20240829142515.29773-1-gianf.trad@gmail.com>
Date: Thu, 29 Aug 2024 17:14:58 +0200
Message-ID: <877cbz9x8t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 29 2024 at 16:25, Gianfranco Trad wrote:

Please add a proper subsystem prefix to the subject.                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                               git log --oneline $FILE                                                                                                                                                                                                                                                                                                      
gives you a decent hint       

Thanks,

       tglx

