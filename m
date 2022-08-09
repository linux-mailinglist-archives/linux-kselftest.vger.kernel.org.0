Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3185558D193
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 02:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbiHIA54 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Aug 2022 20:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiHIA5y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Aug 2022 20:57:54 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ECF1BEAE;
        Mon,  8 Aug 2022 17:57:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6584D3FC698;
        Mon,  8 Aug 2022 20:57:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id L-cbIrCayAKv; Mon,  8 Aug 2022 20:57:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B22A93FC697;
        Mon,  8 Aug 2022 20:57:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B22A93FC697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1660006670;
        bh=fHIX23eKmWI7H4gFYuEyjtQ4fI/u8qNcHkF2ldepniQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ACfv8WIfdHAvgNTeJK+6js4kcLL0eqSO+nmbNobRKBkXpzfW2HxFGy0SM8OiO6bow
         29WBIW3Em2nhNU+NWYZulOoWyvR0YGKNkJAXPIDMTbdz7bqo+A+u0eDmTQD0dkC4+S
         I2hQs3fw9uJmxY94fYeFkh7fig3tQPJPf7Xz30S2wDpf7TldDCd2SBpXmWi8/e+tGD
         BuG8wwzUWFPJQ+51WyjoHdP2AS01X9gm1yXEF+zMObmLJVAu6D/n5P7GQTPVGPRTRj
         5lfp8gF05l8aFGySZwl48XyV03oRh19SCkOnnZFZw/Dheu8BSdJMkBX6ZgSH3+GM+X
         Y/r69vikkBb3g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9rN7wNNTIody; Mon,  8 Aug 2022 20:57:50 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A2BBD3FC2DE;
        Mon,  8 Aug 2022 20:57:50 -0400 (EDT)
Date:   Mon, 8 Aug 2022 20:57:50 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1675511593.114778.1660006670558.JavaMail.zimbra@efficios.com>
In-Reply-To: <465d3599-2433-7f6e-66fc-b4018ba258cf@redhat.com>
References: <875yj2n2r0.fsf@oldenburg.str.redhat.com> <465d3599-2433-7f6e-66fc-b4018ba258cf@redhat.com>
Subject: Re: tools/testing/selftests/kvm/rseq_test and glibc 2.35
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (zclient/8.8.15_GA_4304)
Thread-Topic: tools/testing/selftests/kvm/rseq_test and glibc 2.35
Thread-Index: tLu7f3UTxnUwftC9I0Hq80rlQtlKdQ==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


----- Gavin Shan <gshan@redhat.com> wrote:
> Hi Florian,
> 
> On 8/9/22 2:01 AM, Florian Weimer wrote:
> > It has come to my attention that the KVM rseq test apparently needs to
> > be ported to glibc 2.35.  The background is that on aarch64, rseq is the
> > only way to get a practically useful sched_getcpu.  (There's no hidden
> > per-task CPU state the vDSO could reveal as the CPU ID.)
> > 
> 
> Yes, kvm/selftests/rseq needs to support glibc 2.35. The question is
> about glibc 2.34 or 2.35 because kvm/selftest/rseq fails on glibc 2.34
> 
> I would guess upstream-glibc-2.35 feature is enabled on downstream
> glibc-2.34?
> 
> # ./rseq_test
> ==== Test Assertion Failure ====
>    rseq_test.c:60: !r
>    pid=112043 tid=112043 errno=22 - Invalid argument
>       1	0x0000000000401973: main at rseq_test.c:226
>       2	0x0000ffff84b6c79b: ?? ??:0
>       3	0x0000ffff84b6c86b: ?? ??:0
>       4	0x0000000000401b6f: _start at ??:?
>    rseq failed, errno = 22 (Invalid argument)
> # rpm -aq | grep glibc-2
> glibc-2.34-39.el9.aarch64
> 
> 
> > The main rseq tests have already been adjusted via:
> > 
> > commit 233e667e1ae3e348686bd9dd0172e62a09d852e1
> > Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Date:   Mon Jan 24 12:12:45 2022 -0500
> > 
> >      selftests/rseq: Uplift rseq selftests for compatibility with glibc-2.35
> >      
> >      glibc-2.35 (upcoming release date 2022-02-01) exposes the rseq per-thread
> >      data in the TCB, accessible at an offset from the thread pointer, rather
> >      than through an actual Thread-Local Storage (TLS) variable, as the
> >      Linux kernel selftests initially expected.
> >      
> >      The __rseq_abi TLS and glibc-2.35's ABI for per-thread data cannot
> >      actively coexist in a process, because the kernel supports only a single
> >      rseq registration per thread.
> >      
> >      Here is the scheme introduced to ensure selftests can work both with an
> >      older glibc and with glibc-2.35+:
> >      
> >      - librseq exposes its own "rseq_offset, rseq_size, rseq_flags" ABI.
> >      
> >      - librseq queries for glibc rseq ABI (__rseq_offset, __rseq_size,
> >        __rseq_flags) using dlsym() in a librseq library constructor. If those
> >        are found, copy their values into rseq_offset, rseq_size, and
> >        rseq_flags.
> >      
> >      - Else, if those glibc symbols are not found, handle rseq registration
> >        from librseq and use its own IE-model TLS to implement the rseq ABI
> >        per-thread storage.
> >      
> >      Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >      Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >      Link: https://lkml.kernel.org/r/20220124171253.22072-8-mathieu.desnoyers@efficios.com
> > 
> > But I don't see a similar adjustment for
> > tools/testing/selftests/kvm/rseq_test.c.  As an additional wrinkle,
> > you'd have to start calling getcpu (glibc function or system call)
> > because comparing rseq.cpu_id against sched_getcpu won't test anything
> > anymore once glibc implements sched_getcpu using rseq.
> > 
> > We noticed this because our downstream glibc version, while based on
> > 2.34, enables rseq registration by default.  To facilitate coordination
> > with rseq application usage, we also backported the __rseq_* ABI
> > symbols, so the selftests could use that even in our downstream version.
> > (We enable the glibc tunables downstream, but they are an optional
> > glibc feature, so it's probably better in the long run to fix the kernel
> > selftests rather than using the tunables as a workaround.)
> > 
> 
> Thanks for the pointer. It makes sense. So it means rseq registration has
> been done by glibc TLS? In this case, kvm/selftests/rseq is unable to
> register again.

The registration is done by glibc initialization and thread startup code.

> 
> I will come up something similiar for kvm/selftest/rseq.

Make sure to chech the rseq selftests fixes recently pulled in the current merge window as well. One is relevant:

https://github.com/torvalds/linux/commit/d1a997ba4c1bf65497d956aea90de42a6398f73a

We may want to find a way to remove this duplicated rseq.c code eventually.

Thanks,

Mathieu

> 
> Thanks,
> Gavin
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
