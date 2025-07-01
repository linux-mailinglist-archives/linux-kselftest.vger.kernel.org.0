Return-Path: <linux-kselftest+bounces-36173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 008EFAEF313
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 11:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96CB7A5302
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1DD26A0CC;
	Tue,  1 Jul 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yBqEUq8z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6rpWolqS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E392B265CC8;
	Tue,  1 Jul 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361614; cv=none; b=NP52Q0ScTZaX8JCiBnM4QeGD3LGQe+dlHD08aEgkzwP5GRd1hL8brwtn3t1e8E5fJx7VEwp1FloAqcU4BwVGctZsf+9syx4xhcIlsFQiB8nFPnTfq0bwd/2m0XJbJQQVfUNG0IsSsKSzmb9Z5dfBOWeiuuCr/XfjcxwjtBfOPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361614; c=relaxed/simple;
	bh=KPY0cy7BQgcxhMXxnZUiQIEBB0cc7c0a4JDNyuonjmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERVvu+oZFghH+Bk8r4vfoMbWH2nPBwFB7ePHJv8HAaLqnBZizkCfyhB7uVo7Mkw88TahmAAG78DV30RMAWPhb2cixVV3oXmzPb2H38Af1s3sx2t5kzCAyFHFuBYjXi2wHYRywC9IOMlJmk+6Y5LTAVT8ZS3BMX1SKCDIXuU1WVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yBqEUq8z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6rpWolqS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751361611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPY0cy7BQgcxhMXxnZUiQIEBB0cc7c0a4JDNyuonjmY=;
	b=yBqEUq8zJY+V7UQhU6ToVH4fJCzKOo1Ji7GWudxWFNeRAclR7VQjG+cm5sprgb2qT2Evsv
	1xFJRcIElyzFp43Z8xCi3qf+Iq1F+JadETWOL7B6UPZ6pIMETdiIWoltAKByL0xhY8WH51
	wSo+z+XWi61AphDJQcl1wwxgTHa7P+jBS+RfF6x6KEXlb8X2/+jMr/H7R5zGPhX+j2IwtQ
	/vA7DuDZ6wcl4R0uku1w39Zcrn/4BHq9zxyfBAdRS7eOikzbL6mBZ3IEknsPa8tIhBnUtl
	Y2xWOXYNInO/YOctgYseUiQgs1U+QWbag3zSCYteTvq/0fRJzZA3+mPlb5Ya6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751361611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPY0cy7BQgcxhMXxnZUiQIEBB0cc7c0a4JDNyuonjmY=;
	b=6rpWolqS2daOkyj05IlcAgrXfFDlUgr/hfktAQo+wmlp2Qg2vvQpnLzSfEVHSRPR1V8de+
	ErhaIJk0cuIJBzBQ==
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Shuah Khan
 <shuah@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Peter Zijlstra
 <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, linux-api@vger.kernel.org,
 kernel-dev@igalia.com, Darren Hart <dvhart@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 1/7] selftests/futex: Add ASSERT_ macros
In-Reply-To: <96b3d0fa-7fd2-4d2b-a6d6-cc91ed1dca4e@igalia.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
 <20250626-tonyk-robust_futex-v5-1-179194dbde8f@igalia.com>
 <87ecv6p364.ffs@tglx> <96b3d0fa-7fd2-4d2b-a6d6-cc91ed1dca4e@igalia.com>
Date: Tue, 01 Jul 2025 11:20:10 +0200
Message-ID: <874ivwmfn9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27 2025 at 17:23, Andr=C3=A9 Almeida wrote:
> Em 26/06/2025 19:07, Thomas Gleixner escreveu:
>> On Thu, Jun 26 2025 at 14:11, Andr=C3=A9 Almeida wrote:
>>=20
>>> Create ASSERT_{EQ, NE, TRUE, FALSE} macros to make test creation easier.
>>=20
>> What's so futex special about this that it can't use the same muck in
>>=20
>> tools/testing/selftests/kselftest_harness.h
>>=20
>
> My previous version of this test used kselftest_harness.h, but Shuah=20
> request to keep consistency and don't use this header, giving that the=20
> rest of futex test doesn't use it:
>
> https://lore.kernel.org/lkml/fe02f42b-7ba8-4a3b-a86c-2a4a7942fd3b@linuxfo=
undation.org/

So proliferating duplicate and pointlessly different code is the
preferred option here?

Cleaning up the existing mess first before adding more would be too
sensible, right?

I'm lost for words, which is an achievement.

