Return-Path: <linux-kselftest+bounces-46639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA468C8E743
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEAC54E193E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96623269806;
	Thu, 27 Nov 2025 13:28:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E382264F96;
	Thu, 27 Nov 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250093; cv=none; b=OZXPZQTb4hOWr2ooBfRJzfv/KXiGg2ZHKH83q4vRaXITIw81gxtRS3AGPirCn0Qu3Ic2CHUnaRQ7HDkwfWl5LGf+3KkSQVYI9RgFDfFXWKoy15qSKI4XT+51xD6Y0lidaRFPdgXSmtfgI8uIbEeTIo2Ai1/qKkfIY92G1HzLJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250093; c=relaxed/simple;
	bh=9s2UvXSm4i7julWWSBjWMXuoCaUx+KDLKxx1Nn8+iLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E8z75MXbiBKkEG3invhtghnIFbvFX/j07rLeXEO/H072sNUbGy2cMzRQLrpv4ktq+h512qM7NKEVdJ/VTqzZQE1yIUUT/HmFLPYzE0suNRV+bkdCaBeORozfbKfGCSIelsRgOcaJ22nHQDYwUKNSQI0iXf6uTIEegH0nbBOKnVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C0821570;
	Thu, 27 Nov 2025 05:28:02 -0800 (PST)
Received: from [10.57.43.59] (unknown [10.57.43.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 775903F66E;
	Thu, 27 Nov 2025 05:28:03 -0800 (PST)
Message-ID: <591e2e73-ec24-4ffa-b333-3459b59cd870@arm.com>
Date: Thu, 27 Nov 2025 14:28:00 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/12] arm64/ptrace: Split report_syscall()
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org,
 luto@kernel.org, shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 charlie@rivosinc.com, akpm@linux-foundation.org, ldv@strace.io,
 macro@orcam.me.uk, deller@gmx.de, mark.rutland@arm.com, efault@gmx.de,
 song@kernel.org, mbenes@suse.cz, ryan.roberts@arm.com,
 ada.coupriediaz@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 pengcan@kylinos.cn, dvyukov@google.com, kmal@cock.li,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251126071446.3234218-1-ruanjinjie@huawei.com>
 <20251126071446.3234218-3-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251126071446.3234218-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2025 08:14, Jinjie Ruan wrote:
> The generic syscall entry code has the form:
>
> | syscall_trace_enter()
> | {
> |	ptrace_report_syscall_entry()
> | }
> |
> | syscall_exit_work()
> | {
> |	ptrace_report_syscall_exit()
> | }
>
> In preparation for moving arm64 over to the generic entry code, split
> report_syscall() to two separate enter and exit functions to align
> the structure of the arm64 code with syscall_trace_enter() and
> syscall_exit_work() from the generic entry code.
>
> No functional changes.
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

