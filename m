Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2E67BD90B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjJIK5G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjJIK5F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:57:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156829C;
        Mon,  9 Oct 2023 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696849024; x=1728385024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nhwDkG5fTQwXX2IXshsi+tqVY3iJoWVLRu0MJIMDoL4=;
  b=nnfqkSOjT6GckUupeWXYdceZelWtCYY3D+eAs5+ywus9sWj0HeiEdYcw
   a5tv2yDbe+wc2tBwznef9Z8qAtwfJH87+taLINNQdq1zAqyzRFZ27JsFw
   NrpMW/uL6WqowR6L3wJ6E24bSjkaFeT0ScN7nkeIXGAJx1D6LxGDIRWxq
   YlO+34SNemZr1uo6vKy13OCORrp1AUfhMQPJ9EkJINi5RRxRf4c0oEZJc
   +X8fulryXz9XiPvDgzJkPlky/59Flki8P8TqK29wAyYnnGFw1Fg2QmCrb
   ONFEIPxsRV92bh+2fnx46cZkVaGqhV1bFR5SY4b+bmXMBwvgQb15/meLN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="363472276"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="363472276"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="896726280"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="896726280"
Received: from kkensic-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.30.239])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:55:21 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 0/2] selftests/resctrl: Bug fix and optimization
Date:   Mon,  9 Oct 2023 12:56:22 +0200
Message-ID: <cover.1696848653.git.maciej.wieczor-retman@intel.com>
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

The resctrlfs.c defines functions that interact with the resctrl FS
while resctrl_val.c defines functions that perform measurements on
the cache. Run_benchmark() fits logically into the second file before
resctrl_val() that uses it.

Move run_benchmark() from resctrlfs.c to resctrl_val.c and remove
redundant part of the kernel-doc comment. Make run_benchmark() static
and remove it from the header file.

Patch series is based on [1] which is based on [2] which are based on
kselftest next branch.

Changelog v6:
- Align schema_len error checking with typical snprintf format.
  (Reinette)
- Initialize schema string for early return eventuality. (Reinette)

Changelog v5:
- Add Ilpo's reviewed-by tag to Patch 1/2.
- Reword patch messages slightly.
- Add error check to schema_len variable.

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
- Add Ilpo's reviewed-by tag to Patch 2/2.
- Patch messages and cover letter rewording.

Changelog v2:
- Change sprintf() to snprintf() in write_schemata().
- Redo write_schemata() with syscalls instead of stdio functions.
- Fix typos and missing dots in patch messages.
- Branch printf attribute patch to a separate series.

[v1] https://lore.kernel.org/all/cover.1692880423.git.maciej.wieczor-retman@intel.com/
[v2] https://lore.kernel.org/all/cover.1693213468.git.maciej.wieczor-retman@intel.com/
[v3] https://lore.kernel.org/all/cover.1693575451.git.maciej.wieczor-retman@intel.com/
[v4] https://lore.kernel.org/all/cover.1695369120.git.maciej.wieczor-retman@intel.com/
[v5] https://lore.kernel.org/all/cover.1695975327.git.maciej.wieczor-retman@intel.com/

[1] https://lore.kernel.org/all/20231002094813.6633-1-ilpo.jarvinen@linux.intel.com/
[2] https://lore.kernel.org/all/20230904095339.11321-1-ilpo.jarvinen@linux.intel.com/

Maciej Wieczor-Retman (2):
  selftests/resctrl: Fix schemata write error check
  selftests/resctrl: Move run_benchmark() to a more fitting file

 tools/testing/selftests/resctrl/resctrl.h     |  1 -
 tools/testing/selftests/resctrl/resctrl_val.c | 50 +++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 88 +++++--------------
 3 files changed, 73 insertions(+), 66 deletions(-)

-- 
2.42.0

