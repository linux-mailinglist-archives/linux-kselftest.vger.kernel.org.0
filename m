Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16604249D8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHSMN7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 08:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHSMN6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 08:13:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDBAD206DA;
        Wed, 19 Aug 2020 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597839238;
        bh=bIFlSXIIsQjIccJou2YAZAKBbvj6NCQucUbNoOBlCVU=;
        h=From:To:Cc:Subject:Date:From;
        b=pttSn2hY0g6Ci3LmbH9QuR4JebHg1e14+H+BxYrIEeDsg/BSs12kksw8bw+ooHOeI
         ma8/hfbQ91rYXMvPA5BUP7qHLmnHCUeQ8sSeZJSq9+zgB/oyco+/+8z7L89/L12bjT
         RA/8V1D/mD2o6Ir//A6D1nXRA8HjjARKGA8Fyba0=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/5] arm64: vdso: getcpu() support
Date:   Wed, 19 Aug 2020 13:13:13 +0100
Message-Id: <20200819121318.52158-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some applications, especially tracing ones, benefit from avoiding the
syscall overhead for getcpu() so it is common for architectures to have
vDSO implementations. Add one for arm64, using TPIDRRO_EL0 to pass a
pointer to per-CPU data rather than just store the immediate value in
order to allow for future extensibility.

It is questionable if something TPIDRRO_EL0 based is worthwhile at all
on current kernels, since v4.18 we have had support for restartable
sequences which can be used to provide a sched_getcpu() implementation
with generally better performance than the vDSO approach on
architectures which have that[1]. Work is ongoing to implement this for
glibc:

    https://lore.kernel.org/lkml/20200527185130.5604-3-mathieu.desnoyers@efficios.com/

but is not yet merged and will need similar work for other userspaces.
The main advantages for the vDSO implementation are the node parameter
(though this is a static mapping to CPU number so could be looked up
separately when processing data if it's needed, it shouldn't need to be
in the hot path) and ease of implementation for users.

This is currently not compatible with KPTI due to the use of TPIDRRO_EL0
by the KPTI trampoline, this could be addressed by reinitializing that
system register in the return path but I have found it hard to justify
adding that overhead for all users for something that is essentially a
profiling optimization which is likely to get superceeded by a more
modern implementation - if there are other uses for the per-CPU data
then the balance might change here.

This builds on work done by Kristina Martsenko some time ago but is a
new implementation.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7822b1e24f2df5df98c76f0e94a5416349ff759

v3:
 - Rebase on v5.9-rc1.
 - Drop in progress portions of the series.
v2:
 - Rebase on v5.8-rc3.
 - Add further cleanup patches & a first draft of multi-page support.

Mark Brown (5):
  arm64: vdso: Provide a define when building the vDSO
  arm64: vdso: Add per-CPU data
  arm64: vdso: Initialise the per-CPU vDSO data
  arm64: vdso: Add getcpu() implementation
  selftests: vdso: Support arm64 in getcpu() test

 arch/arm64/include/asm/processor.h            | 12 +----
 arch/arm64/include/asm/vdso/datapage.h        | 54 +++++++++++++++++++
 arch/arm64/kernel/process.c                   | 26 ++++++++-
 arch/arm64/kernel/vdso.c                      | 33 +++++++++++-
 arch/arm64/kernel/vdso/Makefile               |  4 +-
 arch/arm64/kernel/vdso/vdso.lds.S             |  1 +
 arch/arm64/kernel/vdso/vgetcpu.c              | 48 +++++++++++++++++
 .../testing/selftests/vDSO/vdso_test_getcpu.c | 10 ++++
 8 files changed, 172 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/include/asm/vdso/datapage.h
 create mode 100644 arch/arm64/kernel/vdso/vgetcpu.c

-- 
2.20.1

