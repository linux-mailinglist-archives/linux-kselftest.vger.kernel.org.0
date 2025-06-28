Return-Path: <linux-kselftest+bounces-36034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2202AEC65F
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 11:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939751897E0F
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D7E23372C;
	Sat, 28 Jun 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="UrhL/Bgr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9319E992;
	Sat, 28 Jun 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751102970; cv=pass; b=G2qu2pRgqAFkzywvWCSR5HbmJO5Vvl4KHD0Ca3tam/AZ7lYUqqV6/aAlr9dcSUYHgfn1A/wHUVFnkrT4eAFcxWpny4NazFyhGAUZpEi23ZgIophz3kFzLPGZiCfHHGiyzk69sK7Mem9uPq0W7qsBhGyVvFo/eEU6BJERMi1fy/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751102970; c=relaxed/simple;
	bh=wUXnKzgbvtT25rCDfOYl322+9yAQAx3rHgAkzEYbFz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mogueLBky8OOvsPl2pFwrJ4qJRsqThOzO+P2aiF5z40dL+iekZCbOUO1u6/WZPxpGkDp19ieb9umuDwfP4L3bfMb9qBb8s+CgQmddAJ6S1G78+9P09a98thvKNPv4SQaTAyaJo2OLtXfwMbLfeD2xUDvIvuxesgzP22/yphlg34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=UrhL/Bgr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751102930; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cWbUTuWqB9x2sQD3DIK5xq7PDr62IZitZP2Wdt6o1RFVmaR/CqqGfW9OAVlsdI1jDIN22VcmTRA/tHNtEHjqKWGv6Rgz9LaKYH7MJMDcrQWtho+AHDpuGdOoWmz5GYrqPbuqV67ARPxCfu9wLf2mxyYOSCkO0c8dGUgV8VdRzCM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751102930; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oVePXl2d+XiNoZkk1lUmaWYsXq/VWl9Vy7svJjVL9LI=; 
	b=a56zD+GTz269d+12+O2dfrFkw1CVH3BlJR1Ix2Qw1Nzo6Tukp/GpqZzdP7r/JL8PZi4YEcJ6cS2laDOgsr/katT6gfuW5eEPprSDz86T4W95r5kccDVTOqurAt3J8fOecgUuuRvuUKQPfKV0b3/l83CnRY03rI+Ly8F23EXiZa8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751102930;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oVePXl2d+XiNoZkk1lUmaWYsXq/VWl9Vy7svJjVL9LI=;
	b=UrhL/Bgrv5vFpriKD1Sojazt8POylqsVk+uwQ8auhjzc7dBlus/3X2MfMbyT6I9/
	ltH0EP8h/efaPN6IWr1njkxyOUybQn5Vy8m8FRnbePiWSRbZYWn303eVYTk1MqtU4q4
	436xzCb/V936rImYgLWtkignd2XvJcLHh7r/wiWo=
Received: by mx.zohomail.com with SMTPS id 1751102928164588.2772597295957;
	Sat, 28 Jun 2025 02:28:48 -0700 (PDT)
Message-ID: <0b5231e2-8dd0-4bbf-a0d3-0f6460bc8030@collabora.com>
Date: Sat, 28 Jun 2025 14:28:42 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: futex: define SYS_futex on 32-bit
 architectures with 64-bit time_t
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tim609@andestech.com,
 Cynthia Huang <cynthia@andestech.com>
References: <20250627090812.937939-1-ben717@andestech.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250627090812.937939-1-ben717@andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 6/27/25 2:08 PM, Ben Zong-You Xie wrote:
> glibc does not define SYS_futex for 32-bit architectures using 64-bit
> time_t e.g. riscv32, therefore this test fails to compile since it does not
> find SYS_futex in C library headers. Define SYS_futex as SYS_futex_time64
> in this situation to ensure successful compilation and compatibility.
> 
> Signed-off-by: Cynthia Huang <cynthia@andestech.com>
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> Changes since v1:
>   - Fix the SOB chain
> 
> v1 : https://lore.kernel.org/all/20250527093536.3646143-1-ben717@andestech.com/
> ---
>  tools/testing/selftests/futex/include/futextest.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
> index ddbcfc9b7bac..7a5fd1d5355e 100644
> --- a/tools/testing/selftests/futex/include/futextest.h
> +++ b/tools/testing/selftests/futex/include/futextest.h
> @@ -47,6 +47,17 @@ typedef volatile u_int32_t futex_t;
>  					 FUTEX_PRIVATE_FLAG)
>  #endif
> 
> +/*
> + * SYS_futex is expected from system C library, in glibc some 32-bit
> + * architectures (e.g. RV32) are using 64-bit time_t, therefore it doesn't have
> + * SYS_futex defined but just SYS_futex_time64. Define SYS_futex as
> + * SYS_futex_time64 in this situation to ensure the compilation and the
> + * compatibility.
> + */
> +#if !defined(SYS_futex) && defined(SYS_futex_time64)
> +#define SYS_futex SYS_futex_time64
> +#endif
> +
>  /**
>   * futex() - SYS_futex syscall wrapper
>   * @uaddr:	address of first futex
> --
> 2.34.1


