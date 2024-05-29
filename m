Return-Path: <linux-kselftest+bounces-10854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9FF8D3DDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 20:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A751C22BFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 18:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE051C0DE2;
	Wed, 29 May 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLRWpfbG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1601A38D6
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005920; cv=none; b=MTV6j+PxuiX1s8bzvOlNUT2MNZ9XZpjoDdBCODp0o5XOvuGzYLDgWi7+Mz1vIIdYRSj4auF0w3WHlYCjP6WI3n2qx1h0MQ0DAEZneQlEuZ5dr0ps+kK1bM7AxxiD9XlIugY4ZJW/+sYW4TzAFPJoXbMBK+l6ks6pgoAsY6wIDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005920; c=relaxed/simple;
	bh=h8JkqpoA+/dGY56tQssLYSYz7fbc8Z61hZF9yYzrrVk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mpIu9dQAbeWVSzihXFoXav4eWijU7KNwYJBODKSqFcu2vuiCktrzAeGFrN4BppPP/p0svQJSnqnIB+hlI3gIfVgUx7BvbCELWWvX90phL7KymxBXk9tFG5vEMKCE3TiZJZEpi44v5g8jJd/WrNCUuumqmMOFtIT9WAdW2TRD95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLRWpfbG; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-48ba698d852so23879137.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717005917; x=1717610717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oSeK4HIzvhbzZ4+kBhyxeRArFmVuKpeUMlCOBrkyZKY=;
        b=tLRWpfbGom0LK4rvIK0fV+2oiPGudLhbJMuEVPxaG9jqnjzkOp2rvqgebKwjHUIzu6
         6QybeDGEtIAIR5yD7T6WgXhxdgP/WAdhCuxqhRzZ5N0+wMxzBqzRk3xYB5fhkKjVK1k5
         XJHF3lEXkF9EzFibHmlEbsDcpoZ1gmhFnk6xMMk0m+LSsCeaAr6vV63Nqi9EGuljRGHk
         64/UW/2GsLbMsJeh/ZA7bh2IZfku27lIEE99+yXUgLPHtW/26razedGjyTWAW0Ct+glR
         O6zsGKJWCH/x247dAU+xCr4Pc9xfzNA5KKB/OKuGwPxSQByArJ5uF1E/x82EXR1ssTVd
         7RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717005917; x=1717610717;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSeK4HIzvhbzZ4+kBhyxeRArFmVuKpeUMlCOBrkyZKY=;
        b=EWnuUtyst9PnPsjocHycW8Zw37Cbo1xEIvAw9J1aSSMJ6dElNlXrFTE6iEpO2cbq0v
         KEtkkyqTzgPjyWpBoZ+mUjFjxBnrc80UbRvZ0gCUz6PR4DruIBIOky8e+8m0xbn7q2Pm
         dklj/OHrfdruSWJfdbH+Wt0bGl+HF5xN21YoWMJNU3XOin/xiBKhyNgyC0Nl1zfn83Y1
         1zT5w6/lsGLU2/eQOMqyaEjsM/vhBWRNnXWUA64tJj+iqSpBoBFtefPP0oScUGR9WN16
         QLLwJ4U8DRoHjpjO+/Kk5BKFN4LJwWSF7pxkX5AdC+HFGc8QI1/70SGrgPG6vWcaLpiJ
         gPNw==
X-Forwarded-Encrypted: i=1; AJvYcCWwk8TFfFQTZM8H2egU+9DsQc0+p+cBNC9Gth4XTGLaximlXdMBfc+6Olbcoz86d6t+cjeKzDtBv6Twp5DI12BLp8MZ+2gbtFwLrb6D65G2
X-Gm-Message-State: AOJu0YxdPjP4zb0Cv6YBk5KjQ3sfkSMya0DjdFIX/Rck9TAUZ8BmA6eN
	3ZDg50Tc5vNaJTMfNvL2coZZkGvajceV8XbqA95pe/ndgKY94HIsowCuq5GGa+eDTu8NN4hJRqH
	OQOoVmqax6Fp0KcWM2Q==
X-Google-Smtp-Source: AGHT+IGirSTR9frt+FMY7mEAkHJfvAwcaa/uk6kZfZAYRVHTIdMTLDcjTaGUq6V+fW4RjZ9NSYV+AI/l972bzeUv
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:3f9e:b0:48a:5834:cea7 with
 SMTP id ada2fe7eead31-48a5834e759mr882345137.7.1717005917523; Wed, 29 May
 2024 11:05:17 -0700 (PDT)
Date: Wed, 29 May 2024 18:05:03 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240529180510.2295118-1-jthoughton@google.com>
Subject: [PATCH v4 0/7] mm: multi-gen LRU: Walk secondary MMU page tables
 while aging
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	James Houghton <jthoughton@google.com>, James Morse <james.morse@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Shaoqin Huang <shahuang@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This patchset makes it possible for MGLRU to consult secondary MMUs
while doing aging, not just during eviction. This allows for more
accurate reclaim decisions, which is especially important for proactive
reclaim.

This series makes the necessary MMU notifier changes to MGLRU and then
includes optimizations on top of that. This series also now includes
changes to access_tracking_perf_test to verify that aging works properly
for pages that are mainly used by KVM.

access_tracking_perf_test also has a mode (-p) to check performance of
MGLRU aging while the VM is faulting memory in. Here are some results:

  Testing MGLRU aging while vCPUs are faulting in memory on x86 with the
  TDP MMU. THPs disabled.

  The test results varied a decent amount from run to run. I did my best to
  take representative averages, but nonetheless, the big picture is the
  important part.

  Main takeaways:
  - With the optimizations, the workload is much less impacted
    by the presence of aging.
  - With the optimizations, MGLRU is able to do aging much more
    quickly, especially at 8+ vCPUs on my machine.

  ./access_tracking_perf_test -p -l -b 1G -v $N_VCPUS # 1G per vCPU

  num_vcpus       vcpu wall time          aging avg pass time

  1 (no aging)    0.878822016             n/a
  1 (no opt)      0.938250568             0.008236007
  1 (opt)         0.912270190             0.007314582

  2 (no aging)    0.984959659             n/a
  2 (no opt)      1.057880728             0.017989741
  2 (opt)         1.037735641             0.013996319

  4 (no aging)    1.264881581             n/a
  4 (no opt)      1.318849182             0.056164918
  4 (opt)         1.314653465             0.029311993

  8 (no aging)    1.473883699             n/a
  8 (no opt)      1.589441079             0.227419586s
  8 (opt)         1.498439592             0.063857740s

  16 (no aging)   2.048766096             n/a
  16 (no opt)     2.399335597             1.247142841s
  16 (opt)        2.000914001             0.121628689s

  32 (no aging)   3.316256321             n/a
  32 (no opt)     3.955417018             4.347290433
  32 (opt)        3.355274507             0.250886289

  64 (no aging)   6.498958516             n/a
  64 (no opt)     7.127533884             9.815592054
  64 (opt)        6.442582168             1.392907010

  112 (no aging)  8.498029491             n/a
  112 (no opt)    10.21372495             13.47381656
  112 (opt)       8.896963554             2.292223850

Previous versions of this series included logic in MGLRU and KVM to
support batching the updates to secondary page tables. This version
removes this logic, as it was complex and not necessary to enable
proactive reclaim. This optimization, as well as the additional
optimizations for arm64 and powerpc, can be done in a later series.

Changes since v3[1]:
 - Vastly simplified the series (thanks David). Removed mmu notifier
   batching logic entirely.
 - Cleaned up how locking is done for mmu_notifier_test/clear_young
   (thanks David).
 - Look-around is now only done when there are no secondary MMUs
   subscribed to MMU notifiers.
 - CONFIG_LRU_GEN_WALKS_SECONDARY_MMU has been added.
 - Fixed the lockless implementation of kvm_{test,}age_gfn for x86
   (thanks David).
 - Added MGLRU functional and performance tests to
   access_tracking_perf_test (thanks Axel).
 - In v3, an mm would be completely ignored (for aging) if there was a
   secondary MMU but support for secondary MMU walking was missing. Now,
   missing secondary MMU walking support simply skips the notifier
   calls (except for eviction).
 - Added a sanity check for that range->lockless and range->on_lock are
   never both provided for the memslot walk.

For the changes from v2[2] to v3, see v3[1].

This series applies cleanly to mm/mm-unstable and kvm/queue.

[1]: https://lore.kernel.org/linux-mm/20240401232946.1837665-1-jthoughton@google.com/
[2]: https://lore.kernel.org/kvmarm/20230526234435.662652-1-yuzhao@google.com/

James Houghton (7):
  mm/Kconfig: Add LRU_GEN_WALKS_SECONDARY_MMU
  mm: multi-gen LRU: Have secondary MMUs participate in aging
  KVM: Add lockless memslot walk to KVM
  KVM: Move MMU lock acquisition for test/clear_young to architecture
  KVM: x86: Relax locking for kvm_test_age_gfn and kvm_age_gfn
  KVM: arm64: Relax locking for kvm_test_age_gfn and kvm_age_gfn
  KVM: selftests: Add multi-gen LRU aging to access_tracking_perf_test

 Documentation/admin-guide/mm/multigen_lru.rst |   6 +-
 arch/arm64/kvm/hyp/pgtable.c                  |   9 +-
 arch/arm64/kvm/mmu.c                          |  30 +-
 arch/loongarch/kvm/mmu.c                      |  20 +-
 arch/mips/kvm/mmu.c                           |  21 +-
 arch/powerpc/kvm/book3s.c                     |  14 +-
 arch/riscv/kvm/mmu.c                          |  26 +-
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/kvm/mmu/mmu.c                        |  10 +-
 arch/x86/kvm/mmu/tdp_iter.h                   |  27 +-
 arch/x86/kvm/mmu/tdp_mmu.c                    |  67 ++-
 include/linux/kvm_host.h                      |   1 +
 include/linux/mmzone.h                        |   6 +-
 mm/Kconfig                                    |   8 +
 mm/rmap.c                                     |   9 +-
 mm/vmscan.c                                   | 144 +++++--
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/access_tracking_perf_test.c | 365 ++++++++++++++--
 .../selftests/kvm/include/lru_gen_util.h      |  55 +++
 .../testing/selftests/kvm/lib/lru_gen_util.c  | 391 ++++++++++++++++++
 virt/kvm/kvm_main.c                           |  38 +-
 21 files changed, 1104 insertions(+), 145 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/lru_gen_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/lru_gen_util.c


base-commit: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
-- 
2.45.1.288.g0e0cd299f1-goog


