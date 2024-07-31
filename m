Return-Path: <linux-kselftest+bounces-14576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328194373E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A741F2755B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD981649BF;
	Wed, 31 Jul 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FaNAh4m5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWZWuQ/j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946421607B7;
	Wed, 31 Jul 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458551; cv=none; b=RtOHgxg9oXPnQPKWA7PaN4OW/wrudM25lOOtAzFTpZR242hjn4b6yzfMU3oFsubiOpEbsCUkXsVi9uUVQzcXhiWO3R0fVE7YSQJLUHrIBq13jxObxvyqXQop+XkoyTX5palhkfgKG6j3Bkgk1Ucv93e7YsZcFWb15BwqspaggMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458551; c=relaxed/simple;
	bh=dOyZ1Sek8HoJU/p17Y2r+u7nuSiHoOF73MPvoL/r+QE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DLCepw3b3WB1wDStEoTJDpJMRP7dk3V0txEnKx2X6iOPxu8TkmXzHqqBN15TPI9g7UliuUFzz/R5+aqv1sOaUIw7lZUyt+5wWk7voK9ZPAIqo+AoaYpqHi+VDrWozHlqP/Gu0z959/poEAJ57i/ewa01do+ygPRURy+fM9WNZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FaNAh4m5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KWZWuQ/j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722458547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBVcrUhpLPegJjGqjS/cwXdw3G5n9gw3ZxokXCgffPg=;
	b=FaNAh4m5ehNCZjdVtIV95kJeXTvN5iYiatVr2VnW4AGjcrVIzMHtLce+eY63olidN/TJqT
	YVKG4q7A9e54i8ZVrh0b2lgoz+5K2v8MIBx4UYQ0ZZirVXmjN7napqcrZMn/bym9q3PamY
	4DbYVDgJRYmTG2XvePktMAYCfR0LQmAbKkbnUz/trrZyzVMqdbGZJn4Nqq0zh/1bXpshRm
	miyu9+FHzjVOk/w667785Pdq+aq5afYF5hh0rXb/fdGtrNq4w7z758KvGPKQQocoHFngB2
	ma/ulF/1KspaMg34ce/A8E1SgdEVFR1L730dqmz0bd8KFwIL5w+k0hcmUeVglA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722458547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBVcrUhpLPegJjGqjS/cwXdw3G5n9gw3ZxokXCgffPg=;
	b=KWZWuQ/jVRpzYRz0d2yIgm8/Fkvp89Hh2kUA68lQYhPNYmUXNW3J5hZv2fGkWJ3dY8kJJD
	js0MaYM/RmZ1v1BQ==
To: Bjorn Helgaas <helgaas@kernel.org>, Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, mochs@nvidia.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/1] selftest: drivers: Add support its msi hwirq checking
In-Reply-To: <20240731192436.GA76176@bhelgaas>
References: <20240731192436.GA76176@bhelgaas>
Date: Wed, 31 Jul 2024 22:42:27 +0200
Message-ID: <87sevp47kc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31 2024 at 14:24, Bjorn Helgaas wrote:
> On Wed, May 29, 2024 at 06:27:27PM -0700, Joseph Jang wrote:
>> Validate there are no duplicate ITS-MSI hwirqs from the
>> /sys/kernel/irq/*/hwirq.
>> 
>> One example log show 2 duplicated MSI entries in the /proc/interrupts.
>> 
>> 150: 0 ... ITS-MSI 3355443200 Edge      pciehp
>> 152: 0 ... ITS-MSI 3355443200 Edge      pciehp
>
> I don't know how ITS-MSI works, so I don't know whether it's an error
> that both entries mention 3355443200.
>
> 3355443200 == 0xc8000000, which looks like it could be an address or
> address/data pair or something, and it does make sense to me that if
> two devices write the same MSI address/data, it should result in the
> same IRQ.

That was an issue with truncation which got fixed some time ago:

  https://lore.kernel.org/all/20240115135649.708536-1-vidyas@nvidia.com/

> It seems like maybe this is a generic issue, i.e., if this is a
> problem, maybe it would affect *other* kinds of MSI too, not just
> ITS-MSI?

It's the same for ALL interrupts whether MSI or not.

The requirement is that for any interrupt chip all hardware interrupt
numbers related to a particular chip must be unique.

Adding a ITS-MSI specific parser is just wrong. It's a generic problem
and has absolutely nothing to do with ITS or MSI.

Aside of that the proposed parser does not even work anymore on 6.11
because we switched ARM[64] over to per device domains during the merge
window.

So if we want a selftest for the correctness of the hardware interrupt
numbers then it should grab the per interrupt sysfs entry 'chip_name'
and 'hwirq' pairs and do an analysis per 'chip_name' whether all
hardware interrupt numbers for a chip are unique.

Thanks,

        tglx

