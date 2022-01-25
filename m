Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F7549B6C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 15:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580065AbiAYOpy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 09:45:54 -0500
Received: from mail.efficios.com ([167.114.26.124]:45014 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579980AbiAYOla (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 09:41:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9EC9034DADC;
        Tue, 25 Jan 2022 09:41:14 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YxB3tzVOmELA; Tue, 25 Jan 2022 09:41:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 98E8434DADB;
        Tue, 25 Jan 2022 09:41:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 98E8434DADB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643121673;
        bh=UHmsUtxRyc2FuICvfcuMd8VU1FfVxU1M1pUOGC/s44M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=N85YOg6In8OwsbZQpAXoK5xB8E3qIVHONNmqMtaz8WWMEkyBItYkr1GcS5kee0tmX
         0bN7CP8hipq4nhJL4Jxpl4nJvaxzM2QNQG8WF6bnwEg5y/CR7Pqz7W872JFCdSsl9k
         q1NvEEtdYTfqMs9XqF8DOHlYsgQAz6HtjNW2mT2lb/S5LQH8LLVxzYllqb72dZw0X5
         2msFMBewjejqWC40X3278ONKGm6jkRy9iv+ZD7D6BSDREBj0ZF6wz/qQ5jwMS6C7BU
         d4Yzz+4J4VcsLue6ukVO8qaVl+5ekmeV46WyPZ0SlyYzitmRjsdsZ2rszxBGFTcXIS
         lSVr9P+utpqLw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bd4ULRnk5POI; Tue, 25 Jan 2022 09:41:13 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7B50E34DC54;
        Tue, 25 Jan 2022 09:41:13 -0500 (EST)
Date:   Tue, 25 Jan 2022 09:41:13 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <1234069751.70438.1643121673355.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220125122156.v2f5anzcs35i3rii@wittgenstein>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com> <20220124171253.22072-3-mathieu.desnoyers@efficios.com> <20220125122156.v2f5anzcs35i3rii@wittgenstein>
Subject: Re: [RFC PATCH 02/15] rseq: Remove broken uapi field layout on
 32-bit little endian
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: Remove broken uapi field layout on 32-bit little endian
Thread-Index: jBpzgk+GT1oWkc+mziLmJCxydp6hDQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Jan 25, 2022, at 7:21 AM, Christian Brauner brauner@kernel.org wrote:

> On Mon, Jan 24, 2022 at 12:12:40PM -0500, Mathieu Desnoyers wrote:
>> The rseq rseq_cs.ptr.{ptr32,padding} uapi endianness handling is
>> entirely wrong on 32-bit little endian: a preprocessor logic mistake
>> wrongly uses the big endian field layout on 32-bit little endian
>> architectures.
>> 
>> Fortunately, those ptr32 accessors were never used within the kernel,
>> and only meant as a convenience for user-space.
>> 
>> Remove those and only leave the "ptr64" union field, as this is the only
>> thing really needed to express the ABI. Document how 32-bit
>> architectures are meant to interact with this "ptr64" union field.
>> 
>> Fixes: ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union, update
>> includes")
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Florian Weimer <fw@deneb.enyo.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-api@vger.kernel.org
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Dave Watson <davejwatson@fb.com>
>> Cc: Paul Turner <pjt@google.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: "H . Peter Anvin" <hpa@zytor.com>
>> Cc: Andi Kleen <andi@firstfloor.org>
>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>> Cc: Ben Maurer <bmaurer@fb.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> Cc: Joel Fernandes <joelaf@google.com>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> ---
>>  include/uapi/linux/rseq.h | 17 ++++-------------
>>  1 file changed, 4 insertions(+), 13 deletions(-)
>> 
>> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
>> index 9a402fdb60e9..31290f2424a7 100644
>> --- a/include/uapi/linux/rseq.h
>> +++ b/include/uapi/linux/rseq.h
>> @@ -105,22 +105,13 @@ struct rseq {
>>  	 * Read and set by the kernel. Set by user-space with single-copy
>>  	 * atomicity semantics. This field should only be updated by the
>>  	 * thread which registered this data structure. Aligned on 64-bit.
>> +	 *
>> +	 * 32-bit architectures should update the low order bits of the
>> +	 * rseq_cs.ptr64 field, leaving the high order bits initialized
>> +	 * to 0.
>>  	 */
>>  	union {
> 
> A bit unfortunate we seem to have to keep the union around even though
> it's just one field now.

Well, as far as the user-space projects that I know of which use rseq
are concerned (glibc, librseq, tcmalloc), those end up with their own
copy of the uapi header anyway to deal with the big/little endian field
on 32-bit. So I'm very much open to remove the union if we accept that
this uapi header is really just meant to express the ABI and is not
expected to be used as an API by user-space.

That would mean we also bring a uapi header copy into the kernel
rseq selftests as well to minimize the gap between librseq and
the kernel sefltests (the kernel sefltests pretty much include a
copy of librseq for convenience. librseq is maintained out of tree).

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
