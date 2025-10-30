Return-Path: <linux-kselftest+bounces-44418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA609C20AFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 870F434F72B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84EC23EAB8;
	Thu, 30 Oct 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oVCtoStt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e82/qKKR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B8725A2A2;
	Thu, 30 Oct 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835604; cv=none; b=pX86nWLwCQk0GArUOQaP372+TWwGgtm3UUcTFls5EdX1KAIOnaMqh1cc6QePHUTdMPf+2YLUaYuQGyqF1NFq7JQwvxtLB76/2VBdGKagy1PtyUc0n0EuVEV6SNtpp784vrldeOIE0cb/KHWYDsCuSO8ZZkUX9QC4RY33mK0hyC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835604; c=relaxed/simple;
	bh=hwom/9Pw4N/VBgtc2jmqRmRlOKuePcQjEIxGERUjxKo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WPZTWyM94JCQFIP/8SxXpxZ2Xwy+yVt+MvbUWOTglyK/X5bo/jVGYvFGzJPosAzfNaXtKJRI/HIOVOhOW7ykk4PR98AZWGCEFrszVIeRodY/arU55NwlgYkkhlB3l5K+r95MbOKfwLtuJGGMi47zpgO0DqWFwYXC0ZmUgTJIPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oVCtoStt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e82/qKKR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D58F57A0198;
	Thu, 30 Oct 2025 10:46:41 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 10:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761835601;
	 x=1761922001; bh=mq773LgvHiz9EeslLKHUfMGabLJxIqZC6ZCw+K/E+Gg=; b=
	oVCtoStt3IhLvDDR2JnIIsiE0FbbwAGCsRlfeNm6vKPCgQLiM+OM5RaMAngjqBpx
	vqSLf5oD9N1Yy7xaMuRPhs02QzXMsM3AQ4586+781LJa5Jrcve0LAX60p5U6amrI
	803plTsov+Z7fjdyqjYPFqerKqQrT7tuOseMtJDkrsK2LSNtf45XovhaEyG8dQoc
	w/Ximhplspga5Ka70ejaoQ0crVsyDknX136+633DcDM8jq4yKoW1pDHAun7ZTqCS
	BNp4czqCCH9DPDFlGoD9EJZpW2XXA9JF4wl0Q0X/NMK3729oVMR3e43ayTB3CNpU
	FFwSsdeAgKphppmsHtT26Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761835601; x=
	1761922001; bh=mq773LgvHiz9EeslLKHUfMGabLJxIqZC6ZCw+K/E+Gg=; b=e
	82/qKKRo4OpbBFPmp9kwlpcc4RwRjDN1SF5JU5i4yPnqpE1hDR/MWSkPiqt46MzE
	Qsakbauj/yGKKFs4j+ZnPoUnvJbwwirlJnOANip5RGyphOo9ZEfvLMhiD142kObN
	65bFcyPS7EoGfqo1BxjNA5tuEuyPxL6EznE1nnBdDiiLCKAv5a36YXH5RQEsGopA
	d3QVogZdgL/Ek5btDxe/johOPtj8gOcS0WNv5Vmkg72aWFxVyxpIGAwZsRvz3amG
	rWWqq93IW+C1Hg8n7E1JWPHsD5pdAyuwUSI+bSkiyMsS2POiXXWjBuQyjh//rKZf
	GjIORx16Utqlnr+1QsAGw==
X-ME-Sender: <xms:UXoDaeimKUDbrxREAGQh1FQkrocZO6a9Jfga9RYtNYrV2lthm5VugA>
    <xme:UXoDaZ1UH6f-L5GeusE1mpL16Vmp5QBrPVaSuiOVkjzY_lU3PsXtV8FFlURJJmXAj
    GWtY7pZTQs3qm7VLonhv4lRABGt0r98ajvP29Qa0mT0dBQVMeh5Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeikeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghr
    nhgusgdruggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvle
    ehvddvgeejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifsedufihtrdgvuhdprhgt
    phhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugiesfigvihhsshhstghhuhhhrdhnvght
X-ME-Proxy: <xmx:UXoDadti9-zEwvYXUQhbA4ifJK6LeLJU7P6SDBSNYrRJC1x1nrttrw>
    <xmx:UXoDafYyBjgImx_VImRM3cwW_d5uSB567TOdKUMC_4VTGDNwZzk6HA>
    <xmx:UXoDacX-bRHCr-umNeYFgu7QQ8v0SuFxy3Was1lOuWeb5Pn8uPQFkQ>
    <xmx:UXoDaUS5x-moSgOVBB6ymExlpBGdCXmQudwRPuuOqkUfXbw_EFD07A>
    <xmx:UXoDaXRuBSkvtrvhZZcDdYMkuFPZjbCYKdu5V0zUqBimyLs4YAhoaS8y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 650E7700065; Thu, 30 Oct 2025 10:46:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIJo198GG4pg
Date: Thu, 30 Oct 2025 15:46:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Willy Tarreau" <w@1wt.eu>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <9c8025ad-8c47-470d-89fa-81a19664ba24@app.fastmail.com>
In-Reply-To: <20251029-nolibc-uapi-types-v1-9-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-9-e79de3b215d8@weissschuh.net>
Subject: Re: [PATCH 09/12] tools/nolibc: use a custom struct timespec
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025, at 17:02, Thomas Wei=C3=9Fschuh wrote:
>=20
> +struct timespec {
> +	time_t	tv_sec;
> +	long	tv_nsec;
> +};
> +#define _STRUCT_TIMESPEC
> +
> +#include <linux/time.h>

Unfortunately this is not the definition we want on big-endian
systems because it puts the tv_nsec field in the wrong place.

You can either uses the simple (non-POSIX) __kernel_timespec
definition in nolibc with a 64-bit tv_nsec, or copy the more
complicated definition with explicit padding that is used
in musl and glibc.

      Arnd

