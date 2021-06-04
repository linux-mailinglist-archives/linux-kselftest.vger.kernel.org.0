Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F30C39BDF9
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jun 2021 19:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFDRGT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Jun 2021 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRGT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Jun 2021 13:06:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB8C061766;
        Fri,  4 Jun 2021 10:04:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 200A01F43A0D
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Zebediah Figura <z.figura12@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, joel@joelfernandes.org,
        malteskarupke@fastmail.fm, linux-api@vger.kernel.org,
        fweimer@redhat.com, libc-alpha@sourceware.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, acme@kernel.org,
        corbet@lwn.net, Peter Oskolkov <posk@posk.io>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <dab34fd2-b494-8686-bcd7-68beeba4f386@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <d3d2a8f9-4a5e-fff5-c0f3-2563366b4c11@collabora.com>
Date:   Fri, 4 Jun 2021 14:04:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <dab34fd2-b494-8686-bcd7-68beeba4f386@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Às 01:51 de 04/06/21, Zebediah Figura escreveu:
> On 6/3/21 2:59 PM, André Almeida wrote:
>>   ** The wait on multiple problem
>>
>>   The use case lies in the Wine implementation of the Windows NT
>> interface
>>   WaitMultipleObjects. This Windows API function allows a thread to sleep
>>   waiting on the first of a set of event sources (mutexes, timers,
>> signal,
>>   console input, etc) to signal.  Considering this is a primitive
>>   synchronization operation for Windows applications, being able to
>> quickly
>>   signal events on the producer side, and quickly go to sleep on the
>>   consumer side is essential for good performance of those running
>> over Wine.
>>
> 
> I know this is part of the cover letter, but I really do want to clarify
> that this isn't really accurate. The use case that this is referring to
> is not "the Wine implementation of WaitForMultipleObjects", it is an
> out-of-tree implementation of WaitForMultipleObjects that provides
> improved performance compared to the in-tree implementation.
> 
> This is especially salient because:
> 
> (1) this out-of-tree implementation is only in a small handful of cases
> any more performant than a different out-of-tree implementation which
> uses eventfd and poll() instead;
> 
> (2) these implementations will remain out-of-tree due to compatibility
> and robustness problems;
> 
> (3) I believe there is potential for an upstreamable implementation
> which does not rely on futex or futex2.

I'll let it more clear next time that this applies to Proton's Wine, and
not Wine.

Along with that, wait on multiple will be useful for other workloads,
such as the ones that uses Boost's mass locking algorithms and native
game engines for instance.
