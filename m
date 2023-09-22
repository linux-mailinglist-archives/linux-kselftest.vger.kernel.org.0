Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459D77AABF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjIVIKm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 04:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjIVIKL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 04:10:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C25A9;
        Fri, 22 Sep 2023 01:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695370203; x=1726906203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=15lmJ/+YhtIrXX8BY7eWBkaUaOZiS9o2XSYGf6Nf8CE=;
  b=dQ6Gt3Nqnt7qZnMdfEv6PIldnZtDSzOjdx/1wVP03X03meIOrHtwgKzy
   3+cPIATHHwd/UZPHiWW3yrzOIG3OhShz9c4nyHj3MzBYyvMGLycQ8V+TG
   P8QKKdbqtW9D9aehmLYXGEFVvnOIQH7CyULGaEyTPtGeEXWm/DXRlgCoT
   J/Fzr4GGK3qlb8j/b5U7YrhYbG9ehQ2cCoRk1nYR8U7GQzbB9U4etM+IQ
   smRo0xOMjoPVd/mCAIQuvTkdGbr8rIXMcmkNzsBchauTkZBkOzJg19+Lk
   b+om/WF2agED3OAcrkboCZ8yqg3Pj9hCZB5o84ueBWTGaPvr38Vowti9r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="444873882"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="444873882"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="921079097"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="921079097"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:10:00 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 0/2] selftests/resctrl: Bug fix and optimization
Date:   Fri, 22 Sep 2023 10:09:33 +0200
Message-ID: <cover.1695369120.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Write_schemata() uses fprintf() to write a bitmask into a schemata file
inside resctrl FS. It checks fprintf() return value but it doesn't check
fclose() return value. Error codes from fprintf() such as write errors,
are buffered and flushed back to the user only after fclose() is executed
which means any invalid bitmask can be written into the schemata file.

Rewrite write_schemata() to use syscalls instead of stdio file
operations to avoid the buffering.

The resctrlfs.c file defines functions that interact with the resctrl FS
while resctrl_val.c file defines functions that perform measurements on
the cache. Run_benchmark() fits logically into the second file before
resctrl_val() function that uses it.

Move run_benchmark() from resctrlfs.c to resctrl_val.c and remove
redundant part of the kernel-doc comment. Make run_benchmark() static
and remove it from the header file.

Patch series is based on [1] which is based on [2] which are based on
ksefltest next branch.

Changelog v4:
- Change git signature from Wieczor-Retman Maciej to Maciej
  Wieczor-Retman.
- Rebase onto [1] which is based on [2]. (Reinette)
- Add fcntl.h explicitly to provide glibc backward compatibility.
  (Reinette)

Changelog v3:
- Use snprintf() return value instead of strlen() in write_schemata().
  (Ilpo)
- Make run_benchmark() static and remove it from the header file.
  (Reinette)
- Added Ilpo's reviewed-by tag to Patch 2/2.
- Patch messages and cover letter rewording.

Changelog v2:
- Change sprintf() to snprintf() in write_schemata().
- Redo write_schemata() with syscalls instead of stdio functions.
- Fix typos and missing dots in patch messages.
- Branch printf attribute patch to a separate series.

[v1] https://lore.kernel.org/all/cover.1692880423.git.maciej.wieczor-retman@intel.com/
[v2] https://lore.kernel.org/all/cover.1693213468.git.maciej.wieczor-retman@intel.com/
[v3] https://lore.kernel.org/all/cover.1693575451.git.maciej.wieczor-retman@intel.com/

[1] https://lore.kernel.org/all/20230915154438.82931-1-ilpo.jarvinen@linux.intel.com/
[2] https://lore.kernel.org/all/20230904095339.11321-1-ilpo.jarvinen@linux.intel.com/

Maciej Wieczor-Retman (2):
  selftests/resctrl: Fix schemata write error check
  selftests/resctrl: Move run_benchmark() to a more fitting file

 tools/testing/selftests/resctrl/resctrl.h     |  1 -
 tools/testing/selftests/resctrl/resctrl_val.c | 50 +++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 82 ++++---------------
 3 files changed, 67 insertions(+), 66 deletions(-)


base-commit: 3b3e8a34b1d50c2c5c6b030dab7682b123162cb4
-- 
2.42.0

