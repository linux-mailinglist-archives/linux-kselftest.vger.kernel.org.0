Return-Path: <linux-kselftest+bounces-40047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD9BB3806F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 12:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C31686646
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E7634DCC3;
	Wed, 27 Aug 2025 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7OuoMu9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nvLFa0fY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1229B20A;
	Wed, 27 Aug 2025 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292339; cv=none; b=XIDDWOvD+3F0wlYvbBiTW79g71B1hpE8wxZSC07lQTS3AoGmfUix0pAtd0Z81nIshrOoMhUMALSn2HeU3L76ltWLQL7FECZMOS0KznvfE/eunwDhiLiKmXhiM3DszZIfDVxS7Nm1/i4o2LgyJIT18q+fuHXQTQFrsOKbtZSkzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292339; c=relaxed/simple;
	bh=MXUkqGGH4CcgOZ4nksRcX095cWley3qknoAkOqvD38g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEpODFeoUGoWDRb2JDy8q+ElZk7GaBj+PEJdYehWu+3SzvMzPMX3gOcHwHgdndOWueW3Mt11LnpCLBRFK2krXx1LHlhygPPoWe3PXdpzFW0Fx2gW7bb2sk//IG38AOi+qJxctAiRMzy15ivmg49ZwkRID0nHgM5jxDmcKlU/l0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7OuoMu9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nvLFa0fY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 12:58:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756292336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERJZUCYk0fH7r0vcq84dLsqRugJCVEYDMnDkohzM+yQ=;
	b=m7OuoMu9Og8qqa9WzU+GK7Jc9tCrSizORkpDIGoauQzvUGwhUJdrnyP7MqKJv0zNC9AE5+
	nOlvlTUGvZFZ+LNJugnw9cMYnRZ6aLOWmLstnNlYjvTOL8vSmpgd/RBvUPNFz/K4XE7YUN
	53R0aL2iVv6FPLJzED5qPWIdIy0pJNds1kVKbdaNVrNsTWZCUglu8Ud3rIPAjwGbBeIeBx
	uO1nKGT0XwhovOj2wBZ03dsbNqhSY/F6xIBC6DEyiyQpUjasPAujCEcXr1UR3BgGCi6i+l
	/BULJOMD4b4ppHfynTC949nfWOgzo42yxWB/MAWrmUFmbEHCbUye7Md6sDEDmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756292336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERJZUCYk0fH7r0vcq84dLsqRugJCVEYDMnDkohzM+yQ=;
	b=nvLFa0fYwrj5KdT4We1U0fQkRUMwPEJoNjnOO/wJFnt4nDMF5vaCBzGgkDlP62TDEkXlNr
	RHr9ds9jl0llnpAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Cynthia Huang <cynthia@andestech.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/futex: fix futex_wait() for 32bit ARM
Message-ID: <20250827105854.DwmcsKlC@linutronix.de>
References: <cover.1756217858.git.dan.carpenter@linaro.org>
 <ebd4a415169f9a3153bbd3c1fe6244511c9d1cb3.1756217858.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebd4a415169f9a3153bbd3c1fe6244511c9d1cb3.1756217858.git.dan.carpenter@linaro.org>

On 2025-08-26 17:25:11 [+0300], Dan Carpenter wrote:
> On 32bit ARM systems gcc-12 will use 32bit timestamps while gcc-13 and
> later will use 64bit timestamps.  The problem is that SYS_futex will
> continue pointing at the 32bit system call.  This makes the futex_wait
> test fail like this:
> 
> waiter failed errno 110
> not ok 1 futex_wake private returned: 0 Success
> waiter failed errno 110
> not ok 2 futex_wake shared (page anon) returned: 0 Success
> waiter failed errno 110
> not ok 3 futex_wake shared (file backed) returned: 0 Success
> 
> Instead of compiling differently depending on the gcc version, use the
> -D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 options to ensure that we are
> building with 64bit timestamps.  Then use ifdefs to make SYS_futex point
> to the 64bit system call.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>

It appears glibc uses the 64bit syscall by default. So that is fine.

Sebastian

