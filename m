Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6931462F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 08:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAWHz7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 02:55:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37879 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWHz7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 02:55:59 -0500
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 00N7s0r21387140
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 22 Jan 2020 23:54:00 -0800
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system
 call
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Chris Lameter <cl@linux.com>
Cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>, shuah <shuah@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com>
 <CAG48ez2bQdoT9y7HkyU06DTazysUDdPdJe+gyV-NxgQA7JWQVQ@mail.gmail.com>
 <430172781.596271.1579636021412.JavaMail.zimbra@efficios.com>
 <CAG48ez2Z5CesMfandNK+S32Rrgp_QGQHqQ1Fpd5-YTsCWGfHeg@mail.gmail.com>
 <2049164886.596497.1579641536619.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.2001212141590.1231@www.lameter.com>
 <1648013936.596672.1579655468604.JavaMail.zimbra@efficios.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <ead7a565-9a23-a7d7-904d-c4860f63952a@zytor.com>
Date:   Wed, 22 Jan 2020 23:53:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1648013936.596672.1579655468604.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-01-21 17:11, Mathieu Desnoyers wrote:
> ----- On Jan 21, 2020, at 4:44 PM, Chris Lameter cl@linux.com wrote:
> 
>> These scenarios are all pretty complex and will be difficult to understand
>> for the user of these APIs.
>>
>> I think the easiest solution (and most comprehensible) is for the user
>> space process that does per cpu operations to get some sort of signal. If
>> its not able to handle that then terminate it. The code makes a basic
>> assumption after all that the process is running on a specific cpu. If
>> this is no longer the case then its better to abort if the process cannot
>> handle moving to a different processor.
> 
> The point of pin_on_cpu() is to allow threads to access per-cpu data
> structures belonging to a given CPU even if they cannot run on that
> CPU (because it is offline).
> 
> I am not sure what scenario your signal delivery proposal aims to cover.
> 
> Just to try to put this into the context of a specific scenario to see
> if I understand your point, is the following what you have in mind ?
> 
> 1. Thread A issues pin_on_cpu(5),
> 2. Thread B issues sched_setaffinity removing cpu 5 from thread A's
>    affinity mask,
> 3. Noticing that it would generate an invalid combination, rather than
>    failing sched_setaffinity, it would send a SIGSEGV (or other) signal
>    to thread A.
> 
> Or so you have something entirely different in mind ?
> 

I would agree that this seems like the only sane option, or you will be in a
world of hurt because of conflicting semantics. It is not just offlining, but
what happens if a policy manager calls sched_setaffinity() on another thread
-- and now the universe breaks because a library is updated to use this new
system call which collides with the expectations of the policy manager.

There doesn't seem to be any way to get this to be a local event which doesn't
break assumptions elsewhere in the system without making this an abort event
of some type. However, signals are painful in their own right, mostly because
of the lack of any infrastructure for allocating signals to libraries in user
space. I was actually thinking about exactly that issue just this weekend.

	-hpa


