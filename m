Return-Path: <linux-kselftest+bounces-19147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49354992B90
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 14:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35741B220C1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A61D1E71;
	Mon,  7 Oct 2024 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f9ROVft7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RB/8Uwfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C441547D4;
	Mon,  7 Oct 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303733; cv=none; b=n/RP6cQ9sgsdo+BP9t8y8BIOyImALIH7hvm63y3mLLRrtQIMZ2kEFmuj8TFRAy1RAcxWmhtjMBkHFgaGQk26ZUO662SBnB7CG/a0IHXJ1+5XbcKvikChmMNcI1dDGAYMI1WJ8QS4Ru9fH0M8IHGJW5zBa58TBVh6knyk31kCEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303733; c=relaxed/simple;
	bh=DwH7ZNkOPfhY1o/iPZ5YTjnZ1h2+xxSZzKq/l6Ymbvs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NlXDabJYOpUnVyLAg4R17+32Mab7i0Vqm2SNLqOQPbnm1cMbwQ780ZSzORjZ6bcUlu3hEAJEdHD1pfkm4lLhjcGOEGDsG0jYncsrbFsA0I/OfEb7oiQzmA5UKIk5jwz4Zb/IOwEmz7xVwV4rlHyW3YNg+Fjo75cnAqlF5oz1bQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f9ROVft7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RB/8Uwfx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728303730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzoeHZNzvuiR/fKXzHPClhkbROvPhMF1uJDrJvUyL0I=;
	b=f9ROVft7X2UqHeEuMqP9vnD967aaQq2Hpn3gf3L9qjKB53HHvK8VDlDVXa9453m7BCDWr8
	i77GDM0d/WB+aVm4SDo1/HxLm56/6hnE2AKXquBpeG79/KU6pi6MVy3IE2PXv+6AoEjynV
	WWwtjj355/u/m0jqsXRFAAfgmryPBKPJiIcRBo/SVD+BTbToovhjasN++SJX4mBwUjn2dB
	EFKYGR2eGmf0sCF5loYwFdMKjkCMktn2jhf/gEc89lYwsXPPnJbH+rgt0CVJsjAazdxoPR
	pE0XacnaIqf1UP5xHEf7srxirl84csi1cMEZXUkdsI19vUBeZvizvYW311aWjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728303730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzoeHZNzvuiR/fKXzHPClhkbROvPhMF1uJDrJvUyL0I=;
	b=RB/8UwfxWyU26ILZ078mrNEWbQlGyrd2sDC4Sxt6zIyar/OSkvIwraYJ7jqHwpcL+zeQOs
	hK96gDHU1kpurIDA==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, David Gow
 <davidgow@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
Subject: Re: [PATCH 3/3] debugobjects: Use hlist_cut_number() to optimize
 performance and improve readability
In-Reply-To: <878qvya7u6.ffs@tglx>
References: <20240904134152.2141-1-thunder.leizhen@huawei.com>
 <20240904134152.2141-4-thunder.leizhen@huawei.com> <87jzfkbrgf.ffs@tglx>
 <5333927d-3f21-b7cc-8c57-6e21f1b4a3e5@huawei.com> <87bk0vbumx.ffs@tglx>
 <85a8aa26-f135-fdde-fadf-c2b38a563805@huawei.com> <878qvya7u6.ffs@tglx>
Date: Mon, 07 Oct 2024 14:22:10 +0200
Message-ID: <87v7y4t85p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 11 2024 at 10:54, Thomas Gleixner wrote:
> On Wed, Sep 11 2024 at 15:44, Leizhen wrote:
>> 2. Member tot_cnt of struct global_pool can be deleted. We can get it
>>    simply and quickly through (slot_idx * ODEBUG_BATCH_SIZE). Avoid
>>    redundant maintenance.
>
> Agreed.
>
>> 3. debug_objects_pool_min_level also needs to be adjusted accordingly,
>>    the number of batches of the min level.
>
> Sure. There are certainly more problems with that code. As I said, it's
> untested and way to big to be reviewed. I'll split it up into more
> manageable bits and pieces.

I finally found some time and ended up doing it differently. I'll send
out the patches later today.

Thanks,

        tglx

