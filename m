Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF95AEB9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 22:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfD2U2V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 16:28:21 -0400
Received: from mail.efficios.com ([167.114.142.138]:51518 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfD2U2V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 16:28:21 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 462E71DA3AD;
        Mon, 29 Apr 2019 16:28:19 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id lfsha8KaN3Fx; Mon, 29 Apr 2019 16:28:18 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 465211DA3A4;
        Mon, 29 Apr 2019 16:28:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 465211DA3A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556569698;
        bh=YdzuJk5SnUFbR7C4FKv2y0/l5GDXHqEZ1IsDFtfLIUU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=joV9WmxEQVsqv19xO5E+SX74B/DmyGn6EayUx6zUFDMkG+aZpO/OwVshAQ75YdpCN
         9H414rbzLgB39elHjRYUbZ6ZCymS+V11b9Vpngz2cvicrJ6iJ6wT8YjE/UwtlSruF4
         Ri63rFjdn1PoO8MEhAsVjjPvaA6OGnRXJ6DlneymQ5olMeBwzNf/kdeqBR6reW79PQ
         3f++EZ9boHhC6ok8or6vGjriDoH2E1hDb0kV2Lj8T+W6wAPjPjIdYzZKghgM4ShWjn
         ZIIJujpKMw7UA1qqREsVKKowtWi8VeKtdHf+M2/1fnF+cGZWZqErIixavrdoVs+Qn+
         LKzDi6vPjokAA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id C8GZDjvDNJLn; Mon, 29 Apr 2019 16:28:18 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 261AB1DA393;
        Mon, 29 Apr 2019 16:28:18 -0400 (EDT)
Date:   Mon, 29 Apr 2019 16:28:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     ndesaulniers <ndesaulniers@google.com>, shuah <shuah@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <712082435.384.1556569697998.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAKwvOdnbH0+ju5Ny-mB-Z4kC+ALyCJOU4Q8OCLHHjFAQzJqsXA@mail.gmail.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com> <20190429152803.7719-13-mathieu.desnoyers@efficios.com> <CAKwvOdnbH0+ju5Ny-mB-Z4kC+ALyCJOU4Q8OCLHHjFAQzJqsXA@mail.gmail.com>
Subject: Re: [PATCH for 5.2 12/12] rseq/selftests: add -no-integrated-as for
 clang
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: add -no-integrated-as for clang
Thread-Index: Ac/EHQ/mSHgf8Nq7m+w8ff+ojTnKhQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Apr 29, 2019, at 1:03 PM, ndesaulniers ndesaulniers@google.com wrote:

> On Mon, Apr 29, 2019 at 8:29 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Ongoing work for asm goto support from clang requires the
>> -no-integrated-as compiler flag.
>>
>> This compiler flag is present in the toplevel kernel Makefile,
>> but is not replicated for selftests. Add it specifically for
>> the rseq selftest which requires asm goto.
>>
>> Link: https://reviews.llvm.org/D56571
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Nick Desaulniers <ndesaulniers@google.com>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: Joel Fernandes <joelaf@google.com>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Dave Watson <davejwatson@fb.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Shuah Khan <shuah@kernel.org>
>> CC: Andi Kleen <andi@firstfloor.org>
>> CC: linux-kselftest@vger.kernel.org
>> CC: "H . Peter Anvin" <hpa@zytor.com>
>> CC: Chris Lameter <cl@linux.com>
>> CC: Russell King <linux@arm.linux.org.uk>
>> CC: Michael Kerrisk <mtk.manpages@gmail.com>
>> CC: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
>> CC: Paul Turner <pjt@google.com>
>> CC: Boqun Feng <boqun.feng@gmail.com>
>> CC: Josh Triplett <josh@joshtriplett.org>
>> CC: Steven Rostedt <rostedt@goodmis.org>
>> CC: Ben Maurer <bmaurer@fb.com>
>> CC: linux-api@vger.kernel.org
>> CC: Andy Lutomirski <luto@amacapital.net>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> ---
>>  tools/testing/selftests/rseq/Makefile | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/rseq/Makefile
>> b/tools/testing/selftests/rseq/Makefile
>> index c30c52e1d0d2..d6469535630a 100644
>> --- a/tools/testing/selftests/rseq/Makefile
>> +++ b/tools/testing/selftests/rseq/Makefile
>> @@ -1,5 +1,11 @@
>>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>> -CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
>> +
>> +ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>> +CLANG_FLAGS += -no-integrated-as
>> +endif
>> +
>> +CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ \
>> +         $(CLANG_FLAGS)
> 
> The top level Makefile exports $(CLANG_FLAGS), which should contain
> `-no-integrated-as`.  Is that available here?  If so, then you can
> just add `$(CLANG_FLAGS)`, no compiler check needed.

AFAIU, the makefiles under tools/testing/selftests all end up including
tools/testing/selftests/lib.mk, which states:

"# This mimics the top-level Makefile. We do it explicitly here so that this
 # Makefile can operate with or without the kbuild infrastructure."

So I don't think it's using any of the definitions from the toplevel
Makefile.

> If not, maybe the test for CONFIG_CC_IS_CLANG is cleaner?

A quick test indicates that the toplevel CONFIG_* definitions are unavailable
from the kernel selftests makefiles.

> Thanks for the patch, and helping test asm goto in Clang!

You're very welcome! Considering that I intend to have rseq widely adopted in
user-space, it's only natural to consider that its user-space side needs to be
compiled by clang as well.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
