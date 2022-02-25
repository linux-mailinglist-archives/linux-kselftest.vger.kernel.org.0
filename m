Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD424C4551
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbiBYNIL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 08:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiBYNH5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 08:07:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC03320DB03;
        Fri, 25 Feb 2022 05:07:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A30CB830AA;
        Fri, 25 Feb 2022 13:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C241C340E7;
        Fri, 25 Feb 2022 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645794442;
        bh=ZUFJT4ywE29W78D9GKOYSIKqDWeccLmuYfsgdarTsgU=;
        h=From:To:Cc:Subject:Date:From;
        b=LMbBmRMpP8GRphnysgLov+NXxY+6C6crc3SpncSlZ7l1zXUHMkBZNkAF2rjCVFTmk
         JWabw+gZqQrujIyxGcEbhtLzqNPNtY4upKJ0mQK2F4ZOjaHbcopAAy5m7pZ2pVIKAU
         OW2Iak/Wpqui1reVC0T7rXxQAczEchej5SUxgWfsKkW510VrZ0PTH9AVGlVF2lSN3r
         jP/wktSCsmZckzPlErP7P33o0JFaMP8L7rDGCjiBWM94MI1Jih4Wj5GSeX6OPnrMhe
         ZN7MICqWfxvr3SQlRGscaxSZOKCQl9mYlTokYVS+6U4dtur2sGeHg7yK+4yBEbQQTu
         jK8KEKREfeeiQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 00/13] Introduce DAMON sysfs interface
Date:   Fri, 25 Feb 2022 13:06:59 +0000
Message-Id: <20220225130712.12682-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes from Previous Version (v1)
==================================

Compared to the v1 of this patchset
(https://lore.kernel.org/linux-mm/20220223152051.22936-1-sj@kernel.org/), this
version contains below changes.

- Use __ATTR_R{O,W}_MODE() instead of __ATTR() (Greg KH)
- Change some file names for using __ATTR_R{O,W}_MODE() (Greg KH)
- Add ABI document (Greg KH)

Introduction
============

DAMON's debugfs-based user interface (DAMON_DBGFS) served very well, so far.
However, it unnecessarily depends on debugfs, while DAMON is not aimed to be
used for only debugging.  Also, the interface receives multiple values via one
file.  For example, schemes file receives 18 values.  As a result, it is
inefficient, hard to be used, and difficult to be extended.  Especially,
keeping backward compatibility of user space tools is getting only challenging.
It would be better to implement another reliable and flexible interface and
deprecate DAMON_DBGFS in long term.

For the reason, this patchset introduces a sysfs-based new user interface of
DAMON.  The idea of the new interface is, using directory hierarchies and
having one dedicated file for each value.  For a short example, users can do
the virtual address monitoring via the interface as below:

    # cd /sys/kernel/mm/damon/admin/
    # echo 1 > kdamonds/nr_kdamonds
    # echo 1 > kdamonds/0/contexts/nr_contexts
    # echo vaddr > kdamonds/0/contexts/0/operations
    # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid_target
    # echo on > kdamonds/0/state

A brief representation of the files hierarchy of DAMON sysfs interface is as
below.  Childs are represented with indentation, directories are having '/'
suffix, and files in each directory are separated by comma.

    /sys/kernel/mm/damon/admin
    │ kdamonds/nr_kdamonds
    │ │ 0/state,pid
    │ │ │ contexts/nr_contexts
    │ │ │ │ 0/operations
    │ │ │ │ │ monitoring_attrs/
    │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
    │ │ │ │ │ │ nr_regions/min,max
    │ │ │ │ │ targets/nr_targets
    │ │ │ │ │ │ 0/pid_target
    │ │ │ │ │ │ │ regions/nr_regions
    │ │ │ │ │ │ │ │ 0/start,end
    │ │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ ...
    │ │ │ │ │ schemes/nr_schemes
    │ │ │ │ │ │ 0/action
    │ │ │ │ │ │ │ access_pattern/
    │ │ │ │ │ │ │ │ sz/min,max
    │ │ │ │ │ │ │ │ nr_accesses/min,max
    │ │ │ │ │ │ │ │ age/min,max
    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
    │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
    │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
    │ │ │ │ │ │ ...
    │ │ │ │ ...
    │ │ ...

Detailed usage of the files will be described in the final Documentation patch
of this patchset.

Main Difference Between DAMON_DBGFS and DAMON_SYSFS
---------------------------------------------------

At the moment, DAMON_DBGFS and DAMON_SYSFS provides same features.  One
important difference between them is their exclusiveness.  DAMON_DBGFS works in
an exclusive manner, so that no DAMON worker thread (kdamond) in the system can
run concurrently and interfere somehow.  For the reason, DAMON_DBGFS asks users
to construct all monitoring contexts and start them at once.  It's not a big
problem but makes the operation a little bit complex and unflexible.

For more flexible usage, DAMON_SYSFS moves the responsibility of preventing any
possible interference to the admins and work in a non-exclusive manner.  That
is, users can configure and start contexts one by one.  Note that DAMON
respects both exclusive groups and non-exclusive groups of contexts, in a
manner similar to that of reader-writer locks.  That is, if any exclusive
monitoring contexts (e.g., contexts that started via DAMON_DBGFS) are running,
DAMON_SYSFS does not start new contexts, and vice versa.

Future Plan of DAMON_DBGFS Deprecation
======================================

Once this patchset is merged, DAMON_DBGFS development will be frozen.  That is,
we will maintain it to work as is now so that no users will be break.  But, it
will not be extended to provide any new feature of DAMON.  The support will be
continued only until next LTS release.  After that, we will drop DAMON_DBGFS.

User-space Tooling Compatibility
--------------------------------

As DAMON_SYSFS provides all features of DAMON_DBGFS, all user space tooling can
move to DAMON_SYSFS.  As we will continue supporting DAMON_DBGFS until next LTS
kernel release, user space tools would have enough time to move to DAMON_SYSFS.

The official user space tool, damo[1], is already supporting both DAMON_SYSFS
and DAMON_DBGFS.  Both correctness tests[2] and performance tests[3] of DAMON
using DAMON_SYSFS also passed.

[1] https://github.com/awslabs/damo
[2] https://github.com/awslabs/damon-tests/tree/master/corr
[3] https://github.com/awslabs/damon-tests/tree/master/perf

Complete Git Tree
=================

You can get the complete git tree from
https://git.kernel.org/sj/h/damon/sysfs/patches/v2.

Sequence of Patches
===================

First two patches (patches 1-2) make core changes for DAMON_SYSFS.  The first
one (patch 1) allows non-exclusive DAMON contexts so that DAMON_SYSFS can work
in non-exclusive mode, while the second one (patch 2) adds size of DAMON enum
types so that DAMON API users can safely iterate the enums.

Third patch (patch 3) implements basic sysfs stub for virtual address spaces
monitoring.  Note that this implements only sysfs files and DAMON is not
linked.  Fourth patch (patch 4) links the DAMON_SYSFS to DAMON so that users
can control DAMON using the sysfs files.

Following six patches (patches 5-10) implements other DAMON features that
DAMON_DBGFS supports one by one (physical address space monitoring, DAMON-based
operation schemes, schemes quotas, schemes prioritization weights, schemes
watermarks, and schemes stats).

Following patch (patch 11) adds a simple selftest for DAMON_SYSFS, and the
final one (patch 12) documents DAMON_SYSFS.

Patch History
=============

Changes from Previous Version (v1)
==================================

Changes from v1
(https://lore.kernel.org/linux-mm/20220223152051.22936-1-sj@kernel.org/)
- Use __ATTR_R{O,W}_MODE() instead of __ATTR() (Greg KH)
- Change some file names for using __ATTR_R{O,W}_MODE() (Greg KH)
- Add ABI document (Greg KH)

Chages from RFC
(https://lore.kernel.org/linux-mm/20220217161938.8874-1-sj@kernel.org/)
- Implement all DAMON debugfs interface providing features
- Writeup documents
- Add more selftests

SeongJae Park (13):
  mm/damon/core: Allow non-exclusive DAMON start/stop
  mm/damon/core: Add number of each enum type values
  mm/damon: Implement a minimal stub for sysfs-based DAMON interface
  mm/damon/sysfs: Link DAMON for virtual address spaces monitoring
  mm/damon/sysfs: Support the physical address space monitoring
  mm/damon/sysfs: Support DAMON-based Operation Schemes
  mm/damon/sysfs: Support DAMOS quotas
  mm/damon/sysfs: Support schemes prioritization
  mm/damon/sysfs: Support DAMOS watermarks
  mm/damon/sysfs: Support DAMOS stats
  selftests/damon: Add a test for DAMON sysfs interface
  Docs/admin-guide/mm/damon/usage: Document DAMON sysfs interface
  Docs/ABI/testing: Add DAMON sysfs interface ABI document

 .../ABI/testing/sysfs-kernel-mm-damon         |  276 ++
 Documentation/admin-guide/mm/damon/usage.rst  |  350 ++-
 MAINTAINERS                                   |    1 +
 include/linux/damon.h                         |    6 +-
 mm/damon/Kconfig                              |    7 +
 mm/damon/Makefile                             |    1 +
 mm/damon/core.c                               |   23 +-
 mm/damon/dbgfs.c                              |    2 +-
 mm/damon/reclaim.c                            |    2 +-
 mm/damon/sysfs.c                              | 2594 +++++++++++++++++
 tools/testing/selftests/damon/Makefile        |    1 +
 tools/testing/selftests/damon/sysfs.sh        |  306 ++
 12 files changed, 3552 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-damon
 create mode 100644 mm/damon/sysfs.c
 create mode 100755 tools/testing/selftests/damon/sysfs.sh

-- 
2.17.1

