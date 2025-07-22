Return-Path: <linux-kselftest+bounces-37792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6841CB0CF25
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 03:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5D654626D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 01:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52301A256E;
	Tue, 22 Jul 2025 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qqJxG486"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF62E370E;
	Tue, 22 Jul 2025 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148236; cv=none; b=Wu245enc+qwR0QX7BDhrUpK0eQdgUfowiuJo795FUz+qHbJV1QsBpv3mBrwCIpQ2WuJgZlDKz/I4HX6V4ktDgQ9PQU+tgrnK3iPIGStKKFmGKVoHAqAUxVtswcBRBO7S4P5z/LkShSdMPPJFOV43ZgEwqsHjl+PBmZMM3nUJoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148236; c=relaxed/simple;
	bh=ByZxmRZPo6y9Q+OY8IiuEXxxlvn/7jgaLw4erEtYFng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDGmQZLAlhVurYyOcbzg/ZDNNw8p9zZe9eiisbDb++0l/4SZnhFFqIcRS0YsXhAVnew7zkjWMAgjnBIe8vSNbHqM7pxqfO7Axk76FymnymuHep1Azj24ZmxjC6NJ92KGxVC50iTU2Ol6QLFo/67DWF71hBmfAtWVwUgWt19H7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qqJxG486; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753148231; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1BOL1qYMWR3O2znqmM5i4r2htXkqnEWXRuKcVY1Fd80=;
	b=qqJxG486elMgYi6npWCpF5r8Bjxwaz9xxxA8/efq+9a0/+ZE7Yct6kWpq8vXx7IDwh6FaSBTG4y6GMpXIEf0tVF3MjBHVCq1PNyFV14AyDlnF406UAGCp9/2kwu6SQccTFWp/3yjne/q8cLszly3QyWvzK0r4yJ5jtadi/szAHE=
Received: from 30.246.160.95(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjTgZZ2_1753148229 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 09:37:10 +0800
Message-ID: <87ed033c-f2b1-4858-8438-f9935c4f12cf@linux.alibaba.com>
Date: Tue, 22 Jul 2025 09:37:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] selftests/pidfd: align stack to fix SP alignment
 exception
To: Will Deacon <will@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Cc: brauner@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com,
 catalin.marinas@arm.com, mark.rutland@arm.com
References: <20250616050648.58716-1-xueshuai@linux.alibaba.com>
 <ee095fdd-b3c1-4c41-9b06-a8e3695c1863@linuxfoundation.org>
 <0a8d5fdb-28b9-41f5-a601-cf36641bddbf@linux.alibaba.com>
 <821acc51-1429-4625-bae5-daa67bddc7bc@linux.alibaba.com>
 <c6dca956-d0ea-4c63-a48f-d02f21d38b9d@linuxfoundation.org>
 <aH5NiFDmnLwh7J_w@willie-the-truck>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aH5NiFDmnLwh7J_w@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/21 22:24, Will Deacon 写道:
> On Fri, Jul 18, 2025 at 03:10:32PM -0600, Shuah Khan wrote:
>> Can you take a look at this and let me know if this change looks
>> good to you both.
>>
>> I can take this through my tree after your reviews.
> 
> I never got to the point of fully understanding how the test was
> supposed to work, but it is true that arm64 requires a 16-byte aligned
> stack pointer and this patch appears to achieve that.
> 
> Will


Hi, Will,

In case you missed I reply in last version. I just paste the original
reply, I hope it can help you understand the root cause.

 From man page of clone():

	The stack argument specifies the location of the stack used by the
         child process.  Since the child and calling process may share
         memory, it is not possible for the child process to execute in the
         same stack as the calling process.  *The calling process must
         therefore set up memory space for the child stack and pass a
         pointer to this space to clone()*.  Stacks grow downward on all
         processors that run Linux (except the HP PA processors), so stack
         usually points to the topmost address of the memory space set up
         for the child stack.  Note that clone() does not provide a means
         whereby the caller can inform the kernel of the size of the stack
         area.

The glibc will do the sanity check:

/* int clone(int (*fn)(void *arg),            x0
	     void *child_stack,               x1
	     int flags,                       x2
	     void *arg,                       x3
	     pid_t *ptid,                     x4
	     struct user_desc *tls,           x5
              pid_t *ctid);                    x6
  */
         .text
ENTRY(__clone)
	PTR_ARG (0)
	PTR_ARG (1)
	PTR_ARG (3)
	PTR_ARG (4)
	PTR_ARG (5)
	PTR_ARG (6)
	/* Save args for the child.  */
	mov	x10, x0
	mov	x11, x2
	mov	x12, x3

	/* Sanity check args.  */
	mov	x0, #-EINVAL
	cbz	x10, .Lsyscall_error
	/* Align sp.  */
	and	x1, x1, -16		
	cbz	x1, .Lsyscall_error	// this line


When the stack pointer is set to NULL, the aligned stack pointer remains
zero, leading __clone to perform a syscall error, returning -EINVAL due
to an invalid argument.

In summary, Whether or not CLONE_VM is used, an address-aligned child
stack needs to be allocated.


Thanks.
Shuai

