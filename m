Return-Path: <linux-kselftest+bounces-44422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AAAC20C90
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AB9460B5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCC9286D7D;
	Thu, 30 Oct 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="K3ZQh7Np";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mGBM+Kse"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAEC2857F0;
	Thu, 30 Oct 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836349; cv=none; b=sjd+1AK3rmy9iXvhIJX3WILelCkF13AG52zWCVjJJThz6XDECL91By2W9D3RHZ5CRKXxdaLbwkTqUA2FaPYazVfZC6N5fGqszVWabb0Xy2sLcpkahWr10iMlvc3Bmp99iHRvybYaEnWUGCDI6475OUi2r1zdM6dvuxphM7yI06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836349; c=relaxed/simple;
	bh=iAMRPUbbYbZlhKn5in/HGlgUn+ksUFRcO6IEVrJCJv8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YeYzoeJiTCoMPllYrzsmdLZt200zq8+RUd8A42bbpOQ60nPvCAoUr2Do9UJMF/e+n2EQDIu1HvS8UfM3TILt5GTzLs6S9SC8rO/hNrDp3wN3btLD9POTwhQ/jNTOh7XCAbA8vk+UyFDMYmzswL0t6lhP4h2eMnFSKMYzU8nlg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=K3ZQh7Np; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mGBM+Kse; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D517E7A0160;
	Thu, 30 Oct 2025 10:59:06 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 10:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761836346;
	 x=1761922746; bh=iAMRPUbbYbZlhKn5in/HGlgUn+ksUFRcO6IEVrJCJv8=; b=
	K3ZQh7NpKBLDq7TE6gR55oLH0KU4k0deEz2HPO8ED1FRL61uGon+/10mDd/7kdjo
	ntwCNvSnSZxnDHS3Zruu/8WdtvMPuqMDmiL3r6E/qmAo54sI6qIBj1kIY8/iNKq1
	TPcSD7WeCI7kMXW6VzBh4SPFnZEc8+FbXxrq9/J3qh0YeGjhYtMG3cMVV4qMpA5J
	m7/o91j3JZXeC9Vf1VB3Da1BDX3BOY7NdcWIh6W1DSyp5JYP/lAvKbVyuXE1v0hp
	I31Jm0vPgVK1Kr6On1a8KkMGW32mbedZb5c+rcxWRYinOXc+cMWCoyr9eztq3A3F
	hrCBu5P9HLy1uqCsRytUrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761836346; x=
	1761922746; bh=iAMRPUbbYbZlhKn5in/HGlgUn+ksUFRcO6IEVrJCJv8=; b=m
	GBM+Ksesig0lHRYd2u+NiP7tq4MCftcyLnNRO3BF9Hu51hPLeouqX+vt6Z0gXOOT
	OoROs34V3X8KN1Kxs36weBOzKdFqJlBEeoZUfeCzUzbGPigLkFYa2Q/msElyXbAz
	KEyUQVUnnpsPNRBfQnYe4hNEz9RqT2Ot54sdzQv7PswL/LeGBwMwKpgKkJUPB9YR
	jx0UFlQZxFT//O1A02jbdlQuaJYIHOftGuFi7zYby02bhRga1VHEkdwICmqkmIlf
	TUnJXoLo7ojn0Wj7y//itXXzfGw7x87A2LLL8NKQGKjWBi6W97PUyD4Tn8XDkFGI
	JZOhBIpjVNPYjsxTlfO5Q==
X-ME-Sender: <xms:On0DafqdqH3uE0CmVlLRmjzh8Ghu8TdMl3Dye-o56p2boBUFrOOAfQ>
    <xme:On0DaUezwEh-rmiMB3lUNChwjtqubDCNZT2Og4mL87c4ayTGSSUIWtlj3mqOn86yT
    4F-G5mS5r-hCrJ_j3mscWAKuiaUkrf9519wMzBUow1IwFx_ZaYsBcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghr
    nhgusgdruggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvle
    ehvddvgeejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifsedufihtrdgvuhdprhgt
    phhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugiesfigvihhsshhstghhuhhhrdhnvght
X-ME-Proxy: <xmx:On0DaQ16PkpP0Kwq_CQZC7sOaVGXU4tPPehsNnvkl5piOPribijXrw>
    <xmx:On0DaUD_OYwxvX4Wb1_aLsZFjizVLL870rHNFqZvtCDxk727vHONXg>
    <xmx:On0DaUd2PvV2joyuJSX-dLKgI7-EQK9yFEvVYksV0E0UDdsAdOdkaA>
    <xmx:On0DaZ5nwRzyJL_xbw5L3nkez0_lRV-ZzPkuK_X-SIL8K4TRGdWKUA>
    <xmx:On0DaXbzgphq62Yu4ut5OZ3RQ4iWfB5E0UtQyDC4tVMB3J9-S2KZlWDJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5DEF9700063; Thu, 30 Oct 2025 10:59:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ao3O5_vZS4X7
Date: Thu, 30 Oct 2025 15:58:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Willy Tarreau" <w@1wt.eu>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <344a3ebe-f991-4d28-ae54-89e76725830d@app.fastmail.com>
In-Reply-To: <20251029-nolibc-uapi-types-v1-5-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-5-e79de3b215d8@weissschuh.net>
Subject: Re: [PATCH 05/12] tools/nolibc: remove now superfluous overflow check in
 llseek
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025, at 17:02, Thomas Wei=C3=9Fschuh wrote:
> As off_t is now always 64-bit wide this overflow can not happen anymor=
e,
> remove the check.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

