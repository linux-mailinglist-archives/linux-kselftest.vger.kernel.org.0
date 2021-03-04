Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F16B32DA35
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Mar 2021 20:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhCDTQf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Mar 2021 14:16:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55008 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhCDTQM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Mar 2021 14:16:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 5B4931F46668
Subject: Re: [RFC PATCH v2 00/13] Add futex2 syscall
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net
References: <20210304004219.134051-1-andrealmeid@collabora.com>
 <YED2OrBdsiYWMqpp@mit.edu>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <3659bc06-f8f3-31ff-b4d6-99aee4ed2199@collabora.com>
Date:   Thu, 4 Mar 2021 16:15:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YED2OrBdsiYWMqpp@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ted,

Às 12:01 de 04/03/21, Theodore Ts'o escreveu:
> On Wed, Mar 03, 2021 at 09:42:06PM -0300, André Almeida wrote:
>>   ** Performance
>>
>>   - For comparing futex() and futex2() performance, I used the artificial
>>     benchmarks implemented at perf (wake, wake-parallel, hash and
>>     requeue). The setup was 200 runs for each test and using 8, 80, 800,
>>     8000 for the number of threads, Note that for this test, I'm not using
>>     patch 14 ("kernel: Enable waitpid() for futex2") , for reasons explained
>>     at "The patchset" section.
> 
> How heavily contended where the benchmarks?  One of the benefits of
> the original futex was that no system call was necessary in the happy
> path when the lock is uncontended.  

futex2 has the same design in that aspect, no syscall is needed in the 
happy path. Did something in the cover letter gave the impression that 
is not the case? I would like to reword it to clarify this.

> Especially on a non-NUMA system
> (which are the far more common case), since that's where relying on a
> single memory access was a huge win for the original futex.  I would
> expect that futex2 will fare worse in this particular case, since it
> requires a system call entry for all operations --- the question is
> how large is the delta in this worst case (for futex2) and best case
> (for futex) scenario.
> 
> Cheers,
> 
> 						- Ted
> 

Thanks,
	André
