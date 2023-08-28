Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4746978A968
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 11:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjH1J4n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjH1J4h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 05:56:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC107110;
        Mon, 28 Aug 2023 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693216594; x=1724752594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=83BH7b4GlvBh9TptjxL2A1sfhSS1AvOLrnGkC7t0Q4k=;
  b=TVjQDslwbd5JatAe2eXQGW06LIaDhxaPHM+ZXQ4DI/gx5FLAWoJz4B+H
   qph5QcBSEFI2oqMUHWB+WDM6SifQVOLlLCSUjLjmLFzE/Z+GWXC3Rr611
   57aAYsyGsrfr9JeTQRze1EjCoagc6UiTaO7X5/z4mWC141UZujY95DloH
   /qBqi7Gsa79Tf7pz9MS0MsuEm5Vh2fHD/SFG2g7Q98Ys303WH7run9dhV
   MdOQfmA1S1o18pEwIL4eUUpzxwb8c8xX/p/RiOKK3xwGk/0veAXQ3Ydpd
   ZFFNmSSq7I5klvZG8X8CHeJ06fDdz0QXP5pYYaJbSc6ahyTmShosk4AeV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="365266305"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="365266305"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 02:56:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="803650165"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="803650165"
Received: from nwiklans-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 02:56:17 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com
Subject: [PATCH v2 0/2] selftests/resctrl: Bug fix and optimizations
Date:   Mon, 28 Aug 2023 11:56:06 +0200
Message-ID: <cover.1693213468.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Write_schemata() uses fprintf() to write a bitmask into a schemata file
inside resctrl FS. It checks fprintf() return value but it doesn't check
fclose() return value. Error codes from fprintf() such as write errors,
are flushed back to the user only after fclose() is executed which means
any invalid bitmask can be written into the schemata file.

Rewrite write_schemata() to use syscalls instead of stdio functions to
interact with the schemata file.

Change sprintf() to snprintf() in write_schemata().

In case of write() returning an error pass the string acquired with
strerror() to the "reason" buffer.

Extend "reason" buffer by a factor of two so it can hold longer error
messages.

The resctrlfs.c file defines functions that interact with the resctrl FS
while resctrl_val.c file defines functions that perform measurements on
the cache. Run_benchmark() fits logically into the second file before
resctrl_val() function that uses it.

Move run_benchmark() from resctrlfs.c to resctrl_val.c just before
resctrl_val() function definition.

Series is based on kselftest next branch.

Changelog v2:
- Change sprintf() to snprintf() in write_schemata().
- Redo write_schemata() with syscalls instead of stdio functions.
- Fix typos and missing dots in patch messages.
- Branch printf attribute patch to a separate series.

[v1] https://lore.kernel.org/all/cover.1692880423.git.maciej.wieczor-retman@intel.com/

Wieczor-Retman, Maciej (2):
  selftests/resctrl: Fix schemata write error check
  selftests/resctrl: Move run_benchmark() to a more fitting file

 tools/testing/selftests/resctrl/resctrl_val.c | 50 ++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 76 ++++---------------
 2 files changed, 63 insertions(+), 63 deletions(-)


base-commit: 13eb52f6293dbda02890698d92f3d9913d8d5aeb
-- 
2.42.0

