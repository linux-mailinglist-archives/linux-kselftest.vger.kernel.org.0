Return-Path: <linux-kselftest+bounces-46645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E953C8E79A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBB13B2195
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8A27F163;
	Thu, 27 Nov 2025 13:30:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597FD230996;
	Thu, 27 Nov 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250234; cv=none; b=Eefy16ezs47V1mohLaoh1kIovbuj+2jj0tidkwuin5yPOKNd1BrVCiQ3olxvmDiZHLfqjzu2m9v7r1i8P7UqfrBVcrmfnlsGNZnAMTiKNDI1ykdYbm6zpfS0b8u0BkyCfG/oF8JT3b51NdZm4gYqKy5Lj5bOjna/WI0xXHF3KnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250234; c=relaxed/simple;
	bh=NJWqv0MRisudxQACugsiUjdRyXY+ptplgDxQlbtp29s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CfoPtwP6dBkGyeBS+1SPfk+3W23TvAKL0gjqpbiSHul8YH99VhOJ+hYy+Y5qz6G2mAMtwM5RTYD95OFkANI58hy3EiLIRi0jfpM9XK8JDohbtLYe9wwP/H/Ljfw7gw3O6SWlKsUtdRP/4nN1UoD0i4djrKMp9GNU1mXdsYC0PNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E255175D;
	Thu, 27 Nov 2025 05:30:25 -0800 (PST)
Received: from [10.57.43.59] (unknown [10.57.43.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB8D63F66E;
	Thu, 27 Nov 2025 05:30:26 -0800 (PST)
Message-ID: <5b4f4cf7-75ab-4024-b02f-fb70b3bb151d@arm.com>
Date: Thu, 27 Nov 2025 14:30:24 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/12] arm64/ptrace: Use syscall_get_arguments()
 heleper
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
 <20251126071446.3234218-9-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251126071446.3234218-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2025 08:14, Jinjie Ruan wrote:
> The generic entry check audit context first and use
> syscall_get_arguments() helper.
>
> In order to switch to the generic entry for arm64,
>
> - Also use syscall_get_arguments() to get audit_syscall_entry()'s
>   last four parameters.
>
> - Extract the syscall_enter_audit() helper to make it clear.
>
> - Check audit context first, which saves an unnecessary memcpy when
>   current process's audit_context is NULL.
>
> Overall these changes make syscall_enter_audit() exactly equivalent
> to the generic one.
>
> No functional changes.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

As noted in v7, in subject: s/heleper/helper/

Otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

