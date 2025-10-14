Return-Path: <linux-kselftest+bounces-43124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEDBD8DEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 13:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 210384FF852
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673B2FD1A1;
	Tue, 14 Oct 2025 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BiR+m8sa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6392F0C48
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439567; cv=none; b=QnBLhDQaMJ84rS7U6BUhRMxPml6KypOV0X4IvA2NyJx+ywJki3D3K3OVvTHvExZH3GbFfzYoZrJNVd3sEMCM9I9YB99zgqDGaOUlOyMyuxzXDJQxcYhE5BhIotOgJ4pGFkgDjIPAnySmrJLLrYM7vMQfqfuw+Q2mpMYnRoJx06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439567; c=relaxed/simple;
	bh=HR5GnwEkVqDna1+GdhyTzuD+nxlbjBGd85vqWOHkd7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8vTPD6wzDVfOqApCdWlq7lky5xkAq94kpkdMOMbyVlrl0Ly93DeGGKHLrpBd3LMvdVdbYyVZ+znHBVdxjieGLuXs15XtYbp1s9PqA2xlSr8HI1ftxJ9EYWj98zPeHU8sAMh4dsZQUupODK4f68OrfGk0rarYR/mN4yFer6Rje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BiR+m8sa; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3acdcd15-7e52-4a9a-9492-a434ed609dcc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760439559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEvM+uhGgelsYNE930lxc/ZO1r9l2srRhYCoY59fvZI=;
	b=BiR+m8sacQLfJamWviP0aUJZSo9wnpjGz6QYPqt/6NI9DNz9xzTtXzaORvGO75k6ieWkbU
	ejrTjgascTaQ7moGN5ndS+DY7Tu/xY5mjJ4yJdKB476LoOWOBTkmiB8iYkbkn8w6lCrro9
	LY1hD72GCumzUMDh8YXWz5v0H039po4=
Date: Tue, 14 Oct 2025 18:59:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][v3] hung_task: Panic after fixed number of hung tasks
To: lirongqing <lirongqing@baidu.com>, Petr Mladek <pmladek@suse.com>
Cc: wireguard@lists.zx2c4.com, linux-arm-kernel@lists.infradead.org,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-doc@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Russell King <linux@armlinux.org.uk>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 Joel Granados <joel.granados@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Phil Auld <pauld@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Simon Horman <horms@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
 <aO4boXFaIb0_Wiif@pathway.suse.cz>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aO4boXFaIb0_Wiif@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/14 17:45, Petr Mladek wrote:
> On Tue 2025-10-14 13:23:58, Lance Yang wrote:
>> Thanks for the patch!
>>
>> I noticed the implementation panics only when N tasks are detected
>> within a single scan, because total_hung_task is reset for each
>> check_hung_uninterruptible_tasks() run.
> 
> Great catch!
> 
> Does it make sense?
> Is is the intended behavior, please?
> 
>> So some suggestions to align the documentation with the code's
>> behavior below :)
> 
>> On 2025/10/12 19:50, lirongqing wrote:
>>> From: Li RongQing <lirongqing@baidu.com>
>>>
>>> Currently, when 'hung_task_panic' is enabled, the kernel panics
>>> immediately upon detecting the first hung task. However, some hung
>>> tasks are transient and the system can recover, while others are
>>> persistent and may accumulate progressively.
> 
> My understanding is that this patch wanted to do:
> 
>     + report even temporary stalls
>     + panic only when the stall was much longer and likely persistent
> 
> Which might make some sense. But the code does something else.

Cool. Sounds good to me!

> 
>>> --- a/kernel/hung_task.c
>>> +++ b/kernel/hung_task.c
>>> @@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>>>    	 */
>>>    	sysctl_hung_task_detect_count++;
>>> +	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
>>>    	trace_sched_process_hang(t);
>>> -	if (sysctl_hung_task_panic) {
>>> +	if (sysctl_hung_task_panic &&
>>> +			(total_hung_task >= sysctl_hung_task_panic)) {
>>>    		console_verbose();
>>>    		hung_task_show_lock = true;
>>>    		hung_task_call_panic = true;
> 
> I would expect that this patch added another counter, similar to
> sysctl_hung_task_detect_count. It would be incremented only
> once per check when a hung task was detected. And it would
> be cleared (reset) when no hung task was found.

Much cleaner. We could add an internal counter for that, yeah. No need
to expose it to userspace ;)

Petr's suggestion seems to align better with the goal of panicking on
persistent hangs, IMHO. Panic after N consecutive checks with hung tasks.

@RongQing does that work for you?

