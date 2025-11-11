Return-Path: <linux-kselftest+bounces-45319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3935C4E6F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 15:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AAC1895B69
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05B230FC15;
	Tue, 11 Nov 2025 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZhYP9xnI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2WZpgtF1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99513009F8;
	Tue, 11 Nov 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870764; cv=none; b=toMNFe1zVNiyMzI59kNMnOGBUcGQHlEcLWd3f0ShH/XBQrUDJQ7fEZwGbSiD53kut4dYieP2ak7VF9W7jOoiEJPM0bkTybiEqx0LErKOhisM8VzHD/r3d+M+V+MbH+dVMs5r3PetOp2fsG+zeIjTMngwdsF8Z4Q+MkM8Ll4ZeLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870764; c=relaxed/simple;
	bh=NpByBHiupA9mwAKBz1qThmMNm5PKagkHfsCY5dM5c18=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YLXC6SdbB9+ThdPTdPA1P2/uc+APF6268sqvJTVKK/0mT+O3a3Vl3+3HMEX5f+fJnLdSc4HCFs0/zYZ4gszhhEw9DZPx5eBmt4vaQkg2BZ0g22778vWArxkrtNOX1ctE+8wONGNuI/PS+WX7rgynKFbJ5EuRocy2nmvfL2O4II0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZhYP9xnI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2WZpgtF1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 87241EC01B5;
	Tue, 11 Nov 2025 09:19:21 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 09:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762870761;
	 x=1762957161; bh=bVi+m0X0BXfoG2Nsfva8RYjAvFJDsmuCQjkkB+K0KuA=; b=
	ZhYP9xnI9wliJLlntLzoUk1X4TQVE9oL6i0Hh9ddlf5shEUa7wojA5MS+keq0F+U
	MCg8WXVDMGat+8kgjSlbDmAXsZ/EYGiYBxhOT/1wYITAFtwF9JEmenebDLUHadUq
	xELkTz5BXifZlI9WnWmB2zs4Aj68I9mFp2NgkVrtec7sFVTnb7+uv5p9tJpq04DS
	SyL3gCMJTly+qBOsbKhi8dt5UcQJDOT0UyWaJpAKJ/cGgPt8zwyL4FwIuEgLVrIU
	NKwrRXG7EgLO6iGIxdOZNojr06FBJ5ZyCAM0wssbQvZooIbjB/YXj/e/PVuXzcvk
	9gtDn3liKiFqMPM1svNc8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762870761; x=
	1762957161; bh=bVi+m0X0BXfoG2Nsfva8RYjAvFJDsmuCQjkkB+K0KuA=; b=2
	WZpgtF15oW2ZZpYzJ4yyEuOlfgRGDZpWxWad2X3OMvlEZA5NEAdh+5HC0pacTBLM
	FNnSutjoZIfyuZKbCLOP3z/k/KguXKHroUCFuJr3q1Q28D2hniFquTPeCTDSRnzY
	aDF8Arlu8DORQYSLRg08FjxwEMk9NJj/7z5Luc+rblBQ/JHNvNRk21o9kKOf6Wvc
	w5t8sl2NqqXalZthbTq4gGMH1vdC72P7daJTyNbuQ5iQmKYKY5IkY5Lv1EUgcSNB
	BrKqJINcZin8wB9pE85B+LQK5cFVaF1zKd/BSaPU5rPatI1WOz1DBCmS3FQL/Bdj
	RbkYr8y8Fpg3ZKQdDnx/A==
X-ME-Sender: <xms:6UUTaWw66VOFgMf7OLXVMB781_YbgWqXGE7R1EEeunTwwoqjnybFaw>
    <xme:6UUTadG76aNHLXNT-3DGUQDVC-bW_vm0fzKyDO6TgKlzfFFyiuykeV_tGS5F9sU9j
    RiN2C0i7PjJtfjEANtOHlhYu838rBeSbnKRibnHZfX4zv5KLujGiTth>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvhhinhgtvghniihordhfrhgrshgtihhnohesrghrmhdrtghomhdprh
    gtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidrug
    gvpdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6UUTacaV_5flJD5-LccgC0AsOYvjOOrTZ7t_2FcugszkZU57Mwg66g>
    <xmx:6UUTaRcJOHHzxKj802S8vRgtI-kpqlJh7TRiSLFPZWVIzHaFAK6LMw>
    <xmx:6UUTaW3kFFScndluEqR1wAzGbZBOGH5k9sJBqrPCZf8xVQk-5b14nQ>
    <xmx:6UUTaYIrBDu0GFJL5kbaPES6fOKs7-ChGuwblM-wDvgzEbdoE6sSmw>
    <xmx:6UUTacfl4kXKy2oa8eV9Y0ckV5i6S0FGHI-lDM1C78_9h7BffmPL9DgB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F0F1C700054; Tue, 11 Nov 2025 09:19:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5RixjiBPr7B
Date: Tue, 11 Nov 2025 15:19:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <a78a17eb-1df2-471b-9c28-64619c71dc54@app.fastmail.com>
In-Reply-To: 
 <20251111144805-ab2781fe-5424-492b-9cb3-55ebaaedc199@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
 <20251111-vdso-test-types-v1-4-03b31f88c659@linutronix.de>
 <29dd9e11-9ae8-415a-acb3-b96af56550b0@app.fastmail.com>
 <20251111144805-ab2781fe-5424-492b-9cb3-55ebaaedc199@linutronix.de>
Subject: Re: [PATCH 04/10] selftests: vDSO: vdso_test_abi: Provide compatibility with
 32-bit musl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025, at 14:55, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Nov 11, 2025 at 01:59:02PM +0100, Arnd Bergmann wrote:
>> On Tue, Nov 11, 2025, at 11:49, Thomas Wei=C3=9Fschuh wrote:
>> >=20
>> > +#ifdef SYS_clock_getres
>> >  	ret =3D syscall(SYS_clock_getres, clk_id, &sys_ts);
>> > +#else
>> > +	ret =3D syscall(SYS_clock_getres_time32, clk_id, &sys_ts);
>> > +#endif
>> >=20
>>=20
>> I think this #ifdef check is not reliable enough and may hide
>> bugs. As with the other syscalls, the best way to call these
>> is to either use __NR_clock_getres_time64 on __kernel_timespec, or
>> to use __NR_clock_getres on __kernel_old_timespec.
>
> Could you give an example for such a bug?

If CONFIG_COMPAT_32BIT_TIME is disabled, 32-bit targets
only provide clock_getres_time64, so using SYS_clock_getres
may -ENOSYS.

Since SYS_clock_getres itself is provided by the libc implementation,
I wouldn't trust that this actually means the same as __NR_clock_getres,
and it might be set to __NR_clock_getres_time64.

>> If we are trying to validate the interface here, we should probably
>> call both if available. If we just want to know the result and
>> trust that both work correctly, I'd always use __NR_clock_getres_time=
64
>> on 32-bit systems and __NR_clock_getres on 64-bit systems.
>
> As these are vDSO and not timer selftests I think we trust the syscall=
s.
> But how do we detect a native 64-bit time system? The preprocessor bui=
ltins
> won't work as a 32-bit pointer system may use 64-bit time syscalls. I =
am not
> aware of the UAPI #define, beyond the absence of __NR_clock_getres_tim=
e64.

I would just check __BITS_PER_LONG=3D32 and require a linux-5.6+ kernel
at runtime to ensure the 64-bit calls are available.

    Arnd

