Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52862146345
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 09:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgAWITf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 03:19:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40115 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbgAWITf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 03:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579767574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r8G9CiUcTrvaUADmAjAIB3KCKMVrK5hIYghUAfanm1s=;
        b=FoZFuOpIBG+mw4dSFEXvDtg/itXuFJfoMRiAySH74ydGir4rNFSGmGyiqAc07VWfY2Vf88
        nTOBsZtWqWBvbx3chaDz+QzZo9UHXzNTBs4lPkEtJa5/E15aIv2wwlJpAT5LXMjh+SR6O8
        lWA0NC3Z/HCtSklwh2gCm/q+yGeVTS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-GDK3HAbMObCnYJNP01EYcQ-1; Thu, 23 Jan 2020 03:19:30 -0500
X-MC-Unique: GDK3HAbMObCnYJNP01EYcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0034A1800D48;
        Thu, 23 Jan 2020 08:19:27 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-150.ams2.redhat.com [10.36.116.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B137581C0A;
        Thu, 23 Jan 2020 08:19:20 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Chris Lameter <cl@linux.com>, Jann Horn <jannh@google.com>,
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
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system call
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com>
        <CAG48ez2bQdoT9y7HkyU06DTazysUDdPdJe+gyV-NxgQA7JWQVQ@mail.gmail.com>
        <430172781.596271.1579636021412.JavaMail.zimbra@efficios.com>
        <CAG48ez2Z5CesMfandNK+S32Rrgp_QGQHqQ1Fpd5-YTsCWGfHeg@mail.gmail.com>
        <2049164886.596497.1579641536619.JavaMail.zimbra@efficios.com>
        <alpine.DEB.2.21.2001212141590.1231@www.lameter.com>
        <1648013936.596672.1579655468604.JavaMail.zimbra@efficios.com>
        <ead7a565-9a23-a7d7-904d-c4860f63952a@zytor.com>
Date:   Thu, 23 Jan 2020 09:19:18 +0100
In-Reply-To: <ead7a565-9a23-a7d7-904d-c4860f63952a@zytor.com> (H. Peter
        Anvin's message of "Wed, 22 Jan 2020 23:53:54 -0800")
Message-ID: <87a76efuux.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* H. Peter Anvin:

> On 2020-01-21 17:11, Mathieu Desnoyers wrote:
>> ----- On Jan 21, 2020, at 4:44 PM, Chris Lameter cl@linux.com wrote:
>> 
>>> These scenarios are all pretty complex and will be difficult to understand
>>> for the user of these APIs.
>>>
>>> I think the easiest solution (and most comprehensible) is for the user
>>> space process that does per cpu operations to get some sort of signal. If
>>> its not able to handle that then terminate it. The code makes a basic
>>> assumption after all that the process is running on a specific cpu. If
>>> this is no longer the case then its better to abort if the process cannot
>>> handle moving to a different processor.
>> 
>> The point of pin_on_cpu() is to allow threads to access per-cpu data
>> structures belonging to a given CPU even if they cannot run on that
>> CPU (because it is offline).
>> 
>> I am not sure what scenario your signal delivery proposal aims to cover.
>> 
>> Just to try to put this into the context of a specific scenario to see
>> if I understand your point, is the following what you have in mind ?
>> 
>> 1. Thread A issues pin_on_cpu(5),
>> 2. Thread B issues sched_setaffinity removing cpu 5 from thread A's
>>    affinity mask,
>> 3. Noticing that it would generate an invalid combination, rather than
>>    failing sched_setaffinity, it would send a SIGSEGV (or other) signal
>>    to thread A.
>> 
>> Or so you have something entirely different in mind ?
>> 
>
> I would agree that this seems like the only sane option, or you will
> be in a world of hurt because of conflicting semantics. It is not just
> offlining, but what happens if a policy manager calls
> sched_setaffinity() on another thread -- and now the universe breaks
> because a library is updated to use this new system call which
> collides with the expectations of the policy manager.

Yes, this new interface seems fundamentally incompatible with how
affinity masks are changed today.

Would it be possible to make pin_on_cpu_set to use fallback
synchronization via a futex if the CPU cannot be acquired by running on
it?  The rseq section would need to check the futex as well, but would
not have to acquire it.

Thanks,
Florian

