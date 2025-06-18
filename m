Return-Path: <linux-kselftest+bounces-35249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591DAADE328
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 07:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB3F7A1D93
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 05:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874AA19F10A;
	Wed, 18 Jun 2025 05:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+nsG4SZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C93yPb7s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D4A93D
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 05:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225646; cv=none; b=qLp2V5NoWb/P6bS2Hi/CEgCuO85OUUFvrsd22BfUcruuvQytEcIHAEAS2KKiyl4odM699VHE/OyBgsnlDAcsy4OoEFC8Q9gAcsm/PR7jypM7kmm53nuiHx1BA93On6Bjc1zL+/BedXihgotWu5+oLHoVX58FG7bk0TC/wobdiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225646; c=relaxed/simple;
	bh=Mnz8b57+3LRLybY4iw/dqb03f/tWTfG5iDYUaR8gJzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba8gnkPHvFjMbxGlIudYhWXkfCW/NHdn89iEe2USgQi+P+7n9YU8L/qgvbkQvPA2/vjfYaTDfG6Uoxp8yTFtxy0uB1s6qWxtpqzcNcrfinuX3IyYBxaooXkZWNli4Z8NA7oeHqsNQcEjgfy2t4SUFngDo1qhMpnE13cNL0SZ7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+nsG4SZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C93yPb7s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Jun 2025 07:47:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750225642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBHNZ3+fvy4PjuHZKXNMNGa6vvXFQq4b/xIOSxEPzTM=;
	b=0+nsG4SZq2a1PYWQYHIhv7gN3jwC1B2FPSGBorcEW66AHBlfa2mMnRG3G3AjtER0G9q2pX
	Kp78MbBXUWXzKQ6S6geDZLwOx4wBx+zATxbAqSeLo+RsmruDQKGQutQ6ZOpwrYhRk160HP
	qk07UkOVsbrquTxY1bivFJl7ED7TWC/vk03H93mVNx5BunhgvsMVpGkmIP0Gf09qOthCkm
	V+CvDblgFJAiOMNI3c2CZHQ4VrRtH0maVBLmk255Qigl1v5XTiR7PU9IS324Jkxbd2PHQA
	5QPWl4nT4xUYajP41XpSxzB16AEXiSif0IiRgnjgUvGaYz9Fvs+Jwt79AEB/5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750225642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBHNZ3+fvy4PjuHZKXNMNGa6vvXFQq4b/xIOSxEPzTM=;
	b=C93yPb7suV4ledGljV8SK1hxSoJni5pFxJcEw69NcJiIAm84DFMPAXI8VE/4qo9oJoa9aY
	XS1l7HKC6bOadrAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: shuah@kernel.org, kees@kernel.org, luto@amacapital.net, 
	wad@chromium.org, linux-kselftest@vger.kernel.org, usama.anjum@collabora.com, 
	skhan@linuxfoundation.org
Subject: Re: [PATCH 3/3] selftests: harness: Add kselftest harness selftest
 with variant
Message-ID: <20250618074357-cb331853-aa30-43b1-8a2a-e193fd98eb90@linutronix.de>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-4-richard.weiyang@gmail.com>
 <20250617093230-7c07d08b-5956-4a78-863c-f35cc300815c@linutronix.de>
 <20250617235748.pbw2mrpneol6gajb@master>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617235748.pbw2mrpneol6gajb@master>

On Tue, Jun 17, 2025 at 11:57:48PM +0000, Wei Yang wrote:
> On Tue, Jun 17, 2025 at 09:35:12AM +0200, Thomas Weiﬂschuh wrote:

<snip>

> >> +FIXTURE_SETUP(fixture_variant) {
> >> +	TH_LOG("setup %d", variant->value);
> >> +	self->testpid = getpid();
> >> +}
> >> +
> >> +FIXTURE_TEARDOWN(fixture_variant) {
> >> +	TH_LOG("teardown same-process=%d", self->testpid == getpid());
> >> +}
> >> +
> >> +TEST_F(fixture_variant, pass) {
> >> +	TH_LOG("before");
> >> +	ASSERT_EQ(0, 0);
> >
> >Please log the variant value from the test itself and the teardown function.
> >Also I don't think we need the pid logging and before/after/ASSERT in this test
> >also, it is already validated in the other ones.
> >
> 
> Sure, per my understanding, is this what you prefer?
> 
> 
> FIXTURE_SETUP(fixture_variant) {
> 	TH_LOG("setup %d", variant->value);
> }
> 
> FIXTURE_TEARDOWN(fixture_variant) {
> 	TH_LOG("teardown %d", variant->value);
> }
> 
> TEST_F(fixture_variant, pass) {
> 	TH_LOG("before %d", variant->value);
> 	ASSERT_EQ(0, 0);
> 	TH_LOG("after %d", variant->value);

I would drop the three lines above and just do:

TH_LOG("test function %d", variant->value);

Also please note that my earlier comment about the patch prefix
"selftests: harness:" should only apply to the patches really related to the
harness.
Not patch 2, which should use "selftests: kselftest:".

> }
> 
> 
> -- 
> Wei Yang
> Help you, Help me

