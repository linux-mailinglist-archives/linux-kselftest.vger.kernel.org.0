Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE56D9DFE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 18:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbjDFQx7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbjDFQx6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 12:53:58 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0956D2108
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 09:53:56 -0700 (PDT)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 147F2AC5FA63; Thu,  6 Apr 2023 09:53:44 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org
Subject: [PATCH v5 0/3] mm: process/cgroup ksm support
Date:   Thu,  6 Apr 2023 09:53:36 -0700
Message-Id: <20230406165339.1017597-1-shr@devkernel.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.0 required=5.0 tests=RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_NEUTRAL,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

So far KSM can only be enabled by calling madvise for memory regions. To
be able to use KSM for more workloads, KSM needs to have the ability to b=
e
enabled / disabled at the process / cgroup level.

Use case 1:
The madvise call is not available in the programming language. An example=
 for
this are programs with forked workloads using a garbage collected languag=
e without
pointers. In such a language madvise cannot be made available.

In addition the addresses of objects get moved around as they are garbage
collected. KSM sharing needs to be enabled "from the outside" for these t=
ype of
workloads.

Use case 2:
The same interpreter can also be used for workloads where KSM brings no
benefit or even has overhead. We'd like to be able to enable KSM on a wor=
kload
by workload basis.

Use case 3:
With the madvise call sharing opportunities are only enabled for the curr=
ent
process: it is a workload-local decision. A considerable number of sharin=
g
opportunities may exist across multiple workloads or jobs (if they are pa=
rt
of the same security domain). Only a higler level entity like a job sched=
uler
or container can know for certain if its running one or more instances of=
 a
job. That job scheduler however doesn't have the necessary internal workl=
oad
knowledge to make targeted madvise calls.

Security concerns:
In previous discussions security concerns have been brought up. The probl=
em is
that an individual workload does not have the knowledge about what else i=
s
running on a machine. Therefore it has to be very conservative in what me=
mory
areas can be shared or not. However, if the system is dedicated to runnin=
g
multiple jobs within the same security domain, its the job scheduler that=
 has
the knowledge that sharing can be safely enabled and is even desirable.

Performance:
Experiments with using UKSM have shown a capacity increase of around 20%.


1. New options for prctl system command
This patch series adds two new options to the prctl system call. The firs=
t
one allows to enable KSM at the process level and the second one to query=
 the
setting.

The setting will be inherited by child processes.

With the above setting, KSM can be enabled for the seed process of a cgro=
up
and all processes in the cgroup will inherit the setting.

2. Changes to KSM processing
When KSM is enabled at the process level, the KSM code will iterate over =
all
the VMA's and enable KSM for the eligible VMA's.

When forking a process that has KSM enabled, the setting will be inherite=
d by
the new child process.

In addition when KSM is disabled for a process, KSM will be disabled for =
the
VMA's where KSM has been enabled.

3. Add general_profit metric
The general_profit metric of KSM is specified in the documentation, but n=
ot
calculated. This adds the general profit metric to /sys/kernel/debug/mm/k=
sm.

4. Add more metrics to ksm_stat
This adds the process profit and ksm type metric to /proc/<pid>/ksm_stat.

5. Add more tests to ksm_tests
This adds an option to specify the merge type to the ksm_tests. This allo=
ws to
test madvise and prctl KSM. It also adds a new option to query if prctl K=
SM has
been enabled. It adds a fork test to verify that the KSM process setting =
is
inherited by client processes.


Changes:
- V5:
  - When the prctl system call is invoked, mark all compatible VMA
    as mergeable
  - Instead of checcking during scan if VMA is mergeable, mark the VMA
    mergeable when the VMA is created (in case the VMA is compatible)
    - Remove earlier changes, they are no longer necessary
  - Unset the flag MMF_VM_MERGE_ANY in gmap_mark_unmergeable().
  - When unsetting the MMF_VM_MERGE_ANY flag with prctl, only unset the
    flag
  - Remove pages_volatile function (with the simplar general_profit calcu=
lation,
    the function is no longer needed)
  - Use simpler formula for calculation of general_profit

- V4:
  - removing check in prctl for MMF_VM_MERGEABLE in PR_SET_MEMORY_MERGE
    handling
  - Checking for VM_MERGEABLE AND MMF_VM_MERGE_ANY to avoid chaning vm_fl=
ags
    - This requires also checking that the vma is compatible. The
      compatibility check is provided by a new helper
    - processes which have set MMF_VM_MERGE_ANY, only need to call the
      helper and not madvise.
  - removed unmerge_vmas function, this function is no longer necessary,
    clearing the MMF_VM_MERGE_ANY bit is sufficient

- V3:
  - folded patch 1 - 6
  - folded patch 7 - 14
  - folded patch 15 - 19
  - Expanded on the use cases in the cover letter
  - Added a section on security concerns to the cover letter

- V2:
  - Added use cases to the cover letter
  - Removed the tracing patch from the patch series and posted it as an
    individual patch
  - Refreshed repo


Stefan Roesch (3):
  mm: add new api to enable ksm per process
  mm: add new KSM process and sysfs knobs
  selftests/mm: add new selftests for KSM

 Documentation/ABI/testing/sysfs-kernel-mm-ksm |   8 +
 Documentation/admin-guide/mm/ksm.rst          |   8 +-
 arch/s390/mm/gmap.c                           |   1 +
 fs/proc/base.c                                |   5 +
 include/linux/ksm.h                           |  36 ++-
 include/linux/sched/coredump.h                |   1 +
 include/uapi/linux/prctl.h                    |   2 +
 kernel/fork.c                                 |   1 +
 kernel/sys.c                                  |  24 ++
 mm/ksm.c                                      | 143 ++++++++--
 mm/mmap.c                                     |   7 +
 tools/include/uapi/linux/prctl.h              |   2 +
 tools/testing/selftests/mm/Makefile           |   2 +-
 tools/testing/selftests/mm/ksm_tests.c        | 254 +++++++++++++++---
 14 files changed, 426 insertions(+), 68 deletions(-)

--=20
2.34.1

