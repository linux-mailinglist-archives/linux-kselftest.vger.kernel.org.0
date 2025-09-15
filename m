Return-Path: <linux-kselftest+bounces-41512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D9B58266
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5507AD03A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D781223DF6;
	Mon, 15 Sep 2025 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vy4TDkOF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8361EB5D6
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954740; cv=none; b=LhnK3RHVfD6Q4IQSYctlY9pzQeYZsn0v+sUmgwVDvc0tQ2zdzuZYYh2bCyOS+NsuU4Do9gDUKvAugcJ+6Q52ezSUsGYF0QhFtXWDRiZtbsk24oq7DRtwVvdzfKUH7u7q/pKlsdmvM8r/XDO5/k14xGAgqknJuD48hTWPN0fiORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954740; c=relaxed/simple;
	bh=zbBslusboByHikprpTmSMVoZIVvAXZzfHllUZVLH0Bg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=byUyM3z8aiSRd3aQQ9xkCIOSp3+2oUowyiD0evG8SdFxu4nVdmLoYjgsLuPxZHI3msBW6Xeaa18QWlQJndNfnBLQMxCSXommu+ChPYeVIlu2ebrsNWDBG4wRp5yH0y7x0K10QCxCO6Yysve/PGqNkPyEWj3Lcp5d9kvev0jVorc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vy4TDkOF; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b521ae330b0so3126222a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757954737; x=1758559537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rV+XG5RFGGx0WSlVed1inCLN42/DoGgCGt9RoOWZ17Y=;
        b=vy4TDkOFlhGwaWqsF7dkZemIZKR5lPy1BJmdVy82vSrMlbTeEjIYmLCjJCORXS+azl
         Mz95LzElxxdZKUI1biqNdwOLkoOBWItbauDVGx0jdY/IRVQsuLQe2CqbacWZTGA0PPpE
         MoDzkIQ4q4wKmAki2PN/EqAd8yIfvbMsdrOpTubKTNSE4vmikpTq5RuFXjvfHPcyIuID
         M9GBalHvC42bMT0EzkFaFqkTRfgrVeNWNKfUg4cZ/aLxxIgAm/1cUmaZV921ELXYz/xE
         m/qf0em0s2nauKMC6sgncn2i2XJb2Xjm2pwsQbo3maG+WwDeCVsphisbL6ZH4ApvA6Ai
         V2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954737; x=1758559537;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rV+XG5RFGGx0WSlVed1inCLN42/DoGgCGt9RoOWZ17Y=;
        b=LhbAo5R7UVXPoWel2s7+ou6Q4Vv5lTlbmJG5pqgfZlyXoul9ls/id/9xDGq7sV5HCa
         k3yRl5Xoa/uBovUIz3ZKnASnzRAPDF5itZEi/llVt45UMTkp4tu1mUGKHwv6Qq9lqtAf
         2xkf0pbdT5NObwEyI2HPAo0I5uzafkxzAXdi/qIITZ5k9WSVdTQJi0luqJDjagFvy8a4
         zuPNQ37VV3b7aJkcftWAoXpEdYtghqaNVaj1PTyEB4NxaekckT9tqJq5YjyOfnpLnXUZ
         nmMkHneyUA5UMY3CaabUUaLtG6Yu3btGSV1CP6mXXP1phls31J3HtM5w/yCCNYAGtYyS
         TXUw==
X-Forwarded-Encrypted: i=1; AJvYcCUTllER+a401IP0A686JQjd3AmTbQ20pBSN49ra4fLw3EqJMdH4+Kx+6blHtZb4eosSOdQSkpdhDSq3VdVkdEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEstz0nr1kTzwNCpOhGqGhe+QNMrnWxVnDYmtKvflTS8nohITX
	ZIHp9a9a0lS50gPogWqS/WdeLihySsw0M9aPVQJd6zCC8+VuokBSiBHg5OPTOxZVh58jJMn9S5X
	rSd4iRc0/JYcd+uv+Dg8VDgJx+g==
X-Google-Smtp-Source: AGHT+IEAgY6VkXbGhl6l9muDNqmcvsiv9qd7+stbRvW4guJMBZCDnQLACUz038WuYWTWZXakBxrH9BGqLG7UDujvDA==
X-Received: from pjk14.prod.google.com ([2002:a17:90b:558e:b0:32e:27d9:eda1])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2449:b0:25b:d1a8:5ccf with SMTP id adf61e73a8af0-2602a593791mr17106705637.21.1757954736574;
 Mon, 15 Sep 2025 09:45:36 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:36:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915163838.631445-1-kaleshsingh@google.com>
Subject: [PATCH v2 0/7] vma count: fixes, test and improvements
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This is v2 to the VMA count patch I previously posted at:

https://lore.kernel.org/r/20250903232437.1454293-1-kaleshsingh@google.com/


I've split it into multiple patches to address the feedback.

The main changes in v2 are:

- Use a capacity-based check for VMA count limit, per Lorenzo.
- Rename map_count to vma_count, per David.
- Add assertions for exceeding the limit, per Pedro.
- Add tests for max_vma_count, per Liam.
- Emit a trace event for failure due to insufficient capacity for
  observability

Tested on x86_64 and arm64:

- Build test:
    - allyesconfig for rename

- Selftests:
      cd tools/testing/selftests/mm && \
          make && \
          ./run_vmtests.sh -t max_vma_count

       (With trace_max_vma_count_exceeded enabled)

- vma tests:
      cd tools/testing/vma && \
          make && \
	  ./vma

Thanks,
Kalesh

Kalesh Singh (7):
  mm: fix off-by-one error in VMA count limit checks
  mm/selftests: add max_vma_count tests
  mm: introduce vma_count_remaining()
  mm: rename mm_struct::map_count to vma_count
  mm: harden vma_count against direct modification
  mm: add assertion for VMA count limit
  mm/tracing: introduce max_vma_count_exceeded trace event

 fs/binfmt_elf.c                               |   2 +-
 fs/coredump.c                                 |   2 +-
 include/linux/mm.h                            |  35 +-
 include/linux/mm_types.h                      |   5 +-
 include/trace/events/vma.h                    |  32 +
 kernel/fork.c                                 |   2 +-
 mm/debug.c                                    |   2 +-
 mm/internal.h                                 |   1 +
 mm/mmap.c                                     |  28 +-
 mm/mremap.c                                   |  13 +-
 mm/nommu.c                                    |   8 +-
 mm/util.c                                     |   1 -
 mm/vma.c                                      |  88 ++-
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/max_vma_count_tests.c        | 709 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   5 +
 tools/testing/vma/vma.c                       |  32 +-
 tools/testing/vma/vma_internal.h              |  44 +-
 18 files changed, 949 insertions(+), 61 deletions(-)
 create mode 100644 include/trace/events/vma.h
 create mode 100644 tools/testing/selftests/mm/max_vma_count_tests.c


base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
-- 
2.51.0.384.g4c02a37b29-goog


