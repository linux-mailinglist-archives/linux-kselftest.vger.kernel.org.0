Return-Path: <linux-kselftest+bounces-43062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E51CBD6CCB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 01:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9696F3A64E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 23:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5B32EE5F5;
	Mon, 13 Oct 2025 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+xk3AH3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A99271459
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399738; cv=none; b=YLIEIZUvbMvV3yE69rnb0fmN34OfP1wMPzh5CDHUdBgZovkuJ1c0ldQbPah2J6gBNGGDh7Lfa5UBdSuy5F/GNlTMoAiiq8Ou3Z8GLQoZVOMOMhNTbf0a52QVUSh3KVzNh+ukqR0IRHYMv5W8zWMH4S8VkSK83PP/1t2AfsguzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399738; c=relaxed/simple;
	bh=urzKYwsz4v8MUa+hzukBWSpBHTXA4qGcUAhV7CQ87z0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WCKwekrssdaBfNE5pWS08npMjNteZJaYVv8Re5gPi0a/bTjc2zYTtGIkBo59oyTP7RCbeilCFIcl1Q05XnmNrLI70dHLltg3/PJSkwIjSKUo5e/6o9AEzvZ1mrgb8U7naXRHpwxcjVrZpdRHCidDubiC/0dOXhNsVb3i1kwLD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+xk3AH3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so10006635a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 16:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760399736; x=1761004536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gOLw9DyCbQUK9US9qj81M7l3NRwOmAnngyQTgfMrJas=;
        b=D+xk3AH3IhW9BLj49dBoLZViY1M+COVm9KLmUSgK7PLp56BP8AAqx1ChSxQbX8RLF0
         mR9sXcncaww01vpUvURjhzQcNNOP4l4Ea1G3D32B4nyodWbXi6XeZag4BDhfc+Gekhto
         S5ocXF5YKqV2BkRdv/8GiDsYKNmq4P/s5QMnOffdCn25Km/zD67Jk3sEk6UVv2Ke3nrV
         NRSSizC+dOpoAQixssbcLXDIde7BJ7yRzgdtsfqXKCXMfMzLELHNj20/xRTQill+1viY
         I6wVh9y/799Wa5PrUbPmmJw+7fvxwGMKr7L/4i6gnl7Oiu0Ct7Ly1izlNk9yddP7AhMa
         tgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399736; x=1761004536;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOLw9DyCbQUK9US9qj81M7l3NRwOmAnngyQTgfMrJas=;
        b=kG2+aSPcQ6DasWd4UO7ly0Umdxh+rg+W+DI54WI86MiFOP3W3LoR2d3cXfg7j14OZJ
         shtGn6DcdW1mJA0MrWNmb1T892SVHhW8nQvv4jpUQ9rPSPh/Z+7py6Tzf4g703STEAhL
         lATtsk6E4kDQ80SOCZIoSYovtgmhq9LYbI/vsxX7xznQCFNNbzT8aoOZOd6TtbNpxuaS
         TzbNYkckaCD5SuiobT28A4eTVHYlCRaLl0oBLQM2uji+LR/I+QA6PYeTw8fRtMsc8SxI
         /ERIHV24vCbBeXrryVsfqRyf2CzVlU9x7h8yoXzfmmanxUX97MRHpDHQ3yvQTFsWRWbI
         rsIA==
X-Forwarded-Encrypted: i=1; AJvYcCUQG+ay1tDTM4YJUKEoL+F/o3ARpMWEq/fSNxyrsZmfX5uBa/v/0fGGzmUnLurPTqTtIpw+OipmTnZE/+nGhm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXckdjrVyljWNwhgv1Fh6bHP+YwhP9ajjERqGMwi1lv5oHbLCE
	iwwI9Z6Qv39vj9mKPaOpo/pQ9oOLPgkY4q2U84vF8JYCm2zisYGXw4YXi3IK4KPAKqE5FmjPjl9
	9hE61Sv5r6BrGRRYVVSFvjVsVlA==
X-Google-Smtp-Source: AGHT+IGFM4fnaJaclf+UwA57x8vAdATG64ugSFxav97RrXYX3bY+Pcic5KOI6oF2kEGVymj334kNdpoiwgiFgae0+Q==
X-Received: from pjrv9.prod.google.com ([2002:a17:90a:bb89:b0:32d:e4c6:7410])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b04:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-33b5114d48fmr29169068a91.4.1760399735929;
 Mon, 13 Oct 2025 16:55:35 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:51:51 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251013235259.589015-1-kaleshsingh@google.com>
Subject: [PATCH v3 0/5] mm: VMA count limit fixes and improvements
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
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

This series addresses an off-by-one bug in the VMA count limit check
and introduces several improvements for clarity, test coverage, and
observability around the VMA limit mechanism.

The VMA count limit, controlled by sysctl_max_map_count, is a critical
safeguard that prevents a single process from consuming excessive kernel
memory by creating too many memory mappings. However, the checks in
do_mmap() and do_brk_flags() used a strict inequality, allowing a
process to exceed this limit by one VMA.

This series begins by fixing this long-standing bug. The subsequent
patches build on this by improving the surrounding code. A comprehensive
selftest is added to validate VMA operations near the limit, preventing
future regressions. The open-coded limit checks are replaced with a
centralized helper, vma_count_remaining(), to improve readability.
For better code clarity, mm_struct->map_count is renamed to the more
apt vma_count.

Finally, a trace event is added to provide observability for processes
that fail allocations due to VMA exhaustion, which is valuable for
debugging and profiling on production systems.

The major changes in this version are:
 1. Rebased on mm-new to resolve prior conflicts.

 2. The patches to harden and add assertions for the VMA count
    have been dropped. David pointed out that these could be
    racy if sysctl_max_map_count is changed from userspace at
    just the wrong time.

 3. The selftest has been completely rewritten per Lorenzo's
    feedback to make use of the kselftest harness and vm_util.h
    helpers.

 4. The trace event has also been updated to contain more useful
    information and has been given a more fitting name, per
    feedback from Steve and Lorenzo.

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

Link to v2:
https://lore.kernel.org/r/20250915163838.631445-1-kaleshsingh@google.com/

Thanks to everyone for their comments and feedback on the previous
versions.

--Kalesh

Kalesh Singh (5):
  mm: fix off-by-one error in VMA count limit checks
  mm/selftests: add max_vma_count tests
  mm: introduce vma_count_remaining()
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
 mm/mmap.c                                     |  31 +-
 mm/mremap.c                                   |  13 +-
 mm/nommu.c                                    |   8 +-
 mm/util.c                                     |   1 -
 mm/vma.c                                      |  39 +-
 mm/vma_internal.h                             |   2 +
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/max_vma_count_tests.c        | 672 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   5 +
 tools/testing/vma/vma.c                       |  32 +-
 tools/testing/vma/vma_internal.h              |  16 +-
 21 files changed, 818 insertions(+), 52 deletions(-)
 create mode 100644 include/trace/events/vma.h
 create mode 100644 tools/testing/selftests/mm/max_vma_count_tests.c


base-commit: 4c4142c93fc19cd75a024e5c81b0532578a9e187
-- 
2.51.0.760.g7b8bcc2412-goog


