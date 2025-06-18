Return-Path: <linux-kselftest+bounces-35304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3628AADF33B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 18:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5D63B760D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EB32EF9BD;
	Wed, 18 Jun 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhRGpQQE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FnLPum5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1DA2FEE16;
	Wed, 18 Jun 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265807; cv=none; b=B1JY0qw/2m0juKCpRE3Cn7U9GHmIZo+tUolWaFn+SGE3WbUnXpl+ZJq1dq7LANl790Aoi9DqBDAky8bT92rBq90n+yxq4r8RFydyNJCBuTDD5L7bOY0TsUmdgs6GvGfBcRWABhD/q0M0rv76VQ13UfvTuEU6hT48eM28YQ5mEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265807; c=relaxed/simple;
	bh=2zYA68B4BlR5JyqqD0exROuKpDw3lBGK6GxBpriKEq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPRyOH63x5Os7fyTwcCfqtgNKwev+xbfikiEVqgta9bWIpVzcUs3PhZhydqY979GYoWFbdMH5Nc7n75EZ1u0PG7MNmvScXTvhFwNmWjuKdXW5HXxmcltnrvrqcMvdPBXw+12x0YNuWJAn07bMJltptDlSJdqXxTRw50kPvF36CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhRGpQQE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FnLPum5K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Jun 2025 18:56:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750265802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcfkTl8JDTYZY7FxB8pLQQahX1f+flMHTDcEtprjgLw=;
	b=bhRGpQQEaiz+bdjkTn8GYLQAEr9eORNBfGtlyUq2jO+HSGsNxTd78Pp4gi+6w0iVXkI4iv
	KhxJYxdwy3FENwUijepXCUeRT+UyafI9YiUA4IesPsrP6CA7zC+15piWbAS0HR2Fl+hrPL
	QJm4HxtD9Iko7KVfVnkc+Dwk0pRtGA+xpxfN6Q1x/FsiD/7cFKFXgVwqYDjwNMCpiwaxvn
	gdTCe+tyv67b2v5vxyUuldoNaWKdYfqyyVmCcBWpdc/Q/rdzwuCCXKZGreoE/ZtxwyFUeG
	cj9qH14glsnHjFZLi+zXyIZAGVJovyMJiQnrlwQMULYa0XYXQiMWkXU1U4L3PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750265802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcfkTl8JDTYZY7FxB8pLQQahX1f+flMHTDcEtprjgLw=;
	b=FnLPum5KScg44tzTCz7hYq/fT6kdP2Nk8gtEz9KwWCGH8xKl9n8aQ/0xq6b4dPs5YZ4gjr
	uRfakKI7LxvuWtDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH RESEND v4 0/7] futex: Create set_robust_list2
Message-ID: <20250618165641.bKu1_p0P@linutronix.de>
References: <20250617-tonyk-robust_futex-v4-0-6586f5fb9d33@igalia.com>
 <20250618070833._qeCcHLx@linutronix.de>
 <fd2b5bb2-590a-47ee-8e56-965a1d09b2fc@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fd2b5bb2-590a-47ee-8e56-965a1d09b2fc@igalia.com>

On 2025-06-18 13:39:46 [-0300], Andr=C3=A9 Almeida wrote:
>=20
> Ops, I forgot to address them. I will do it for v5.
>=20
> > - You say 64bit x86-64 does not have the problem due the compat syscall.
> >    Arm64 has this problem. New arm64 do not provide arm32 facility. You
> >    introduce the syscall here. Why not introduce the compat syscall
> >    instead? I'm sorry if this has been answered somewhere below but this
> >    was one question I had while I initially skimmed over the patches.
> >=20
>=20
> The main target for this new syscall is Arm64, that can't handle 32 point=
ers
> in the current syscall, so this new interface allows the robust list
> mechanism to know if it needs to do 64 or 32 bit pointer arithmetic
> operations to walk in the list.
>=20
> Introducing a compat syscall won't fix this, giving that it only works in
> x86-64. We need an entry point for Arm64 that can handle 32 bit pointers.

I would need to dig into details to figure out why it won't work for
arm64 and works only for x86-64.=20
There is the set_robust_list syscall as compat which sets
::compat_robust_list. And non-compat sets ::robust_list. The 32bit
application on 64bit kernel should set ::compat_robust_list which what
your syscall provides.
That is why I don't understand the need for it so far. Maybe I am
missing a detail.
We have other architectures with 64 bit kernel and a possible 32bit
userland such as mips, s390 or powerpc which would have the same issue
then. Or there is something special about arm64 in this case which makes
it unique.

Sebastian

