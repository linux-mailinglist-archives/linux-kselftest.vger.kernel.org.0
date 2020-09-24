Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22C9277325
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Sep 2020 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgIXNyC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Sep 2020 09:54:02 -0400
Received: from mail.efficios.com ([167.114.26.124]:47098 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIXNyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Sep 2020 09:54:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B8B292D4D18;
        Thu, 24 Sep 2020 09:54:00 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VGsJ-Aue3d2w; Thu, 24 Sep 2020 09:54:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6129D2D4D17;
        Thu, 24 Sep 2020 09:54:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6129D2D4D17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600955640;
        bh=qEP3NmHnEDlTNp38YWppCtsdQwzePXqrYoLu/kAga7I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FZvEyBC0fFjrZJagQKZEm0zcMvgCL45RW1cF+XnicczPa3msBM/tEIqGhjrEmc4dx
         mKWxCEHw/iekVFMKKa4gD9MjvzZP7cpXqd/r47NkwNGh6qtLDn/9yCbOzcOPErSvXo
         Fv135kfqCa3nJIOsVDvcLeP9EdIYMLSHYG0jWVsIpcLGwknmlhAD6TM6mXGlnsuSg/
         3Xo0NLiCK5JkeaUP8GUCSYC6s4s6QzxaPhkyzvtHBAfhXlYCiitjeD1Oe4UMZKhNDy
         BcRTMFTwg6zbyeZoEoBy2ZdwizcxpH8rMReC4hZaZvPR/bx4sZIOOiSkn9BksXK9I7
         k5dvKLoX3y3ew==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8ICkpus41-4t; Thu, 24 Sep 2020 09:54:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 539D32D4D16;
        Thu, 24 Sep 2020 09:54:00 -0400 (EDT)
Date:   Thu, 24 Sep 2020 09:54:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <1466248917.67912.1600955640316.JavaMail.zimbra@efficios.com>
In-Reply-To: <1143241390.67886.1600954399326.JavaMail.zimbra@efficios.com>
References: <20200923233618.2572849-1-posk@google.com> <20200923233618.2572849-2-posk@google.com> <1143241390.67886.1600954399326.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH v8 2/3] rseq/selftests: add rseq_offset_deref_addv
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: rseq/selftests: add rseq_offset_deref_addv
Thread-Index: YpoSNcdzzS1e6+zsawvuzl/RfjrswmKSqAcE
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Sep 24, 2020, at 9:33 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Sep 23, 2020, at 7:36 PM, Peter Oskolkov posk@google.com wrote:
> 
> The patch title should state that it only adds rseq_offset_deref_addv
> to x86-64. Considering that other architecture maintainers will look
> at it as inspiration for other architectures, we should also state in
> the commit message that architectures implementing it should define
> "RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV".

With those changes applied, you can also add my:

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
>> This patch adds rseq_offset_deref_addv function to
>> tools/testing/selftests/rseq/rseq-x86.h, to be used
>> in a selftest in the next patch in the patchset.
>> 
>> v7->v8: this patch split out of the v7 selftest patch.
>> 
>> Signed-off-by: Peter Oskolkov <posk@google.com>
>> ---
>> tools/testing/selftests/rseq/rseq-x86.h | 57 +++++++++++++++++++++++++
>> 1 file changed, 57 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/rseq/rseq-x86.h
>> b/tools/testing/selftests/rseq/rseq-x86.h
>> index b2da6004fe30..640411518e46 100644
>> --- a/tools/testing/selftests/rseq/rseq-x86.h
>> +++ b/tools/testing/selftests/rseq/rseq-x86.h
>> @@ -279,6 +279,63 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
>> #endif
>> }
>> 
>> +#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
>> +
>> +/*
>> + *   pval = *(ptr+off)
>> + *  *pval += inc;
>> + */
>> +static inline __attribute__((always_inline))
>> +int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
>> +{
>> +	RSEQ_INJECT_C(9)
>> +
>> +	__asm__ __volatile__ goto (
>> +		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
>> +#ifdef RSEQ_COMPARE_TWICE
>> +		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
>> +#endif
>> +		/* Start rseq by storing table entry pointer into rseq_cs. */
>> +		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
>> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
>> +		RSEQ_INJECT_ASM(3)
>> +#ifdef RSEQ_COMPARE_TWICE
>> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
>> +#endif
>> +		/* get p+v */
>> +		"movq %[ptr], %%rbx\n\t"
>> +		"addq %[off], %%rbx\n\t"
>> +		/* get pv */
>> +		"movq (%%rbx), %%rcx\n\t"
>> +		/* *pv += inc */
>> +		"addq %[inc], (%%rcx)\n\t"
>> +		"2:\n\t"
>> +		RSEQ_INJECT_ASM(4)
>> +		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
>> +		: /* gcc asm goto does not allow outputs */
>> +		: [cpu_id]		"r" (cpu),
>> +		  [rseq_abi]		"r" (&__rseq_abi),
>> +		  /* final store input */
>> +		  [ptr]			"m" (*ptr),
>> +		  [off]			"er" (off),
>> +		  [inc]			"er" (inc)
>> +		: "memory", "cc", "rax", "rbx", "rcx"
>> +		  RSEQ_INJECT_CLOBBER
>> +		: abort
>> +#ifdef RSEQ_COMPARE_TWICE
>> +		  , error1
>> +#endif
>> +	);
>> +	return 0;
>> +abort:
>> +	RSEQ_INJECT_FAILED
>> +	return -1;
>> +#ifdef RSEQ_COMPARE_TWICE
>> +error1:
>> +	rseq_bug("cpu_id comparison failed");
>> +#endif
>> +}
>> +
>> static inline __attribute__((always_inline))
>> int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
>> 				 intptr_t *v2, intptr_t newv2,
>> --
>> 2.28.0.709.gb0816b6eb0-goog
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
