Return-Path: <linux-kselftest+bounces-47820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F28CD55AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 10:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 950393015ED2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF8311957;
	Mon, 22 Dec 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oQdXcezJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HtVO8f0f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD6D30DEC6;
	Mon, 22 Dec 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396396; cv=none; b=NPE+eUczbsnpN2ZmbOyrqP9pladJV6Dfz9etV+MRdbUBMij15Cjo/nS5WSEvnbigFzV15LueI2FlOdR2ZHIPDfVo9OatcaTKT1LFIYYmiv4W0QCsawu5ZxaJNE7IY4/v6N2ArNVl35aJUW48Bf8v/kOUhO/axcZsenb1iMaqC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396396; c=relaxed/simple;
	bh=LOwz/BZEk04kj7tjjFjFVyQHbvFbugLoCeA5MPX5Uu8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QGuLOau2+bd1UCav9v2edIcyJDr0KGIYr8FI4zKYsClXUtO2NZcc0qgwdqyMbjC+frLdaTizjSO4CuTIVlE7qFRkBRCILkyinxDqPinVcV/5/VARyzmoOmvuDrPQERgsw+Mz8b+7+PsRYibGZuxcdVBf6s/Hzwpbilj4y7ledU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oQdXcezJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HtVO8f0f; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 289451D00098;
	Mon, 22 Dec 2025 04:39:54 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 22 Dec 2025 04:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766396394;
	 x=1766482794; bh=LOwz/BZEk04kj7tjjFjFVyQHbvFbugLoCeA5MPX5Uu8=; b=
	oQdXcezJepvKmaqmaVydM1CBdga5kpHADJ2cAzeA9QyKOU+BsuGLUmd/LwX4kZDB
	CRYXJacB++LGDYzm0wMldsq2GnnRkekryA8mpoZh+qH9WdSDuZw8pZJ5AeK6xRE/
	BuAibOekZ3XoTE/GHE9kqfqJh1TMEs4Od+JDAVcMltsIBbm50/ZLYjLYi1ayMErf
	o7EtXa1yWrJ9HqJNfjsX6rXI/AqF/LtFS3mCXB8BpsURFAurAbxEghBhnRgcyuY/
	sAIztqZkmX6I/cTHQw4ZHmXcuuIl8UDdtOyrlTx+7v5AuD0sOpi007IfSWYIs32p
	n/CwepxI5jMSYBXP+Db2Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766396394; x=
	1766482794; bh=LOwz/BZEk04kj7tjjFjFVyQHbvFbugLoCeA5MPX5Uu8=; b=H
	tVO8f0fFqz72cfxa3zCNc9OI1iHuWxIPwap4+3Y/T7fa04p2n6kejXQuvgIrEAvL
	Odkw3phlrTGByWO9KdUiVFyC5srvX2BEQXSSGmYDD8Q/aHrmh8I4VKcsYDXgGvgq
	6oeqvx4NtUq761Gb9EgcB8MtK1wbZ+KVkt7Y3MSfNSP8NhiG+5eSQ/LYdJFbdQFg
	w9Cm4ASQPE0dwI1suKHBQtSPslTeu36fJ5bV7zNEUkEEzTwl+sP6jVqGVahhSis+
	clh2imaKMrarrLM/i5/+ieO8+34sQFYbdNok9AbTWTiv4J/yR25gPHVQn8ed2cLe
	/qpvHLVUq/O8DKG7YNrSQ==
X-ME-Sender: <xms:6RFJaWre4-W1m94CxiY1RvThJTKPgitQKdrKCRHWcqDUcNG4oRe_kw>
    <xme:6RFJaffCH20yJamMSRw2ejjd1JCaWhDvS0AsVB9wujcuXis8tXExfmZH9lQ0_5X0_
    7JY2dsB3nu_z9PCvcSoCHRRTmhdHa_PqC1LVpGn_rXrClcxwkWSHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehieeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhn
    uggsrdguvgeqnecuggftrfgrthhtvghrnhepkedvuefhiedtueeijeevtdeiieejfeelve
    fffeelkeeiteejffdvkefgteeuhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopeifsedufihtrdgvuhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugiesfigvihhsshhstghhuhhhrdhn
    vght
X-ME-Proxy: <xmx:6RFJaX3JRyatx7QtLxz8Ewzr8sjjJOiphKgCmxD35AoyBajpO_BIrQ>
    <xmx:6RFJafBxz_RWHNcxQVuturO9mwoY2kGnlJvGtP9uqRYih_rOZbGTiw>
    <xmx:6RFJaTdrKhxvrp272m4_xj8MCoXMHVyRgzUJv4w3O9ICw5fJVoejYw>
    <xmx:6RFJac5RiJopx-_F5UtWpPaD0385lux7G0hOlGjZHWR6oAnSo2vE1A>
    <xmx:6hFJaWY8IST6yj6gITLmm-YpxyQWDPs25wpAHKuK2DJjgMWZStF3CvpI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AF234C40054; Mon, 22 Dec 2025 04:39:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGyFxRjKuRl7
Date: Mon, 22 Dec 2025 10:39:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Willy Tarreau" <w@1wt.eu>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <098abb99-bfa7-43c5-8a54-556ccd4f3448@app.fastmail.com>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
Subject: Re: [PATCH v3 00/14] tools/nolibc: always use 64-bit time-related types
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025, at 14:55, Thomas Wei=C3=9Fschuh wrote:
> nolibc currently uses 32-bit types for various APIs. These are
> problematic as their reduced value range can lead to truncated values.
>
> Intended for 6.19.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Changes in v3:
> - Only use _Static_assert() where available
> - Link to v2:=20
> https://lore.kernel.org/r/20251122-nolibc-uapi-types-v2-0-b814a43654f5=
@weissschuh.net

I looked at each patch again, and I this looks great to me!

Whole series

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

