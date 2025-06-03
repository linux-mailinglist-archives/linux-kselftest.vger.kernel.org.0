Return-Path: <linux-kselftest+bounces-34249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC79EACCE97
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 23:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3D87A2F2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05B223301;
	Tue,  3 Jun 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="SYBaqtRb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A861F12F4;
	Tue,  3 Jun 2025 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984636; cv=none; b=KM8SU6zMP3CN38nLl+5pDDeVkYgOguN9TZPR45fndMBEzG+u6zXGaRnaykIdjBOXxWWJoiM7YhcRjR6NoyskXDcosgvb4nXbQyPEgt75WXXI4bG8I2Aah8c1bAsmSMrM+4+vNv9SrEoYyjy0vCDryc2TgMyLrtT0ZPMD3mVKKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984636; c=relaxed/simple;
	bh=W6Nhh3ZCRHLqwfzIjPbKNeTIxBcOEyxYHK4U+kynE/E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eQYhMJtIDHePSkfZ2iWaPqTK3fz0OWATJ8XyZ+6arZ0Dcq76aRHDVVeR/zQGQ4TjTVLo8AIbhEUxfnaHXnnMLy+FQy6+h1q8o32+SZN9Vt9aoDZbabd9b2xtRSyX+JYRn2X/8jCSAZIIgm1RFEMJkmjaYDLPNXBhYP4aOznVaq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=SYBaqtRb; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1748984285; bh=xfzs1Ogf0DKZ/YULLmQfkygDrX6ZPmGjv16hUj4o9H0=;
	h=From:To:Subject:Date:From:To:CC:Subject;
	b=SYBaqtRb39acS5t+QgIbA5sTlWkgJzSPyuQBg1BDigIHp16Q2J/creWnuLgUDMWZJ
	 HM92g2qDmrsm9ijFygECQZpwQg4b9fHx5AKuv6kh2x7aDcuzebqcLZlnVvcr0wKrNV
	 hSoY28zujYOOGh8snrGw3+Cxg7/FDQiImLPk/gCq4lw0rs9C1EUAej/4+//y8Uk1XF
	 LyIDw5qlnWUEEayv4TalHGl8qToxaNA8suYioxYyqfmvdkkZJv6+9TGWWyJvKavuoc
	 /eDRiOqrKMYivjN3ntSu8Gd2+miv7iE3ZU1TYst+lOHPTTzDVoVPRO1xHnkS3iH4ky
	 OYT1MNbk3MiTw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bBjj90qyPzPjvv;
	Tue,  3 Jun 2025 22:58:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3639:fe00:a21f:4ce4:8495:5578
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3639:fe00:a21f:4ce4:8495:5578])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+JbA/3lyDF+n/+UvApQhduk6C5CJwWwrU=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bBjj46tHzzPkFW;
	Tue,  3 Jun 2025 22:58:00 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Henriette Herzog <henriette.herzog@rub.de>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Jiayuan Chen <mrpre@163.com>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/9] bpf: Mitigate Spectre v1 using barriers
Date: Tue,  3 Jun 2025 22:57:51 +0200
Message-ID: <20250603205800.334980-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This improves the expressiveness of unprivileged BPF by inserting
speculation barriers instead of rejecting the programs.

The approach was previously presented at LPC'24 [1] and RAID'24 [2].

To mitigate the Spectre v1 (PHT) vulnerability, the kernel rejects
potentially-dangerous unprivileged BPF programs as of
commit 9183671af6db ("bpf: Fix leakage under speculation on mispredicted
branches"). In [2], we have analyzed 364 object files from open source
projects (Linux Samples and Selftests, BCC, Loxilb, Cilium, libbpf
Examples, Parca, and Prevail) and found that this affects 31% to 54% of
programs.

To resolve this in the majority of cases this patchset adds a fall-back
for mitigating Spectre v1 using speculation barriers. The kernel still
optimistically attempts to verify all speculative paths but uses
speculation barriers against v1 when unsafe behavior is detected. This
allows for more programs to be accepted without disabling the BPF
Spectre mitigations (e.g., by setting cpu_mitigations_off()).

For this, it relies on the fact that speculation barriers generally
prevent all later instructions from executing if the speculation was not
correct (not only loads). See patch 7 ("bpf: Fall back to nospec for
Spectre v1") for a detailed description and references to the relevant
vendor documentation (AMD and Intel x86-64, ARM64, and PowerPC).

In [1] we have measured the overhead of this approach relative to having
mitigations off and including the upstream Spectre v4 mitigations. For
event tracing and stack-sampling profilers, we found that mitigations
increase BPF program execution time by 0% to 62%. For the Loxilb network
load balancer, we have measured a 14% slowdown in SCTP performance but
no significant slowdown for TCP. This overhead only applies to programs
that were previously rejected.

I reran the expressiveness-evaluation with v6.14 and made sure the main
results still match those from [1] and [2] (which used v6.5).

Main design decisions are:

* Do not use separate bytecode insns for v1 and v4 barriers (inspired by
  Daniel Borkmann's question at LPC). This simplifies the verifier
  significantly and has the only downside that performance on PowerPC is
  not as high as it could be.

* Allow archs to still disable v1/v4 mitigations separately by setting
  bpf_jit_bypass_spec_v1/v4(). This has the benefit that archs can
  benefit from improved BPF expressiveness / performance if they are not
  vulnerable (e.g., ARM64 for v4 in the kernel).

* Do not remove the empty BPF_NOSPEC implementation for backends for
  which it is unknown whether they are vulnerable to Spectre v1.

[1] https://lpc.events/event/18/contributions/1954/ ("Mitigating
    Spectre-PHT using Speculation Barriers in Linux eBPF")
[2] https://arxiv.org/pdf/2405.00078 ("VeriFence: Lightweight and
    Precise Spectre Defenses for Untrusted Linux Kernel Extensions")

Changes:

* v3 -> v4:
  - Remove insn parameter from do_check_insn() and extract
    process_bpf_exit_full as a function as requested by Eduard
  - Investigate apparent sanitize_check_bounds() bug reported by
    Kartikeya (does appear to not be a bug but only confusing code),
    sent separate patch to document it and add an assert
  - Remove already-merged commit 1 ("selftests/bpf: Fix caps for
    __xlated/jited_unpriv")
  - Drop former commit 10 ("bpf: Allow nospec-protected var-offset stack
    access") as it did not include a test and there are other places
    where var-off is rejected. Also, none of the tested real-world
    programs used var-off in the paper. Therefore keep the old behavior
    for now and potentially prepare a patch that converts all cases
    later if required.
  - Add link to AMD lfence and PowerPC speculation barrier (ori 31,31,0)
    documentation
  - Move detailed barrier documentation to commit 7 ("bpf: Fall back to
    nospec for Spectre v1")
  - Link to v3: https://lore.kernel.org/all/20250501073603.1402960-1-luis.gerhorst@fau.de/

* v2 -> v3:
  - Fix
    https://lore.kernel.org/oe-kbuild-all/202504212030.IF1SLhz6-lkp@intel.com/
    and similar by moving the bpf_jit_bypass_spec_v1/v4() prototypes out
    of the #ifdef CONFIG_BPF_SYSCALL. Decided not to move them to
    filter.h (where similar bpf_jit_*() prototypes live) as they would
    still have to be duplicated in bpf.h to be usable to
    bpf_bypass_spec_v1/v4() (unless including filter.h in bpf.h is an
    option).
  - Fix
    https://lore.kernel.org/oe-kbuild-all/202504220035.SoGveGpj-lkp@intel.com/
    by moving the variable declarations out of the switch-case.
  - Build touched C files with W=2 and bpf config on x86 to check that
    there are no other warnings introduced.
  - Found 3 more checkpatch warnings that can be fixed without degrading
    readability.
  - Rebase to bpf-next 2025-05-01
  - Link to v2: https://lore.kernel.org/bpf/20250421091802.3234859-1-luis.gerhorst@fau.de/

* v1 -> v2:
  - Drop former commits 9 ("bpf: Return PTR_ERR from push_stack()") and 11
    ("bpf: Fall back to nospec for spec path verification") as suggested
    by Alexei. This series therefore no longer changes push_stack() to
    return PTR_ERR.
  - Add detailed explanation of how lfence works internally and how it
    affects the algorithm.
  - Add tests checking that nospec instructions are inserted in expected
    locations using __xlated_unpriv as suggested by Eduard (also,
    include a fix for __xlated_unpriv)
  - Add a test for the mitigations from the description of
    commit 9183671af6db ("bpf: Fix leakage under speculation on
    mispredicted branches")
  - Remove unused variables from do_check[_insn]() as suggested by
    Eduard.
  - Remove INSN_IDX_MODIFIED to improve readability as suggested by
    Eduard. This also causes the nospec_result-check to run (and fail)
    for jumping-ops. Add a warning to assert that this check must never
    succeed in that case.
  - Add details on the safety of patch 10 ("bpf: Allow nospec-protected
    var-offset stack access") based on the feedback on v1.
  - Rebase to bpf-next-250420
  - Link to v1: https://lore.kernel.org/all/20250313172127.1098195-1-luis.gerhorst@fau.de/

* RFC -> v1:
  - rebase to bpf-next-250313
  - tests: mark expected successes/new errors
  - add bpt_jit_bypass_spec_v1/v4() to avoid #ifdef in
    bpf_bypass_spec_v1/v4()
  - ensure that nospec with v1-support is implemented for archs for
    which GCC supports speculation barriers, except for MIPS
  - arm64: emit speculation barrier
  - powerpc: change nospec to include v1 barrier
  - discuss potential security (archs that do not impl. BPF nospec) and
    performance (only PowerPC) regressions
  - Link to RFC: https://lore.kernel.org/bpf/20250224203619.594724-1-luis.gerhorst@fau.de/

Luis Gerhorst (9):
  bpf: Move insn if/else into do_check_insn()
  bpf: Return -EFAULT on misconfigurations
  bpf: Return -EFAULT on internal errors
  bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4()
  bpf, arm64, powerpc: Change nospec to include v1 barrier
  bpf: Rename sanitize_stack_spill to nospec_result
  bpf: Fall back to nospec for Spectre v1
  selftests/bpf: Add test for Spectre v1 mitigation
  bpf: Fall back to nospec for sanitization-failures

 arch/arm64/net/bpf_jit.h                      |   5 +
 arch/arm64/net/bpf_jit_comp.c                 |  28 +-
 arch/powerpc/net/bpf_jit_comp64.c             |  80 ++-
 include/linux/bpf.h                           |  11 +-
 include/linux/bpf_verifier.h                  |   3 +-
 include/linux/filter.h                        |   2 +-
 kernel/bpf/core.c                             |  32 +-
 kernel/bpf/verifier.c                         | 633 ++++++++++--------
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../selftests/bpf/progs/verifier_and.c        |   8 +-
 .../selftests/bpf/progs/verifier_bounds.c     |  66 +-
 .../bpf/progs/verifier_bounds_deduction.c     |  45 +-
 .../selftests/bpf/progs/verifier_map_ptr.c    |  20 +-
 .../selftests/bpf/progs/verifier_movsx.c      |  16 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |  65 +-
 .../bpf/progs/verifier_value_ptr_arith.c      | 101 ++-
 .../selftests/bpf/verifier/dead_code.c        |   3 +-
 tools/testing/selftests/bpf/verifier/jmp32.c  |  33 +-
 tools/testing/selftests/bpf/verifier/jset.c   |  10 +-
 19 files changed, 755 insertions(+), 410 deletions(-)


base-commit: cd2e103d57e5615f9bb027d772f93b9efd567224
-- 
2.49.0


