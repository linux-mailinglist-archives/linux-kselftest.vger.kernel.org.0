Return-Path: <linux-kselftest+bounces-45917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D9C6BBC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DAFB4E3896
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAFC2FD1B2;
	Tue, 18 Nov 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GPRBc4ke";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FkX29SSL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59022FDC41;
	Tue, 18 Nov 2025 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502037; cv=none; b=eN63qBbVnbSQDG9S4UgfS5Z9NTKegioeOtBpP4sEcRdaq+lIvcgT6hfy+r3vN7UxZTy5Pvrm1+08Fvwm0FW0O+HEj8Bs0N+rALzPRd7H7d1gZPrrBoF7FiLog7GdyFAHzOO8oVZWliHaLfMy3j7nhkDz3Qi9mE4CEnMZdAoHRkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502037; c=relaxed/simple;
	bh=Vl3cdKjP26sMoMzS6fUYMm1UdiluXvV3MNOD7fYc2FU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DPX5MmIW2GluTDTzQrehMaqUevGseS7kfZkxSdCfH76bjgS9U7plizgWnL4VG++1wf8IyFzG2EDwyidckHGCgamd54x7O6izsks6AJbqIbI1dWmHo1abI/0Py4U/1Kgu2ZGiZXltix/IBilM9FwWkHal1lLAd3M6Yn0O0w7xLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GPRBc4ke; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FkX29SSL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C3D80EC01A8;
	Tue, 18 Nov 2025 16:40:33 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 16:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763502033;
	 x=1763588433; bh=kbWVlQZCtoMvrcuM7kpobytPmvOeBhZuuYLfB26eALI=; b=
	GPRBc4ke2uHnPpS7APu7bEsmFUfnQMHeGovzRNI22Ehy+UaJT/6ImyzDctIqJZrR
	9t/FdYeZlXiMav40JD3jHMEeFwzFLSnfe6ucxgMRrkInWSqL6G5WAfSp9XSyYloE
	KAk0ifWlSbJ2LswKR6/NL/iOJfK2vU0upvfaEzdGuIb4YcO/bkp7AYJS/e5Eqxq8
	CfxfiWcyeIlXoAqoLAyFlnj6QGgKcj6WCfwrXlyocHSopDx1k70LrxKZVQtbcKII
	j4CJ1kQf/B62IPScQmksYZ0o+zhalNzI33qrDtPFhA154TpdpeOPBi8O5WM0TWdU
	ruQ3ly5o7pUmGqVWk96LXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763502033; x=
	1763588433; bh=kbWVlQZCtoMvrcuM7kpobytPmvOeBhZuuYLfB26eALI=; b=F
	kX29SSLnPaRJ6uKGTDnMH8fwqAVLYo1679aM4pHRbv+fGuWtttf69fdcKHbeh9K/
	9c4ppJOA+Yxz16NJdFnLiRIlhKVVJJ2puupHwu63sBWTi88axeeVrv/L36NJcu82
	NDyNkEUvLp/Qm+Kffm0MQ+Q204YYj4gnXqPRlqNdkYPLnIP3BnUos8T6EDXTz+cl
	Gq87tZZaktP3idW/utc9AfG4Fh4oxBu+f9mF72ffedvi397E7E+lYv+Mpl7DIRep
	oQPNfJKn5N8lYMlRTKJoLRy/fzYjMZxey44g/ZynL+9YdbFGWGtFCyDUtZOIE1gO
	o3sjW71zOKejQnP/Pe/AA==
X-ME-Sender: <xms:0eccacFTvsMWk-wd3wnfOXJm90tDwOxklehUJrQT0Z0k-Yn_PF5ttQ>
    <xme:0eccaQLjw8bXjKHzQ_83Dft3Q5duEI8fd_-ZHRQ_sDl6LyG3Vi9rFV0aUUTnhgBRV
    Il6ZuL7NscvYLuZzOEFQrlsYLJEyqertMzKGFfZfEHsuBLSVc662Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvgedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:0eccaducuqgOvXfIcfhBZmF-3Qdps7gbuB5h0Ro8E57DpMcn1-g4Jw>
    <xmx:0eccaQjrklZePeEASmnQS6VpRvRSbfEYkqgmQ51JIK7vc25tge-wvg>
    <xmx:0eccaQqe8ereSj_ucW5Uj0ABJgfLVgZHXEojtzF4MVBz4Ro5S_PwXg>
    <xmx:0eccaVtBfgjKL3vMe1K1n6GuBCuWQtwMLACws9wFYT3lHOhBQUmvKQ>
    <xmx:0eccaTyQntBdR-dUiphIHB3FhTT7MuvbxMEaBCh2QlyLbZvGwqVzlAuA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E544700054; Tue, 18 Nov 2025 16:40:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ap118jhpfmOV
Date: Tue, 18 Nov 2025 22:40:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <6fbb952c-0119-4be7-8f65-9198330013e7@app.fastmail.com>
In-Reply-To: 
 <20251118145635-16c14d65-cc62-4c0f-bb2c-2cf7eb30b63c@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
 <20251113-vdso-test-types-v2-3-0427eff70d08@linutronix.de>
 <5826549e-88a8-429c-ad42-46aeada9d21b@app.fastmail.com>
 <20251114093245-04b5eb56-d3ed-486b-90ff-7c7ad5cfc7e7@linutronix.de>
 <22ec7315-49b2-4fde-bd2f-f24f2cfcec37@app.fastmail.com>
 <20251114102555-293562eb-f1f9-47e1-bc2d-59f26a7283fa@linutronix.de>
 <db53e96f-d0c4-4702-aee5-1c38c69074cd@app.fastmail.com>
 <20251118145635-16c14d65-cc62-4c0f-bb2c-2cf7eb30b63c@linutronix.de>
Subject: Re: [PATCH v2 03/14] selftests: vDSO: Introduce vdso_syscalls.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025, at 15:22, Thomas Wei=C3=9Fschuh wrote:
> On Fri, Nov 14, 2025 at 11:40:31AM +0100, Arnd Bergmann wrote:
>> On Fri, Nov 14, 2025, at 11:02, Thomas Wei=C3=9Fschuh wrote:
>> > On Fri, Nov 14, 2025 at 10:16:01AM +0100, Arnd Bergmann wrote:
>> >
>> > I don't think it is important. For my SPARC vDSO series I even
>> > dropped the regular clock_getres() after your request. But because =
it
>> > doesn't exist we need to handle the presence of vdso_clock_getres()=
 and
>> > the simultaneous absence of sys_clock_getres() in the test.
>>=20
>> But that is the other way round, right? On sparc32 we have
>> (optionally) sys_clock_getres() but never vdso_clock_getres().
>
> Here SPARC was just an example to show that I don't really care about
> clock_getres() in the vDSO in general.
> But if it was present before for an architecture and we now drop it wi=
thout a
> replacement, userspace developers might complain. Manually caching the=
 value
> in userspace sounds ugly and brittle, as it could even change at some =
point.
> Introducing a time64 replacement on the other hand wouldn't make much
> difference as the values never would exceed the 32-bit range anyways.
>
> So I would keep vdso_clock_getres() where it exists today even with
> CONFIG_COMPAT_32BIT_TIME=3Dn.

It is rather inconsistent with all the other interfaces though:
when we originally did the time64 conversion, there were a number
of interfaces that didn't really need a replacement, but we
deliberately made new interfaces wherever possible. For architectures
without time32 support, and for validating the time64 support,
it should be possible to build both kernel and userspace without
even defining the __kernel_old_time{_t,spec,val} types.

>> Right, but then I would make it return 'struct timespec', not
>> 'struct __kernel_timespec', because it's no longer the kernel
>> interface.
>
> 'struct timespec' might be only 32-bit, breaking the tests after y2038.
> While that shouldn't happen in actual y2038 it would be nice if we can
> validate the future behavior today without reconfiguring libc.
> Given that this is also no longer a libc interface, can't we just use
> the UAPI type?

It clearly works, it just feels a bit wrong to me as mixing up
the types and the interfaces is what caused the problem
originally.

> What is the general expectation for userspace using 32-bit interfaces
> after y2038 from the kernel's perspective?

I would hope that we'll end up turning off the fallback path
and eventually remove that code entirely as we get closer to
y2038, but not everyone agrees with that. An important
open question is whether we'd want to still support running
a 32-bit kernel from 2038+ with time32 userland but the RTC
backdated to 1970.

     Arnd

