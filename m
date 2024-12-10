Return-Path: <linux-kselftest+bounces-23124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08539EBA85
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 20:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EA71883BC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 19:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D53226181;
	Tue, 10 Dec 2024 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="f3PDxkhn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/VyTXr4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B321420D
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860759; cv=none; b=M+OE59XKPbyAFWkHEFyg46juvSLSsiQ8kYefE0avdqgua0Cd04T4fjeCaN9cJ7hdUMCZJLNFVbhq03ygcCfyFYr2KyEfM6iYmyRx+g1kK58HYRsGm+ePSmp14FV0Os21it+9mVT4UraSpLcQAgy8YA6dbkPzP54zKX2u9ST9Svk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860759; c=relaxed/simple;
	bh=RMhZhYSET6nd2Fmz2e9fskR9q3KW3AepYvXkPGqP2qw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lyd6JPz3sfvYbHYMrbGd96Nui18NXEHNKOxMEpQZcdVzHHEOpU8pjPt4PY/bFlk+buOQL+Kd74EfvGlQnsYfxp/dmh9HrZMbyTt0rhNpV6Nm5vAG3MiVxL4uRm7pfTWPAr9D/YnSscHbpmE9sWyQ/3Y6xXOUpJYPsDZy0yMYJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=f3PDxkhn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/VyTXr4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F274F2540157;
	Tue, 10 Dec 2024 14:59:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 10 Dec 2024 14:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733860754; x=1733947154; bh=nhLJJeGbE0
	o8UiOo++H8appvZHqsVY2XetMzuS/UGV0=; b=f3PDxkhnnw6HEf13mR7TqJg5FU
	l9+3kRHLLRhFz0ULPRHg6F7cS77ZMoay+9oW+khr0lZ6nKHxrEONau/Xe8UbrzJF
	gxB2BDBnCxkfDyT4IjLv+SvWjb0+SvBeOEEzwBG3yAmDQHVDDnVetq6VlGgnFrMt
	2gtyCqvRY7b2Eg9h7wTl6B1yq/O8w4xMQ0F04MyuU0Y2oACtV/TtCldp7FTDmZkV
	gL4VWM2+lTIco0qjqP0EWW/xVr9FFPGo1d0vT2QMinkuLRYdq/uxPFbbBU5V0WIQ
	km6zgwEDwc9BhUhqZOyKkHExzTbJMREZ0oPzdjDlGGioE5MJ9tgRXM3XrEZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733860754; x=1733947154; bh=nhLJJeGbE0o8UiOo++H8appvZHqsVY2XetM
	zuS/UGV0=; b=A/VyTXr4QW4e6vjOcOmGgGWsrR78G/dKb/BhK/3qAqQTcKaZ1EW
	fdgcrxr1yCQyUOFh0WC5XnT2aiRudz0VonpfIG1SRsSuWGA41Dr6p/GNaJbTI2Lo
	axR0ZgWVDtJUEPGjY1XbKrQuZtJ2Dpfhkxy8Ke2skAUuxGl2nBoDMp9+0bjlYhVd
	quWj66pMLniVXfqmbFPaACe7YbJQm5ZsuDGMGwbkPT4L1UTKuegpvophIFkTCK+O
	CNH1AaegSP04gndpJyIs1nkjqLLkoO1G5eSkJijd0vDY7J9HhuSRD5xz3YqL2lE9
	JUiz1LIQh9GuIVYg5tDrMlnTMejwGsE3XxA==
X-ME-Sender: <xms:kZ1YZzpRa5hHe1kF6IV13bAkp8-DkG9DHZyPAAvFc-6DVJvL1s4qXw>
    <xme:kZ1YZ9rNGcY-xnZS-Xx7J7sOKEtSy-uWIGgCP5wD-uIFZWg32Dhfc4CNQWNT9hVgf
    qndAEodG1lQnVz5sZs>
X-ME-Received: <xmr:kZ1YZwPaRlAGSGqmWxCzchBg35qheSes2V3Fsub19yQeUBRvSUlMOPcUExLI8dqZrZn1s9AOZd2Qu8vA1uCOJ0LUXiFNuLdwLk0FJZ3Sh3obshNKEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpefgvedvhfefueejgefggfefhfelffeiieduvdehffdu
    heduffekkefhgeffhfefveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohep
    uddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehurdhklhgvihhnvgdqkhhovg
    hnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehluhhishdrhhgvrhhnrghn
    uggviidtleefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhhiughgohifsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehkuhhnihhtqdguvghvsehgohhoghhlvghgrhho
    uhhpshdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhioh
    hnrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhu
    gidrihhnthgvlhdrtghomhdprhgtphhtthhopehskhhhrghnsehlihhnuhigfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlqdhmvghnthgv
    vghssehlihhsthhsrdhlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eprhgsmhesshhushgvrdgtohhm
X-ME-Proxy: <xmx:kZ1YZ27xsK9OFkJEIFaEPnS8YDZMVlfUtrMztcVTJGPZOSa-Bj6F6w>
    <xmx:kZ1YZy5k6_jUnv8qgc_6wNapkf2j1isNEJVigVLhocUqSVgwtU6E7g>
    <xmx:kZ1YZ-iXiTdXf4pr99rmlcq6aNkotriD4UH17wTHwukoTq6Vigj_oQ>
    <xmx:kZ1YZ06vjfDCcs_GjsEE_xqXAYSo1sSfvkCFmIJOGpxOtFEWdYpsjA>
    <xmx:kp1YZ_xdyz8yFb3vspNh-KyNLzCWnVclkXAob0TCuFRu9jM9Zh_0eij->
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 14:59:13 -0500 (EST)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id DC8CDF36150;
	Tue, 10 Dec 2024 14:59:12 -0500 (EST)
Date: Tue, 10 Dec 2024 14:59:12 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
cc: davidgow@google.com, Andrew Morton <akpm@linux-foundation.org>, 
    andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com, 
    skhan@linuxfoundation.org, rbm@suse.com, linux-kselftest@vger.kernel.org, 
    linux-kernel-mentees@lists.linuxfoundation.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v4] lib/math: Add int_sqrt test suite
In-Reply-To: <20241210172822.97683-1-luis.hernandez093@gmail.com>
Message-ID: <9op57qr3-p152-6ns7-52n6-35599801rq22@syhkavp.arg>
References: <20241210172822.97683-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Dec 2024, Luis Felipe Hernandez wrote:

> Adds test suite for integer based square root function.
> 
> +struct test_case_params {
> +	unsigned long x;
> +	unsigned long expected_result;
> +	const char *name;
> +};
> +
> +static const struct test_case_params params[] = {
> +	{ 0, 0, "edge-case: square root of 0" },
> +	{ 4, 2, "perfect square: square root of 4" },
> +	{ 81, 9, "perfect square: square root of 9" },
> +	{ 2, 1, "non-perfect square: square root of 2" },
> +	{ 5, 2, "non-perfect square: square root of 5"},
> +	{ ULONG_MAX, 4294967295, "large input"},

This will fail on a 32-bit system where sizeof(long) == 32 and 
ULONG_MAX == 4294967295. (meaning the result would be 65535).


Nicolas

