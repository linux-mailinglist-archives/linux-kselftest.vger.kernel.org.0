Return-Path: <linux-kselftest+bounces-3729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1538418B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 02:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DF81C214EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAF936139;
	Tue, 30 Jan 2024 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DhbXJuXu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kXNeMn+g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA933CD0;
	Tue, 30 Jan 2024 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579672; cv=none; b=P2ZzUJytSkJms2EudQngkMTVvGEudf0MVuWvk8ihMVpJCmV+8M40uuYoMua3w4js8LIS/WTRespgxU/KaRjKF+LTUu4KkNyqiXjQhDCd7nAgIJqANYp2irqSQrodVTTdjWPdMse1ezA+ET6369tn/jR/a0AQLL7HsSewjC087Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579672; c=relaxed/simple;
	bh=eIeYLq9/742SiWiUw4IIOlMxueZ84oQHFavPtxby0bs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Fkb39RfL/j2b5KzIa+/tPKFpbg78+rDiGtjSChFs7I6FBnDT8yyjG5FMb/08pQcVddZV+I8sUKLzehF2wPcAtyTpFmE8BCAAUhh3qApF59py0/OEoHS5g/tNJbwsRC9JEkh1O5wQYTc7YcdKfY7JK4RAgL22/JBMXE8CtB7TEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DhbXJuXu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kXNeMn+g; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id B0B195C008E;
	Mon, 29 Jan 2024 20:54:29 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Mon, 29 Jan 2024 20:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706579669; x=1706666069; bh=mMpNTLFWFB
	+c+/GqlSqqj8inaaP0ntBJTMndPE1dOMg=; b=DhbXJuXuirbal3flctgFLnEDMY
	NVV90NGALz4rFUD+jhVjdOPnm9O1a/Z8Cqj182nL6o0fQ1583n+uaLdPbVyN8S4M
	kJ7KtlaTJcuIlHk96FfWq/2B6lpWE+SCIuKgfLlo/y2Q/aUrknQwdWuosJl8WWzV
	BguoRjRYMAtQYncU8/4S6s4dIAdSyv3hEJ4eOcMph0S2EQIND86VZv9HdumZZXX1
	zvAIKBi7Xn4J7hGkGZHa90NEewHFJI3+YEWgOGT5zuyFwE+ukDmwTknR5EJMei3Q
	blre5Y+f31bvwkO30v0lWYZ4gHDsdDHrGGjzqihyfU9p1lhcNHyHrOo7ZvPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706579669; x=1706666069; bh=mMpNTLFWFB+c+/GqlSqqj8inaaP0
	ntBJTMndPE1dOMg=; b=kXNeMn+gqMZDHn5/MRv1MlFQLB7P4lJvgo/HQFt22TxG
	EbQll0ypr4fVfX8hSBY76VsXMttudPwTFqCYQpYUrIkmLU5BOo8tSbxepMhFYa37
	O39tmRZS2LXLZlaRUJb1sajC8ZMtvOA5/mk4LgODWKhEtsgpwJ85cpRtj5LfHrBn
	3KNNddQ9vh61s7naxyBn5vwTPoU1Yg3zE/l6JE5Nu27n0ypq9vRZLbkFMdCrWxVr
	71+SWNyMS4GKx+W2rVoHomY5EEIGEqX4faD5FpUh2QEOQ2QF9VNxu1I+IVUx8WNQ
	+aNJZ6IrZtY9byS/BhWszHijVEMax6byne2kludvfQ==
X-ME-Sender: <xms:1Va4Zch97yQW2uZHhRP3aVO1GyaW8fGNG-fZkc_enBgKyb6_OWUDuA>
    <xme:1Va4ZVBaUJG9ZqQAFuUQqTJMVIftV-CP40drOQf8-pAf4p5enN2DOWpuU-50lacRW
    pDQDl8uwvAJkTJPrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufht
    vghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepjeeuheegtdeuteeghfehjeejiefghfeifeejheduvdeugedt
    hfehvefggefgkedtnecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhorhgvrghrsehf
    rghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:1Va4ZUGseqlASZF7QeeiKcjbmesx_chOdeWTawBf1ffzzBaiSov5AQ>
    <xmx:1Va4ZdQpzc4y7-9nZ2i9a9L8AdhHDlW5VH8ooA50yJsM7qzJeq8e7Q>
    <xmx:1Va4ZZwLowROqck9Rq2H9wRJTggRNAII88JP7-tjL0QFzntH88vqmg>
    <xmx:1Va4ZZdnkK2W4JBOV-1A5EKgpvCdqdWALiFkOrL2fPoyoXhciqvzjg>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F40761700096; Mon, 29 Jan 2024 20:54:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <46b90dbc-3b5f-4f52-8539-0f6fa7e28ce9@app.fastmail.com>
In-Reply-To: <20240129-use_mmap_hint_address-v1-1-4c74da813ba1@rivosinc.com>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
 <20240129-use_mmap_hint_address-v1-1-4c74da813ba1@rivosinc.com>
Date: Mon, 29 Jan 2024 20:53:31 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Charlie Jenkins" <charlie@rivosinc.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Shuah Khan" <shuah@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Yangyu Chen" <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: mm: Use hint address in mmap if available
Content-Type: text/plain

On Mon, Jan 29, 2024, at 7:37 PM, Charlie Jenkins wrote:
> On riscv it is guaranteed that the address returned by mmap is less than
> the hint address. Allow mmap to return an address all the way up to
> addr, if provided, rather than just up to the lower address space.
>
> This provides a performance benefit as well, allowing mmap to exit after
> checking that the address is in range rather than searching for a valid
> address.
>
> It is possible to provide an address that uses at most the same number
> of bits, however it is significantly more computationally expensive to
> provide that number rather than setting the max to be the hint address.
> There is the instruction clz/clzw in Zbb that returns the highest set bit
> which could be used to performantly implement this, but it would still
> be slower than the current implementation. At worst case, half of the
> address would not be able to be allocated when a hint address is
> provided.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/processor.h | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/include/asm/processor.h 
> b/arch/riscv/include/asm/processor.h
> index f19f861cda54..f3ea5166e3b2 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -22,14 +22,11 @@
>  ({								\
>  	unsigned long mmap_end;					\
>  	typeof(addr) _addr = (addr);				\
> -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> -		mmap_end = STACK_TOP_MAX;			\

Setting mmap_end in the no-hint case seems to have been lost?

-s

> -	else if ((_addr) >= VA_USER_SV57)			\
> -		mmap_end = STACK_TOP_MAX;			\
> -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> -		mmap_end = VA_USER_SV48;			\
> +	if ((_addr) == 0 ||					\
> +		(IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
> +		((_addr + len) > BIT(VA_BITS - 1)))		\
>  	else							\
> -		mmap_end = VA_USER_SV39;			\
> +		mmap_end = (_addr + len);			\
>  	mmap_end;						\
>  })
> 
> @@ -39,14 +36,12 @@
>  	typeof(addr) _addr = (addr);				\
>  	typeof(base) _base = (base);				\
>  	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
> -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> +	if ((_addr) == 0 ||					\
> +	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
> +	    ((_addr + len) > BIT(VA_BITS - 1)))			\
>  		mmap_base = (_base);				\
> -	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
> -		mmap_base = VA_USER_SV57 - rnd_gap;		\
> -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> -		mmap_base = VA_USER_SV48 - rnd_gap;		\
>  	else							\
> -		mmap_base = VA_USER_SV39 - rnd_gap;		\
> +		mmap_base = (_addr + len) - rnd_gap;		\
>  	mmap_base;						\
>  })
> 
>
> -- 
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

