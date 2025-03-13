Return-Path: <linux-kselftest+bounces-28969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB63A5FDC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C50173B7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0544D16DC28;
	Thu, 13 Mar 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="SQb4+8R3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9078F4C;
	Thu, 13 Mar 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886981; cv=none; b=C6EYhz7VBHTlF5k+BBu2iGEjQIc6YqzU6MfEQXC4b5CWd1yVB92r8lkFYWh3FhKeF5mO2bYnEJm+7kmZtMTXo6FFbqVrGjDRFw8SUe08vdd18jPwvMi2NabQ6imTgB5W3B6GaQQBE4m0lk2dagbosliX9fmBZpEUkifuDFX8K3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886981; c=relaxed/simple;
	bh=6KZ4fjAT2bZCwY5Ayu8IzLehBcqStD+SrveP6Nwlt8w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nqrd9oh7nj1vOQyUPf+WW6afdQHUYQHo4jKzdoN7U++4apoqXtbqmdin+ywJ4vtEAOsWQ4206UtBhHU85E5WpB3CkpwXFxj7WnbIxEFyGUbR75pO20vK0PH+0dUg/Ep9gCxt7in2mQlx/wCZAPVR4LpJhNSGzR5Phfw3zfcmprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=SQb4+8R3; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1741886518; bh=Vto+5sxnbm5itz1/EdAaR/loDZXRrbOwTv+hhdfdi+g=;
	h=From:To:Subject:Date:From:To:CC:Subject;
	b=SQb4+8R3TWR3guJqo8PvChxi/O/yIjyNHMha8Fpu3fcZLoHvqRwGpqOblbKkwQb4r
	 c1kZod9390FDuTl/vD2BomjUVRQP1SWzWJ1Kxe3IEZwe0JM9RUBuyTsW2CIngIm2Ff
	 J4boAbcVavk1imK3SNhsdFte8535234fLWDgkYS2AOPn4Hv/PMbnI1wcxOm/Phfdo7
	 ikZfmJjnQl/8npWntufPP+VLIR2aixi5Yw76YDNFKqdUWqZfdXZgVTDZ7qBHAUIwNK
	 D9IvoeRve6/e8z3cNM72/+yB/3ui7Q2jN8r/90eJ8YkRJZLAy76bMKUztZskv8MxQ9
	 woxjQOdGBZnEA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZDDnf0gK1z1yGm;
	Thu, 13 Mar 2025 18:21:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3614:2b00:7ee6:68e5:4447:ba92
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3614:2b00:7ee6:68e5:4447:ba92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19Ijm4+IBM849zk+H8/lYlR6tkKHCOwLNk=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZDDnZ2L1Nz1yN1;
	Thu, 13 Mar 2025 18:21:54 +0100 (CET)
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
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>,
	WANG Xuerui <git@xen0n.name>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH bpf-next 00/11] bpf: Mitigate Spectre v1 using barriers
Date: Thu, 13 Mar 2025 18:21:16 +0100
Message-ID: <20250313172127.1098195-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.48.1
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

* Do not use separate bytecode insns for v1 and v4 barriers. This
  simplifies the verifier significantly and has the only downside that
  performance on PowerPC is not as high as it could be.

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

RFC: https://lore.kernel.org/bpf/20250224203619.594724-1-luis.gerhorst@fau.de/

Luis Gerhorst (11):
  bpf: Move insn if/else into do_check_insn()
  bpf: Return -EFAULT on misconfigurations
  bpf: Return -EFAULT on internal errors
  bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4()
  bpf, arm64, powerpc: Change nospec to include v1 barrier
  bpf: Rename sanitize_stack_spill to nospec_result
  bpf: Fall back to nospec for Spectre v1
  bpf: Allow nospec-protected var-offset stack access
  bpf: Return PTR_ERR from push_stack()
  bpf: Fall back to nospec for sanitization-failures
  bpf: Fall back to nospec for spec path verification

 arch/arm64/net/bpf_jit.h                      |   5 +
 arch/arm64/net/bpf_jit_comp.c                 |  28 +-
 arch/powerpc/net/bpf_jit_comp64.c             |  79 +-
 include/linux/bpf.h                           |  11 +-
 include/linux/bpf_verifier.h                  |   3 +-
 include/linux/filter.h                        |   2 +-
 kernel/bpf/core.c                             |  32 +-
 kernel/bpf/verifier.c                         | 723 ++++++++++--------
 .../selftests/bpf/progs/verifier_and.c        |   3 +-
 .../selftests/bpf/progs/verifier_bounds.c     |  35 +-
 .../bpf/progs/verifier_bounds_deduction.c     |  43 +-
 .../selftests/bpf/progs/verifier_map_ptr.c    |  12 +-
 .../selftests/bpf/progs/verifier_movsx.c      |   6 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |   3 +-
 .../bpf/progs/verifier_value_ptr_arith.c      |  50 +-
 .../selftests/bpf/verifier/dead_code.c        |   3 +-
 tools/testing/selftests/bpf/verifier/jmp32.c  |  33 +-
 tools/testing/selftests/bpf/verifier/jset.c   |  10 +-
 18 files changed, 630 insertions(+), 451 deletions(-)


base-commit: 46d38f489ef02175dcff1e03a849c226eb0729a6
-- 
2.48.1


