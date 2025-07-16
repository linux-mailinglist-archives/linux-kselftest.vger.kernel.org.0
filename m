Return-Path: <linux-kselftest+bounces-37406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0362AB06E62
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 09:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF954A530D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 07:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0132877CD;
	Wed, 16 Jul 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wDCijffF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453853BE;
	Wed, 16 Jul 2025 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649258; cv=none; b=kXHXzAHVYAIBkLkm7bPvcfBvKIOV4ogRawv4whwc0XwlxhYgtGNfSttVP3wyPgjX4KLkzaYsXFmeII6G/kqkTmoBxvgw05igk2//OMlp+EAw2ZBDKYteG/rUksL2AITQzpx/rm8DwmR2NVke/HoAYgAdIhnRM5hyuXiXbtmbZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649258; c=relaxed/simple;
	bh=TODVAf6bMWKxws9hy9swJj0Vc+U1CCg0ajAqHBjPBSk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SK3ERLKZLaEIaKyhokiapTSBvDJcaaseZIUkifJDwaj9OlSozJZhJ7BL+iZsoz/Pk6xiFYJw2yodNOr6dlJUyQKqTM1GS8mLi3Ly2xGtUIxAPAzGvD9ectF8r2nn0IkzR7ppxpJbVNz97eDLmGVbn0UUe1pFmYkdPTs1etT7SPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wDCijffF; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752649251; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=bVLa1Kcib58l4NG5Ofy5IZrRqpUeoZqxvRab1vYbzG4=;
	b=wDCijffFVEaAUFdB/nXpG17I7Yb6ezaDZL46jX7OmsNo3p5qgdi3ME1jcUuJmp5QLWFG+Dvv2DQkMiKfosy3491ljpDQ9TP5rwFD2DJZphzKDlytjBYX4N1jrKdleaJt0vu5sL6Ik+9wNLQvj/e8i45v4pFlNJllVerFolilwgQ=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wj3A094_1752649250 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 15:00:50 +0800
Message-ID: <821acc51-1429-4625-bae5-daa67bddc7bc@linux.alibaba.com>
Date: Wed, 16 Jul 2025 15:00:49 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] selftests/pidfd: align stack to fix SP alignment
 exception
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Shuah Khan <skhan@linuxfoundation.org>, brauner@kernel.org,
 shuah@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com,
 catalin.marinas@arm.com, mark.rutland@arm.com
References: <20250616050648.58716-1-xueshuai@linux.alibaba.com>
 <ee095fdd-b3c1-4c41-9b06-a8e3695c1863@linuxfoundation.org>
 <0a8d5fdb-28b9-41f5-a601-cf36641bddbf@linux.alibaba.com>
In-Reply-To: <0a8d5fdb-28b9-41f5-a601-cf36641bddbf@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/19 10:26, Shuai Xue 写道:
> 
> 
> 在 2025/6/19 05:36, Shuah Khan 写道:
>> On 6/15/25 23:06, Shuai Xue wrote:
>>> The pidfd_test fails on the ARM64 platform with the following error:
>>>
>>>      Bail out! pidfd_poll check for premature notification on child thread exec test: Failed
>>>
>>> When exception-trace is enabled, the kernel logs the details:
>>>
>>>      #echo 1 > /proc/sys/debug/exception-trace
>>>      #dmesg | tail -n 20
>>>      [48628.713023] pidfd_test[1082142]: unhandled exception: SP Alignment, ESR 0x000000009a000000, SP/PC alignment exception in pidfd_test[400000+4000]
>>>      [48628.713049] CPU: 21 PID: 1082142 Comm: pidfd_test Kdump: loaded Tainted: G        W   E      6.6.71-3_rc1.al8.aarch64 #1
>>>      [48628.713051] Hardware name: AlibabaCloud AliServer-Xuanwu2.0AM-1UC1P-5B/AS1111MG1, BIOS 1.2.M1.AL.P.157.00 07/29/2023
>>>      [48628.713053] pstate: 60001800 (nZCv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=-c)
>>>      [48628.713055] pc : 0000000000402100
>>>      [48628.713056] lr : 0000ffff98288f9c
>>>      [48628.713056] sp : 0000ffffde49daa8
>>>      [48628.713057] x29: 0000000000000000 x28: 0000000000000000 x27: 0000000000000000
>>>      [48628.713060] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
>>>      [48628.713062] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000400e80
>>>      [48628.713065] x20: 0000000000000000 x19: 0000000000402650 x18: 0000000000000000
>>>      [48628.713067] x17: 00000000004200d8 x16: 0000ffff98288f40 x15: 0000ffffde49b92c
>>>      [48628.713070] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>>      [48628.713072] x11: 0000000000001011 x10: 0000000000402100 x9 : 0000000000000010
>>>      [48628.713074] x8 : 00000000000000dc x7 : 3861616239346564 x6 : 000000000000000a
>>>      [48628.713077] x5 : 0000ffffde49daa8 x4 : 000000000000000a x3 : 0000ffffde49daa8
>>>      [48628.713079] x2 : 0000ffffde49dadc x1 : 0000ffffde49daa8 x0 : 0000000000000000
>>>
>>> According to ARM ARM D1.3.10.2 SP alignment checking:
>>>
>>>> When the SP is used as the base address of a calculation, regardless of
>>>> any offset applied by the instruction, if bits [3:0] of the SP are not
>>>> 0b0000, there is a misaligned SP.
>>>
>>> To fix it, align the stack with 16 bytes.
>>>
>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>> ---
>>
>> Assuming this is going through Christian's tree.
>>
>> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> Let me know if you would like me to pick it up.
>>
>> thanks,
>> -- Shuah
> 
> Hi, Shuah
> 
> Thanks for your review.
> 
> I send this fix in Mar, but it missed last linux version.
> I think I need your help to pick it up.
> 
> Thanks.
> Shuai
> 

Hi, Shuah,

Gentle ping,

Thanks.
Shuai


