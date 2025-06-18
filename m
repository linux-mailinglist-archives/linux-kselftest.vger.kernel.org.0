Return-Path: <linux-kselftest+bounces-35305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F47BADF357
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F8E189F7B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA6288C92;
	Wed, 18 Jun 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="A11OmPem";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUZNCOrL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E72FEE1F;
	Wed, 18 Jun 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266244; cv=none; b=kSYax4I3AECbL51WdwSrfyUOKTUYnCuok0GIrG5xVWE/LqrTolgWFk49SQd2Rpzbwg0AnW1RsLvhz8vI72Pg1HnxwoiKr43lfEW0sINbV3roUxD/B+0qM4OjbCbbM7rBlkRdAaCs5dUmoSH6KY8wDWqhuxZJ+peWnrU3fc/b2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266244; c=relaxed/simple;
	bh=69QQN32zF37TgZP6aMrcACJGz2RahWkvz+IbbNqkeAo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Fy+6Pb4R1khZV7cbq+ZgBWR+F3smkekscjx2+FwqFaU+v+FLlRNYzC26sgy1Qu3QAh8v1U8veIt7OPQcpzkKLBbwFVeS2e0CGw44KdfQ9vTg3fu4uWuJJQxOIH5rXi+HX+gqktIYNPMmgpQGYmPj449D0cD8UytCX2vgRffl/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=A11OmPem; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UUZNCOrL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E252911401E4;
	Wed, 18 Jun 2025 13:04:00 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 18 Jun 2025 13:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750266240;
	 x=1750352640; bh=uJboEt4dLgTrZ+sXs/YyjFsL4mKqHkn79Fj83ukQdZY=; b=
	A11OmPemhdFP0tCj3UvMPAzrZRvxcxxbVynbNzjIt6whM2g4TJ6ICm5EiSZ22J7i
	U2G+BVlaXJsCHG/V2nMIAHdMvln7lBPLPAYIx/vMRSwXv4IsnY5uKgFpUZ21f9+l
	iQzmJw862f+JNxXbhCvxDyw/DOHomdBwZvTQov3pzNRlJkhHfuxvxFgUIE4H8wwg
	pp80cpyG01ZcB8bL8THMNlRb+RRsqqNmsxFkFijTAzq8NZXJqyW90CsuCTMaOjxJ
	X1m12pggkZFlQlR2kJIyi8jhyuKpFLIG+USRQNMWyBaTolimHBjpGHJ4vlhU88J6
	r2USS/HoyIBxsw8p1pADnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750266240; x=
	1750352640; bh=uJboEt4dLgTrZ+sXs/YyjFsL4mKqHkn79Fj83ukQdZY=; b=U
	UZNCOrL5km/DXmf/IoZFtpac1kMa/KQ98mfMu5Er44xUk4c6yYUlPzMgwpbjtIMf
	rmWLZrlgHZVRlN0koI9n5Fz2nmxTEyk5fpDEGU0iuXSK4SNccYMMuEL/PHS9fsml
	FcAt0ckrZicjfaI5IkL6Tl58y4jRIeLQbqrkwVEeVHUsZVmnHlMRAmAWH6W+NrZK
	hx+t1YTl9Bf0n3gUN6BBoUQkIUOYcLe2qWNUK16TUF43K5RqXD5c8BmK74Xyo/wn
	yFsHXAVD1D8McW+gxrW2hxIae/J+jKy9rQyq2wOG0Z7M6PT3iiiMQV+9IhJaKJqd
	2I2HcA+1No6P6N8gtn64w==
X-ME-Sender: <xms:gPFSaCwfsSmVb5005cOv0tZ51LYKn4smcUIOaFVZkdGPgNtpKgR6oQ>
    <xme:gPFSaOZOjdFfkUwsbz-8-9gyfprWK9Jtu6DpCy2T77NIuMjFohTXc2uujxxFUKW_d
    2WJksA_o6cLW31aQnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehigh
    grlhhirgdrtghomhdprhgtphhtthhopehkvghrnhgvlhdquggvvhesihhgrghlihgrrdgt
    ohhmpdhrtghpthhtohepughvhhgrrhhtsehinhhfrhgruggvrggurdhorhhgpdhrtghpth
    htohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhhuhgr
    hheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghighgvrghshieslhhinhhuthhroh
    hnihigrdguvgdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgt
    phhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhngh
    hosehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:gPFSaMRF6MukXibteMlIRSsnM5OaJD63pom5JghAjMttaqkH-_DLww>
    <xmx:gPFSaAyNcix4ILbrR39-mwqB1FCitRP1Acj0li2772a7GlJ1s-59Rw>
    <xmx:gPFSaO3jeLRsIFpQI4Y7-kq8hhkco6tK6hZVoy3jkRgvkxy1ILD1Jg>
    <xmx:gPFSaO4H3PE6IFsNUl7x_2cB_e8JM0Qjar29yOziaBlbK_X0V37SKQ>
    <xmx:gPFSaI38-TYXMMnPxg3ouRk-R2nPaSbUA0xVfRFjuP27K8UxwreF-StL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2DA5F700064; Wed, 18 Jun 2025 13:04:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3c57378c8624ec39
Date: Wed, 18 Jun 2025 19:03:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Darren Hart" <dvhart@infradead.org>, "Davidlohr Bueso" <dave@stgolabs.net>,
 shuah <shuah@kernel.org>, "Waiman Long" <longman@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, kernel-dev@igalia.com
Message-Id: <e79698f8-c428-44dc-afac-8d918968d11d@app.fastmail.com>
In-Reply-To: <20250618165641.bKu1_p0P@linutronix.de>
References: <20250617-tonyk-robust_futex-v4-0-6586f5fb9d33@igalia.com>
 <20250618070833._qeCcHLx@linutronix.de>
 <fd2b5bb2-590a-47ee-8e56-965a1d09b2fc@igalia.com>
 <20250618165641.bKu1_p0P@linutronix.de>
Subject: Re: [PATCH RESEND v4 0/7] futex: Create set_robust_list2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025, at 18:56, Sebastian Andrzej Siewior wrote:
> On 2025-06-18 13:39:46 [-0300], Andr=C3=A9 Almeida wrote:
>>=20
>> Ops, I forgot to address them. I will do it for v5.
>>=20
>> > - You say 64bit x86-64 does not have the problem due the compat sys=
call.
>> >    Arm64 has this problem. New arm64 do not provide arm32 facility.=
 You
>> >    introduce the syscall here. Why not introduce the compat syscall
>> >    instead? I'm sorry if this has been answered somewhere below but=
 this
>> >    was one question I had while I initially skimmed over the patche=
s.
>> >=20
>>=20
>> The main target for this new syscall is Arm64, that can't handle 32 p=
ointers
>> in the current syscall, so this new interface allows the robust list
>> mechanism to know if it needs to do 64 or 32 bit pointer arithmetic
>> operations to walk in the list.
>>=20
>> Introducing a compat syscall won't fix this, giving that it only work=
s in
>> x86-64. We need an entry point for Arm64 that can handle 32 bit point=
ers.
>
> I would need to dig into details to figure out why it won't work for
> arm64 and works only for x86-64.=20
> There is the set_robust_list syscall as compat which sets
> ::compat_robust_list. And non-compat sets ::robust_list. The 32bit
> application on 64bit kernel should set ::compat_robust_list which what
> your syscall provides.
> That is why I don't understand the need for it so far. Maybe I am
> missing a detail.
> We have other architectures with 64 bit kernel and a possible 32bit
> userland such as mips, s390 or powerpc which would have the same issue
> then. Or there is something special about arm64 in this case which mak=
es
> it unique.

x86 is the special case here, since it allows applications to
call both the 32-bit (compat) and 64-bit syscalls directly on
a 64-bit kernel. I think MIPS may do that as well, but the other
architectures only allow a process to call syscalls for its native
ABI, so the only way to call a compat syscall is from a 32-bit
task. On Arm and RISC-V it's also common to have CPUs that cannot
run 32-bit tasks at all, so even running your x86-32 emulator as
an arm32 or rv32 task won't work.

      Arnd

