Return-Path: <linux-kselftest+bounces-3731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F90F8418C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 03:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08783284782
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 02:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E78364AB;
	Tue, 30 Jan 2024 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="2z8ErkKV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/3HTLMR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D590364A1;
	Tue, 30 Jan 2024 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580314; cv=none; b=n2a5ZFrVTYB2c0Ndp7hwMpnn7xrASRc/o32KPyroxx+CcGFqNc3ICWRLe+DC33fCADobCWIq4GBywzCNyalobZxl01stetrhsqWDEtpip1q4rM8/ODhTapH9gwpV+p3lIJn03SXIsLL7OqTA3iXYU3ORB/kSDmIak9bIzdi2zA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580314; c=relaxed/simple;
	bh=uDA7d3cK4HbTYyyBoJczpNMeDohAUd3hVaFEKFttN/Q=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qGCXzhDnMBJ1Z2Zes/aBQi1knKym/CPjGQj8XdMs7g0Gj+A45ANiQZevNKHViVu67is5Ypnm4yJzIYL7AjLPiQlCvYhNkVj0DN4+cUgWVPQgCRX3KVHAar09YaqoQ6hgniKBVoqhwtsQV8kNKfRZbLAlnwcN+QDRYy+veXplqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=2z8ErkKV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P/3HTLMR; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 464EA5C010D;
	Mon, 29 Jan 2024 21:05:11 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Mon, 29 Jan 2024 21:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706580311; x=1706666711; bh=iLeD5NyYmg
	72Cm6NJo9Xsz1DLz/QM40Pa0y25iwGzm4=; b=2z8ErkKVofkXU6vb0+GpNcY1Ev
	DN0VSmpJMSYgVL6oMI6aqHChOPodXW0ak/rC516/u91b4pOCj4WL31uL0ySdeYt/
	Zt0n4CAwxyklvk/16jQt0Th0ZWk4BNd5GleLGY50l6/B14l4qKy+R6DlVoONY8B4
	1s3yHjji09al6QeGFKmCcb0C7EFWmBRhg5lHRLluWpXAhwXKcJO91L43g7RqNmb3
	t8b0oWriFurLUVEvWLdjhpTPSAhJUPsqaG4vpNj8epnzBsNUVhxvZDVhjvrm2q37
	f44jSNFaaI+mlEmcHu8oFT+UI/3Alvqu1SjaZr9DiG2F+GlsGHFH4Y+m+3XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706580311; x=1706666711; bh=iLeD5NyYmg72Cm6NJo9Xsz1DLz/Q
	M40Pa0y25iwGzm4=; b=P/3HTLMR1NyvILWY/qH8z4LlOSPWsEr0CuYxpGHB5El2
	SEr8uDmdEuNKYadKhLaQGtsx4vsbdWtFF42uoE/b7A200HDTV4Hvhdyv2R7bdUgB
	7/i8P96RFX3PJ1tJuemYOs7X5YCbCVxdIj6nJI9k1f2W+Ka5OJ0qD4eOTPCv7aPJ
	qN4z9eo6IGFAB5gl6WdaZA2zwK1vELZKFsvQziAMEWwB35vuG7faJDlvQBVYfKXL
	Pl+tpOBdmevExIlVfjZWJNPtx/5iLfdQzZ0GTn/QVZ2k/a+z1gfZzZGMU41DziWE
	ctsjxv/qQ8okWoH+bvLXNryypQQbKFjvD42WBQGyyw==
X-ME-Sender: <xms:Vlm4ZQvybkCA5Pa-nSFOfQgqhgjebVGQzSUMLquUjSG2tEzTwrr-Fg>
    <xme:Vlm4ZdcMzRCdXDG7ZXbVPycI9eKmyEfO5VPy5R8_qfnbcMgQC4NzM99yLueajcsAP
    bXMnxMPZi_h1yTgiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufht
    vghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepjeeuheegtdeuteeghfehjeejiefghfeifeejheduvdeugedt
    hfehvefggefgkedtnecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhorhgvrghrsehf
    rghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:Vlm4Zbz5a6D3BGfYLFHVLA9bDEEPRShToQQxMiL0ZorD4bVvIlnQKQ>
    <xmx:Vlm4ZTOpi9bKOED5VhGqE5hEavR5xxSgpRjEvD_G9Hl2wzJLE5GvTA>
    <xmx:Vlm4ZQ-hwkQz-KjErDAczUp2j-_VJ77iGniywRoKeCpDnVmeSk2liw>
    <xmx:V1m4ZbZ8-Xg9JXPeil1OanYcKEr-w93OWjfXsRG16Y0wv8gvlVCp1w>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 992D11700093; Mon, 29 Jan 2024 21:05:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5fd69812-f07b-4079-a871-7e0ee857aaca@app.fastmail.com>
In-Reply-To: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
Date: Mon, 29 Jan 2024 21:04:50 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Charlie Jenkins" <charlie@rivosinc.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Shuah Khan" <shuah@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Yangyu Chen" <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] riscv: mm: Use hint address in mmap if available
Content-Type: text/plain

On Mon, Jan 29, 2024, at 7:36 PM, Charlie Jenkins wrote:
> On riscv, mmap currently returns an address from the largest address
> space that can fit entirely inside of the hint address. This makes it
> such that the hint address is almost never returned. This patch raises
> the mappable area up to and including the hint address. This allows mmap
> to often return the hint address, which allows a performance improvement
> over searching for a valid address as well as making the behavior more
> similar to other architectures.

This means that if an application or library opts in to Sv48 support by
passing a nonzero hint, it will lose the benefits of ASLR.

Allowing applications to opt in to a VA space smaller than the
architectural minimum seems like an independently useful feature.
Is there a reason to only add it for riscv64?

-s

> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Charlie Jenkins (3):
>       riscv: mm: Use hint address in mmap if available
>       selftests: riscv: Generalize mm selftests
>       docs: riscv: Define behavior of mmap
>
>  Documentation/arch/riscv/vm-layout.rst           | 16 ++--
>  arch/riscv/include/asm/processor.h               | 21 ++----
>  tools/testing/selftests/riscv/mm/mmap_bottomup.c | 20 +----
>  tools/testing/selftests/riscv/mm/mmap_default.c  | 20 +----
>  tools/testing/selftests/riscv/mm/mmap_test.h     | 93 +++++++++++++-----------
>  5 files changed, 66 insertions(+), 104 deletions(-)
> ---
> base-commit: 556e2d17cae620d549c5474b1ece053430cd50bc
> change-id: 20240119-use_mmap_hint_address-f9f4b1b6f5f1
> -- 
> - Charlie
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

