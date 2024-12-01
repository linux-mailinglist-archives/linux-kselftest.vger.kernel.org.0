Return-Path: <linux-kselftest+bounces-22647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FE29DF565
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Dec 2024 12:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D9BB20EB2
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Dec 2024 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C74C130E4A;
	Sun,  1 Dec 2024 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vSD+fw1W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x0E8eqFF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99954740;
	Sun,  1 Dec 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733053137; cv=none; b=Pflj8q8F+zoolrHrStrlT3+4LjlQnZ0jhf8ddyD4ULaVdLsfQQ4rYYdQCHNCqCSZ3dmwMj/UEJN8KE4mvz5cYTSHj1SeqTBXsmakT8px7PqZC+O5gaxMCptmJ2c4SQ84WXtqWealvVM6CH3KfZKBCHzzHVN/392njmNbL2aAh6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733053137; c=relaxed/simple;
	bh=uaNCwrDOYRDsGZUgFSZpRE9jvo4dK15ZiOg+4i+cfRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BGFtTiS9/hg/MmyqHjkjrP2jpV+NQn/DUvOrlTQ/Om2gSJAMAu+Mr8UWQpeV1HbcaB6Eqxi0bv5/dmTQZ4/2AQZDTephkfUb0c5WaoqLdPQkNyecHVK1IzEh4910IziYlPF5IeXtU6D6J1zoCoPm0dY2tZ8utgXI8fjGgcPsl8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vSD+fw1W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x0E8eqFF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733053133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcupQt0sdYFNBC+Aof2tc9oLogrIPqFx4siJ56S0Zm4=;
	b=vSD+fw1W++a2CyF6D1DixR0Wo6IJJf5bRK9K7lBf6lfvPO3nX4gIUjoJ1go8289i+EcvYd
	v0321ohMbuZzS/VpPCtGcs+nR/wHcFk1JfSqRx1uQMLaObzrc8Cya1um7UPxhgXtvoUO3t
	mTCP49F6vGfa1BfIrt2zTtDSBfH698+QMpxTC6BGnbDZ7kTJnaceuxSWhi5SpL9szTYveT
	HLTHpXWDvkBjT0s5bFa1TiCXgbRHPwqXsEIOy2iFYT/uk7jtTWeyCWF6UxXkhFF0ON5s+h
	rljDE0YQ9byvVJeriXgAN3ENFDM5upxBHGSUKHK4fQ0GaHgq82FC/clS0UKVMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733053133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcupQt0sdYFNBC+Aof2tc9oLogrIPqFx4siJ56S0Zm4=;
	b=x0E8eqFFSn0V5YQ9fdyiIuzRkgAb/+2eLhA8EBvgf1NQGDnK172vHu8zNQzJziGRFfd0Vi
	QX+qhiH6h6bzdzAQ==
To: Bjorn Helgaas <helgaas@kernel.org>, Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, mochs@nvidia.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] selftest: drivers: Add support to check duplicate hwirq
In-Reply-To: <20241122175449.GA2433467@bhelgaas>
References: <20241122175449.GA2433467@bhelgaas>
Date: Sun, 01 Dec 2024 12:38:53 +0100
Message-ID: <87cyibws36.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 22 2024 at 11:54, Bjorn Helgaas wrote:
> On Mon, Nov 11, 2024 at 03:21:36PM +0800, Joseph Jang wrote:
>> We could not detect the duplicated hwirq number (0xc8000000) in this
>> case.
>
> Again, this is really out of my area, but based on
> Documentation/core-api/irq/irq-domain.rst, I assumed the point of
> hwirq was that hwirq numbers were local to an interrupt controller,
> i.e., to an irq_domain.

Correct.

But due to the truncation problem in pci_msi_domain_calc_hwirq() we
ended up with the same hwirq number for two different interrupts in the
same domain.

That said, I'm not really convinced about the value of the proposed
script as it just checks at a random point in time, which does not give
any meaningful test coverage.

I'd rather want to see a check in the irq domain code itself. At the
point where an interrupt is inserted, the irqdomain can validate that
there is no existing mapping for the hardware interrupt number. This
check can be unconditionally enabled as interrupt setup is not really a
hotpath operation and the lookup in the revmap or the tree is cheap.

Thanks,

        tglx

