Return-Path: <linux-kselftest+bounces-46357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDC9C7E5DD
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 19:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30F4A34607C
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C121B86C7;
	Sun, 23 Nov 2025 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWE9Ke45";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cBMKMT8u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F615E8B;
	Sun, 23 Nov 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923676; cv=none; b=NmhNpS2q9JmCibr/es4K3VknzSEk2UbDkriftUoz0raAcuZKncY2Fh1NWwc6q1gONm2qIIgsIXZVAlPwwHV38c9iC08WKr6cwrwkHcPFY1VuK8VNtSKvPAHkmtgRNuRxLsQF+XwqdRrQmwwFhwhD9DJEv6rci6YwKW7Yyye+vAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923676; c=relaxed/simple;
	bh=TYbYOLcMERh+enukEUubRJ91bcLR5ALo678X7amkbhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f0ererBrWPO1i9jrkzN8PoEFgdE/2vaG3UHh5S9Ds+dhlmcBsq0ZDMEIteozj2TCWSKe6rS/83n5mRMlhz1O1TVOiCpd8+cKmCntvSxiORyR82VI33rBklLqv+Lea7dJYUbo+vVViFlwyZ7yUCTrwbzz3DW+k6Oa//fOMCJNBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWE9Ke45; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cBMKMT8u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763923673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tI+G/3To6o6zgkIyctIgDOevE5B4OCcqbZ8GMSytGSA=;
	b=jWE9Ke453EtzrnIXgeNaMFY9yg6nwogpvGRKGNaeYl5mD+CiF61seZFzBysZOxBUdflUSy
	AcneD0E4ifJS+fOmaKK/Fuezx5Bic21W/yjDtX2XUEnkcq28NTSd+MUvvosCsFy/huCPsx
	e4ukRUlm1JDR3J+ccRNelpTH+Ai3VLRMzYS/t5H4y1aVCoef7g8HdQWh8fpV7hb4/ddPpF
	hMaCMo8HzwfZ0ny4JT/+QGmqf5EH7u1kk6evT+fvPDZhDvjGZ59NiLoulVHEIdbqhf9VZq
	qO+E+S6XExdGzyI23szAFgXFio0TfxpSg5FfNAcW98ereDiCLe3KFzLrIv2Hhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763923673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tI+G/3To6o6zgkIyctIgDOevE5B4OCcqbZ8GMSytGSA=;
	b=cBMKMT8uMxejLjJRcmxnxXb7zvKdYVD44xh8ZdDuqw3zeR/pUk+nW/WxD+gnBDQTAJBhyz
	iJGQBgvADSz0j3Ag==
To: kernel test robot <lkp@intel.com>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Waiman Long <longman@redhat.com>,
 Ryan Houdek <Sonicadvance1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 kernel-dev@igalia.com, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>
Subject: Re: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
In-Reply-To: <202511221454.rsysOoSt-lkp@intel.com>
References: <20251122-tonyk-robust_futex-v6-6-05fea005a0fd@igalia.com>
 <202511221454.rsysOoSt-lkp@intel.com>
Date: Sun, 23 Nov 2025 19:47:51 +0100
Message-ID: <87ms4cio14.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 22 2025 at 14:49, kernel test robot wrote:
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on c42ba5a87bdccbca11403b7ca8bad1a57b833732]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/futex-Use-explicit-sizes-for-compat_robust_list-structs/20251122-135406
> base:   c42ba5a87bdccbca11403b7ca8bad1a57b833732
> patch link:    https://lore.kernel.org/r/20251122-tonyk-robust_futex-v6-6-05fea005a0fd%40igalia.com
> patch subject: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
> config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20251122/202511221454.rsysOoSt-lkp@intel.com/config)
> compiler: arc-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511221454.rsysOoSt-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511221454.rsysOoSt-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> <stdin>:1627:2: warning: #warning syscall get_robust_list2 not implemented [-Wcpp]
> --
>>> <stdin>:1627:2: warning: #warning syscall get_robust_list2 not implemented [-Wcpp]

Lacks a COND_SYSCALL()

