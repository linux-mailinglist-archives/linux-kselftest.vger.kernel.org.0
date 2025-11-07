Return-Path: <linux-kselftest+bounces-45103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F79C404F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 403E334E581
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785B31E0E1;
	Fri,  7 Nov 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QJ/QPjZx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hAZuvcFL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CE307AE4;
	Fri,  7 Nov 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525476; cv=none; b=lS9qDT0Zqhf17X+dw+B9ZMY6qVu4gZCTQZu3z0M2AFBRpGsNXVx4flSX6RizQG6xW3b7CNxO1B8UsiKxdU469CG609/0oBk4uYCNzGCdY0J6jUM3Ngh5OnUMAdtuwitLbsOffpKGNyEcHb5McWU1dymUoft5CMl7xCAobT63ezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525476; c=relaxed/simple;
	bh=PDrqxdvGdY/0ctSJblRwnBL7+qLC6v9Qb4GKwq/M6KM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PBIbcqnyfc6uL0AAjMLkslUK5NDjc2fV0d5w7uGnJ90qeRUT4F6O7C+NaBlaaa/z9ulidCfsEQU3ausPU6EaIiI8vTKIvTb0hJ5DvmOdHJpxRlMMgV1psM2y1kaX8O5FEM/IbtK3dntr8KtmOJJclR/2u3++vlgyzY/+nyAeNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QJ/QPjZx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hAZuvcFL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E2EB4EC04A3;
	Fri,  7 Nov 2025 09:24:33 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 09:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762525473;
	 x=1762611873; bh=03E8O4U+Hx2IbaAwplnWCKG3u1yuAJRKX7CrPA3lERk=; b=
	QJ/QPjZxbc+lypbX/rSVwYf+MP3sivq9ySc6y9Jd1F0TWGUA8LxG39B1WRQBzxXx
	WYNRH/7vk1OLE5duMRZrs+yvMW0Bmxm30d+6DZQ1aMLsyPGX8hTUJ9mN8X7V+OCV
	ZIoM0XPgtaAcLc2F0DZJ+W0OjMFR3FBKBPIzEdM3S0LXbK65jTho+uJWJxCld7JC
	7ndxX4YHi980aaHAnRDpM6qwiMFxZQwJiHIxKLWIgggm9pNHzmk4shKeKgchDkw7
	Ehdl9ZwKAphiDB7WqBhaOfMwc3rRAE2gvhs4Mu1TpAuXMPcVScS5LBPkEBN/SWGN
	GcE5CuxS9yZ0jJ7651FNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762525473; x=
	1762611873; bh=03E8O4U+Hx2IbaAwplnWCKG3u1yuAJRKX7CrPA3lERk=; b=h
	AZuvcFLNt4YmyCdxp+JYLLLiU4SmSy2iQTqInP9Gy2ZNlXugWN8jBR7gwoUuGdH8
	vuOhf0cQwqMP6wAkWjIC4N27TxK2UYqSuIgIi5mpiahDhis6ch8lSjK4mJUzr8Kh
	xjYmn27X17YRFhnv7Mh83atzwQJOH858K3HRXtsJrvw/IPYVNZf2ty9BMaYBjDUW
	WrrgcmNJh5nA+SoAq2Pmay1iiCoIzwF9FYEbV5phdNfCoF9CfRZhVrt72UQk84J5
	DHSZfFIrT2xYvzI/LeyWVhhgywUXLMpDkGKPlaC2SIQfpaqOTJMJ1r/YKEvJkCIE
	EIq3jYuidtN6A4+33ExxQ==
X-ME-Sender: <xms:IQEOaSThobp1IAIE6T5r7sq6HNC6vqmvcc33SqkFGKMLgSVLZQZ_OQ>
    <xme:IQEOaSkI8oeAKZp7IcWGltcmel62RUueeeZD3Llu-auszp594kwmiJxqf-I7WTWyC
    fPFppkG79hD0xRFut6NDSJFZ2S_hz52RWTzNh63PkbJDavGp6bb_PJ_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtg
    hpthhtohepjhhovgihrdhgohhulhihsegrrhhmrdgtohhmpdhrtghpthhtohepkhgvvhhi
    nhdrsghrohgushhkhiesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrg
    hnugesrghrmhdrtghomhdprhgtphhtthhopehmihhkohdrlhgvnhgtiigvfihskhhisegr
    rhhmrdgtohhmpdhrtghpthhtohepshhuiihukhhirdhpohhulhhoshgvsegrrhhmrdgtoh
    hmpdhrtghpthhtohephigvohhrvghumhdrhihunhesrghrmhdrtghomhdprhgtphhtthho
    peihrghnghihihgtohhngheshhhishhilhhitghonhdrtghomhdprhgtphhtthhopeihuh
    iivghnghhhuhhisehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:IQEOacoy_lSdASJXZL6c0G3A8uQxjmp5EevZiIlcAz4imGJCg9bUdQ>
    <xmx:IQEOaWljP166LdUMXYixillNG3PC9dTRZ2tSJ9U0Gzy1ayiMJfETeQ>
    <xmx:IQEOaZvp1g9BC1VCNwpafJsofFTXr9KOwkM-2CKilgg39AQK6r3SXA>
    <xmx:IQEOadfJIguVZ8SR8A8UkuEYhbEqrec42AOtzXMYsP8G4AAjzb-RWg>
    <xmx:IQEOadou3K6Ddhszr15hfKtk2clMSsblFQNUi1Muo-gUMH4Konn5ledM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 309B4700054; Fri,  7 Nov 2025 09:24:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGYZwPnl2csF
Date: Fri, 07 Nov 2025 15:24:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, "Oliver Upton" <oliver.upton@linux.dev>,
 miko.lenczewski@arm.com, "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>, yangyicong@hisilicon.com,
 scott@os.amperecomputing.com, "Joey Gouly" <joey.gouly@arm.com>,
 "Zenghui Yu" <yuzenghui@huawei.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 shuah <shuah@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <a9f4eb49-b06e-4941-a75a-df39f5d3d735@app.fastmail.com>
In-Reply-To: <aQ3/35146HkAqM+I@e129823.arm.com>
References: <20251106094023.1371246-1-yeoreum.yun@arm.com>
 <20251106094023.1371246-10-yeoreum.yun@arm.com>
 <9fffb30d-fc9c-4e2e-94d2-c724e81ae3ac@app.fastmail.com>
 <aQ3/35146HkAqM+I@e129823.arm.com>
Subject: Re: [PATCH v11 9/9] arm64: armv8_deprecated: apply FEAT_LSUI for swpX
 emulation.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 7, 2025, at 15:19, Yeoreum Yun wrote:
>> On Thu, Nov 6, 2025, at 10:40, Yeoreum Yun wrote:
>> > apply FEAT_LSUI instruction to emulate deprecated swpX instruction.
>>
>> Can you explain in the changrelog why you do this?
>>
>> In particular, is this a performance optimization or is this required
>> for correctness in some scenario?
>
> I think the main purpose using for this is to "remove the toggling the
> PSTATE.PAN" bit. so that remove some *potential* problem which can
> happen when PAN bit is cleared.

Ok, I see. This should definitely be part of the commit
log for the patch in addition to the cover letter.

> also, though swpb might add some complexity, but swp can get
> a little bit of benifit by removing the ll/sc way and reduce
> the amount of instructions.

This part I think you can ignore in the patch description,
unless there is an additional problem with possibly mixing ll/sc
and lse atomics that you are trying to solve.

    Arnd

