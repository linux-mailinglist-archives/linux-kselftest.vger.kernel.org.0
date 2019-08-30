Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76589A3A2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfH3PTD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 11:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3PTD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 11:19:03 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C070E23407;
        Fri, 30 Aug 2019 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567178342;
        bh=vQfKaQCOOvRxsISEVm5YkqcibbR2NduhLMlGiVwylHM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HUd34ltmgb0Kcr0QVXguoMwr0LOFCR3TLG8GlgiZA3Tc1NdjOPVZHMPV0y14johUM
         s8uuapf3mG5hF9AGpHhRQ/nMiX+ZP/j/AzDX2WvC6yT87jRsC5olXOUMx27FKWxS7I
         i5l4GgnM6wBjoYeLSttlJA3S3K2OPj7oOqCxuOSo=
Subject: Re: [PATCH] selftests/seccomp: fix build on older kernels
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alakesh Haloi <alakesh.haloi@gmail.com>,
        shuah <shuah@kernel.org>
References: <20190826144302.7745-1-tycho@tycho.ws>
 <201908291003.005EB96606@keescook>
 <f01c3383-0184-9770-c72e-7fe08b552112@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <1a3e9d47-73f5-9cf5-e050-46a455b6a6cc@kernel.org>
Date:   Fri, 30 Aug 2019 09:19:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f01c3383-0184-9770-c72e-7fe08b552112@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/29/19 6:45 PM, shuah wrote:
> On 8/29/19 11:06 AM, Kees Cook wrote:
>> On Mon, Aug 26, 2019 at 08:43:02AM -0600, Tycho Andersen wrote:
>>> The seccomp selftest goes to some length to build against older kernel
>>> headers, viz. all the #ifdefs at the beginning of the file. 201766a20e30
>>> ("ptrace: add PTRACE_GET_SYSCALL_INFO request") introduces some 
>>> additional
>>> macros, but doesn't do the #ifdef dance. Let's add that dance here to
>>> avoid:
>>>
>>> gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
>>> In file included from seccomp_bpf.c:51:
>>> seccomp_bpf.c: In function ‘tracer_ptrace’:
>>> seccomp_bpf.c:1787:20: error: ‘PTRACE_EVENTMSG_SYSCALL_ENTRY’ 
>>> undeclared (first use in this function); did you mean 
>>> ‘PTRACE_EVENT_CLONE’?
>>>    EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>>>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
>>>    __typeof__(_expected) __exp = (_expected); \
>>>               ^~~~~~~~~
>>> seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
>>>    EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>>>    ^~~~~~~~~
>>> seccomp_bpf.c:1787:20: note: each undeclared identifier is reported 
>>> only once for each function it appears in
>>>    EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>>>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
>>>    __typeof__(_expected) __exp = (_expected); \
>>>               ^~~~~~~~~
>>> seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
>>>    EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>>>    ^~~~~~~~~
>>> seccomp_bpf.c:1788:6: error: ‘PTRACE_EVENTMSG_SYSCALL_EXIT’ 
>>> undeclared (first use in this function); did you mean 
>>> ‘PTRACE_EVENT_EXIT’?
>>>      : PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
>>>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
>>>    __typeof__(_expected) __exp = (_expected); \
>>>               ^~~~~~~~~
>>> seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
>>>    EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>>>    ^~~~~~~~~
>>> make: *** [Makefile:12: seccomp_bpf] Error 1
>>>
>>> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
>>> Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>>
>> Alakesh Haloi also sent a fix[1] for this. I prefer Tycho's solution
>> (one #ifndef and a Fixes line). Shuah, can you please apply this?
>>
> 
> Kees,
> 
> Yes I will pick this up.
> 
> thanks,
> -- Shuah
> 

Applied after fixing the following checkpatch error in the commit log:

ERROR: Please use git commit description style 'commit <12+ chars of 
sha1> ("<title line>")' - ie: 'commit 201766a20e30 ("ptrace: add 
PTRACE_GET_SYSCALL_INFO request")'
#82:

Now reads as follows:

Commit 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
     introduces some additional macros, but doesn't do the #ifdef dance.
     Let's add that dance here to avoid:

thanks,
-- Shuah
