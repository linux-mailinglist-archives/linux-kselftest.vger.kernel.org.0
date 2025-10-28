Return-Path: <linux-kselftest+bounces-44235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941DC1702A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB96A1A63546
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5863570D2;
	Tue, 28 Oct 2025 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRldQMR9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33513570C7
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686741; cv=none; b=SK+pB4jRLtl6YzVL0lhKmGsMvESo1GZLinqeXvUXPMD3E6yxqL78IsFueYg5Ekjx7bSSXrWYAvmNi9WV8TFT4Y0/JJEv3X1gQ5JK2pjcyOH0Wrt9N6bILTfOfL9JCRhCPKNG28uIIYFIyoMvtcZKJ1G7rN6xyuX4dPzACwbhKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686741; c=relaxed/simple;
	bh=VONa5+qGmceUz/WA5Ut4vRFxC2i/SKI2Ca9kKEHzbt8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jRvRgTsBaPjQsW+rf/5UCWGH7c3bOI/uac4UM1aPw2NVUw3AdxhvEJnFNECOWlrOQiZ2INgAk2i34R37fwJhcOzFUMQc1Z3/Cm/P6uQlno8bOU2Sfe39FtwZPFgEqRAILzaADWtLKU5JjDNjpr834jx5HmjiA2eIssaavnnFjyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRldQMR9; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-63e1d6438e0so8258876d50.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686738; x=1762291538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U4p6kxOlNOG31wIDXmwy414BSQw9sWas+789Bv9fSts=;
        b=sRldQMR9bGFZcTGpGR/kF50apQxspOQb9yLQuOgNfr+ScULM/dVFL7Q0WMYyjjW0Zm
         djz2EpBg6SFifB+PTE4YWtAMQ5rNIh17w6gmIMidgJcSGWeUjUvOhBPigRu+bBP+pkq+
         mdQeP0r1Z5nYZLx1EFYE2dIKFGduIeOxkEPc2cD72LAhZ5GdG3+7rBIullPFAEyBcZWp
         fPBMF54Sp6JUS9P3oAbQDLzhTE3CaEe0piX1Yx4WuHSbcUtYf3DKfei+nGq7A7Qp/J6l
         6ZDCjOS2Gm9DqDPYn//KQsGqT73IKp1iycZIXI8vwcmAU85wuy/HjUY+CNmp3aJLCQE/
         9dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686738; x=1762291538;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4p6kxOlNOG31wIDXmwy414BSQw9sWas+789Bv9fSts=;
        b=v8YwT+FDp2ZL0dSlCEN2tn8SXMCu+rHRNwo7uBJHfZ71b6ID0hXkZgLXIYDtMRL890
         IKtIjBVDC56TRvV5QGMlU/+Q29zrMCISXvzawSdS4XbopGIl7WZmT1lOS8JGWJuImYDc
         LnLth9V82YKsxiUkw/fBhWWGeIMhkj/lpcGiiYTsoi65MvEZ6e88qZunS9rmvVD51kjx
         pp2V+HgMrIJrhZoaXDdpTy5NMlcNURszDPbt/e87heEGUbEmzzSfDJ/Z0ZvchDJA6cKO
         B/SawEv880NmQ/ivCNKnsKpmW6E3Sn5ZStSFEwwMTwVWOiozM1cxHtgDbVEt3ns72BdU
         AaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmbO+b83RJN1m5YBPdibsQ6DADT8PH9H9IR+9w4UA7fj1CUE7m78lR0vMSaObgzZxMPGdnUqmknhUG6pV9GCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweeKHKRZZIsZEtwphzZxjcBQLwDpfawzJzQIuXwYzR/lQxgrh1
	fHxZWgAh8sgSUqd/IAH2A8Yxmk1uPlUqxZNobtEZ1uOoy2qXrNtWPUkce5SFf6zq+JSHAWnM6pa
	ZXdA4b4S9u43GpKKj2zXYAlsiwg==
X-Google-Smtp-Source: AGHT+IGJWNdmzr+80PlpfT/LLo3Pibom+vpVqtRUcL1zZ6uSsgkD1esTGCr9/87u9nvyfQFqt6WKW0iDTdv7HmQAjw==
X-Received: from yxli18.prod.google.com ([2002:a53:c0d2:0:b0:63f:2d9a:6543])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:38c:b0:63e:1de4:7fc0 with SMTP id 956f58d0204a3-63f76df7854mr600821d50.66.1761686737742;
 Tue, 28 Oct 2025 14:25:37 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:24:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212528.681081-1-kaleshsingh@google.com>
Subject: [PATCH v4 0/5] mm: Refactor and improve VMA count limit code
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: rostedt@goodmis.org, hughd@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This series refactors the VMA count limit code to improve clarity,
test coverage, and observability.

The VMA count limit, controlled by sysctl_max_map_count, is a safeguard
that prevents a single process from consuming excessive kernel memory
by creating too many memory mappings.

A major change since v3 is the first patch in the series which instead of 
attempting to fix overshooting the limit now documents that this is the
intended behavior. As Hugh pointed out, the lenient check (>) in do_mmap()
and do_brk_flags() is intentional to allow for potential VMA merges or
expansions when the process is at the sysctl_max_map_count limit. 
The consensus is that this historical behavior is correct but non-obvious.

This series now focuses on making that behavior clear and the surrounding
code more robust. Based on feedback from Lorenzo and David, this series
retains the helper function and the rename of map_count.

The refined v4 series is now structured as follows:

1.  Documents the lenient VMA count checks with comments to clarify
    their purpose.

2.  Adds a comprehensive selftest to codify the expected behavior at the
    limit, including the lenient mmap case.

3.  Introduces max_vma_count() to abstract the max map count sysctl,
    making the sysctl static and converting all callers to use the new
    helper.

4.  Renames mm_struct->map_count to the more explicit vma_count for
    better code clarity.

5.  Adds a tracepoint for observability when a process fails to
    allocate a VMA due to the count limit.

Tested on x86_64 and arm64:

 1. Build test:
      allyesconfig for rename

 2. Selftests:
      cd tools/testing/selftests/mm && \
          make && \
          ./run_vmtests.sh -t max_vma_count

 3. vma tests:
      cd tools/testing/vma && \
          make && \
          ./vma

Link to v3:
https://lore.kernel.org/r/20251013235259.589015-1-kaleshsingh@google.com/

Thanks to everyone for the valuable discussion on previous revisions.

-- Kalesh

Kalesh Singh (5):
  mm: Document lenient map_count checks
  mm/selftests: add max_vma_count tests
  mm: Introduce max_vma_count() to abstract the max map count sysctl
  mm: rename mm_struct::map_count to vma_count
  mm/tracing: introduce trace_mm_insufficient_vma_slots event

 MAINTAINERS                                   |   2 +
 fs/binfmt_elf.c                               |   2 +-
 fs/coredump.c                                 |   2 +-
 include/linux/mm.h                            |   2 -
 include/linux/mm_types.h                      |   2 +-
 include/trace/events/vma.h                    |  32 +
 kernel/fork.c                                 |   2 +-
 mm/debug.c                                    |   2 +-
 mm/internal.h                                 |   3 +
 mm/mmap.c                                     |  25 +-
 mm/mremap.c                                   |  13 +-
 mm/nommu.c                                    |   8 +-
 mm/util.c                                     |   1 -
 mm/vma.c                                      |  42 +-
 mm/vma_internal.h                             |   2 +
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/max_vma_count_tests.c        | 716 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   5 +
 tools/testing/vma/vma.c                       |  32 +-
 tools/testing/vma/vma_internal.h              |  13 +-
 21 files changed, 856 insertions(+), 52 deletions(-)
 create mode 100644 include/trace/events/vma.h
 create mode 100644 tools/testing/selftests/mm/max_vma_count_tests.c


base-commit: b227c04932039bccc21a0a89cd6df50fa57e4716
-- 
2.51.1.851.g4ebd6896fd-goog


