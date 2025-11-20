Return-Path: <linux-kselftest+bounces-46097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBB9C73D88
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 12:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8BA6351988
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B3F31BCB8;
	Thu, 20 Nov 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EMVq3dyT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hK5pkoTN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0E1BC3F;
	Thu, 20 Nov 2025 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639971; cv=none; b=YQeZFhY6nmsQz2l/y4D7xxO7w2v5t8ngFK5pPwbks9eQAhlkFMs1GaJhhz2auh4+EHjtc0t59OZbd4NP2lJ6K1EW7Zwc+0zIoF1z4Bu54D3U50ELhZEmFUeOBtqMOVmW0fyFWDYG3GDa5xPAuGbwaKdLHPdJxsFnKbkCzMnNiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639971; c=relaxed/simple;
	bh=9QHTUFiZMrL09oOH888PHkjWLmdyCtDfMMuDJnUrOow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a01QpQg4qJbtzkEQgoaPVWpa0wM1+Y2q4Bq7kBpAI7fRMDWuepiuJNLQfhYCXiqTQSl+qH09g989deVOm7T6+TZfkg5/JiR+HZmoZoDa7oQRpQ+jY85j6Luoo7bCNn5MMGkhYRcYecbg91KHdW06t9RX7d7exsFTV+uIUrYLvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EMVq3dyT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hK5pkoTN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763639968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qH7FAt22d1/ZCZq95u/fjMr/5/vt3UjmlteWHNRbshc=;
	b=EMVq3dyTZCehuON+wH3y5vCAC+87S12Zrio6N3cyTnONjzlnNxzIrp/J1AdYeSQAMHqQ3J
	jt9uAsK+kruA4vax/QWTrPss5KwW4zDsFg5RFICLXipCptmdqwn5aPoyDzVWM9jX0wY0p+
	O2sdFPqFknGyueZlhyg97E3TlRNppCAZtNe9kVweHzjl/NdiNVKEnCADIK5oQU0w28G4nR
	rwU/nsOweHEuT5yNTOJYYwIsbT8h6GK8nZ49dGW8BNg8QOOOM3KlSOVn+E7z8CQdc+Qiud
	F9y7wjHq5cxoE8p8DNdyO51Q3astExnfJHmIOo1mkeF6zt8liFOG4Bgmkt8N0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763639968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qH7FAt22d1/ZCZq95u/fjMr/5/vt3UjmlteWHNRbshc=;
	b=hK5pkoTNJadZONfLCbEB19GQ6bjFWAFUmxDdCGo7QeK7JX1O8EuAwvp7APoY6aBv+LrDz5
	cHY5Ktm4URvqOsDw==
To: Wake Liu <wakel@google.com>, Ingo Molnar <mingo@redhat.com>, Shuah Khan
 <shuah@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?An?=
 =?utf-8?Q?dr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, Wake Liu <wakel@google.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest: futex: Fix memset with zero size warning
In-Reply-To: <20251119030052.315502-1-wakel@google.com>
References: <20251119030052.315502-1-wakel@google.com>
Date: Thu, 20 Nov 2025 12:59:27 +0100
Message-ID: <871plslxsw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 19 2025 at 11:00, Wake Liu wrote:
> The `FIXTURE(args)` macro defines an empty `struct _test_data_args`,
> leading to `sizeof(struct _test_data_args)` evaluating to 0. This
> caused a build error due to a compiler warning on a `memset` call
> with a zero size argument.

Where is that memset? The only possibly related one I can find in the
kselftest harness is:

        if (sizeof(foo) > 0)
           memset(foo, 0, sizeof(foo));

If your compiler complains about that, then you need to fix your
compiler and not perfectly correct code.

You again fail to provide enough information to understand what you are
trying to "fix" including the compiler version and related built
options.

Thanks,

        tglx

