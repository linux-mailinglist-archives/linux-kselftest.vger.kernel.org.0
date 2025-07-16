Return-Path: <linux-kselftest+bounces-37396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5C6B06BE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 05:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149CF173AF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 03:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D82275B1A;
	Wed, 16 Jul 2025 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMyn8Za+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C6EEAB
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635162; cv=none; b=bR/oCbVcpHuFQtVyuE9LvYHwHrVZfarAflZHH9i2GIdPdqyMUuyuMH10y7xbd4QfiOS07vwGZOtnEfWRs7xPZJVta0FZ+xvroKAubcmkmiNzaGPpFkyU4xeT11uVk+Kfmv5j90SurzEo+5HR8oHA9F2XtIgmiYxWSE/prfzd6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635162; c=relaxed/simple;
	bh=+XtSMkGE/5QvqEE+lL3n76fzlCuwPQSvKrQJzIhm/Rw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cMDo2/E3anDKNvrMs9LVKx39Oadb+yx7YKARaXI6uZCH46VDfgS4esX41HYk6QCW98p2K+VAK7V/YYqHE4LQVnUCYh4DI+P8tulnZzOq7KK5zRbGTSVuR/s3C4VTMfHSmySThZDEvzxzL+6JoNWjS2eTBs56GWlhNCXmSeUWts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMyn8Za+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-236725af87fso97227435ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 20:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752635160; x=1753239960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eDv47DkO9rpguv0/x/E9VgT+e3TflfjSKvW5WkAgvTA=;
        b=uMyn8Za+Ian7eUdPg/Yyum8RcfnSQ6j8Qyuvyb7vq5srDEBOGcwyr6D1QK7fgh3+SU
         j2NU7yBmVZEnRAJtcrK+tRmtUT1cnuRmfc9OatyfaA38MapxiNDl2rqHRxsa+mbqGM5s
         84eMvjqgxf+2Z7LeXIeuBu/vsAA0sRJ6K3fJYhAaVJXc4S5c4qvyOULEgIusbrdzg25j
         ZhmzMgO238ewJko1Z9yXu596EaJ1y72UWOH/dfO6coJ58GJxA2IYwumzssznY6ta1ktw
         cDV5AtMhxZ+w5FX4p3Cuu91mWvTCPCK56bSxTOlv/zfx0enp+05p6dUztjkU6nPyok5c
         9bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635160; x=1753239960;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDv47DkO9rpguv0/x/E9VgT+e3TflfjSKvW5WkAgvTA=;
        b=dr6l6QPkHfYERN5g2G40erldK+uqF0cchn79YkaA3F1cMXz4L6jkR3kBvkKGg9jSRB
         VmeKuVBahF/P4HkPXigwJYICUMm94HyubC4fQs3vZBMdlB/HaK2SHSDeGO0jKl7UCS0p
         fCk2LHiPoVu9adp0/jtOtFeDr0fydpMLZw5C1UWHdGfjOjvQGzpO3Ss5OjkorMThgoz0
         Iy3Gmmljn7hwmZua7fUW3N6sCKl1s33JMl74tFB7Kz9BoT3zceW552/IxgUeMlDjisQp
         txh3uR7fzB4pV9Ob0rg1fczCii51Y1wE2I+KYty9lxDOHSEIiCJqQEy4E0Fue/6Vw8Fi
         qS4w==
X-Forwarded-Encrypted: i=1; AJvYcCUZsC90Ce9PF6Mr3aQKNZBcs3pzx9FYpCoF3bHsRvr18ZnYpJLnNL+w75Nwo1/ArygghdIR3kCspf2k2HbIQv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9FfRCG9BSRp6Vi9DZ4kEJgEJCeuGktbHpgYclOQmiM1ASP/S
	AUZcn5ygnbNdSq/Yhp72t18j0N05zbcDQh14tEf0FnFO8GOcCbrvM2Wjdwn9HkUdAMDtGmTXJua
	3AjNhQQ==
X-Google-Smtp-Source: AGHT+IEPtmZuJ+5HKfkWNrtmVe10N89vfR95f1nmH8wDJGEyWdE9MGwq0OX+02SEWInjPEcER+UFtfGUfYk=
X-Received: from pjee13.prod.google.com ([2002:a17:90b:578d:b0:311:f699:df0a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a4e:b0:210:f706:dc4b
 with SMTP id d9443c01a7336-23e24ed701cmr16149755ad.13.1752635160521; Tue, 15
 Jul 2025 20:06:00 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:05:49 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716030557.1547501-1-surenb@google.com>
Subject: [PATCH v7 0/7] use per-vma locks for /proc/pid/maps reads
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Reading /proc/pid/maps requires read-locking mmap_lock which prevents any
other task from concurrently modifying the address space. This guarantees
coherent reporting of virtual address ranges, however it can block
important updates from happening. Oftentimes /proc/pid/maps readers are
low priority monitoring tasks and them blocking high priority tasks
results in priority inversion.

Locking the entire address space is required to present fully coherent
picture of the address space, however even current implementation does not
strictly guarantee that by outputting vmas in page-size chunks and
dropping mmap_lock in between each chunk. Address space modifications are
possible while mmap_lock is dropped and userspace reading the content is
expected to deal with possible concurrent address space modifications.
Considering these relaxed rules, holding mmap_lock is not strictly needed
as long as we can guarantee that a concurrently modified vma is reported
either in its original form or after it was modified.

This patchset switches from holding mmap_lock while reading /proc/pid/maps
to taking per-vma locks as we walk the vma tree. This reduces the
contention with tasks modifying the address space because they would have
to contend for the same vma as opposed to the entire address space.
Previous version of this patchset [1] tried to perform /proc/pid/maps
reading under RCU, however its implementation is quite complex and the
results are worse than the new version because it still relied on
mmap_lock speculation which retries if any part of the address space gets
modified. New implementaion is both simpler and results in less
contention. Note that similar approach would not work for /proc/pid/smaps
reading as it also walks the page table and that's not RCU-safe.

Paul McKenney's designed a test [2] to measure mmap/munmap latencies while
concurrently reading /proc/pid/maps. The test has a pair of processes
scanning /proc/PID/maps, and another process unmapping and remapping 4K
pages from a 128MB range of anonymous memory.  At the end of each 10
second run, the latency of each mmap() or munmap() operation is measured,
and for each run the maximum and mean latency is printed. The map/unmap
process is started first, its PID is passed to the scanners, and then the
map/unmap process waits until both scanners are running before starting
its timed test.  The scanners keep scanning until the specified
/proc/PID/maps file disappears.

The latest results from Paul:
Stock mm-unstable, all of the runs had maximum latencies in excess of
0.5 milliseconds, and with 80% of the runs' latencies exceeding a full
millisecond, and ranging up beyond 4 full milliseconds.  In contrast,
99% of the runs with this patch series applied had maximum latencies
of less than 0.5 milliseconds, with the single outlier at only 0.608
milliseconds.

From a median-performance (as opposed to maximum-latency) viewpoint,
this patch series also looks good, with stock mm weighing in at 11
microseconds and patch series at 6 microseconds, better than a 2x
improvement.

Before the change:
./run-proc-vs-map.sh --nsamples 100 --rawdata -- --busyduration 2
    0.011     0.008     0.521
    0.011     0.008     0.552
    0.011     0.008     0.590
    0.011     0.008     0.660
    ...
    0.011     0.015     2.987
    0.011     0.015     3.038
    0.011     0.016     3.431
    0.011     0.016     4.707

After the change:
./run-proc-vs-map.sh --nsamples 100 --rawdata -- --busyduration 2
    0.006     0.005     0.026
    0.006     0.005     0.029
    0.006     0.005     0.034
    0.006     0.005     0.035
    ...
    0.006     0.006     0.421
    0.006     0.006     0.423
    0.006     0.006     0.439
    0.006     0.006     0.608

The patchset also adds a number of tests to check for /proc/pid/maps data
coherency. They are designed to detect any unexpected data tearing while
performing some common address space modifications (vma split, resize and
remap). Even before these changes, reading /proc/pid/maps might have
inconsistent data because the file is read page-by-page with mmap_lock
being dropped between the pages. An example of user-visible inconsistency
can be that the same vma is printed twice: once before it was modified and
then after the modifications. For example if vma was extended, it might be
found and reported twice. What is not expected is to see a gap where there
should have been a vma both before and after modification. This patchset
increases the chances of such tearing, therefore it's even more important
now to test for unexpected inconsistencies.

In [3] Lorenzo identified the following possible vma merging/splitting
scenarios:

Merges with changes to existing vmas:
1 Merge both - mapping a vma over another one and between two vmas which
can be merged after this replacement;
2. Merge left full - mapping a vma at the end of an existing one and
completely over its right neighbor;
3. Merge left partial - mapping a vma at the end of an existing one and
partially over its right neighbor;
4. Merge right full - mapping a vma before the start of an existing one
and completely over its left neighbor;
5. Merge right partial - mapping a vma before the start of an existing one
and partially over its left neighbor;

Merges without changes to existing vmas:
6. Merge both - mapping a vma into a gap between two vmas which can be
merged after the insertion;
7. Merge left - mapping a vma at the end of an existing one;
8. Merge right - mapping a vma before the start end of an existing one;

Splits
9. Split with new vma at the lower address;
10. Split with new vma at the higher address;

If such merges or splits happen concurrently with the /proc/maps reading
we might report a vma twice, once before the modification and once after
it is modified:

Case 1 might report overwritten and previous vma along with the final
merged vma;
Case 2 might report previous and the final merged vma;
Case 3 might cause us to retry once we detect the temporary gap caused by
shrinking of the right neighbor;
Case 4 might report overritten and the final merged vma;
Case 5 might cause us to retry once we detect the temporary gap caused by
shrinking of the left neighbor;
Case 6 might report previous vma and the gap along with the final marged
vma;
Case 7 might report previous and the final merged vma;
Case 8 might report the original gap and the final merged vma covering the
gap;
Case 9 might cause us to retry once we detect the temporary gap caused by
shrinking of the original vma at the vma start;
Case 10 might cause us to retry once we detect the temporary gap caused by
shrinking of the original vma at the vma end;

In all these cases the retry mechanism prevents us from reporting possible
temporary gaps.

Changes since v6 [4]:
- Updated patch 7/8 changelog, per Lorenzo Stoakes
- Added comments, per Lorenzo Stoakes
- Added Reviewed-by, per Lorenzo Stoakes and Liam Howlett
- Replaced iter with vmi, per Lorenzo Stoakes
- Renamed from lock_vma_under_mmap_lock() to
lock_next_vma_under_mmap_lock(), per Lorenzo Stoakes
- Renamed lock_next_vma() parameter from addr to from_addr
- Renamed labels in lock_next_vma() to reflect fallback cases,
per Lorenzo Stoakes
- Handle vma_start_read_locked() failure inside
lock_next_vma_under_mmap_lock() and added fallback_to_mmap_lock()
for that, per Vlastimil Babka
- Added missing vma_iter_init() after re-entering rcu read section inside
lock_next_vma(), per Vlastimil Babka
- Replaced vma_iter_init() with vma_iter_set(), per Liam Howlett
- Removed the last patch converting PROCMAP_QUERY to use per-vma locks.
That patch will be posted separately,
per David Hildenbrand, Vlastimil Babka and Liam Howlett
- Updated performance numbers, per Paul E. McKenney

!!! NOTES FOR APPLYING THE PATCHSET !!!

Applies cleanly over mm-unstable after reverting v6 version of this
patchset (from 2771a4b86aa1 to a20b00f7cf33 in mm-unstable).

[1] https://lore.kernel.org/all/20250418174959.1431962-1-surenb@google.com/
[2] https://github.com/paulmckrcu/proc-mmap_sem-test
[3] https://lore.kernel.org/all/e1863f40-39ab-4e5b-984a-c48765ffde1c@lucifer.local/
[4] https://lore.kernel.org/all/20250704060727.724817-1-surenb@google.com/

Suren Baghdasaryan (7):
  selftests/proc: add /proc/pid/maps tearing from vma split test
  selftests/proc: extend /proc/pid/maps tearing test to include vma
    resizing
  selftests/proc: extend /proc/pid/maps tearing test to include vma
    remapping
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  selftests/proc: add verbose more for tests to facilitate debugging
  fs/proc/task_mmu: remove conversion of seq_file position to unsigned
  fs/proc/task_mmu: read proc/pid/maps under per-vma lock

 fs/proc/internal.h                            |   5 +
 fs/proc/task_mmu.c                            | 155 +++-
 include/linux/mmap_lock.h                     |  11 +
 mm/madvise.c                                  |   3 +-
 mm/mmap_lock.c                                |  93 ++
 tools/testing/selftests/proc/.gitignore       |   1 +
 tools/testing/selftests/proc/Makefile         |   1 +
 tools/testing/selftests/proc/proc-maps-race.c | 829 ++++++++++++++++++
 8 files changed, 1082 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-maps-race.c

-- 
2.50.0.727.gbf7dc18ff4-goog


