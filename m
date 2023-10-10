Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A847BF4F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442596AbjJJHzs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 03:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442525AbjJJHzr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 03:55:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAB491;
        Tue, 10 Oct 2023 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696924544; x=1728460544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o9KXt3CWPr1jno2uTLIRYflTe5fXU4Oamiy/W1dyREI=;
  b=OtJ2vKjjF2/y2CugZrcDoTdZVUST5OIvkZ7fG/ZzF4/oaomUZLM+ey2e
   Rk2zkdmrMggNB02lH5rM2ceJDIN+SmSsn6OWrLzyTgDSBtsNcbY1VNIeu
   NqXD9hc0YeX4Tp10cjr8pmRFhIER5KXgntnIwqxmWGZVr6LZXUIii+GIh
   O1VX8RAMm21a/ckhaB1JnSaGV5nQRQKOMKNKNEoSqnQVg0DunKj5Sgg0Z
   nPwNv1GkJ83MJQyt26G/IxPFHpipN2T6rtGXPMJI9klVguQWI3/yxmsvq
   ptrm7w+6WwgtTM6JkC++EqNdDF6hFov1i2VZHzrDNW4mnxvPpseRmOoNV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374679002"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="374679002"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 00:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="746979915"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="746979915"
Received: from asalaman-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.16.145])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 00:55:41 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 0/2] selftests/resctrl: Bug fix and optimization
Date:   Tue, 10 Oct 2023 09:55:30 +0200
Message-ID: <cover.1696923907.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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

The resctrlfs.c defines functions that interact with the resctrl FS
while resctrl_val.c defines functions that perform measurements on
the cache. Run_benchmark() fits logically into the second file before
resctrl_val() that uses it.

Move run_benchmark() from resctrlfs.c to resctrl_val.c and remove
redundant part of the kernel-doc comment. Make run_benchmark() static
and remove it from the header file.

Patch series is based on [1] which is based on [2] which are based on
kselftest next branch.

Changelog v7:
- Add label for non-empty schema error case to Patch 1/2. (Reinette)
- Add Reinette's reviewed-by tag to Patch 1/2.

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
[v6] https://lore.kernel.org/all/cover.1696848653.git.maciej.wieczor-retman@intel.com/

[1] https://lore.kernel.org/all/20231002094813.6633-1-ilpo.jarvinen@linux.intel.com/
[2] https://lore.kernel.org/all/20230904095339.11321-1-ilpo.jarvinen@linux.intel.com/

Maciej Wieczor-Retman (2):
  selftests/resctrl: Fix schemata write error check
  selftests/resctrl: Move run_benchmark() to a more fitting file

 tools/testing/selftests/resctrl/resctrl.h     |  1 -
 tools/testing/selftests/resctrl/resctrl_val.c | 50 ++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 93 ++++++-------------
 3 files changed, 76 insertions(+), 68 deletions(-)

-- 
2.42.0

