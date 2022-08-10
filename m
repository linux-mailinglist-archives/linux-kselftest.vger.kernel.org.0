Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6110558EBE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiHJMWj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 08:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJMWj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 08:22:39 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332327333F;
        Wed, 10 Aug 2022 05:22:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8CD7643EA2C;
        Wed, 10 Aug 2022 08:22:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id macRiZ503hEg; Wed, 10 Aug 2022 08:22:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1862A43EC11;
        Wed, 10 Aug 2022 08:22:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1862A43EC11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1660134157;
        bh=sfAauo/mWpg8zOIkCNkUX/HMbO4wG21Si6g++dnvoyE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nZdbRT4AvSFpu8TzhuYZxIHHOAeTCCeHwddyfuBKZ1bmiJDKmNy9as3q6La1j3OfM
         YVPperUtSSs4kRCThx1MGYQbi/kzkwT94oHNkCqB0UvliKkhsoFQ2yLqAEzV1AmZqm
         vfw+Qp3Mo9VVmQCpvm/rJ3Zp99aKBrJ7dufoCiOMGld4ZRXr7kcskGL3n63moV63rL
         jC+XE6JA5OhDAudAGBr+NBVb592c+ZPm9JAQaZOHnhDBpKKTp1gnuo2G80FAWedMLT
         AsLVLBUrYatb4KKixttIkRUlnfot42FgWXu1HfsICe4e8aksGtRArF7e0KsLEHZShn
         jxrtT1VdGkoIw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pk8I3S8vxJQb; Wed, 10 Aug 2022 08:22:37 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 03E2C43E9B8;
        Wed, 10 Aug 2022 08:22:37 -0400 (EDT)
Date:   Wed, 10 Aug 2022 08:22:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm <kvmarm@lists.cs.columbia.edu>,
        KVM list <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        shan gavin <shan.gavin@gmail.com>, maz <maz@kernel.org>,
        andrew jones <andrew.jones@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>, yihyu <yihyu@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        oliver upton <oliver.upton@linux.dev>
Message-ID: <876568572.367.1660134156963.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220810104114.6838-2-gshan@redhat.com>
References: <20220810104114.6838-1-gshan@redhat.com> <20220810104114.6838-2-gshan@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: selftests: Make rseq compatible with
 glibc-2.35
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103 (Linux)/8.8.15_GA_4372)
Thread-Topic: selftests: Make rseq compatible with glibc-2.35
Thread-Index: Hk36Kh5rkKAuYYVYbwiYIwpCd68vFA==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Aug 10, 2022, at 6:41 AM, Gavin Shan gshan@redhat.com wrote:

> The rseq information is registered by TLS, starting from glibc-2.35.
> In this case, the test always fails due to syscall(__NR_rseq). For
> example, on RHEL9.1 where upstream glibc-2.35 features are enabled
> on downstream glibc-2.34, the test fails like below.
> 
>  # ./rseq_test
>  ==== Test Assertion Failure ====
>    rseq_test.c:60: !r
>    pid=112043 tid=112043 errno=22 - Invalid argument
>       1        0x0000000000401973: main at rseq_test.c:226
>       2        0x0000ffff84b6c79b: ?? ??:0
>       3        0x0000ffff84b6c86b: ?? ??:0
>       4        0x0000000000401b6f: _start at ??:?
>    rseq failed, errno = 22 (Invalid argument)
>  # rpm -aq | grep glibc-2
>  glibc-2.34-39.el9.aarch64
> 
> Fix the issue by using "../rseq/rseq.c" to fetch the rseq information,
> registred by TLS if it exists. Otherwise, we're going to register our
> own rseq information as before.
> 
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Suggested-by: Florian Weimer <fweimer@redhat.com>
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> tools/testing/selftests/kvm/Makefile    |  5 +++--
> tools/testing/selftests/kvm/rseq_test.c | 28 +++++++------------------
> 2 files changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile
> b/tools/testing/selftests/kvm/Makefile
> index c7f47429d6cd..89c9a8c52c5f 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -197,7 +197,8 @@ endif
> CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
> 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
> 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
> -	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
> +	-I$(<D) -Iinclude/$(UNAME_M) -I ../rseq -I.. $(EXTRA_CFLAGS) \
> +	$(KHDR_INCLUDES)
> 
> no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
>         $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
> @@ -206,7 +207,7 @@ no-pie-option := $(call try-run, echo 'int main() { return
> 0; }' | \
> pgste-option = $(call try-run, echo 'int main() { return 0; }' | \
> 	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
> 
> -
> +LDLIBS += -ldl
> LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
> 
> # After inclusion, $(OUTPUT) is defined and
> diff --git a/tools/testing/selftests/kvm/rseq_test.c
> b/tools/testing/selftests/kvm/rseq_test.c
> index a54d4d05a058..2cd5fe49ac8b 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -20,15 +20,7 @@
> #include "processor.h"
> #include "test_util.h"
> 
> -static __thread volatile struct rseq __rseq = {
> -	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
> -};
> -
> -/*
> - * Use an arbitrary, bogus signature for configuring rseq, this test does not
> - * actually enter an rseq critical section.
> - */
> -#define RSEQ_SIG 0xdeadbeef
> +#include "../rseq/rseq.c"
> 
> /*
>  * Any bug related to task migration is likely to be timing-dependent; perform
> @@ -37,6 +29,7 @@ static __thread volatile struct rseq __rseq = {
> #define NR_TASK_MIGRATIONS 100000
> 
> static pthread_t migration_thread;
> +static struct rseq_abi *__rseq;

What is this ?

> static cpu_set_t possible_mask;
> static int min_cpu, max_cpu;
> static bool done;
> @@ -49,14 +42,6 @@ static void guest_code(void)
> 		GUEST_SYNC(0);
> }
> 
> -static void sys_rseq(int flags)
> -{
> -	int r;
> -
> -	r = syscall(__NR_rseq, &__rseq, sizeof(__rseq), flags, RSEQ_SIG);
> -	TEST_ASSERT(!r, "rseq failed, errno = %d (%s)", errno, strerror(errno));
> -}
> -
> static int next_cpu(int cpu)
> {
> 	/*
> @@ -218,7 +203,10 @@ int main(int argc, char *argv[])
> 
> 	calc_min_max_cpu();
> 
> -	sys_rseq(0);
> +	r = rseq_register_current_thread();
> +	TEST_ASSERT(!r, "rseq_register_current_thread failed, errno = %d (%s)",
> +		    errno, strerror(errno));
> +	__rseq = rseq_get_abi();
> 
> 	/*
> 	 * Create and run a dummy VM that immediately exits to userspace via
> @@ -256,7 +244,7 @@ int main(int argc, char *argv[])
> 			 */
> 			smp_rmb();
> 			cpu = sched_getcpu();
> -			rseq_cpu = READ_ONCE(__rseq.cpu_id);
> +			rseq_cpu = READ_ONCE(__rseq->cpu_id);

#include <rseq.h>

and use

rseq_current_cpu_raw().

Thanks,

Mathieu


> 			smp_rmb();
> 		} while (snapshot != atomic_read(&seq_cnt));
> 
> @@ -278,7 +266,7 @@ int main(int argc, char *argv[])
> 
> 	kvm_vm_free(vm);
> 
> -	sys_rseq(RSEQ_FLAG_UNREGISTER);
> +	rseq_unregister_current_thread();
> 
> 	return 0;
> }
> --
> 2.23.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
