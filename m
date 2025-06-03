Return-Path: <linux-kselftest+bounces-34212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C1FACC6B9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7467A43AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 12:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C422D4DC;
	Tue,  3 Jun 2025 12:35:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024EE1A0BE0;
	Tue,  3 Jun 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748954107; cv=none; b=U8dRoIkDJv7NsAaSNa/4Cz0Af+9WBzwttnu+EEUswtNo8G9d4lmV9mUOL8GU3eucV88KfMNZcm0j8IzDCwzlMiMhCAGhdtHunEfAo8YajyMhN3Ko5CfNcUJS20HnDM1JXpLASOORfvhTsb1Q/VXXN95I9kumR+fG2kQx4+TXcbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748954107; c=relaxed/simple;
	bh=34ur0U6vtA9C6kezmUaRFXNbvfQ0KUk517aG4VIHXww=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SUtymYOuzoTIYHMmERoDDVywxoQG2TUxPcXxWtXePx8lNP2eXp8b0FLqbFrBgkX4Enw+itYWs29OSR/oo/obY9s+IM7n/D++Y56ptp0vwBuvJfaDvsIwIqTYHSnneOvAndEm94Gy2FnDY1rDs5OcQziIj3scYQlyGTnUda5n9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bBVSK3nP7z1BFhD;
	Tue,  3 Jun 2025 20:31:13 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 78D9318007F;
	Tue,  3 Jun 2025 20:35:01 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 20:35:00 +0800
Subject: Re: [PATCH v2 0/3] KVM: arm64: selftests: arch_timer_edge_cases fixes
To: Sebastian Ott <sebott@redhat.com>
CC: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Colton Lewis <coltonlewis@google.com>, Ricardo Koller <ricarkol@google.com>,
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20250527142434.25209-1-sebott@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <adf8b877-7ca2-f60b-fb59-578c70d0e3c0@huawei.com>
Date: Tue, 3 Jun 2025 20:35:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250527142434.25209-1-sebott@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200017.china.huawei.com (7.202.194.83)

Hi Sebastian,

On 2025/5/27 22:24, Sebastian Ott wrote:
> Some small fixes for arch_timer_edge_cases that I stumbled upon
> while debugging failures for this selftest on ampere-one.
> 
> Changes since v1: modified patch 3 based on suggestions from Marc.
> 
> I've done some tests with this on various machines - seems to be all
> good, however on ampere-one I now hit this in 10% of the runs:
> ==== Test Assertion Failure ====
>   arm64/arch_timer_edge_cases.c:481: timer_get_cntct(timer) >= DEF_CNT + (timer_get_cntfrq() * (uint64_t)(delta_2_ms) / 1000)
>   pid=166657 tid=166657 errno=4 - Interrupted system call
>      1  0x0000000000404db3: test_run at arch_timer_edge_cases.c:933
>      2  0x0000000000401f9f: main at arch_timer_edge_cases.c:1062
>      3  0x0000ffffaedd625b: ?? ??:0
>      4  0x0000ffffaedd633b: ?? ??:0
>      5  0x00000000004020af: _start at ??:?
>   timer_get_cntct(timer) >= DEF_CNT + msec_to_cycles(delta_2_ms)
> 
> This is not new, it was just hidden behind the other failure. I'll
> try to figure out what this is about (seems to be independent of
> the wait time)..

Not sure if you have figured it out. I can easily reproduce it on my box
and I *guess* it is that we have some random XVAL values when we enable
the timer..

test_reprogramming_timer()
{
	local_irq_disable();
	reset_timer_state(timer, DEF_CNT);

	/* Program the timer to DEF_CNT + delta_1_ms. */
	set_tval_irq(timer, msec_to_cycles(delta_1_ms), CTL_ENABLE);

	[...]
}

set_tval_irq()
{
	timer_set_ctl(timer, ctl);

	// There is a window that we enable the timer with *random* XVAL
	// values and we may get the unexpected interrupt.. And it's
	// unlikely that KVM can be aware of TVAL's change (and
	// re-evaluate the interrupt's pending state) before hitting the
	// GUEST_ASSERT().

	timer_set_tval(timer, tval_cycles);
}

I'm not familiar with the test so I'm not 100% sure that this is the
root cause. But I hope this helps with your analysis ;-) .

Thanks,
Zenghui

