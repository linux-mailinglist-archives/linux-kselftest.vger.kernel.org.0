Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F9D78FE7D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 15:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbjIANnO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 09:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIANnN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 09:43:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6277CC5;
        Fri,  1 Sep 2023 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575759; x=1725111759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/3MU68KN7Ol8kTACvtoyXQuvYrqukbUxzP+MPq8beO4=;
  b=eEh3c9DJhMnGK57SThrXJEMUEQgo/mlqSUv0QY/mn5zEl6ovPFrcdN3U
   cv2PBHeAtTPejJxlxNN0Is4HZFRZXBCr9eatuZ7fhqjGxn61zbWlBfiQZ
   9AkvU9XgC6/RraK9QmJQGUXOXAg/045ixrcNqCqoD/nc2QfyvbK9ZcJoC
   Dk2ZTapFSkpkp5DdkurMsNmwcLRGbJEWfHygnVW/A9EzrAq26yKtxEXcf
   Wwt0IgJnNDuZE/4rnT0pHYCh85wyg3Wh5LVDTjj45CYzAo96/m3B4Osi8
   kybHUnd1eB+C6mkD5vQ+0bdCWzFz6WlLOymNoJGbau1cibD1AgiPPexNQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375122085"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="375122085"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:42:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070755314"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="1070755314"
Received: from rawskaal-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.136])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:42:27 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH RESEND v3 0/2] selftests/resctrl: Bug fix and optimization
Date:   Fri,  1 Sep 2023 15:41:56 +0200
Message-ID: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 tools/testing/selftests/resctrl/resctrlfs.c   | 78 ++++---------------
 3 files changed, 64 insertions(+), 65 deletions(-)


base-commit: 9b1db732866bee060b9bca9493e5ebf5e8874c48
-- 
2.42.0

