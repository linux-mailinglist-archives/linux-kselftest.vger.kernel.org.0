Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F0F58CBC4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 18:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbiHHQBn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Aug 2022 12:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243127AbiHHQBk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Aug 2022 12:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF29314035
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Aug 2022 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659974494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7pT5UbHsiY1LLtifq5MffoFG8hCa3QU5ajq1qvlO3Ug=;
        b=Jj/PwG1dzX1HrCRd5IGpYt6mY3AKZU3OpaLBWcpmvLugcJ00G/65GEOEQPpw/T2n8y+HHJ
        fZ2M4jJbXlmR//KeS6h9yN29FG92jA1RkdRy+h2oymluaj0cDw1mMddD0TYEjgeGeHFpnG
        iRqQY07L6S4s7ibw1WeBoLSjZUA390I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-3mEvrRj8MAydhgbrNyi6nA-1; Mon, 08 Aug 2022 12:01:32 -0400
X-MC-Unique: 3mEvrRj8MAydhgbrNyi6nA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EE1D801585;
        Mon,  8 Aug 2022 16:01:27 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3457140EBE3;
        Mon,  8 Aug 2022 16:01:25 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gavin Shan <gshan@redhat.com>
Subject: tools/testing/selftests/kvm/rseq_test and glibc 2.35
Date:   Mon, 08 Aug 2022 18:01:23 +0200
Message-ID: <875yj2n2r0.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It has come to my attention that the KVM rseq test apparently needs to
be ported to glibc 2.35.  The background is that on aarch64, rseq is the
only way to get a practically useful sched_getcpu.  (There's no hidden
per-task CPU state the vDSO could reveal as the CPU ID.)

The main rseq tests have already been adjusted via:

commit 233e667e1ae3e348686bd9dd0172e62a09d852e1
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Jan 24 12:12:45 2022 -0500

    selftests/rseq: Uplift rseq selftests for compatibility with glibc-2.35
    
    glibc-2.35 (upcoming release date 2022-02-01) exposes the rseq per-thread
    data in the TCB, accessible at an offset from the thread pointer, rather
    than through an actual Thread-Local Storage (TLS) variable, as the
    Linux kernel selftests initially expected.
    
    The __rseq_abi TLS and glibc-2.35's ABI for per-thread data cannot
    actively coexist in a process, because the kernel supports only a single
    rseq registration per thread.
    
    Here is the scheme introduced to ensure selftests can work both with an
    older glibc and with glibc-2.35+:
    
    - librseq exposes its own "rseq_offset, rseq_size, rseq_flags" ABI.
    
    - librseq queries for glibc rseq ABI (__rseq_offset, __rseq_size,
      __rseq_flags) using dlsym() in a librseq library constructor. If those
      are found, copy their values into rseq_offset, rseq_size, and
      rseq_flags.
    
    - Else, if those glibc symbols are not found, handle rseq registration
      from librseq and use its own IE-model TLS to implement the rseq ABI
      per-thread storage.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: https://lkml.kernel.org/r/20220124171253.22072-8-mathieu.desnoyers@efficios.com

But I don't see a similar adjustment for
tools/testing/selftests/kvm/rseq_test.c.  As an additional wrinkle,
you'd have to start calling getcpu (glibc function or system call)
because comparing rseq.cpu_id against sched_getcpu won't test anything
anymore once glibc implements sched_getcpu using rseq.

We noticed this because our downstream glibc version, while based on
2.34, enables rseq registration by default.  To facilitate coordination
with rseq application usage, we also backported the __rseq_* ABI
symbols, so the selftests could use that even in our downstream version.
(We enable the glibc tunables downstream, but they are an optional
glibc feature, so it's probably better in the long run to fix the kernel
selftests rather than using the tunables as a workaround.)

Thanks,
Florian

