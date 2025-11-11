Return-Path: <linux-kselftest+bounces-45333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBDDC4F08E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32C304E1992
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3436CDFB;
	Tue, 11 Nov 2025 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="uQ9ckRfz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNKrbOpE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AD17A2FB;
	Tue, 11 Nov 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878540; cv=none; b=lc7p1d2rjkXcGZorbzRpeLjSmiKCijKbjvJmiVFGrIcvRYCh1IRCl7BvyapA8So3M1PW8a1X0gI30VRbYCZ8LVJUjINWPA3LiwQI8VnN2DG6iKXO/9DmfY6KjVEv6LTa+psrmQKg/i7HcLlHOy+7keSUrsJG1xDJHRHysO4wrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878540; c=relaxed/simple;
	bh=igbCFNV88UsqLg7THUBcVdPg7porPF2EdXaVzR/K8+w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cxubzeAe+va9/c2O8plNExMOKrokicsyR2GLSv8/zYA6Kj5rDs4qTU+dyuFubt5EH/g3C4plCs0YXp8pyprkSNzFHhWjbCgtVhNf6hyQ2jAZ/Hz4oIXGbqIKc4Br2lULt9a1CRARoZuxcMjiVB+hz1+R3P9lcSQEmcuw6H4wLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=uQ9ckRfz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNKrbOpE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 594E6EC0239;
	Tue, 11 Nov 2025 11:28:57 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 11:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762878537;
	 x=1762964937; bh=EWTav2r45lk9UwrLdBHRN+uvdOUdm3NWQF7iSCcLMHU=; b=
	uQ9ckRfzGVUcw4GY4v7OiJUPgdCFvI26y6oO1jQbc0yap7oCEd61R/mijE80iYnD
	xjpRdUazppPBfCuCgAcul7rcctqk0v4JWQ1KA6QSNFJ4udXQ9ctr9Ukb9YQHvjpL
	BKGAUXycOhaQN2iF00mtztcbQUMAh5esthJ5cNJpfnd6SCtsoy0pc4r3Jjhe4IZ7
	m/jN5ZgpA1sJ+cxzBGYTfPLU5P4LGLQpunSHc9AZD9o3xhVLzsFhe0yeCsxDL/e8
	ME1XFvRegxA9J0Lj/cKYtsFoPbUrtXn65jktixMPGxVGG08NNRd2rltdRFxzVCzj
	Tg6xKAgJ9sLH5Q1bIMCJ4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762878537; x=
	1762964937; bh=EWTav2r45lk9UwrLdBHRN+uvdOUdm3NWQF7iSCcLMHU=; b=R
	NKrbOpE8BRqCvmWd+VebOEtMlLzXKMn/HXFJ/otPBLbk60sPGPf5IkMIze/EXIGE
	ZlxK0OYnLeBZNslTDyQ3+dewBYCwu5DDFKnPW4dav9uIa5QnKnY/Nbg6lLxq/lpQ
	jnoOp1NpB/WVA59NB1/wP1Q8r8eM3EWB1oHGnGyv9OfE1juOLnzBcZ9PINiU7R8+
	Kths9pimAwiNazgbIEEmcAZJNEN1MxESfBKmtegfjIRVhneju2dqkdHh5fpBwscg
	shHPJFfxlqYkwKT3Rkq23B56WTJE2P+McWbae3hFzRFlAwGdpsRsV+ITmgtzaBlf
	YdSxCOxPuHxLJBYNlkyIw==
X-ME-Sender: <xms:SWQTaQVxlsUeALUlBPHfhIOmTrmgxCwtddjepU-ByhN91XX6zMf9xg>
    <xme:SWQTafZww6x0IX5IYKkG2ZDtn2K1zJX6Sy3072HRToNs6MAcFdQZIZdwGReVEfVnb
    anydrNgoapBPkh4xNd5cNAw5hNh2-mVf5Zyxwu8mAPFRsCuzqaH0Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduieejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:SWQTaR8F0fRb2cEcpQtqpKFDnEdwB85SlC_JeNf2O7Z0CLKNpX0BQQ>
    <xmx:SWQTafxnevS_VGrqmoFYXFdv1BIzwv_X5VWRBUOBRU5LWtWB_5TAcw>
    <xmx:SWQTae4JtelLyquHE_7c-Kd6FOgiZhYeag7xugcQcIoHcJj-xJNIJg>
    <xmx:SWQTaW8J0kLCOy1xhr-CLc3PQtyIM6FfQkFxQjugV6UaQlIZOabBoA>
    <xmx:SWQTaQAoR3hVFF5NauOZrA-jZsLJRITwuyCwQsZqAziKyaJNCItFhMGb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E81C9700054; Tue, 11 Nov 2025 11:28:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5RixjiBPr7B
Date: Tue, 11 Nov 2025 17:28:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <226858d1-fa36-4fad-bb80-15852617c20a@app.fastmail.com>
In-Reply-To: 
 <20251111162059-734e18c4-f428-411c-afe3-87fb430fb64d@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
 <20251111-vdso-test-types-v1-4-03b31f88c659@linutronix.de>
 <29dd9e11-9ae8-415a-acb3-b96af56550b0@app.fastmail.com>
 <20251111144805-ab2781fe-5424-492b-9cb3-55ebaaedc199@linutronix.de>
 <a78a17eb-1df2-471b-9c28-64619c71dc54@app.fastmail.com>
 <20251111153707-0926c681-0b2a-4cc0-9074-acbe8a6371c2@linutronix.de>
 <2976374e-dd64-48ce-9726-56d97e94323c@app.fastmail.com>
 <20251111162059-734e18c4-f428-411c-afe3-87fb430fb64d@linutronix.de>
Subject: Re: [PATCH 04/10] selftests: vDSO: vdso_test_abi: Provide compatibility with
 32-bit musl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025, at 16:50, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Nov 11, 2025 at 04:07:58PM +0100, Arnd Bergmann wrote:
>> On Tue, Nov 11, 2025, at 15:46, Thomas Wei=C3=9Fschuh wrote:
>> > On Tue, Nov 11, 2025 at 03:19:00PM +0100, Arnd Bergmann wrote:
>
> On musl there is no SYS_clock_getres_time64 but instead there is
> SYS_clock_getres_time32.

Right. While this makes a lot of sense conceptually, it also
makes it harder to do anything portable based on those macros.

I have been wondering whether the kernel should do something
similar and replace __NR_clock_getres with __NR_clock_getres_time32
etc on 32-bit architectures unless a user specifically asks for
the compatibility macros. This would help avoid problems with
old source code using the traditional macros in combination with
the libc data structures. Unfortunately any change here also
causes new problems.

> Switching to __NR gives us back the more natural
> fallback logic. We are back at the nolibc 64-bit time functions.
> We can add a static_assert() to gain some compile-time safety.
>
> static int
> syscall_clock_getres(__kernel_clockid_t clockid, struct __kernel_times=
pec *res)
> {
> #ifdef __NR_clock_getres_time64
> 	return syscall(__NR_clock_getres_time64, clockid, res);
> #else
> 	/*
> 	 * __NR_clock_getres expects __kernel_old_timespec.
> 	 * Make sure the actual parameter is compatible.
> 	 */
> 	_Static_assert(sizeof(struct __kernel_old_timespec) =3D=3D sizeof(*re=
s));
> 	return syscall(__NR_clock_getres, clockid, res);
> #endif
> }
>
> And stick all of those wrappers into another helper header.

Ok, sounds good.

    Arnd

