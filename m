Return-Path: <linux-kselftest+bounces-33379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F42ABD251
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81A34A47AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F959266B4D;
	Tue, 20 May 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FrbMJrWV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lkpzu8bg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201642609DF;
	Tue, 20 May 2025 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731073; cv=none; b=tV9xOrqcYv7LCuekh21WohOBKZ756vHSeRavULRKDBHt6295ChA73wj56e78YDAzfBOFLZWRwvuttHXrTbgnZS8n5BeEcyhGVpQJ6tXGZqRcQoBEmm4u5b9NTdpx8J3GO+x8Bg5LsOeoUu4iceLTQZ6xWOz6tZfsCQ9zU2CQcj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731073; c=relaxed/simple;
	bh=j7k9kuOSIr4GMcGXb1NEvatg55OF6bXsyRSdV1THpdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7654L12IiW1SCNr+NPcIriNXk+1zGADefXpo2urQKQv03M3kfPtg362HiiRNANJVY1pR4OGwCpULUbwL9KBIuDFuZlfHTlsOeRJ3ez7qhpwdXOk0D1rpn6mDgDcP5lPQPgTx6CsjJ0Ho6uMUaU3xfGtRD+2XvN51RNPfOMabak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FrbMJrWV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lkpzu8bg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 May 2025 10:51:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747731068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAXUtQcpZUdkmC1TyAO0R3zmLqg2lXnELKr3jI8UqTo=;
	b=FrbMJrWVtwaZ4FM8NVOo4EQFlSWaTo6S34mh5xeiqcv3gtjfXunzlDksn74PR99PW81JQp
	ZBUbOLDBTEdX1JUIQeWsqecpGJ4IdjM+N9j5QBMYAvWYvc8tyNJlAOhlMCFpAn/KZe1JLp
	DFQEORGKaDcPWlKn5XN8AsKMRETQMNTzDhAXbQ/RLLlNLTm7OaBM8Rfv7tsNNvXhdz9lqs
	Pk2Q33XPVJpwbIHTFyeh6kdFRjZ1OLVPYmFUpWd3XzHSNhDEc5nIfeHytt1iiSj/m32b93
	vbK8CxEg0UC1kDdFBggENZb67rGC3WQe+BROcl6+fRNOw6dYJtOoZANQ+6ZSEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747731068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAXUtQcpZUdkmC1TyAO0R3zmLqg2lXnELKr3jI8UqTo=;
	b=lkpzu8bgx5D+G8io7SmMkkgzirR81Q8VcCw9KHkpokD7vixoQTI4qRzDNenN+8wUI6Vrby
	dgrOXb2Pwia7hUAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] selftests/futex: Fix spelling mistake
 "unitiliazed" -> "uninitialized"
Message-ID: <20250520085106.-gdQ0Hnd@linutronix.de>
References: <20250520080657.30726-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520080657.30726-1-colin.i.king@gmail.com>

On 2025-05-20 09:06:57 [+0100], Colin Ian King wrote:
> There is a spelling mistake in a fail error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

