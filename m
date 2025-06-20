Return-Path: <linux-kselftest+bounces-35404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A706AE1399
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 08:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C967A55F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 06:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACCB20ADEE;
	Fri, 20 Jun 2025 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nEaBepoO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VHeEsOQK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67E38DD8
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750399674; cv=none; b=Sqq5EiuFTc+8W+SbFiXZ/0AYmNGhvZvaQ+wzmLKNqieQKDp1MAavjQ1YGhmU0qIWOSfV4E6IM/JfTu/ROIkU7s2Ch1o0haakReUEPLEVAQU4RfvE8xHuBGJPb6ZHmJnLCSaYsOtoEwXbS6nUBNHC0k1WM+OBHZ3ASCl5sIIEULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750399674; c=relaxed/simple;
	bh=diUK3r86nP4JLNB9t3tDiR2u1lneykGuZ21ATzq53Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlQF2DaNk3Dv44QfUM8rbzQglb1ZPxAqcPKzFpuxkSAGSiMSM5iBL4QD+3aXCJ9U6ZKKUzzlVmPFvx+I2XN8mVJY/c1Ukz90JiKp6d/6AzJTs656xaXzJ5BZrogRlqIse8hNcitwiVkn6vJ7y1KywnXTaN5SvSwnNVXcZ2OhgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nEaBepoO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VHeEsOQK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 08:07:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750399670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4PhLzyLXE0MbJzV5b8LQKwjDsSFxRlBSuTvQXPsK60=;
	b=nEaBepoO0kgKCFDtF6nnAST9ZxuIgfLX74hici8CrSsAUxUo9zACoBjgSYpkheh67Z3dnv
	i8G086pW9VzUCLGaU7Ss7kiVS5sy/xny+1qc6qOKoDXKJBZdfLOH4uQBdL1Hp63hsM9Clg
	0GP7pWLSKnIow9ZB/SNGDRHeU6ofng+EbcScKUadnbWKOj3P7TVuCBpLputLXVFXx6ShB2
	uTjbHYXzspwfmYbATfuqsyfX93ABKzxBXaDFzMdi8QzR0BUbawtk3VHohg9fSj+3ezWKi7
	5ti4KEv5sTmKYXMAGAy5NXIKqDNJJd8XEq4oBs792wtAyHOT8q6+9Sq6QRpKpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750399670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4PhLzyLXE0MbJzV5b8LQKwjDsSFxRlBSuTvQXPsK60=;
	b=VHeEsOQKMdzw0VI+rGu8O2Fmg+fKUJESjPGQcwsvONj5ZSPlKcO2z4/xj3bBAyremugVWC
	sIe8gDUtXygK4eCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, usama.anjum@collabora.com
Subject: Re: [Patch v2 2/2] selftests: harness: Add kselftest harness
 selftest with variant
Message-ID: <20250620080701-f81dc6cb-a1ca-4bef-9d96-1d692a320a50@linutronix.de>
References: <20250620032815.14543-1-richard.weiyang@gmail.com>
 <20250620032815.14543-3-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620032815.14543-3-richard.weiyang@gmail.com>

On Fri, Jun 20, 2025 at 03:28:15AM +0000, Wei Yang wrote:
> Each fixture could support variant. Add fixture with variant to verify
> the behavior, so we can validate for further change.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
> v2:
>   * remove testpid
>   * print value in teardown and test itself
> ---
>  .../kselftest_harness/harness-selftest.c      | 30 +++++++++++++++++++
>  .../harness-selftest.expected                 | 20 ++++++++++---
>  2 files changed, 46 insertions(+), 4 deletions(-)

<snip>

