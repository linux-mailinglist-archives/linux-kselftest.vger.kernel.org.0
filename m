Return-Path: <linux-kselftest+bounces-48018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE3CEAB68
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 22:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D972300699E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 21:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B8223F40D;
	Tue, 30 Dec 2025 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="p4H65R3a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bLUvyc0+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C083A1E81;
	Tue, 30 Dec 2025 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767129840; cv=none; b=PJoxV3p/aABJmvEdy0QIcUVxIxHEoTovAHuEMNxId7gA9ciQvXooREHzDfcIzlfyydKMzKmLhTXVy6z7vBd5vn57rncSl1jrTlZ+K0GoGliQVn2Lh8JOVKoZdvuh9XwbAEWKWpQbMT+Fp3UKZ3GW7QrRWN8SjsR0lOqcZxdzLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767129840; c=relaxed/simple;
	bh=B0ckIWnp3yESlLOmyabv81FO28IAPWS6FyBnhf/gFu4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sr4yb7HWxSRcGghIwzkIv0hB+l0KOt0Q6UTzFrh0Vhy40wNHnyJLn/n/+/PLpnvU6aGrR2Eepnv85VC9cdU1SvU464F4WvsZXUpUiZQeCa96LYolb30F2wMLi/5TR61OGnCM78cTBmUKrKHkjud9MudijMLwlTdUh+27zWKUK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=p4H65R3a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bLUvyc0+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C5F81400085;
	Tue, 30 Dec 2025 16:23:58 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 30 Dec 2025 16:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767129838;
	 x=1767216238; bh=B0ckIWnp3yESlLOmyabv81FO28IAPWS6FyBnhf/gFu4=; b=
	p4H65R3aBxgWEvEChftFpx5WWT6LMxaT4bz0Tk+Nc5LZWcS2nebHs/sZT4Oi8Etb
	NGGqsgprTmkmGkrwLcHzDygt25mwWHpzQ4OsvMNy/PSmYtOR+YL61N1O+JvNllRa
	ol/H6+34cgwtFFuxWbR60rSkDrq6rhU00Sn4nvb99oktxslrbm3QLl8/cCOW5SQh
	1AZ/hF09Z6gqFzQVzAYH5RuK1ehiapZNibo5Q0zv92WlemUNGcqa9RvgUNRMOvlv
	sZQkqCHiWIdGv8ogscAAc+pf5Sq3OSbGIfL6XgQ7bw1Y/x+ldRa1ZxG/+Ay2w592
	lM75Lh/qgnnWQ9ja+bLHrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767129838; x=
	1767216238; bh=B0ckIWnp3yESlLOmyabv81FO28IAPWS6FyBnhf/gFu4=; b=b
	LUvyc0+c5k7XkGskDRpp0yt8Oo4lDgrJPAXw/1XwyvyZE9G15ZoUqHU+3Er/Ob1E
	N2j5hjIxZW38Wx+7mgR9sySZVPZFkE1ObJuTNO3p5K++4SO7j3sdFeKqd857iuCR
	W7vsXSnghObX5EiOamxwHwmxrTS5GueLZ0ZDf7IMsbczcBh26bmAgD+6fnp0RO/Q
	02Vt+PeAB30L4ky/2v8wK2CEqjxvQZSV0UgY5v9KiFXcgARNsTK1p9DSG08qiVQp
	DIr8cHV9hfH+x9CF/FWFUH59or69vOFhtO7+dJdG8qI4KQvKONx37LNKDtZHUjcV
	MsQ/Tr4RFRHgPuCCzw70A==
X-ME-Sender: <xms:7EJUaZlixzN0UyHjRfCRhotwlKDpIKysNl-YR6ID5HKMTygc6b6VTQ>
    <xme:7EJUafpEFZ0pFPM42ezylH7rhq1a4btpwDFvhtR1GeCFl_hAzw4-nJuuBjj6_xwAL
    asLBka-CbEhMbKj2gnV057ISHU1gh3S-soYvBxRqzp8HbCE5dKP7m4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekuddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepvhhinhgtvghnii
    hordhfrhgrshgtihhnohesrghrmhdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggr
    iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeei
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrd
    guvgdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehlihhnuhhtrhho
    nhhigidruggvpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghmrdgtoh
    hm
X-ME-Proxy: <xmx:7EJUadtBvY635gejtgGX47cKPAWpsRUe0VPlemKpNR1p2AyzQLBh2w>
    <xmx:7EJUaR7e7G5eZb-MP2g0obta-MBzFM1Y6E3lISsTd8IXx-RW7H06FQ>
    <xmx:7EJUafesAiIO6FOKNkSSivltaHgE0yQVHhN2On3A5GWohr6k9fpQmg>
    <xmx:7EJUaRW-3-DeC7Qw4zpZ8_dd4B2p2ShAb03a1ifzk0uuIscfkqJh9Q>
    <xmx:7kJUaUHBl7Nf_j2U_4tAhK7sLsJpoR-E5cnP0yFvhA0pL5XM4PDtEV_4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AF806700065; Tue, 30 Dec 2025 16:23:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag1fLqAFCLhc
Date: Tue, 30 Dec 2025 22:23:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Message-Id: <324be2f3-092c-4796-a7ae-4cddbc65ec00@app.fastmail.com>
In-Reply-To: <20251230-getcpu_cache-v3-1-fb9c5f880ebe@linutronix.de>
References: <20251230-getcpu_cache-v3-1-fb9c5f880ebe@linutronix.de>
Subject: Re: [PATCH v3] vdso: Remove struct getcpu_cache
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025, at 08:08, Thomas Wei=C3=9Fschuh wrote:
> The cache parameter of getcpu() is useless nowadays for various reason=
s.
> * It is never passed by userspace for either the vDSO or syscalls.
> * It is never used by the kernel.
> * It could not be made to work on the current vDSO architecture.
> * The structure definition is not part of the UAPI headers.
> * vdso_getcpu() is superseded by restartable sequences in any case.
>
> Remove the struct and its header.
>
> As a side-effect we get rid of an unwanted inclusion of the linux/
> header namespace from vDSO code.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

