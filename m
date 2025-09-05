Return-Path: <linux-kselftest+bounces-40849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41F1B45C6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603161686DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B41C701F;
	Fri,  5 Sep 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nHqnhPzi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B871EFF80;
	Fri,  5 Sep 2025 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085676; cv=none; b=KF25GgWe1fPSyuQmgSGubMxAkjBSTy69OES5ZNmvRKfH36uJVEU9ljP/+gLtf48IECV9DRZwkyMC3gDlUEADky04iKzKHDKWsLfx15tBeleHoSntTNtN8AV4FPq6PcfrIFA1mz5BDS9utKpLUSbnazkpxrTEoPoGFKGH7B4elSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085676; c=relaxed/simple;
	bh=HwEB9zcB73yTaXaC7iNpOhKiQuq/DfF4LpQFqnl6AiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDutcDVrXDfVv1cgdpuON4rY5ycg9mcI0UlPQ2zU+Jv3vHTfi0zA5aa5mmoIDGZU6i9ztHO1lz8vdRGJtZV992px4rqVhI5Zbvy3SLD8kEhdlLjIdkbTuZDvbuicjec0DC+fRlzWLu2+fq+ou40HE7xINab3OXlRgS0WGS8k7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nHqnhPzi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DAMabG9hfGXPfyfTnl0j/cVmrEvKd8DLw2e1RyPu01Q=; b=nHqnhPzi04+FBhQ7f0yO9xD2KC
	c7lU/6vfxWpMVl3FtSA7IIBf3SYKnHP3999Qtg4193b8+KbglsjmyMyGYnNDrbTFUvYuVrZwJBx4d
	gA8pKXrEZCCn3MEDyGkpvn5b+bMFqBQBmcs0MoSAX2zfCelBPvGNazEVHNfIaYNYUOZBJkkmjo+2Z
	VoqfWdeL4GIxIQq477nxK0QNIwqqF3cXj7VW0A7VQxuHVKsQL1FY4jK5mw1DHHRVIxuRDepYoznz8
	VIH4b1BTnd4SMPh+r0E30he10URFgJs6Dz0ma2HhTMzVkUOwTxQuvOpCfNeQqo7AgsjW5gI32BvCN
	pWoM3cjw==;
Received: from [177.139.20.31] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uuYFH-007Lk8-Vk; Fri, 05 Sep 2025 17:21:00 +0200
Message-ID: <55a80c17-6fab-4a5e-82e7-25274c5d9579@igalia.com>
Date: Fri, 5 Sep 2025 12:20:55 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix -Wformat-security warnings in
 futex_priv_hash
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Shuah Khan <shuah@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Thomas Gleixner <tglx@linutronix.de>, Colin Ian King
 <colin.i.king@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "open list:FUTEX SUBSYSTEM" <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>
References: <20250905151734.12729-1-hsukrut3@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250905151734.12729-1-hsukrut3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sukrut,

Em 05/09/2025 12:17, Sukrut Heroorkar escreveu:
> Fix several -Wformat-security warnings in futex_priv_hash by passing
> the test message strings as arguments to %s format specifiers in
> ksft_*() logging functions.
> 
> This silences the warnings without changing the functional behavior
> of the test.
> 
>
This is already fixed upstream:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=locking/futex&id=f8ef9c24029c85cd0328a9c668283017d8c292ad

https://lore.kernel.org/all/20250827130011.677600-4-bigeasy@linutronix.de/

Thanks,
	 André

