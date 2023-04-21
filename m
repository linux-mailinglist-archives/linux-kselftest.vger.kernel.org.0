Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA186EAC9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 16:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjDUOSB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 10:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjDUORq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 10:17:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139BE1258F
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f566ea5e6so6392595276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682086663; x=1684678663;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ObvMQpDO4VdOnjufZAdgVMFaduqKSCa+HnPbId1089s=;
        b=ns5H+QuUh8mZPsqMyCzdWVAI4JV7KSMOsX/PkKfi+KNM578zeMJZglKgjpr9UxuRnA
         wi25x9VT/iovSYgHd+ve7v7cd+FGEBPpntXYK5n0ggGm32KLQWoAmoG1zm5YzGbgtbrq
         RgTiawh3lkrVdmd0R3kDNubrRwYA0ZgP70oIVMckT5bHQVK56Xdft2ji0Wnav1ky6YhF
         nniaUNEowlFAQLCk2RUV86VHg09+JUS0zqM05SVxhgO6+lK/se36eKCwGMRdVYXqX4nx
         8uLc5IBLZvH0koSjHV6sUtsZWbHv1v1y0x+sKRLknFsVO04HECC7IZBwaOVCeLtP7eYM
         qOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086663; x=1684678663;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObvMQpDO4VdOnjufZAdgVMFaduqKSCa+HnPbId1089s=;
        b=aClKZN0KGWfj1WnhId1QyKx7liqNAMT/HrvSpnUsoVqW0P28ShG0OzzCDcNEMHuwB3
         5xlIZwMe0/wusmwP885FSyp9m3xn7aAx9kdDRpYEc7bNqO03rtNxDi/YygOCeBUsiOlQ
         8eA/eGSvVaB0BtqQY5plL7pswsCULIYcP+Fs9QsGCW4v24mTreHtcY5hgbHEB97XdCN1
         AnigiTeDOmPxFIS3RZQFOc93fAQ4yF0C8tZDbOe3Qwjsw9kr4cX4tl3dWmPqMtKtvgrd
         Bjo2v3+8QhlRt0n8HOW6gQh6Nu2cGm9nK2wa9CppGbLY9IpiiyteNNNdnVFkz6DgKiNx
         AOXA==
X-Gm-Message-State: AAQBX9egtb2r5vmDcpy8d/d4oboHCNmrcPNkac4pfQztLXg7T2mluiCl
        OA5GDne3EZLJTYBp+QcZoMYS8vtl2sJ1YlCnHg==
X-Google-Smtp-Source: AKy350ZG7u2gePkwhYPhvuDsxGloMw0UJdMM4BeAyPegJQdDxY8uNtCzr8KodyMKn0yqhT8McYTYsD6j34k8q2wqkQ==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:c801:daa2:428c:d3fc])
 (user=peternewman job=sendgmr) by 2002:a05:690c:2b88:b0:54c:15ad:11e4 with
 SMTP id en8-20020a05690c2b8800b0054c15ad11e4mr1865952ywb.0.1682086663349;
 Fri, 21 Apr 2023 07:17:43 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:17:14 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421141723.2405942-1-peternewman@google.com>
Subject: [PATCH v1 0/9] x86/resctrl: Use soft RMIDs for reliable MBM on AMD
From:   Peter Newman <peternewman@google.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette, Fenghua,

This series introduces a new mount option enabling an alternate mode for
MBM to work around an issue on present AMD implementations and any other
resctrl implementation where there are more RMIDs (or equivalent) than
hardware counters.

The L3 External Bandwidth Monitoring feature of the AMD PQoS
extension[1] only guarantees that RMIDs currently assigned to a
processor will be tracked by hardware. The counters of any other RMIDs
which are no longer being tracked will be reset to zero. The MBM event
counters return "Unavailable" to indicate when this has happened.

An interval for effectively measuring memory bandwidth typically needs
to be multiple seconds long. In Google's workloads, it is not feasible
to bound the number of jobs with different RMIDs which will run in a
cache domain over any period of time.  Consequently, on a
fully-committed system where all RMIDs are allocated, few groups'
counters return non-zero values.

To demonstrate the underlying issue, the first patch provides a test
case in tools/testing/selftests/resctrl/test_rmids.sh.

On an AMD EPYC 7B12 64-Core Processor with the default behavior:

 # ./test_rmids.sh
 Created 255 monitoring groups.
 g1: mbm_total_bytes: Unavailable -> Unavailable (FAIL)
 g2: mbm_total_bytes: Unavailable -> Unavailable (FAIL)
 g3: mbm_total_bytes: Unavailable -> Unavailable (FAIL)
[..]
 g238: mbm_total_bytes: Unavailable -> Unavailable (FAIL)
 g239: mbm_total_bytes: Unavailable -> Unavailable (FAIL)
 g240: mbm_total_bytes: Unavailable -> Unavailable (FAIL)
 g241: mbm_total_bytes: Unavailable -> 660497472
 g242: mbm_total_bytes: Unavailable -> 660793344
 g243: mbm_total_bytes: Unavailable -> 660477312
 g244: mbm_total_bytes: Unavailable -> 660495360
 g245: mbm_total_bytes: Unavailable -> 660775360
 g246: mbm_total_bytes: Unavailable -> 660645504
 g247: mbm_total_bytes: Unavailable -> 660696128
 g248: mbm_total_bytes: Unavailable -> 660605248
 g249: mbm_total_bytes: Unavailable -> 660681280
 g250: mbm_total_bytes: Unavailable -> 660834240
 g251: mbm_total_bytes: Unavailable -> 660440064
 g252: mbm_total_bytes: Unavailable -> 660501504
 g253: mbm_total_bytes: Unavailable -> 660590720
 g254: mbm_total_bytes: Unavailable -> 660548352
 g255: mbm_total_bytes: Unavailable -> 660607296
 255 groups, 0 returned counts in first pass, 15 in second
 successfully measured bandwidth from 15/255 groups

To compare, here is the output from an Intel(R) Xeon(R) Platinum 8173M
CPU:

 # ./test_rmids.sh
 Created 223 monitoring groups.
 g1: mbm_total_bytes: 0 -> 606126080
 g2: mbm_total_bytes: 0 -> 613236736
 g3: mbm_total_bytes: 0 -> 610254848
[..]
 g221: mbm_total_bytes: 0 -> 584679424
 g222: mbm_total_bytes: 0 -> 588808192
 g223: mbm_total_bytes: 0 -> 587317248
 223 groups, 223 returned counts in first pass, 223 in second
 successfully measured bandwidth from 223/223 groups

To make better use of the hardware in such a use case, this patchset
introduces a "soft" RMID implementation, where each CPU is permanently
assigned a "hard" RMID. On context switches which change the current
soft RMID, the difference between each CPU's current event counts and
most recent counts is added to the totals for the current or outgoing
soft RMID.

This technique does not work for cache occupancy counters, so this patch
series disables cache occupancy events when soft RMIDs are enabled.

This series adds the "mbm_soft_rmid" mount option to allow users to
opt-in to the functionaltiy when they deem it helpful.

When the same system from the earlier AMD example enables the
mbm_soft_rmid mount option:

 # ./test_rmids.sh
 Created 255 monitoring groups.
 g1: mbm_total_bytes: 0 -> 686560576
 g2: mbm_total_bytes: 0 -> 668204416
[..]
 g252: mbm_total_bytes: 0 -> 672651200
 g253: mbm_total_bytes: 0 -> 666956800
 g254: mbm_total_bytes: 0 -> 665917056
 g255: mbm_total_bytes: 0 -> 671049600
 255 groups, 255 returned counts in first pass, 255 in second
 successfully measured bandwidth from 255/255 groups

(patches are based on tip/master)

[1] https://www.amd.com/system/files/TechDocs/56375_1.03_PUB.pdf

Peter Newman (8):
  selftests/resctrl: Verify all RMIDs count together
  x86/resctrl: Add resctrl_mbm_flush_cpu() to collect CPUs' MBM events
  x86/resctrl: Flush MBM event counts on soft RMID change
  x86/resctrl: Call mon_event_count() directly for soft RMIDs
  x86/resctrl: Create soft RMID version of __mon_event_count()
  x86/resctrl: Assign HW RMIDs to CPUs for soft RMID
  x86/resctrl: Use mbm_update() to push soft RMID counts
  x86/resctrl: Add mount option to enable soft RMID

Stephane Eranian (1):
  x86/resctrl: Hold a spinlock in __rmid_read() on AMD

 arch/x86/include/asm/resctrl.h                |  29 +++-
 arch/x86/kernel/cpu/resctrl/core.c            |  80 ++++++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   9 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  19 ++-
 arch/x86/kernel/cpu/resctrl/monitor.c         | 158 +++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |  52 ++++++
 tools/testing/selftests/resctrl/test_rmids.sh |  93 +++++++++++
 7 files changed, 425 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/resctrl/test_rmids.sh


base-commit: dd806e2f030e57dd5bac973372aa252b6c175b73
-- 
2.40.0.634.g4ca3ef3211-goog

