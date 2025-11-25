Return-Path: <linux-kselftest+bounces-46434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5ADC851B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 14:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BDC3AA719
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AFF3246EB;
	Tue, 25 Nov 2025 13:06:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D1A320CA2;
	Tue, 25 Nov 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076013; cv=none; b=nXgeZwYffWiKVjG2Zx8WuGrW16R2jLMNOiNJcDUD+vyRKux8J0tzxWc9mQ1f04gtMHJ+BpqAiARFVeqfI4vtEIkNCkHQBLF7JYwKuPPH+Zi/cM2YwuKd1qK8ugGjgPYw4eqpA6qUQliCfk7iUb3Ej7Vy3SPLyDlO+rDNIQE9d/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076013; c=relaxed/simple;
	bh=a3AtTs6m1zk1Nyf1/3CeNVcPmtiifQMmtV/uuSbCFqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cUe3nB9n0umw8CqoQDGSQcxlKK9dR80+TcU9cPaCsGjiHIn0DB83Pxj996yZWZWddYD3/JDD3BbeygYvsBj9XDj1OXBLthKuMKKzpl4VRhSG05Bp3xu9xqv05bm7yBtjc92M15ebNj5vlFugk3UcVy5gmhbChU3V++UTF/Tn+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1494314BF;
	Tue, 25 Nov 2025 05:06:43 -0800 (PST)
Received: from [10.44.160.56] (e126510-lin.lund.arm.com [10.44.160.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2492B3F73B;
	Tue, 25 Nov 2025 05:06:43 -0800 (PST)
Message-ID: <c7032b82-12b3-4334-b568-86cf620c2ee7@arm.com>
Date: Tue, 25 Nov 2025 14:06:40 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/11] arm64/ptrace: Split report_syscall()
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org,
 luto@kernel.org, shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 akpm@linux-foundation.org, ldv@strace.io, macro@orcam.me.uk, deller@gmx.de,
 mark.rutland@arm.com, song@kernel.org, mbenes@suse.cz, ryan.roberts@arm.com,
 ada.coupriediaz@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 pengcan@kylinos.cn, dvyukov@google.com, kmal@cock.li, lihongbo22@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251117133048.53182-1-ruanjinjie@huawei.com>
 <20251117133048.53182-2-ruanjinjie@huawei.com>
 <970d9689-4188-4c40-92e6-bdf1e589e8a2@arm.com>
 <9adaa51a-09d1-8450-afb0-838ace0f28e9@huawei.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <9adaa51a-09d1-8450-afb0-838ace0f28e9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/2025 10:49, Jinjie Ruan wrote:
>
> On 2025/11/19 1:09, Kevin Brodsky wrote:
>> On 17/11/2025 14:30, Jinjie Ruan wrote:
>>> The generic syscall entry code has the form:
>>>
>>> | syscall_trace_enter()
>>> | {
>>> |	ptrace_report_syscall_entry()
>>> | }
>>> |
>>> | syscall_exit_work()
>>> | {
>>> |	ptrace_report_syscall_exit()
>>> | }
>>>
>>> In preparation for moving arm64 over to the generic entry code, split
>>> report_syscall() to two separate enter and exit functions to align
>>> the structure of the arm64 code with syscall_trace_enter() and
>>> syscall_exit_work() from the generic entry code.
>>>
>>> No functional changes.
>>>
>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>  arch/arm64/kernel/ptrace.c | 29 ++++++++++++++++++++---------
>>>  1 file changed, 20 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>>> index 4b001121c72d..5534c175ceb7 100644
>>> --- a/arch/arm64/kernel/ptrace.c
>>> +++ b/arch/arm64/kernel/ptrace.c
>>> @@ -2317,7 +2317,7 @@ enum ptrace_syscall_dir {
>>>  	PTRACE_SYSCALL_EXIT,
>>>  };
>> This is now unused so it should be removed.
> Sure.

In fact it is not unused, not sure how I missed that... r12/x7 is set to
one of those values during ptrace_syscall_entry().

It would be a good idea to add a comment saying those values are part of
the ABI and must not be changed.

- Kevin

