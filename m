Return-Path: <linux-kselftest+bounces-46641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE428C8E752
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D24F3ADA25
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DAD26ED4F;
	Thu, 27 Nov 2025 13:28:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F5269806;
	Thu, 27 Nov 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250136; cv=none; b=WtLlaGazNTFTv9Sgup5vXlF5/mJobUMqE2KCIE8WXvMSyDDviYApcMNSUtlosr4fz7H+2LbXQUq2BRB7hBCXOj9sXiVxTv2kYmtR1eCQENfAdTpat4rTa2b5oK5RBdKi9VsBobQn4p/IwbvJSmdm5OBJvgoTx77lSWuY7F8w5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250136; c=relaxed/simple;
	bh=nxP4UdShtumCWAH9j9DpA24WgFBTsg6xZDJR5lr3bwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MQIqNTyaLso7CympdYCeFG3So0yFvfSZe+y1N8u0jGhwFakDKZ34PNxYsfuglmPn5xfl3VVQFg2JcvNkGLaFyUEB5mrW4sAO32qI9qkyCypREwvh45fhCPuCsQ7dWpodtZbqN2tPaw0HV+oAFRoLRIGCHTjZ3qvchIBHuYvVKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4F8A16F8;
	Thu, 27 Nov 2025 05:28:46 -0800 (PST)
Received: from [10.57.43.59] (unknown [10.57.43.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A4F63F66E;
	Thu, 27 Nov 2025 05:28:48 -0800 (PST)
Message-ID: <5997e6bb-4d69-46a7-821f-72d470f6ddff@arm.com>
Date: Thu, 27 Nov 2025 14:28:45 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/12] arm64: ptrace: Move rseq_syscall() before
 audit_syscall_exit()
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
 <20251126071446.3234218-5-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251126071446.3234218-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2025 08:14, Jinjie Ruan wrote:
> commit a9f3a74a29af ("entry: Provide generic syscall exit function")
> introduce generic syscall exit function and call rseq_syscall()
> before audit_syscall_exit() and arch_syscall_exit_tracehook().
>
> And commit b74406f37737 ("arm: Add syscall detection for restartable
> sequences") add rseq support for arm32, which also call rseq_syscall()
> before audit_syscall_exit() and tracehook_report_syscall().
>
> However, commit 409d5db49867c ("arm64: rseq: Implement backend rseq
> calls and select HAVE_RSEQ") implement arm64 rseq and call
> rseq_syscall() after audit_syscall_exit() and tracehook_report_syscall().
>
> So compared to the generic entry and arm32 code, arm64 terminates
> the process a bit later if the syscall is issued within
> a restartable sequence.
>
> But as commit b74406f37737 ("arm: Add syscall detection for restartable
> sequences") said, syscalls are not allowed inside restartable sequences,
> so should call rseq_syscall() at the very beginning of system call
> exiting path for CONFIG_DEBUG_RSEQ=y kernel. This could help us to detect
> whether there is a syscall issued inside restartable sequences.
>
> It makes sense to raise SIGSEGV via rseq_syscall() before auditing
> and ptrace syscall exit, because this guarantees that the process is
> already in an error state with SIGSEGV pending when those later steps
> run. Although it makes no practical difference to signal delivery (signals
> are processed at the very end in arm64_exit_to_user_mode()), the ordering
> is more logical: detect and flag the error first, then proceed with
> the remaining work.

Thanks for providing this separate patch with a detailed rationale!

> To make it more reasonable and in preparation for moving arm64 over to
> the generic entry code, move rseq_syscall() ahead before
> audit_syscall_exit().
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

