Return-Path: <linux-kselftest+bounces-46640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA10C8E749
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D32784E34B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B026D26CE34;
	Thu, 27 Nov 2025 13:28:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF11269806;
	Thu, 27 Nov 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250112; cv=none; b=YbIhmQ6uWMw1q8h9uRHTx+RuYTNVYKbB4WNMGaWaDC/+J7sTsQGcI9+PK6D7nml9//OAmjjzdnqJ5lQOHO87O0oaZgpTTwP7hRxfpSYEiqEHyBXizNr/eQGARKfBdBO1WaMz8TPW5ZlpA3GFyj4V98VrCla8cGz9S97Rr/HxZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250112; c=relaxed/simple;
	bh=KYAeEqs9hFthiP49Vp2SiCJyHlrjEEVYrXQUvgkaPQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qs6PpHKHPk1lMxk/K8kVuK0UODal6FFPQm2SSKzeimUtYJMg+qgZfKi59frjfEB0aoU3uBKI1101qe75o29xdZ2yUIz6FQYTxhGXVgjwIjI/v2uKFkdBpAjOE/iRGPmFj3Yc4YxZ+arG+nCGN3uDP6SbH+aw+q/eeDZQYR5Z6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9110168F;
	Thu, 27 Nov 2025 05:28:22 -0800 (PST)
Received: from [10.57.43.59] (unknown [10.57.43.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 761623F66E;
	Thu, 27 Nov 2025 05:28:24 -0800 (PST)
Message-ID: <00c60250-f642-4299-b6bd-805e7e58b9e9@arm.com>
Date: Thu, 27 Nov 2025 14:28:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/12] arm64/ptrace: Refactor
 syscall_trace_enter/exit()
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
 <20251126071446.3234218-4-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251126071446.3234218-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2025 08:14, Jinjie Ruan wrote:
> The generic syscall entry code has the following form, which use
> the input syscall work flag and syscall number:
>
> | syscall_trace_enter(struct pt_regs *regs, long syscall,
> |		      unsigned long work)
> |
> | syscall_exit_work(struct pt_regs *regs, unsigned long work)
>
> In preparation for moving arm64 over to the generic entry code,
> refactor syscall_trace_enter/exit() to also pass thread flags, and
> get syscall number by syscall_get_nr() helper.
>
> No functional changes.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

