Return-Path: <linux-kselftest+bounces-14592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A26943935
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 01:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365A61F2273C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF8816D9AF;
	Wed, 31 Jul 2024 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNatAXpP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7RO4tWle"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973B16CD27;
	Wed, 31 Jul 2024 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467542; cv=none; b=E8gih6MDH0cnJZ51zA8Hpu8sYJuXh4oxP01gss6K8+bL6R3dWWxHPzpJ1tLRdUFpQG/NTgGLUnOjFzsYIQqQg8nVS69u3ZToRiMQcsPDWsx2dRct9VFbk0/BnNSF3EiWah6N/8NZ6MRlAYjY82HpQsWDxlWPEcChF+JmCDM6M6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467542; c=relaxed/simple;
	bh=yTFNCo6dsHpaN6r1OgcB6s6GIEPGM96pH7z4v3J1TrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKYzMJY9DzldPG73z+6NbVNkEC4FoDVV95aTa0I2vO5H2xh6RWHnldqeEUtc59z0NH4l9WsQoNsPtk9DyIZffu4KWmpzUhZvxI7oKbG/TgNnAGiKma7/xS5stkjA8ZwKhRjRrARK2i+gSHYRjPM/kI9HxxArla+y3SaGN3OxQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNatAXpP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7RO4tWle; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722467538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYSYkJYx0g5ZV/EeanAUfppc8A9wc8Vu/gyG9KH/nOI=;
	b=rNatAXpPTdn8K+FwcHrdTjR+m5SoafikSNWQguPUxNfHkuHjiaQHRDrdLoAMfpcc6bBDvV
	m1XQ9g8ew6wsevZk/Zxt1Fijqbb0lRMfZN/JWQij7HfsLmrjOCpxBhLzD7q/HImgYVBvQ5
	L3i3sga7Ch7t6dTtibgW3nQDR7/cZVHZShLpaiHg54+EkAq4jiqTRvdHgULIapmOWt/G1O
	NwjnuhC+a10z06A8lCtC1iSYyNAufPS83gOTQYYSDnI6jHb5198oJDt7hLJQ9pz3MU0RE3
	yAl2f03ceHA6osDLbrkBKFil4VxBw31rd04WdTNijqwYa0lL3L5lOwFGPr2cMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722467538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYSYkJYx0g5ZV/EeanAUfppc8A9wc8Vu/gyG9KH/nOI=;
	b=7RO4tWleTldG4HxsvdmV72m9MRB0FlsuoFfJLFaC+dJn0bXaG1IhgBpKT1XRE9xaQEl7ab
	Zg9Mn+AxLkShmXAA==
To: Bjorn Helgaas <helgaas@kernel.org>, Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, mochs@nvidia.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/1] selftest: drivers: Add support its msi hwirq checking
In-Reply-To: <87sevp47kc.ffs@tglx>
References: <20240731192436.GA76176@bhelgaas> <87sevp47kc.ffs@tglx>
Date: Thu, 01 Aug 2024 01:12:17 +0200
Message-ID: <87ikwl40mm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31 2024 at 22:42, Thomas Gleixner wrote:
> Aside of that the proposed parser does not even work anymore on 6.11
> because we switched ARM[64] over to per device domains during the merge
> window.
>
> So if we want a selftest for the correctness of the hardware interrupt
> numbers then it should grab the per interrupt sysfs entry 'chip_name'
> and 'hwirq' pairs and do an analysis per 'chip_name' whether all
> hardware interrupt numbers for a chip are unique.

I just hacked up a 20 lines snake script to analyze it and indeed that
produces duplicates because some interrupt chips do not have unique chip
names as they are shared between interrupt domains and the chip names
are constant.

There are several ways to handle this:

  1) Amend /sys/kernel/irq/$N/chip_name with the irq domain name

  2) Expose the irq domain name in /sys/kernel/irq/$N/domain_name

  3) Utilize the existing /sys/kernel/debug/irq/ mechanism

#1 Does change the output of chip_name, but that is a kernel internal
   detail anyway so there is no real UABI concern.

#2 has the advantage that it does not change the output of chip_name but
   it consumes more memory for a dubious value.

#3 has the downside that it requires CONFIG_GENERIC_IRQ_DEBUGFS=y and is
   root only, but that should be not a problem for testing. We have other
   selftests which have Kconfig dependencies and root requirements. The
   upside is that it does not require kernel changes.

No real strong opinion either way, but all of that is better than a ITS
specific parser which fails to work on the next kernel version.

Thanks,

        tglx

