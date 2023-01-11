Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC226655C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 09:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjAKIOi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 03:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjAKIOh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 03:14:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409862F5;
        Wed, 11 Jan 2023 00:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673424873; x=1704960873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ob/cAyWIyMqMT+iLEQuK2cLM0d9DsHAMtU1ZfVOlaV8=;
  b=nzW6ilGCD/lX/cJE/ysY2gZ3K/LS0WZsJBCOOs6xbbMnQSyCeF6NL5J5
   kghphZe8Hv7R8nncpSanPJnPBFajqKksB5Ywntnn9iVH8SN9qK4J+0tT6
   1g8qnki4hdHVHCKRKLb1PyPZ9SdwFfVPWhM1nwrPjzOHfvEBkJziyZcH4
   hCB0h/9XPbrKc5N3R1FdJyMeduO62fyajIqVlNW9Uowgbubr2Lxh+S1bK
   E6iANuqH3EPDtjEYwro3J5VXWmPTOEzDMziOtH2OUMnHBFOtobIYaRtQO
   mT6XCxe6fHDXKNbFyUt/JgJTDWh9F8pkG+VLH0FAj8hJuDOJHXN/B8xqM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311167755"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="311167755"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 00:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831272172"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="831272172"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2023 00:14:30 -0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     javierm@redhat.com, skhan@linuxfoundation.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        akpm@linux-foundation.org
Subject: [PATCH v1 1/1] selftests/filesystems: Grant executable permission to run_fat_tests.sh
Date:   Wed, 11 Jan 2023 16:15:31 +0800
Message-Id: <dfdbba6df8a1ab34bb1e81cd8bd7ca3f9ed5c369.1673424747.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1673424747.git.pengfei.xu@intel.com>
References: <cover.1673424747.git.pengfei.xu@intel.com>
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

When use tools/testing/selftests/kselftest_install.sh to make the
kselftest-list.txt under tools/testing/selftests/kselftest_install.

Then use tools/testing/selftests/kselftest_install/run_kselftest.sh to
run all the kselftests in kselftest-list.txt, it will be blocked by
case "filesystems/fat: run_fat_tests.sh" with "Warning: file run_fat_tests.sh
is not executable", so grant executable permission to run_fat_tests.sh to
fix this issue.

Fixes: dd7c9be330d8 ("selftests/filesystems: add a vfat RENAME_EXCHANGE test")
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 tools/testing/selftests/filesystems/fat/run_fat_tests.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

diff --git a/tools/testing/selftests/filesystems/fat/run_fat_tests.sh b/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
old mode 100644
new mode 100755
-- 
2.31.1

