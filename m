Return-Path: <linux-kselftest+bounces-46360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF834C7E6ED
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 21:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 474FB345DE0
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 20:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7B261B71;
	Sun, 23 Nov 2025 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CLr4w+EI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GnxbGwP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E731E7C08;
	Sun, 23 Nov 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763928133; cv=none; b=uxys8Zhb21qHj0/CPtAdMDlo5rma9NdBVqw/jUG42ygCR9qVbSF2qRSUlKi2wFrM1+IjXLEvpKNlIhuuZCBDolg9wvB7T/LtahmBG2y9a9zNHO0wbLhL1f61G+SU2PwG0Lgi1gQh/qk6mqYGGIo+MiCkKIpJX2NmW+KelbLMK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763928133; c=relaxed/simple;
	bh=F3GuzaZscKcz2i4B2SSFistEug+/34/3N87ema8im4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mOkOI2WsNzO2e0sc6ed+pq0+978C1vfBobf+2rdt3XzFEcAezEp9Zj/qYCSAv1RfEwHdH9R6Jl7B6mcQEr2jdNt4E7Qp4eQx+ByMIG3DxT1TkBr+RQwPMf2bPqQWKb626IuuvhbPP4LfQ0JwudfVflaM5nzpe6466v9pWY2kwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CLr4w+EI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GnxbGwP2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763928130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nc4X29K4gmWMDQv5iAIKVGHKqb9bsyOwWA1vx5q2bxw=;
	b=CLr4w+EIKY3htKNF+HNBSplviqNNZK93+fyvtV6GRRvsPkmrrdbBK+LzWJqZ3Iz1XyWtwg
	xlWPy6m1E4Zzd3Pr/T2S19CWGV9UzW0r67LlibvEs9BZiap0MgAdWAfuEcR33nU5ZLjCZR
	UJxIVkYi7ybQkD5AM9j3GKjBzYhEowLobgIpgj20AuP45c7DPged94HrHefKuQKRBWHu4d
	0O4UvqPj7nALDpxBRjcUqIBH65cDMKLINnLLLI9FvV0d6fWhV5MfUQOt9typZy3mOD11H1
	bWFIctHwmGUpXbVD0iGVRN4dGtQUJyg2E0JnhoNgRsIa3Ql3heEl5pJVu91oWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763928130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nc4X29K4gmWMDQv5iAIKVGHKqb9bsyOwWA1vx5q2bxw=;
	b=GnxbGwP22UmW38kOzrstcqCxFTe3uCSiwHjXhoBSKdlFt6Tq+YBKMhN5vaOrD+MXMD1EnA
	+vhvKNf67jUXv2CA==
To: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
 =?utf-8?Q?Andr=C3=A9?=
 Almeida <andrealmeid@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Waiman Long <longman@redhat.com>, Ryan Houdek
 <Sonicadvance1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
In-Reply-To: <326957b0-fbce-4850-a8fb-8eed90fc4fae@app.fastmail.com>
References: <20251122-tonyk-robust_futex-v6-6-05fea005a0fd@igalia.com>
 <202511221454.rsysOoSt-lkp@intel.com> <87ms4cio14.ffs@tglx>
 <326957b0-fbce-4850-a8fb-8eed90fc4fae@app.fastmail.com>
Date: Sun, 23 Nov 2025 21:02:09 +0100
Message-ID: <87jyzgikla.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 23 2025 at 20:19, Arnd Bergmann wrote:
> On Sun, Nov 23, 2025, at 19:47, Thomas Gleixner wrote:
>> On Sat, Nov 22 2025 at 14:49, kernel test robot wrote:
>>> kernel test robot noticed the following build warnings:
>>>
>>> [auto build test WARNING on c42ba5a87bdccbca11403b7ca8bad1a57b833732]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/futex-Use-explicit-sizes-for-compat_robust_list-structs/20251122-135406
>>> base:   c42ba5a87bdccbca11403b7ca8bad1a57b833732
>>> patch link:    https://lore.kernel.org/r/20251122-tonyk-robust_futex-v6-6-05fea005a0fd%40igalia.com
>>> patch subject: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
>>> config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20251122/202511221454.rsysOoSt-lkp@intel.com/config)
>>> compiler: arc-linux-gcc (GCC) 15.1.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511221454.rsysOoSt-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202511221454.rsysOoSt-lkp@intel.com/
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> <stdin>:1627:2: warning: #warning syscall get_robust_list2 not implemented [-Wcpp]
>>> --
>>>>> <stdin>:1627:2: warning: #warning syscall get_robust_list2 not implemented [-Wcpp]
>>
>> Lacks a COND_SYSCALL()
>
> No, it's actually
>
> scripts/syscall.tbl
>
> that is missing, which means that the newer architectures
> are missing the update. This used to be include/uapi/asm/unistd.h,
> which still exists but is now unused.

So it's both. That syscall depends on CONFIG_FUTEX, which means
COND_SYCALL() is required and it's actually added in patch 9/9 while 5/9
which adds the set() variant adds it right away :)

Thanks,

        tglx

