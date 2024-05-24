Return-Path: <linux-kselftest+bounces-10668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E38CE6FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 16:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E11CB20C7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC112C47A;
	Fri, 24 May 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="C0UBxj2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmtcMxuW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981986262;
	Fri, 24 May 2024 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560957; cv=none; b=Qjj8okhPPOrP7qt+VJfyJd82Q5L30GjHjcyH/paO5Sje6li/7qsYNTyxH/soepjydUOYyQ+jTEPc2NgoWG9F69jIa/elCt5k7UpG2l0ahp73GdYrhcTCJZJC3pAkLf8YaWfMi6vRVhnZyZnB1FBzn7DxCaoBej1GyW0uvFtfbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560957; c=relaxed/simple;
	bh=wWkRIiMlgm73/vZ1bN5Kw4M/XsO1r+Ec7tonrYS1gl4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uaPnw3GcdHiBThPYLJe7SAkdRyGODPP31feQOugPBTH72CBt+PIxS5a759UCkTF0XVjuDPt6BILv53nYQMs3RhVDhRiLLngtfEgNpPl019khAXZgg85cTqN1uxcdk77ANK0qpiOBra6WVxZESV9Gwcz2Gdfyqur5EDzrHaSML9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=C0UBxj2u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PmtcMxuW; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 103F2180015A;
	Fri, 24 May 2024 10:29:14 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Fri, 24 May 2024 10:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1716560953;
	 x=1716647353; bh=o8AX8LeWahoPFHk+J4cUsl3zwJzxBQkqh2YVrBWWfog=; b=
	C0UBxj2uJjlibG8L2PThZlcsFGdwQhmn72N+w1ztqwQlSV1pMT7vMP0huWnHUSBs
	AD9K9xexXAcJuShJAp/whush/BYPyJGTLiVHmItllK9uDaIEvtOP21OBi2vZwy8a
	18BqY/76darPC7U7i8KHnfNOA/OcLsAptoN0+1OJ1EWBnTInr690xJyQjX2Spf8B
	m7v6kdTjpD21FezaGQwbm1GeZkpr1ZS1EHuqRA4a1F4ANc5NmIzUh+TSZ+6L4Wub
	R9vgND4eHu1tMlCzk9Ij7ju4Sn2RpSTApb98bWuwE3CY4AlvuUDZuEKH8BJMDWNi
	hHeIFHuqbJx6XrMxOmIPoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716560953; x=
	1716647353; bh=o8AX8LeWahoPFHk+J4cUsl3zwJzxBQkqh2YVrBWWfog=; b=P
	mtcMxuW87sztIVnwRNYwYHkDi5632gdUQZy9L94igZAfSxiKrhUjJZaXZJ26EH2C
	oin9u+4gzbp0L+6cegVxLSxCQasr/6SU7NOK3gz1HUkpzcRlhQmz3gg33W7o1HeO
	KlyDVOhxm+AN3nMcxi/eHVrLCFQqt8QcD1qbr1tv5lY1ME8Cp6jh7I+vrCMgTX8y
	588TS5UxmYrJv6ab4xe5d0hGsHezVwnJfaI3v3ZeHozL02UQ0C85WkmyMM1Uigh5
	CUgy9vh9mAhhLP4buXXuR12Cszkg07xxiLVesoKKCUwdY7NEuV8cxeS3ac7lgPNH
	xnxv4UKSDbamTddQERHMQ==
X-ME-Sender: <xms:OaRQZqX7lQ0d8hynRDHHPb5Jwbvt28Pd1H07Un2r2U1cVXBiZfPtDQ>
    <xme:OaRQZml_BOMnT_Z6k2jKiHbnuuTam3EU3aMLuBE2XmU9eEQzGEnhxeSkVNXzNYP2r
    96mbxPjXWo5XV7-meQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdff
    rghvihguucfthhgvihhnshgsvghrghdfuceouggrvhhiugesrhgvrggurghhvggrugdrvg
    huqeenucggtffrrghtthgvrhhnpeejgeeutdeufedtjeffvdfghfdvvdetteejfedtieff
    keduffeiheeijeehvdekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegurghvihgusehrvggruggrhhgvrggurdgvuh
X-ME-Proxy: <xmx:OaRQZubtji3F1UxuEtKTajXaHr71b188hWYLsl32q14At9wqRVvKXg>
    <xmx:OaRQZhVbg9iwbMpQOpc3scieJQgQMP9Mq3-nApDWSgRx14cGf3Etjg>
    <xmx:OaRQZklqYp123ywL-KrR6iCDTxkIFiG53N0oIeQ-n338WHHLBhTb-A>
    <xmx:OaRQZmdzlziJFgZPIMYQ3wqmsrddOVH7E2ahCQNN5samDfa9GTm5yw>
    <xmx:OaRQZv-Y6IPXT_cKEcmZf02-bB3N_bnjFOky1EDUE17lvVGR-GEB0Xi4>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1A5F11700093; Fri, 24 May 2024 10:29:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f880562e-9521-4270-82e2-c6fb14dc853a@app.fastmail.com>
In-Reply-To: 
 <CALmYWFtedtEnfGFp5DYacHYOE7+GB8yoQC-iyw7JAxySmgQ7vw@mail.gmail.com>
References: <20240513191544.94754-1-pobrn@protonmail.com>
 <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
 <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com>
 <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
 <CALmYWFtedtEnfGFp5DYacHYOE7+GB8yoQC-iyw7JAxySmgQ7vw@mail.gmail.com>
Date: Fri, 24 May 2024 16:28:50 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Jeff Xu" <jeffxu@google.com>, "Aleksa Sarai" <cyphar@cyphar.com>
Cc: =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dmitry.torokhov@gmail.com, "Daniel Verkamp" <dverkamp@chromium.org>,
 hughd@google.com, jorgelo@chromium.org, skhan@linuxfoundation.org,
 "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 23, 2024, at 6:55 PM, Jeff Xu wrote:
> On Thu, May 23, 2024 at 9:20=E2=80=AFAM Jeff Xu <jeffxu@google.com> wr=
ote:
>> On Thu, May 23, 2024 at 1:24=E2=80=AFAM David Rheinsberg <david@reada=
head.eu> wrote:
>> > We asked for exactly this fix before, so I very much support this. =
Our test-suite in `dbus-broker` merely verifies what the current kernel =
behavior is (just like the kernel selftests). I am certainly ok if the k=
ernel breaks it. I will gladly adapt the test-suite.
>> >
> memfd is by default not sealable, and file is by default sealable,
> right ? that makes the memfd  semantics different from other objects
> in linux.
> I wonder what is the original reason to have memfd  this way?

shmem-files are *not* sealable by default. This design was followed for =
backward compatibility reasons, since shmem-files predate sealing and si=
lently enabling sealing on all shmem-files would have broken existing us=
ers (see shmem.c which initializes seals to F_SEAL_SEAL).

I am not sure what you mean with "makes [memfd] semantics different from=
 other objects in linux". Can you elaborate?

Since `memfd_create` was introduced at the same time as shmem-sealing, i=
t could certainly have enabled sealing by default. Not sure whether this=
 would be preferable, though.

> Another solution is to change memfd to be by-default sealable,
> although that will be an api change, but what side effect  will it be
> ?
> If we are worried about the memfd being sealed by an attacker, the
> malicious code could also overwrite the content since memfd is not
> sealed.

You cannot change the default-seals retrospectively. There are existing =
shmem-users that share file-descriptors and *expect* the other party to =
be able to override data, but do *not* expect the other party to be able=
 to apply seals. Note that these models explicitly *want* shared, writab=
le access to the buffer (e.g., render-client shares a buffer with the di=
splay server for scanout), so just because you can *write* to a shmem-fi=
le does not mean that sharing is unsafe (e.g., using SIGBUS+mmap can saf=
ely deal with page-faults).

Thanks
David

