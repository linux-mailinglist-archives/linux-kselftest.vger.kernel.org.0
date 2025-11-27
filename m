Return-Path: <linux-kselftest+bounces-46646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE085C8E7DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CBB3B2888
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADFC27FD44;
	Thu, 27 Nov 2025 13:31:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585732798E6;
	Thu, 27 Nov 2025 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250261; cv=none; b=sU4K7J5y96Esc+9cibuMIdIO0Eq1NrxoqGbWWCKm7FGNKodUB55jSYqBtfHcgKm28Obp2mtk2tu8J/cpb5YgdMP9gbqi1vPzB8+ULwMS4SZ0EqPvrOZol8Dk+FcaAoSbnnPspJkCP0kGEgvSFIbxyrttJSh/9KoCH3PFd64xb9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250261; c=relaxed/simple;
	bh=Nxi6QamY+tXHbFTsJOvxm6MY4XMwJfJxT+uvqO4GGg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ncMN79267l3bZ4paI+bkXPR4s3gloTN1N2iFbWwQjANDGy5GKBKPYdhDFN1BSf8/bRLVQkUxJM9b5b2i5zKMT2pj/cm53TreN5Ykb01P3fKtulbqYD/iIe20uQ1vYaS3dY48l/vYOtkJLr0crGAXfXAsIiNnKb0AbsvoWB7OzxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F6CC1762;
	Thu, 27 Nov 2025 05:30:52 -0800 (PST)
Received: from [10.57.43.59] (unknown [10.57.43.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4786B3F66E;
	Thu, 27 Nov 2025 05:30:54 -0800 (PST)
Message-ID: <1fecc357-2d7d-4016-b70f-5789ff4a8262@arm.com>
Date: Thu, 27 Nov 2025 14:30:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/12] entry: Add
 arch_ptrace_report_syscall_entry/exit()
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
 <20251126071446.3234218-11-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251126071446.3234218-11-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2025 08:14, Jinjie Ruan wrote:
> Differ from generic entry, due to historical reasons, ARM64 need to
> save/restore during syscall entry/exit because ARM64 use a scratch
> register (ip(r12) on AArch32, x7 on AArch64) to denote syscall entry/exit.
>
> In preparation for moving arm64 over to the generic entry code,
> add arch_ptrace_report_syscall_entry/exit() as the default
> ptrace_report_syscall_entry/exit() implementation. This allows
> arm64 to implement the architecture specific version.
>
> This allows arm64 to implement the architecture specific version.
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

