Return-Path: <linux-kselftest+bounces-36217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DABFAF04F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 22:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EF0484FE9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 20:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A31C2E3AF2;
	Tue,  1 Jul 2025 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FD8j6nH7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B47OIQT3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BC29550F;
	Tue,  1 Jul 2025 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402073; cv=none; b=NJucAOmttOMl8PlH2u9iwmy5FrX3mEYz3A34YpqRR7yErReca8AbspuU4Hqk+gHmrCRCST4X9HhgwHUR43w2xN8h5c2KeIHaHAj9Qptbp2zMwfE40yqmBY6mm5m1bazKIfvLbM5QPlJFfwWUTv/9CwBPCMxP5RV9XOxTMsDkZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402073; c=relaxed/simple;
	bh=XB3O/2+mTdiweRtrIksCZupGiwYiomIq/E0DOY5On8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GvniLd2REcjV94vxCL1sBGwYc0kpPdtUEE8K/6LKAJi+1H4soVGsIDrJMUGrZlw9hwBe5b+YotgteESRn6ctw9R2OvrTVQ6kmzxd2GFPywsG9irfLkwydfM+e8yZWZE9LMLu3N/d0CWDydhYEeCeGhZ7qvWeWxG97DVOfb83lyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FD8j6nH7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B47OIQT3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751402069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XB3O/2+mTdiweRtrIksCZupGiwYiomIq/E0DOY5On8M=;
	b=FD8j6nH7eJFub0RWs30lnYscQleG9xPZqi8IkN+BoYltCzfj3KyHTzRMGPhoVj+qJZ244L
	OpUfglb60MkBcL7NFWILd3sdeA1ZsNGPtb2tkrektd1wckG7jNVjNKqI5mRwW7/TVstZvA
	0jT/8lMX3FLyqAnLEMSWl1l4zNhLIDNyQz6mhYN1zMIfvrHO+dGMjTV5Il4uQ7ytL26/pN
	crauwKTuxDGpOQ/DjC54TQUoL3f5pVIRcAwZFYbEkSMBEuHCXDKQ97wc/STDMsoK4JM3tj
	J/vqj9Wjxx8cboo9iOwNNdTWlDLI4XxlKnM7CaQY3F66G5fi3aG7U7PKwUEWXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751402069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XB3O/2+mTdiweRtrIksCZupGiwYiomIq/E0DOY5On8M=;
	b=B47OIQT3m0Pz2PEw/LqhuVcGQpth+G9gvEJxgLM9oZ1ibmHQr+RpsSHLWFAQ/tZxwvPs9C
	rn3NL7vO01sPO6Bw==
To: Terry Tritton <terry.tritton@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: ttritton@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Terry Tritton <terry.tritton@linaro.org>,
 Wei Gao <wegao@suse.com>
Subject: Re: [PATCH v2] selftests/futex: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
In-Reply-To: <20250701142313.9880-1-terry.tritton@linaro.org>
References: <20250701142313.9880-1-terry.tritton@linaro.org>
Date: Tue, 01 Jul 2025 22:34:28 +0200
Message-ID: <87ikkblkff.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 01 2025 at 15:23, Terry Tritton wrote:
> Futex_waitv can not accept old_timespec32 struct, so userspace should
> convert it from 32bit to 64bit before syscall in 32bit compatible mode.
>
> This fix is based off [1]
>
> Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Terry Tritton <terry.tritton@linaro.org>

This is still wrong.

If it is based on someone else work, then you need to attribute it
Originally-by and omit the Signed-off-by of the original author.

If you just picked it up and adopted it to a later kernel version then
you need to add 'From: Original Author' and preserve his Signed-off-by.

If you collaborated with him, then you want to use Co-developed-by.

All of this is documented in Documentation/process/


