Return-Path: <linux-kselftest+bounces-47585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 444A2CBE9E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 16:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A880C3000798
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCFC33436D;
	Mon, 15 Dec 2025 15:24:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3426B2ECEBB;
	Mon, 15 Dec 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812282; cv=none; b=gmUKhVsoF1+Kp/kR77QHfOX/Mz8EOzAK3mrSzRrmaKpGwiJNPlrPYJ2Dk4gS59ccAIc8esD3b7+as+f7j2qfbgKdllQkb+2MfIhD8dsxH4+kMSIbDQDD75yN/B56BPwlA52Fo4rNMQuPs3ebkH9j03iTXTUwjrC49dFzmDcL0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812282; c=relaxed/simple;
	bh=/S+MkuXW2RUNMhk1k2UCBwhsYOX0AgvmqjnXZswu97I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TlsOw75/HVyecqMToJaJ1U3LZH7UC318SmYRVVjK+RNWYomXZoLIJnM8u1U1ggBOZxdSlbUBEnLP08fj3qam1qF3pk4Y076K/ubph//iwYhbjktp8H9vvVSRv6iwJsjg3B5CVi5ue/04Zx+EbUs6LNg7QF/ajKGoQAgEYfLYYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E79E7497;
	Mon, 15 Dec 2025 07:24:31 -0800 (PST)
Received: from [10.57.44.51] (unknown [10.57.44.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF76C3F73B;
	Mon, 15 Dec 2025 07:24:33 -0800 (PST)
Message-ID: <9f6fc1db-5579-4aef-8deb-808ae83f3266@arm.com>
Date: Mon, 15 Dec 2025 16:24:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/16] arm64/ptrace: Return early for
 ptrace_report_syscall_entry() error
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org,
 luto@kernel.org, shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 deller@gmx.de, macro@orcam.me.uk, charlie@rivosinc.com, ldv@strace.io,
 mark.rutland@arm.com, song@kernel.org, ryan.roberts@arm.com,
 ada.coupriediaz@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 pengcan@kylinos.cn, dvyukov@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-4-ruanjinjie@huawei.com>
 <52f63e40-541f-4ed8-9d05-626eab4b39cb@arm.com>
 <051fe45b-f158-85be-3f8e-60c830fb47a2@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <051fe45b-f158-85be-3f8e-60c830fb47a2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/12/2025 05:00, Jinjie Ruan wrote:
> On 2025/12/9 21:46, Kevin Brodsky wrote:
>> On 04/12/2025 09:21, Jinjie Ruan wrote:
>>> The generic entry abort the syscall_trace_enter() sequence if
>>> ptrace_report_syscall_entry() errors out, but arm64 not.
>>>
>>> As the ptrace_report_syscall_entry() comment said, the calling arch code
>>> should abort the system call and must prevent normal entry so no system
>>> call is made if ptrace_report_syscall_entry() return nonzero.
>> This patch is now in the right position, which means that arm64 does
>> abort the syscall already without this patch. What we're changing here
>> is that the tracing sequence is interrupted. The comment you're
>> referring to says nothing about tracing so I'm not sure it helps to
>> refer to it.
> I think “must prevent normal entry ”means When ptrace requests
> interception, all subsequent processing, including audit and seccomp,
> should completely bypassed.

Fair enough, let's just make sure the commit message doesn't imply that
arm64 performs a syscall before this patch.

- Kevin

