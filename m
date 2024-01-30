Return-Path: <linux-kselftest+bounces-3772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFF0842F4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 23:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABFB2865F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602C97D3FA;
	Tue, 30 Jan 2024 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZwLKbUHV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rCmG7DTj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF237D3F7;
	Tue, 30 Jan 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652321; cv=none; b=CnH41UziSSVY0EQH87n6SoPh9n4JV2u+bRKeHUgjff+cFEnnIYVjurolkLcJNDJ/gH87EvGLawMoMjqqkHuWVAhrtHbxYKwJv1bPtqNwJhucaMHPZoY+ojhfCpDN0OlfgGNsjHjoOvG4zuT2SIlBsYWVpgYoZZ80k+eRqH8utCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652321; c=relaxed/simple;
	bh=LQEy0+LoZYeGKc2TxPi2Mrhvs+qROPoYuaU6oR3C34U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=NcM2iz0zljN5vnjA8EbB/2spTHGtJITqKX66o82KBG1VfMIOlq1HNor006GVuQMhsnxUPbhsBmqeHqHFzQ8/GXTqx2uyHhibojfOhYVIFLeOt9vCbmtl0r8a3VBQC/FeOxC8wEqgsptroN5nnhhYBOm+EWgEdGRnMZd4JzV4hCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZwLKbUHV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rCmG7DTj; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 333953200B26;
	Tue, 30 Jan 2024 17:05:17 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 30 Jan 2024 17:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706652316; x=1706738716; bh=6JySg6oxBL
	ctqW7yqA5TQZwLK2NTOu4x+J4bcx93/hs=; b=ZwLKbUHVGU5pLTJfuE8bRKeO7p
	xlRPn5sb3L13ArVNiQlJdRZAIqUjrW/HX30wHoZOmNBHm6OvPjcQJ+KM/P16roNq
	CF7ell2U+wN0Ea6v6R30MujOVViv6Y3v4J+iN8aSlO3he021giX7JhNjsOo7ZlXx
	KmBs0huTzeka+mCf/K3bLuXgLMclQZhZkUHediibs+ws036URqsKzApLRHWZZMlQ
	UNxYtfg/0iYXZ+94jz8LwQXOzzqPXenJSkrH/sixlDujMGjp4FdFvfYk/n0tBAZT
	SBOLG5DbMoF8pqqcSKh7+rYy1CayYbaDWhXq+A+AUbruYZlfSdd/hXPHF8IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706652316; x=1706738716; bh=6JySg6oxBLctqW7yqA5TQZwLK2NT
	Ou4x+J4bcx93/hs=; b=rCmG7DTjLQB/zm6pU3uus63GXaKb9OPy0pBSlFYDB+9G
	vPjUThKVGiVPiT2TxpqF0umOv1EPdeRG7dQdrUryp9reng8LJnhDuuy2+mdmIao/
	z60SAwF8pEAHiBMPybINo41PYzP/x9EmSz6MtPd6jwcd5PfyNRlEEdZQFlqle6JT
	v0tHQRc9jdHVOczm+3i7h8oSR+KRrzMOUAuJ1WxE45Ii4LxPK5B1mRQWKYBX8BeI
	KzHMWxV4TR95WrJi+1+2U1nU95IJxQN90lxMzRQTL+yvKsR8KQo+Ndz28kZjgMPx
	vHwLYolc31U5Yc0mItgzV9iGXY7Ev5qucYPedV4zZQ==
X-ME-Sender: <xms:m3K5ZS-GoQITLfLuEyih--a_ywEwLuR7CvGjR3101vpj_YV2E9XCig>
    <xme:m3K5ZSt4nvo3ub-7LvzV0l7v9rzatpBMtxS-57qExDsZxJgB0NWRVB7Q_04jqRL3W
    kJzNdMR2NxUG5M6mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtjedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufht
    vghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepjeeuheegtdeuteeghfehjeejiefghfeifeejheduvdeugedt
    hfehvefggefgkedtnecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhorhgvrghrsehf
    rghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:nHK5ZYAkdB7mu9efbNWQu13ueqsxhWSVjBgtSayAtJgB_fhwG-aO_w>
    <xmx:nHK5Zaf2ITv3PhoX-zP8ZJTpHkfoMR5WhhsD2dbZx9kc1a1cJvj9pg>
    <xmx:nHK5ZXPTRyHejQGewkPQWQDXjP_V5qHGuxgA4eMk_RDxe10rIe7fGQ>
    <xmx:nHK5ZSoPTsiybhyKCrNJ3diUTscE515yAD27vQoy-UTePUTvjC2_kg>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DB27E1700093; Tue, 30 Jan 2024 17:05:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6352ff7f-1e69-4f7a-b793-f69d223d4684@app.fastmail.com>
In-Reply-To: <ZbhbNYLR9kh5dtFU@ghost>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
 <5fd69812-f07b-4079-a871-7e0ee857aaca@app.fastmail.com>
 <ZbhbNYLR9kh5dtFU@ghost>
Date: Tue, 30 Jan 2024 17:04:55 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Charlie Jenkins" <charlie@rivosinc.com>
Cc: "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Shuah Khan" <shuah@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Yangyu Chen" <cyy@cyyself.name>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] riscv: mm: Use hint address in mmap if available
Content-Type: text/plain

On Mon, Jan 29, 2024, at 9:13 PM, Charlie Jenkins wrote:
> On Mon, Jan 29, 2024 at 09:04:50PM -0500, Stefan O'Rear wrote:
>> On Mon, Jan 29, 2024, at 7:36 PM, Charlie Jenkins wrote:
>> > On riscv, mmap currently returns an address from the largest address
>> > space that can fit entirely inside of the hint address. This makes it
>> > such that the hint address is almost never returned. This patch raises
>> > the mappable area up to and including the hint address. This allows mmap
>> > to often return the hint address, which allows a performance improvement
>> > over searching for a valid address as well as making the behavior more
>> > similar to other architectures.
>> 
>> This means that if an application or library opts in to Sv48 support by
>> passing a nonzero hint, it will lose the benefits of ASLR.
>
> sv48 is default. However your statement stands for opting into sv57.
> If they always pass the same hint address, only the first address will
> be deterministic though, correct?

I think this is correct.

>> 
>> Allowing applications to opt in to a VA space smaller than the
>> architectural minimum seems like an independently useful feature.
>> Is there a reason to only add it for riscv64?
>> 
>
> If there is interest, it can be added to other architectures as well.

I meant as opposed to riscv32.

-s

> - Charlie
>
>> -s
>> 
>> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> > ---
>> > Charlie Jenkins (3):
>> >       riscv: mm: Use hint address in mmap if available
>> >       selftests: riscv: Generalize mm selftests
>> >       docs: riscv: Define behavior of mmap
>> >
>> >  Documentation/arch/riscv/vm-layout.rst           | 16 ++--
>> >  arch/riscv/include/asm/processor.h               | 21 ++----
>> >  tools/testing/selftests/riscv/mm/mmap_bottomup.c | 20 +----
>> >  tools/testing/selftests/riscv/mm/mmap_default.c  | 20 +----
>> >  tools/testing/selftests/riscv/mm/mmap_test.h     | 93 +++++++++++++-----------
>> >  5 files changed, 66 insertions(+), 104 deletions(-)
>> > ---
>> > base-commit: 556e2d17cae620d549c5474b1ece053430cd50bc
>> > change-id: 20240119-use_mmap_hint_address-f9f4b1b6f5f1
>> > -- 
>> > - Charlie
>> >
>> >
>> > _______________________________________________
>> > linux-riscv mailing list
>> > linux-riscv@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

