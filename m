Return-Path: <linux-kselftest+bounces-396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D09FD7F3BCD
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 03:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70590B2110C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 02:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2041C3D;
	Wed, 22 Nov 2023 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UgcGW+Xc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9A181
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 18:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1700620503;
	bh=sJ4yOPpLvJ8TPC0dYLPVJzcI3fezKxpuaN38TD041+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UgcGW+Xc+p1c+VDckG7GhjDAv6BhTGJsNhPzVN+rL683U+8MgNpdG83LmOEqMidvG
	 hL3X38CtJfU2K0b9kTooIJvzze+mCpSbEUKGtKdNuddw5n8KKuW56x3RaH6fQ/3diz
	 A5HmQOUwvc7ZV3IC4Y6J5lJkroyCgxiDc7TVPCwd1uY+/8sUu5miFNaZemj3OxFjfk
	 kMVFyGWwjCTHQcAVXN/4ZYHOFju8qCeaIs9UeUQQ8Sp08+z25rReqY10wYVTMaMYPs
	 KkEc5FQdXfdGNoArYsCUBNy+MNCDQA+Cgj0Oz5THT5Ty/HP9dltwqrhH3SpH5t1y0r
	 Xvm4+GR4XGSqQ==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZlhR3214z1crn;
	Tue, 21 Nov 2023 21:35:03 -0500 (EST)
Message-ID: <938124c8-bc01-4891-a2a5-ea7e933278d7@efficios.com>
Date: Tue, 21 Nov 2023 21:35:40 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/memfd: fix a memleak
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 zhujun2 <zhujun2@cmss.chinamobile.com>
Cc: cyphar@cyphar.com, dverkamp@chromium.org, jeffxu@google.com,
 keescook@chromium.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <12dd2fb2-0fac-4763-ad34-02af9653f91b@efficios.com>
 <20231121025506.2391-1-zhujun2@cmss.chinamobile.com>
 <20231121154300.734732c744f272214e160a3c@linux-foundation.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231121154300.734732c744f272214e160a3c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-21 18:43, Andrew Morton wrote:
> On Mon, 20 Nov 2023 18:55:06 -0800 zhujun2 <zhujun2@cmss.chinamobile.com> wrote:
> 
>> The memory allocated within a function should be released
>> before the function return,otherwise memleak will occur.
>>
>> ...
>>
>> --- a/tools/testing/selftests/memfd/fuse_test.c
>> +++ b/tools/testing/selftests/memfd/fuse_test.c
>> @@ -217,6 +217,7 @@ static pid_t spawn_sealing_thread(void)
>>   		abort();
>>   	}
>>   
>> +	free(stack);
>>   	return pid;
>>   }
> 
> We just freed a thread's stack while it is still running?

Indeed, this patch is completely wrong. Freeing the stack memory should
not happen before joining the thread which uses it.

This also means that this patch was probably not even runtime-tested, 
even less tested with tools like valgrind which should have caught this.

I would advise the patch author to test the changes before submitting a 
patch, especially considering the amount of tools out there which can be 
used to validate userspace programs.

Moreover, the changes done should take into consideration the behavior 
of the system calls they surround. Trying to "fix" a resource leak 
without understanding first the semantic of the system call using the 
resource is causing more problems than it solves.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


