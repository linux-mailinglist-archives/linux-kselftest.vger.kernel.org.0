Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD7478FE1C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjIANMF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 09:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjIANMF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 09:12:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4618E7E;
        Fri,  1 Sep 2023 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693573922; x=1725109922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jXsI7NSlJRp+KqFLiENWU8UxnTN1ynoeW0TkkfW/zt4=;
  b=Vr1oQPGXoPt4ZjrXQRH5vpzF8y1FZtbytajNdyNW25gQa+iLqQjO99If
   B4lQV5wg8/NLzlNXTN9FB7HTJuoeXDqVOIMLHKq6phPqMxccXsQenx2l0
   Byo1Ak1BlCdT/iF/ughC2YMKTjnKj+yUz2qGir2ZOTeajGG50B+906HxK
   4Px2f9rHRiMrObzhyg3z0E3CoH0RY46/wqbuvlHiyymtKgxL78vi2ZHzx
   AH8Kb9YQu+/Gl1FPVaaJJIqGtTDGyxmgc8eXEbHVm5k+hRKfSMfzOxLCG
   UOdMUTLJ9pyGKg0CA8TSNf1wSvNh6Aj9TBRriDwzedeg6PSjJaDxgLFvC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="376147306"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="376147306"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="716764090"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="716764090"
Received: from rawskaal-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.136])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:11:59 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/2] selftests/resctrl: Bug fix and optimization
Date:   Fri,  1 Sep 2023 15:11:34 +0200
Message-ID: <cover.1693569565.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Series is based on kselftest next branch.

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

Wieczor-Retman Maciej (2):
  selftests/resctrl: Fix schemata write error check
  selftests/resctrl: Move run_benchmark() to a more fitting file

 tools/testing/selftests/resctrl/resctrl.h     |  1 -
 tools/testing/selftests/resctrl/resctrl_val.c | 50 ++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 79 ++++---------------
 3 files changed, 65 insertions(+), 65 deletions(-)


base-commit: 9b1db732866bee060b9bca9493e5ebf5e8874c48
-- 
2.42.0

