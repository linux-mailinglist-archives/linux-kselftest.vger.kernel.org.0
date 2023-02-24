Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E5B6A15FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 05:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBXElR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 23:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBXElN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 23:41:13 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5C51F82
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 20:41:11 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 023D77B74ED8; Thu, 23 Feb 2023 20:40:59 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org
Subject: [PATCH v3 0/3] mm: process/cgroup ksm support
Date:   Thu, 23 Feb 2023 20:39:57 -0800
Message-Id: <20230224044000.3084046-1-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
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
opportuniites may exist across multiple workloads or jobs. Only a higler =
level
entity like a job scheduler or container can know for certain if its runn=
ing
one or more instances of a job. That job scheduler however doesn't have
the necessary internal worklaod knowledge to make targeted madvise calls.

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
 fs/proc/base.c                                |   5 +
 include/linux/ksm.h                           |  19 +-
 include/linux/sched/coredump.h                |   1 +
 include/uapi/linux/prctl.h                    |   2 +
 kernel/sys.c                                  |  29 ++
 mm/ksm.c                                      | 114 +++++++-
 tools/include/uapi/linux/prctl.h              |   2 +
 tools/testing/selftests/mm/Makefile           |   3 +-
 tools/testing/selftests/mm/ksm_tests.c        | 254 +++++++++++++++---
 11 files changed, 389 insertions(+), 56 deletions(-)


base-commit: 234a68e24b120b98875a8b6e17a9dead277be16a
--=20
2.30.2

