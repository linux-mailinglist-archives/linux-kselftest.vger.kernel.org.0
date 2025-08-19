Return-Path: <linux-kselftest+bounces-39294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E354B2BB34
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB775E06F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6430FF3F;
	Tue, 19 Aug 2025 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4w2IEShS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IgFSSr+C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5503451DB;
	Tue, 19 Aug 2025 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590194; cv=none; b=qCk+0JTTMHoIkzJisIhmYLdk0k5drLt9unsASJkUBkXLAL8YtrvArFlkMN0UZvxrtSx+iBTd6swiI0vgX6A8ee4yorfE5ID9Is9Z8GZS/TSH9kulOLREGfvRKKzT+rdrK1iJ10PUsyqAnts/a3grdYS7EPB49ulOkD6lZdYLeUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590194; c=relaxed/simple;
	bh=WShfxPZxOA/BSuc5s52oGJwr+EVQtf7UjaPODOk95K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj9ZK2xcRiE2KDASkPGtsj+ZVlPaNY51Bv3JsC2HeYK3SDMcTRINaMCxmaH522C/I8UuIyHtVruUVg0Dj9nZtfqHc8+1M0R+NI90W+jo5fdkvxcSbJ0ikXhfckjbstiGWWEhXyXvogQAO3vRtX+Yni5maInMU2uWN+Yz0NAiRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4w2IEShS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IgFSSr+C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 09:56:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755590191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8jGBaJVDKq9+XJjCbLG1nqfHT7wgCMOXZgXbDJCxEk=;
	b=4w2IEShS59g143qYeTV7iyK1H6svLCqqEnNADu5p6lbqDGLY9SRNHxyYeNanCUOEp5ruI9
	iaMjrOEVLZuMbgazOl2qnfk0mOudtL3+0PWu2Qiku3i4kA4GysWwD66I/1Nc5nPPbs4yKU
	8qrarx0R2H95Ha1K+g9leXHgShVcwCSECWHSgF97VxspZ+b1W/o3Ux88+x6G5pSDt+Z1bl
	EnRFhWtJqqkAqcSdgLwRmJQSCASGlSBI+WkdK20x6nYUHhNYgQ5S5Qj71O/K1JPOgibNqi
	MeYsLGABmvCMwA5SjhKvTOQccOqllYqBUuk0E2CYDFcKeFLyC3rvlSG8K81vlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755590191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8jGBaJVDKq9+XJjCbLG1nqfHT7wgCMOXZgXbDJCxEk=;
	b=IgFSSr+CO/ygfRHmFPANbHUA5H4kALARLgXiIeTsRSHdaJYzHFKGSoQkz02ejCsUKKxEw7
	O16VPCXUm0+Y6uBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: hariconscious@gmail.com
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/futex : fixed typo errors
Message-ID: <20250819075629.AqQPRVR3@linutronix.de>
References: <20250815155147.917-1-hariconscious@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815155147.917-1-hariconscious@gmail.com>

On 2025-08-15 21:21:47 [+0530], hariconscious@gmail.com wrote:
> From: HariKrishna <hariconscious@gmail.com>
> 
> fixed typo errors in kselftest of futex module
> 
> Signed-off-by: HariKrishna <hariconscious@gmail.com>

Addressed by https://lore.kernel.org/all/20250815093942.8595-1-krishnagopi487@gmail.com/

Sebastian

