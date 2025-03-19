Return-Path: <linux-kselftest+bounces-29406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF21A68360
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 04:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C787AB047
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85324E4B0;
	Wed, 19 Mar 2025 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Flbdykl6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882A24E4C3;
	Wed, 19 Mar 2025 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742353209; cv=none; b=natrB8p4rFjAtK3m/IrSu4+r9wpx1BwkljEos8N5yisHRU38V2wSGC6HQcnGOb+4wRzmf9Wiu2f58Qc8YixbSozvFerJXT+w5RjP2eHbd5FwbzzcYkZoybIw5ElpfgsEPEaedcKMK/HaCb8NnLx9inNQe56NXrBJp1zhoPwUWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742353209; c=relaxed/simple;
	bh=XmBYV97ddXCc98ClLrgIh2hgEfg+wCIW7Pq3F2K7xlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5+ZahB0DiyIIVjQbctOzmhOsLUlYfYQB85oFp5hFHyD40/Owd3zhvFYtNUhrrVVbFKaozbgWVBx1ohcDe0grv/JxJU7zn4MuoVgSI9xPfbmzexQBWJx0SnJWg1Hb9CORO1Oxi/VuYDxieuPfPhPy2nPsnVgRHxvqu24I1yW6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Flbdykl6; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742353201; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dX+b5dkCzHI7qs9K1pxSG/IA6mix1y1/JgVcfCigZ/o=;
	b=Flbdykl6JslvtwOJvj/78fil/uExxpeKXaFTo7R5/t6W6ERJVYNOxFLoFnQsYU9aoxdpwjM8jQpBFqdWT30YN/Pe8mBWmaeIFGm8I0D0PLqqgXyg3RdrOXPIZvLgETFJ/OQUlikFnv2BLhQPOt46M0OznAF6y8FSy2LTSj9O8WY=
Received: from 30.246.160.93(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WRzjqK-_1742353198 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 10:59:59 +0800
Message-ID: <0a70f4ab-cd83-434d-8dd2-486d58e5599a@linux.alibaba.com>
Date: Wed, 19 Mar 2025 10:59:57 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/pidfd: align stack to fix SP alignment
 exception
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>
Cc: baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com,
 brauner@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250312061557.28532-1-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250312061557.28532-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+ ARM maintainers for review.

在 2025/3/12 14:15, Shuai Xue 写道:
> The pidfd_test fails on the ARM64 platform with the following error:
> 
>      Bail out! pidfd_poll check for premature notification on child thread exec test: Failed
> 
> When exception-trace is enabled, the kernel logs the details:
> 
>      #echo 1 > /proc/sys/debug/exception-trace
>      #dmesg | tail -n 20
>      [48628.713023] pidfd_test[1082142]: unhandled exception: SP Alignment, ESR 0x000000009a000000, SP/PC alignment exception in pidfd_test[400000+4000]
>      [48628.713049] CPU: 21 PID: 1082142 Comm: pidfd_test Kdump: loaded Tainted: G        W   E      6.6.71-3_rc1.al8.aarch64 #1
>      [48628.713051] Hardware name: AlibabaCloud AliServer-Xuanwu2.0AM-1UC1P-5B/AS1111MG1, BIOS 1.2.M1.AL.P.157.00 07/29/2023
>      [48628.713053] pstate: 60001800 (nZCv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=-c)
>      [48628.713055] pc : 0000000000402100
>      [48628.713056] lr : 0000ffff98288f9c
>      [48628.713056] sp : 0000ffffde49daa8
>      [48628.713057] x29: 0000000000000000 x28: 0000000000000000 x27: 0000000000000000
>      [48628.713060] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
>      [48628.713062] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000400e80
>      [48628.713065] x20: 0000000000000000 x19: 0000000000402650 x18: 0000000000000000
>      [48628.713067] x17: 00000000004200d8 x16: 0000ffff98288f40 x15: 0000ffffde49b92c
>      [48628.713070] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>      [48628.713072] x11: 0000000000001011 x10: 0000000000402100 x9 : 0000000000000010
>      [48628.713074] x8 : 00000000000000dc x7 : 3861616239346564 x6 : 000000000000000a
>      [48628.713077] x5 : 0000ffffde49daa8 x4 : 000000000000000a x3 : 0000ffffde49daa8
>      [48628.713079] x2 : 0000ffffde49dadc x1 : 0000ffffde49daa8 x0 : 0000000000000000
> 
> According to ARM ARM D1.3.10.2 SP alignment checking:
> 
>> When the SP is used as the base address of a calculation, regardless of
>> any offset applied by the instruction, if bits [3:0] of the SP are not
>> 0b0000, there is a misaligned SP.
> 
> To fix it, align the stack with 16 bytes.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>   tools/testing/selftests/pidfd/pidfd_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index c081ae91313a..ec161a7c3ff9 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -33,7 +33,7 @@ static bool have_pidfd_send_signal;
>   static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
>   {
>   	size_t stack_size = 1024;
> -	char *stack[1024] = { 0 };
> +	char *stack[1024] __attribute__((aligned(16))) = {0};
>   
>   #ifdef __ia64__
>   	return __clone2(fn, stack, stack_size, flags | SIGCHLD, NULL, pidfd);


