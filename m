Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC74985FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbiAXRND (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:13:03 -0500
Received: from mail.efficios.com ([167.114.26.124]:47534 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbiAXRND (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 85E4834510B;
        Mon, 24 Jan 2022 12:13:02 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zLtCHEblF7-H; Mon, 24 Jan 2022 12:13:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0774F344CCA;
        Mon, 24 Jan 2022 12:13:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0774F344CCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044382;
        bh=pwRIv4rPPqHaq4ss6KLwBKrB6pKid4L8cUtlJHoIJn0=;
        h=From:To:Date:Message-Id;
        b=Y6gGY37X5scSphKgS7ve01tm7PYjMtlO+WFAghqkA2+nh0TzELYi4VbXdWtD8Wf4S
         BnxjQpk5CyB5IIcEHjNwzUgHQ1sIoAByjtQi9qP9d6+BvZCExTUSn1BVa/g0pYg8B1
         031LIWFzhB3OaetlAU50AQvRxbZRH/K/OW9mFBkncFEQkxo2hjZ+v9sWLkazs2Eb0I
         tE7bCNUcKQf0mqvs0DG01kTqb2FhzDNp1qQEHRTDeWZqO/HXHQig+s39xPOo3+Lk0J
         KaAWqqWb6Fzswe1vfHlkaCH1bzmGm7oVgOMoF0gYVtqKJSuA4fMi+ACCPvw425dUDg
         E4JyyHV3w/DVw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wa59DO4LSHYQ; Mon, 24 Jan 2022 12:13:01 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id A1BCF344CC9;
        Mon, 24 Jan 2022 12:13:01 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 00/15] rseq uapi and selftest updates
Date:   Mon, 24 Jan 2022 12:12:38 -0500
Message-Id: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update the rseq selftests to adapt to the userspace ABI chosen by glibc
(will be released in February 2022). Provide a fallback implementation
to work with older glibc as well.

Remove broken 32-bit little/big endian accessor fields in rseq uapi.

Integrate various fixes gathered from librseq, including work-around for
known gcc and clang compiler bugs with asm goto.

The uplift to glibc's userspace ABI means we can now use %fs/%gs segment
selectors directly in the inline assembler for accesses to the rseq
thread area on x86.

Feedback is welcome,

Thanks,

Mathieu

Mathieu Desnoyers (15):
  selftests/rseq: introduce own copy of rseq uapi header
  rseq: Remove broken uapi field layout on 32-bit little endian
  selftests/rseq: Remove useless assignment to cpu variable
  selftests/rseq: Remove volatile from __rseq_abi
  selftests/rseq: Introduce rseq_get_abi() helper
  selftests/rseq: Introduce thread pointer getters
  selftests/rseq: Uplift rseq selftests for compatibility with
    glibc-2.35
  selftests/rseq: Fix ppc32: wrong rseq_cs 32-bit field pointer on big
    endian
  selftests/rseq: Fix ppc32 missing instruction selection "u" and "x"
    for load/store
  selftests/rseq: Fix ppc32 offsets by using long rather than off_t
  selftests/rseq: Fix warnings about #if checks of undefined tokens
  selftests/rseq: Remove arm/mips asm goto compiler work-around
  selftests/rseq: Fix: work-around asm goto compiler bugs
  selftests/rseq: x86-64: use %fs segment selector for accessing rseq
    thread area
  selftests/rseq: x86-32: use %gs segment selector for accessing rseq
    thread area

 include/uapi/linux/rseq.h                     |  17 +-
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/basic_percpu_ops_test.c    |   2 +-
 tools/testing/selftests/rseq/compiler.h       |  30 +++
 tools/testing/selftests/rseq/param_test.c     |   8 +-
 tools/testing/selftests/rseq/rseq-abi.h       | 151 +++++++++++++
 tools/testing/selftests/rseq/rseq-arm.h       | 110 +++++-----
 tools/testing/selftests/rseq/rseq-arm64.h     |  79 +++++--
 .../rseq/rseq-generic-thread-pointer.h        |  25 +++
 tools/testing/selftests/rseq/rseq-mips.h      |  71 ++-----
 .../selftests/rseq/rseq-ppc-thread-pointer.h  |  30 +++
 tools/testing/selftests/rseq/rseq-ppc.h       | 128 +++++++----
 tools/testing/selftests/rseq/rseq-s390.h      |  55 +++--
 tools/testing/selftests/rseq/rseq-skip.h      |   2 +-
 .../selftests/rseq/rseq-thread-pointer.h      |  19 ++
 .../selftests/rseq/rseq-x86-thread-pointer.h  |  40 ++++
 tools/testing/selftests/rseq/rseq-x86.h       | 200 ++++++++++++------
 tools/testing/selftests/rseq/rseq.c           | 163 +++++++-------
 tools/testing/selftests/rseq/rseq.h           |  29 ++-
 19 files changed, 793 insertions(+), 368 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/compiler.h
 create mode 100644 tools/testing/selftests/rseq/rseq-abi.h
 create mode 100644 tools/testing/selftests/rseq/rseq-generic-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h

-- 
2.17.1

