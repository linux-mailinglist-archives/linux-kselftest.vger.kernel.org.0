Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A651949D22E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 19:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiAZS76 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 13:59:58 -0500
Received: from mail.efficios.com ([167.114.26.124]:52750 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiAZS76 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 13:59:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 94D1C360747;
        Wed, 26 Jan 2022 13:59:57 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JRH9cUaMSB7f; Wed, 26 Jan 2022 13:59:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C518036099B;
        Wed, 26 Jan 2022 13:59:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C518036099B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643223596;
        bh=eICVUmQzw3l/x0zzUTePtqPtDmFZX5u3Ntxlnfacxd4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=sJJ9BIbNfPUQAYN4BQ7bO/SrcDKFM5m0qDZbfswYA1jLFKsCzOqzwIPoyVntAI7ld
         SRGV0U2uVIcFda6/I8d5N6B+NQ4pY/4kjVk8q75vp/7qCnh6+B1j1jBcjmeW66KZQT
         RoyHefximyQv79nvmWTh4cCNpcXMqhJI5oKtIA0wd8wZ/DhuCRmCL/yGNsOW/gaMiX
         LtEmS8/kq/oDQ85atWxHbjmGhGIF2A+5mXvU+0Y2IL8m8oxURv2QC2AYJsI4CJ0/4O
         cNf8GVz5DH5M8iqsbSkQ7Brm4OdzZ4v72njwxK3KAVuavJ6Ar7GIe1NGkk76e3uiOq
         mqyTIZYMIyXJQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4kzbJ7_h7Bql; Wed, 26 Jan 2022 13:59:56 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A117A3606E5;
        Wed, 26 Jan 2022 13:59:56 -0500 (EST)
Date:   Wed, 26 Jan 2022 13:59:56 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Christian Brauner <brauner@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>, shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andi Kleen <andi@firstfloor.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <1116876795.2062.1643223596536.JavaMail.zimbra@efficios.com>
In-Reply-To: <fc04219fc3414bbb968adb844052ecb7@AcuMS.aculab.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com> <20220124171253.22072-3-mathieu.desnoyers@efficios.com> <20220125122156.v2f5anzcs35i3rii@wittgenstein> <1234069751.70438.1643121673355.JavaMail.zimbra@efficios.com> <1445357149.71067.1643137248305.JavaMail.zimbra@efficios.com> <fc04219fc3414bbb968adb844052ecb7@AcuMS.aculab.com>
Subject: Re: [RFC PATCH 02/15] rseq: Remove broken uapi field layout on
 32-bit little endian
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: rseq: Remove broken uapi field layout on 32-bit little endian
Thread-Index: AdgS2G4EeBx+7+jyRfijfhRZbWR//oaEEpo8
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Jan 26, 2022, at 12:16 PM, David Laight David.Laight@ACULAB.COM wrote:

> From: Mathieu Desnoyers
>> Sent: 25 January 2022 19:01
>> 
>> ----- On Jan 25, 2022, at 9:41 AM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>> > ----- On Jan 25, 2022, at 7:21 AM, Christian Brauner brauner@kernel.org wrote:
>> [...]
>> >>>  include/uapi/linux/rseq.h | 17 ++++-------------
>> [...]
>> >>>  	union {
>> >>
>> >> A bit unfortunate we seem to have to keep the union around even though
>> >> it's just one field now.
>> >
>> > Well, as far as the user-space projects that I know of which use rseq
>> > are concerned (glibc, librseq, tcmalloc), those end up with their own
>> > copy of the uapi header anyway to deal with the big/little endian field
>> > on 32-bit. So I'm very much open to remove the union if we accept that
>> > this uapi header is really just meant to express the ABI and is not
>> > expected to be used as an API by user-space.
>> >
>> > That would mean we also bring a uapi header copy into the kernel
>> > rseq selftests as well to minimize the gap between librseq and
>> > the kernel sefltests (the kernel sefltests pretty much include a
>> > copy of librseq for convenience. librseq is maintained out of tree).
>> >
>> > Thoughts ?
>> 
>> Actually, if we go ahead and remove the union, and replace:
>> 
>> struct rseq {
>>   union {
>>     __u64 ptr64;
>>   } rseq_cs;
>> [...]
>> } v;
>> 
>> by:
>> 
>> struct rseq {
>>   __u64 rseq_cs;
>> } v;
>> 
>> expressions such as these are unchanged:
>> 
>> - sizeof(v.rseq_cs),
>> - &v.rseq_cs,
>> - __alignof__(v.rseq_cs),
>> - offsetof(struct rseq, rseq_cs).
>> 
>> So users of the uapi rseq.h (as an API) can still use rseq_abi->rseq_cs before
>> and after the change.
> 
> But:
>	v.rseq_cs.ptr_64 = (uintptr_t)&foo;
> is broken.

True. But v.rseq_cs.ptr (on 64-bit) and v.rseq_cs.ptr.ptr32 (on 32-bit) are also
broken with the planned field removal. So how is the v.rseq_cs_ptr64 situation
different ?

My thinking here is that it does not matter if we break compilation for some
users of the uapi as an API as long as the ABI stays the same, especially
considering that all known users implement their own copy of the header.

I suspect that as far as the API is concerned, it is nice that we have at least
one way to access the field which works both before and after the change.
Simply using "v.rseq_cs" works both before/after for all use-cases that seem
to matter here.

> 
>> Based on this, I am inclined to remove the union, and just make the rseq_cs
>> field
>> a __u64.
> 
> It really is a shame that you can't do:
>	void   *rseq_cs __attribute__((size(8)));
> and have the compiler just DTRT on 32bit systems.

Indeed, the "size" directive appears to be ignored by the compiler.

Thanks,

Mathieu

> 
>	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT,
> UK
> Registration No: 1397386 (Wales)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
