Return-Path: <linux-kselftest+bounces-26476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766C8A32B83
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 17:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C413A1757
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8C620B7F7;
	Wed, 12 Feb 2025 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y6DCvZ2n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GPCQA8P+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81E211A02;
	Wed, 12 Feb 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377429; cv=none; b=RLEY26eMmHzldNNWTgYLjMkKSeudrmVMugtVPxwLUV9RSpTTA6PEiPhcMqfNxFJzYFf1v5r/GPuXbz9mHY3qBAbvZDSNJ9eX7fxXYiRk5bNwFo8JnwQ1dlmrMCDPbM5cS7qxjUSJY5jpulbdtxJCn1AikRVn/FVQw+TJM+ODrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377429; c=relaxed/simple;
	bh=XL39NdLk2V+axPm4CJnYFNcvDmWaUc/u1gUKMgoOE1g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JhkvARBJx8jh11sJZwNCXeFSFhrhFydXnDnMaLvcTKq9xH8hleDMDNOQ9A4PP0rydHPLKq7nUCcdpBOu9SkJ/VoeTD7N3cNtNH0grGbMC4HyMa3/vq/ejyU8onGTUiELj3bTFY9E/fT5uZKayZUSFgMvy2jM3e6muP2wU8+LsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y6DCvZ2n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GPCQA8P+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E50A25401D5;
	Wed, 12 Feb 2025 11:23:46 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-10.internal (MEProxy); Wed, 12 Feb 2025 11:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739377425;
	 x=1739463825; bh=PcRqnxiZ/Ii1llbahddi+kZG8Q9fpkjlbE4tyq6Q1Ys=; b=
	Y6DCvZ2nhGu+5MZ5+s48phkDJ/ZP227k27zDlKQxbOcLnGYGmjhcKTp3Nxdf+f3f
	alb4CUKGn20aNG4YJKsb+v+4LUBgRuQBIy9/djWsyRHos6MWTtipay4DJeaTtA+S
	U8ypTbwLJOKtHj22cNh3axLu7pDaf0Wiq+Vyw6ixOXjLPH4S2U8U6sBhEbiUU76m
	7Noi+bqNzbdwCDD7wsEOIM83fayQepizZXKDOw22cEw4kTCsGxcEkRCLpbjN5yR4
	SW31rc9ezhP+ofvklTmHBC5qp/xi5P/zzW2eFxhgxDFBmjkwKir2d7c44iJd8Zbb
	k4Lq4zcfKoGNTEboDTUv/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739377425; x=
	1739463825; bh=PcRqnxiZ/Ii1llbahddi+kZG8Q9fpkjlbE4tyq6Q1Ys=; b=G
	PCQA8P+HQ56eRkcnk1Cr6A/LB2E8JEiNhNNyUEOg+b2F+wh40yesrXLUu5H3o/kH
	Q49peTijyu7I8QJwuerVFY3Qr1kQAvFXNMcHaW7pE3T0LmC9FYGlVZc+ffbjjW/0
	vmDAdfw69szL2SZfcH5F8gOo/CeXgQeS4FtKJhWz0RYa0bFkcuhZhYi0JAkmXMiG
	T2yxEUudw4RI600MdnxYAQy9vxZDklDsbZiDUYRkNUbI5JkkPWlXe/3TLTZv7aEY
	u10kS2dKnOSevXI6IMzdO1IFu0Y5BSKewJhU5CBD28tpl7j5hLRZNQ0DJr4XqSdi
	pz6PC5n+1JTEp/lbnMGKw==
X-ME-Sender: <xms:EcusZ8MfIEx1bjp714sFIiGR3oLL2JQNio2NT2WvBHhHIkHJPFQSeg>
    <xme:EcusZy_U8O_n8O6OoURh9itSPpXC-EmCE7NK0RElMj5pyY9FMiESAFnYEtsjr2ejz
    kASz5_kQtLhjVFLXZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhguvghsrghulhhnihgvrhhsse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnug
    gvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggrnhdrtggr
    rhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepnhgrrhgvshhhrdhkrg
    hmsghojhhusehlihhnrghrohdrohhrghdprhgtphhtthhopehlkhhfthdqthhrihgrghgv
    sehlihhsthhsrdhlihhnrghrohdrohhrghdprhgtphhtthhopehllhhvmheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EcusZzTq4Ny0Qro4oel8QcTMbqAmnx1jwVwm4_x-_HNIwyMqTKj-kA>
    <xmx:EcusZ0vcAWMqtYh2WD0JCY2JEXSl7M6XCQlwWBoAHB26dqBGt9XSXg>
    <xmx:EcusZ0fyHS9Omlrd-9jYIcq9itqQuBFb3YUx6VNHVWSdAwauYskHxQ>
    <xmx:EcusZ42OxmPtPcKy825z5oczyVoaB_f00tjTjkKMqHuMdKVdVssiBQ>
    <xmx:EcusZ86lQjZm0OHjHG52CM870dGe8QQoJ1aHEzenOumraI7bhtmYwLS3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7658F1C20066; Wed, 12 Feb 2025 11:23:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 17:23:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 clang-built-linux <llvm@lists.linux.dev>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>, shuah <shuah@kernel.org>
Message-Id: <b7dc96e3-4d8a-4da8-adda-161f8ff815b1@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYuw3XJ3NcYGHT=Jt9mQP_si49GQNEa6sSNLeqDm9A6+Cw@mail.gmail.com>
References: 
 <CA+G9fYuw3XJ3NcYGHT=Jt9mQP_si49GQNEa6sSNLeqDm9A6+Cw@mail.gmail.com>
Subject: Re: selftest/vDSO: vdso_test_abi tests with gcc-13 and pass with clang-19
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 12, 2025, at 15:29, Naresh Kamboju wrote:
> The kselftest-vDSO/vdso_test_abi test encounters failures when built
> and executed using GCC-13 on armv7 architecture.
> The issue has been observed on both TI X15 devices and QEMU-armv7.
>
> Interestingly, the same test passes without any issues when built using
> Clang-19.This failure is specific to GCC-13. but test case should have
> been failed on clang toolchain but it did not.

To clarify: the failure depends on how the toolchain is built:
for compilers using the default 32-bit time_t in glibc, ltp does
not notice a problem, but using gcc it will run into a testcase
bug because the vdso_test_abi.c file incorrectly mixes libc types
and kernel types.

> The Clang toolchain likely defaults to the traditional 32-bit time_t on
> 32-bit Debian Trixie (except x86), leading to an ABI issue similar to
> older compilers. This is affecting compatibility.
>
> This is not a new regression,
> this report generated on Linux next but also seen on Linux stable tree.
>
> Test name: kselftest-vDSO/vdso_test_abi
> Fails: gcc-13
> pass: clang-19
>
> Arnd Bergmann investigated and proposed a patch which fixes the problem.

The patch only makes changes ltp so it tests the old system calls
correctly regardless of the toolchain settings.

Someone still needs to change LTP to include this change as well as
add tests for the 64-bit time_t vdso functions.

     Arnd

