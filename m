Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095572772B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Sep 2020 15:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgIXNkJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Sep 2020 09:40:09 -0400
Received: from mail.efficios.com ([167.114.26.124]:43014 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgIXNkI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Sep 2020 09:40:08 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 09:40:08 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AC5182D436C;
        Thu, 24 Sep 2020 09:33:19 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jVRFleH8muaP; Thu, 24 Sep 2020 09:33:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6B8682D4834;
        Thu, 24 Sep 2020 09:33:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6B8682D4834
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600954399;
        bh=n0Ma1mvUkm8thcjDR5/ATCG3mBGIJfRm+0QJYEa7HJM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=R8JgVc56t7B3ZIeF+o/ZFrI7mki4iThekm3LuqcAekP4s1RkGjIKenOQlq/Jd8KLD
         S3FNX26ezPo2l0nbjZo6j/SF0DynKydjGuQTZFlvQg2aW40Cjrnz3hPg6q320DWM5q
         U9BV7YtpqosIVWfLGBnXUOihGZlVAhhrZYOcI8wS/wG18kL39U42wl5cn7UawlxcvR
         ah34b9SjGsIg7HeybP3JBfGQ94aEUc9xvYePSNW4nuFIfXEEhs0at0FHFNGuVsbgzG
         KTtKMlQzCsFn+cvCsBXZrm1KQWWrhbbtYbHIeeZLPqr/UWVBWdM6v2VMbgtP8cmqD2
         cBirZ1Y1bN5Kg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cuZ8Ybh6vSyP; Thu, 24 Sep 2020 09:33:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 5CBDE2D4756;
        Thu, 24 Sep 2020 09:33:19 -0400 (EDT)
Date:   Thu, 24 Sep 2020 09:33:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <1143241390.67886.1600954399326.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200923233618.2572849-2-posk@google.com>
References: <20200923233618.2572849-1-posk@google.com> <20200923233618.2572849-2-posk@google.com>
Subject: Re: [PATCH v8 2/3] rseq/selftests: add rseq_offset_deref_addv
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: rseq/selftests: add rseq_offset_deref_addv
Thread-Index: YpoSNcdzzS1e6+zsawvuzl/Rfjrswg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Sep 23, 2020, at 7:36 PM, Peter Oskolkov posk@google.com wrote:

The patch title should state that it only adds rseq_offset_deref_addv
to x86-64. Considering that other architecture maintainers will look
at it as inspiration for other architectures, we should also state in
the commit message that architectures implementing it should define
"RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV".

Thanks,

Mathieu

> This patch adds rseq_offset_deref_addv function to
> tools/testing/selftests/rseq/rseq-x86.h, to be used
> in a selftest in the next patch in the patchset.
> 
> v7->v8: this patch split out of the v7 selftest patch.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
> tools/testing/selftests/rseq/rseq-x86.h | 57 +++++++++++++++++++++++++
> 1 file changed, 57 insertions(+)
> 
> diff --git a/tools/testing/selftests/rseq/rseq-x86.h
> b/tools/testing/selftests/rseq/rseq-x86.h
> index b2da6004fe30..640411518e46 100644
> --- a/tools/testing/selftests/rseq/rseq-x86.h
> +++ b/tools/testing/selftests/rseq/rseq-x86.h
> @@ -279,6 +279,63 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
> #endif
> }
> 
> +#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
> +
> +/*
> + *   pval = *(ptr+off)
> + *  *pval += inc;
> + */
> +static inline __attribute__((always_inline))
> +int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto (
> +		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
> +#endif
> +		/* Start rseq by storing table entry pointer into rseq_cs. */
> +		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
> +		RSEQ_INJECT_ASM(3)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
> +#endif
> +		/* get p+v */
> +		"movq %[ptr], %%rbx\n\t"
> +		"addq %[off], %%rbx\n\t"
> +		/* get pv */
> +		"movq (%%rbx), %%rcx\n\t"
> +		/* *pv += inc */
> +		"addq %[inc], (%%rcx)\n\t"
> +		"2:\n\t"
> +		RSEQ_INJECT_ASM(4)
> +		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
> +		: /* gcc asm goto does not allow outputs */
> +		: [cpu_id]		"r" (cpu),
> +		  [rseq_abi]		"r" (&__rseq_abi),
> +		  /* final store input */
> +		  [ptr]			"m" (*ptr),
> +		  [off]			"er" (off),
> +		  [inc]			"er" (inc)
> +		: "memory", "cc", "rax", "rbx", "rcx"
> +		  RSEQ_INJECT_CLOBBER
> +		: abort
> +#ifdef RSEQ_COMPARE_TWICE
> +		  , error1
> +#endif
> +	);
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +#endif
> +}
> +
> static inline __attribute__((always_inline))
> int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
> 				 intptr_t *v2, intptr_t newv2,
> --
> 2.28.0.709.gb0816b6eb0-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
