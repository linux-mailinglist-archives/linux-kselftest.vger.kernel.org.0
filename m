Return-Path: <linux-kselftest+bounces-46317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4DC7D2CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9199B4E417D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 14:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84A23ED6A;
	Sat, 22 Nov 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VZG0JMgE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252572612;
	Sat, 22 Nov 2025 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763821576; cv=none; b=gSN8nSh3Czniqgng9byXjTzpfAUNSRQP4jpyQr5ObVyhVidtv8s22+CFUdaxrjqIS14+B4Q6hxZdC5ys0K1pWrsJ+bfTmrz+WBdICLViKEfPH9X6HNDhM9Fct2mWffTUxpgRoECDOZGVcaw9+eJ2SgsiyAFF3q5IzCW5isbE3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763821576; c=relaxed/simple;
	bh=x6aFQyq4A5TItYWPmsGZqckvwTm4JQXCOx8XonzIcd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+RNB+WgeFdgVNi3a5sxhOf3SqmBj+c/ZEK5FH4nYezeF24mbb/K7nE59pgZLvxwAKCkC4vgGZNd2mvXTN5AL7TXd5r3muHSwnUC1kQpT9bwZJoznGzW2Y08JhK65p5xIfQPQpkDcyWcgtD6beDIzSYksMa1o+04O3c77F1ofYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VZG0JMgE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yd7xeK0HzMK+GGxuruRiitBktevLsg+3P/pUegg/QOM=; b=VZG0JMgEmw86qklvBQZpQtdKbF
	9kUId39/Xiy1OYSm/LNGLni036AKPWv1ULPgQ9sXVV2vZFwBuiHktHSeUyZI6/X3PYxoml2GJJRPC
	mPAXnYRPnxOSYYlTagh+roKWuSTzo6zcw829z28I/uHA4rsHZOIAJ6We7Q2ASKFMqL7o0cRYqcGf/
	NnBFTLy4fDRoPxuZxZoStuJMUCacdvc29k9XiFg2h68lhFsBbSIH4WpHfhvcgxcgT/RHufXR2gHKK
	XlxrxEk0DZtIPZ33tW6ntfqllSDiVJCVqQgq854zPnawkKDAEizptZyh2p0On94gcr9aqKc5CK+z4
	aBp2A5dQ==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vMoYg-0044FO-WF; Sat, 22 Nov 2025 15:25:50 +0100
Message-ID: <32cbcdbf-c98e-4075-b5cd-a7e001de05b3@igalia.com>
Date: Sat, 22 Nov 2025 11:25:44 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] futex: Create {set,get}_robust_list2() syscalls
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <longman@redhat.com>, Ryan Houdek <Sonicadvance1@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, kernel-dev@igalia.com
References: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 22/11/2025 02:50, André Almeida escreveu:
> Hello,
> 
> This version is a complete rewrite of the syscall (thanks Thomas for the
> suggestions!).
> 
>   * Use case
> 
> The use-case for the new syscalls is detailed in the last patch version:
> 
>    https://lore.kernel.org/lkml/20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com
> 
>   * The syscall interface
> 
> Documented at patches 3/9 "futex: Create set_robust_list2() syscall" and
> 4/9 "futex: Create get_robust_list2() syscall".
> 
>   * Testing
> 
> I expanded the current robust list selftest to use the new interface,
> and also ported the original syscall to use the new syscall internals,
> and everything survived the tests.
> 
>   * Changelog
> 
> Changes from v5:
>   - Complete interface rewrite, there are so many changes but the main
>     ones are the following points
>   - Array of robust lists now has a static size, allocated once during the
>     first usage of the list
>   - Now that the list of robust lists have a fixed size, I removed the
>     logic of having a command for creating a new index on the list. To
>     simplify things for everyone, userspace just need to call
>     set_robust_list2(head, 32-bit/64-bit type, index).

Actually, this won't work well. The application that calls 
set_robust_list2() may be using glibc, that will also want to call 
set_robust_list2(), and there's no way to know which lists are being by 
each library. I will re-add the create/modify logic for the next version.

