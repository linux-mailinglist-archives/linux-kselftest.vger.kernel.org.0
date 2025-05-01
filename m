Return-Path: <linux-kselftest+bounces-32069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD86AA5B82
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 09:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30607A8368
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 07:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C07276051;
	Thu,  1 May 2025 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="ATedqVIn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6BE2309B0;
	Thu,  1 May 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746085526; cv=none; b=CY0WeDP64LsQQ3Hu9xdbpQdMwTHN2Tj3p0BbH8K91Q4pXWeCK2xPoiWDmZOLbTCwcwZdjKAyGXS+Gb20wUPj0IL0bEe5GkMObfl8yv6PRkRj/lWkr3y9v9n4eKJjoCn3bVE2sg84SzWNjPgDgiGvBFqie09HrRA455MLPJU74L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746085526; c=relaxed/simple;
	bh=QTZ6U4fX9AbDc+bELt/R+cP87pvKLSXb27NFr9gyQlo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tP+id1KZeMtzhEQyiiTQ41CarQqZZn9KP1rGpIncE9zfUmKja8UAhLkDJcf21XCl3evapEKvzO9Uy8fW8mso3/eFqHQizH1hvJfv40sRyOIgTUuRXnwa4z/FWswruf9k/6zWXHHT5ZOH9LT9N4suTpstt72znoAzzgpy46Jz0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=ATedqVIn; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1746084968; bh=K7OHVYuZmHwzYYcyOkPMzX9Wbq0G6D2Zkg8HtjOYyi8=;
	h=From:To:Subject:Date:From:To:CC:Subject;
	b=ATedqVInRFreujHp4X2BHGTHkAKbtKurgYKV4vepneqBRNjUGLXDNJPPgcwaSf4YZ
	 hbY08gJ2vjaoNjkuPiY1m3uwCZD0wE2dqRCV9/cwmMIyGuOCs83aJnOc7y0AauIe19
	 03hNgRHKd/GbaN2np8Mx1NA6uHWVda7HlnctARMufcCwJFKtJLGazE1OOcrmUkHEel
	 F2T0+KD94afn2c3I8Xq7zvNwKGuY6UpcrbGI3/4frfxU9g3rOMRDRoJH/jImee33ld
	 68NtNNih5WHt8inQFfJhHk1BnnbKVBlbtbqeeNZF6/T0irnKiaEmdgfE9g7HZhzEWP
	 buWFgfW1C5CWA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zp5T35jYlz8sls;
	Thu,  1 May 2025 09:36:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3636:a700:12b2:e53f:6cbc:f48c
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3636:a700:12b2:e53f:6cbc:f48c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19pL7WFieYRy5yG8NPdAYH8gSfQgMR0Cx4=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zp5Sz4y7kz8sqL;
	Thu,  1 May 2025 09:36:03 +0200 (CEST)
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
Subject: [PATCH bpf-next v3 00/11] bpf: Mitigate Spectre v1 using barriers
Date: Thu,  1 May 2025 09:35:51 +0200
Message-ID: <20250501073603.1402960-1-luis.gerhorst@fau.de>
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

For this, it relies on the fact that speculation barriers prevent all
later instructions if the speculation was not correct:

* On x86_64, lfence acts as full speculation barrier, not only as a
  load fence [3]:

    An LFENCE instruction or a serializing instruction will ensure that
    no later instructions execute, even speculatively, until all prior
    instructions complete locally. [...] Inserting an LFENCE instruction
    after a bounds check prevents later operations from executing before
    the bound check completes.

  This was experimentally confirmed in [4].

* ARM's SB speculation barrier instruction also affects "any instruction
  that appears later in the program order than the barrier" [5].

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
[3] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/runtime-speculative-side-channel-mitigations.html
    ("Managed Runtime Speculative Execution Side Channel Mitigations")
[4] https://dl.acm.org/doi/pdf/10.1145/3359789.3359837 ("Speculator: a
    tool to analyze speculative execution attacks and mitigations" -
    Section 4.6 "Stopping Speculative Execution")
[5] https://developer.arm.com/documentation/ddi0597/2020-12/Base-Instructions/SB--Speculation-Barrier-
    ("SB - Speculation Barrier - Arm Armv8-A A32/T32 Instruction Set Architecture (2020-12)")

Changes:

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

Luis Gerhorst (11):
  selftests/bpf: Fix caps for __xlated/jited_unpriv
  bpf: Move insn if/else into do_check_insn()
  bpf: Return -EFAULT on misconfigurations
  bpf: Return -EFAULT on internal errors
  bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4()
  bpf, arm64, powerpc: Change nospec to include v1 barrier
  bpf: Rename sanitize_stack_spill to nospec_result
  bpf: Fall back to nospec for Spectre v1
  selftests/bpf: Add test for Spectre v1 mitigation
  bpf: Allow nospec-protected var-offset stack access
  bpf: Fall back to nospec for sanitization-failures

 arch/arm64/net/bpf_jit.h                      |   5 +
 arch/arm64/net/bpf_jit_comp.c                 |  28 +-
 arch/powerpc/net/bpf_jit_comp64.c             |  80 ++-
 include/linux/bpf.h                           |  11 +-
 include/linux/bpf_verifier.h                  |   3 +-
 include/linux/filter.h                        |   2 +-
 kernel/bpf/core.c                             |  32 +-
 kernel/bpf/verifier.c                         | 653 ++++++++++--------
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../selftests/bpf/progs/verifier_and.c        |   8 +-
 .../selftests/bpf/progs/verifier_bounds.c     |  66 +-
 .../bpf/progs/verifier_bounds_deduction.c     |  45 +-
 .../selftests/bpf/progs/verifier_map_ptr.c    |  20 +-
 .../selftests/bpf/progs/verifier_movsx.c      |  16 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |  65 +-
 .../bpf/progs/verifier_value_ptr_arith.c      | 101 ++-
 tools/testing/selftests/bpf/test_loader.c     |  14 +-
 .../selftests/bpf/verifier/dead_code.c        |   3 +-
 tools/testing/selftests/bpf/verifier/jmp32.c  |  33 +-
 tools/testing/selftests/bpf/verifier/jset.c   |  10 +-
 20 files changed, 771 insertions(+), 428 deletions(-)


base-commit: 358b1c0f56ebb6996fcec7dcdcf6bae5dcbc8b6c
-- 
2.49.0


