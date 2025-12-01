Return-Path: <linux-kselftest+bounces-46797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 027E1C96C2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 11:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8E50344C99
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3991C3054E1;
	Mon,  1 Dec 2025 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gVxrvCg0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tv+NmpJS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62082FE591;
	Mon,  1 Dec 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586420; cv=none; b=qVpzuYrgkbffRqMTsfNYwfRbYfEOXIG75VwLYynC7j/C/QjPgE77MGQqKA5prIpu8cKdqnWIH63Dy2CtJVu5jsX0mszRlXra+U8T5+L4XKlC9ptgc1eW947DpKHKTJxtm+XNK1F9yPvOBI+l7+FntobfQErwOiqlZC0VNeXA32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586420; c=relaxed/simple;
	bh=J35d9u8rweiVjB8ttPcL7PtgJyDA4HIFZjVOTezIpG0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fFPAY6xIBYO9n0ImmVlj/XvD6n/DQX1JIt0ErqvNG0gsMvI0T6Ub1vKBOXZn/JiNeN0YY5yWVWQ7lNDmF6XTtXa7eOtJHv6fxNeD7LsLkxhOKmgM0PEOqqThgbxr6wNifZ4jReL4GhuwkTub5b/dEsUU6ZSbNp175hBjvLBpl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gVxrvCg0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tv+NmpJS; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C6DFFEC0817;
	Mon,  1 Dec 2025 05:53:36 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 01 Dec 2025 05:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764586416;
	 x=1764672816; bh=xnZJWBs/RiH5PbQkgIZcruUaLXb2cwe/Wy6Areuom48=; b=
	gVxrvCg0pp3498SzCSNpRlsoYr45sFRZy0b/8MS67ITtX5VF7itgzv6GdXEbficG
	pMEePAc1Wa1D8zcbJ9VdCEKNPnBaQ4Ix+Iq347Sy3fDpRQRxysTFkOiMIC6uhdTi
	0MEcHa/7pP9DKFkyZU42bDWhsIjDG7/z0LrcB7Y1r9RK83seRRGcMtcJyBVYq0Qv
	NZOYytmngoxYmPuWO2Om1lclG/BiW71Zy4LhAE8s2RXIfBJ3oAh9YO2qOqKGHxue
	JfXjWfGNVeVW+aM3AYqq665319QTv+mN6RuYCIuPbvGh12+bko1XmQ0ZXgfak4o0
	1kELeASVtPk6Xr/u/WwuyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764586416; x=
	1764672816; bh=xnZJWBs/RiH5PbQkgIZcruUaLXb2cwe/Wy6Areuom48=; b=T
	v+NmpJSHlmdVSO83p4zPTFDcNYKybDM4FUAZao4yM4kE8NXnCuWqXLieyMiTFBMd
	2N7I40D82JxPJvUqer5OD84iZ5KeCOrdOWnahJPgjkRnVBE185+Gfxy82UH4ThGr
	EHPwkowfkgeFtUPJbbKUiASDt8Prv/4Mqe36CQVBceiVI2RHlffVsylInHy8AbSg
	+CSmuWKLZ7OuYBR/zzjXd7J/ZlfXNgsxb4zuEbtemR2uLYmvTvXwBW851OcJOb+i
	lKQUT2QnlOh0oPe6jbD6UQfS7fg0fPQGJ1pWLiK91iSXSIuWD3Zh1Df+2NAi0APV
	kdqaD/XrjWsbFZKVT5LWg==
X-ME-Sender: <xms:sHMtaWNtAxfHIdJ8XNe3uNxNvUP0MaVrtsCj5MSTDvf706JtzRsOpA>
    <xme:sHMtafxYj22bcGEPRzVji-wGk7u8u5vpjKie6tL1zn61wMZtADm4EhmyDI2RO0G4X
    s5vvRmDZt51DxSc_FKHhm_tctRbZjpYVLfKX1tA-v0ZW3-bBxP9TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghr
    nhgusgdruggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvle
    ehvddvgeejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifsedufihtrdgvuhdprhgt
    phhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugiesfigvihhsshhstghhuhhhrdhnvght
X-ME-Proxy: <xmx:sHMtaYYncX44nkNpwqni31gi1ww9wwoFdr7SB_GJds1rlyUEHkCZCw>
    <xmx:sHMtacWRNCfSgd6EVeJcHkLpK9IS2fJzMuHCTpypuLiAfTRSpOYHSA>
    <xmx:sHMtaehWLno-Z3D9eBpESy22DI-xCadGhD3DSzqbf5S6FQglATfRGQ>
    <xmx:sHMtaSuyIO2wzakgbypXaMJvpAwWtbtRIjgLAeOVYAf9ykLbDThoTg>
    <xmx:sHMtaddC7FZD4O1KC759-UalU2vfu4V6S0xtXXdcBQF5UW7yQT5w7vjp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 54963C40054; Mon,  1 Dec 2025 05:53:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuglI0iV1DGV
Date: Mon, 01 Dec 2025 11:53:16 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Willy Tarreau" <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Message-Id: <2158db79-4b59-4cd2-a4af-a2b4429fd1bd@app.fastmail.com>
In-Reply-To: <20251201103505.GA23859@1wt.eu>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
 <20251122-nolibc-uapi-types-v2-9-b814a43654f5@weissschuh.net>
 <20251130105842.GD31522@1wt.eu>
 <75e632e3-3353-414d-9b8a-8bf9ca46b5a4@app.fastmail.com>
 <20251201103505.GA23859@1wt.eu>
Subject: Re: [PATCH v2 09/13] tools/nolibc: always use 64-bit time types
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025, at 11:35, Willy Tarreau wrote:
> On Mon, Dec 01, 2025 at 08:45:00AM +0100, Arnd Bergmann wrote:
>> On Sun, Nov 30, 2025, at 11:58, Willy Tarreau wrote:
>>
>> #if __TIMESIZE =3D=3D 64 && __WORDSIZE =3D=3D 32
>> # define __TIME_T_TYPE          __SQUAD_TYPE
>> # define __SUSECONDS_T_TYPE     __SQUAD_TYPE
>> #else
>> # define __TIME_T_TYPE          __SLONGWORD_TYPE
>> # define __SUSECONDS_T_TYPE     __SLONGWORD_TYPE
>> #endif
>>=20
>> so this one is explicitly the same width as tv_sec, which has all
>> the issues you listed, but avoids the need for padding.
>
> Ah we seem to just have checked different versions then,
> as in mine there was still some extra padding left depending
> on the endianness :-)

The padding is definitely there in timespec around tv_nsec,
just not in timeval.

Oddly, the version I quoted is from my arm64 /usr/include/
installation and looks different from what I see in the glibc
history, though that also uses a 64-bit tv_usec:

bits/typesizes.h:#define __SUSECONDS64_T_TYPE   __SQUAD_TYPE
posix/bits/types.h:__STD_TYPE __SUSECONDS64_T_TYPE __suseconds64_t;
struct timeval
{
#ifdef __USE_TIME64_REDIRECTS
  __time64_t tv_sec;            /* Seconds.  */
  __suseconds64_t tv_usec;      /* Microseconds.  */
#else
  __time_t tv_sec;              /* Seconds.  */
  __suseconds_t tv_usec;        /* Microseconds.  */
#endif
};

>> C23 has updated the definition and does allow int64_t tv_nsec.
>
> So it purposely breaks existing apps or does it apply only to those
> compiled with -mstd=3Dc23 ?

Neither, it's just that nolibc with a 64-bit tv_nsec would
be compliant with c23, just not earlier versions.

I expect glibc to stick with 32-bit timespec and padding, which
is still compliant with the new definition of

|   The type of tv_nsec is an implementation-defined signed integer type
|   that can represent integers in [=E2=80=8B0=E2=80=8B, 999999999].=20

>> I think it makes sense for nolibc to just follow the kernel's
>> definition here.
>
> Given the very narrow range of existing code that can be impacted,
> I'm fine, but in general I try to remain extremely cautious about
> portability: as a general rule, ifdefs needed to address possible
> incompatibilities, if any, should rather be in the libc code itself
> and not in the user application. I just ran a quick check and don't
> have code using &tv_usec nor &tv_nsec so here the risk remains quite
> low.

Ok

     ARnd

