Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA27C9F70
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 08:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJPGYy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 02:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPGYy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 02:24:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A054295;
        Sun, 15 Oct 2023 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697437492; x=1728973492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C5NvzvYf1xpiz/5DJdtYT8poj0czhsYWbhIHm4WHrhU=;
  b=c/Sjd4nc8EXuUUO6FyTpjPDB773AFlh5Ly+kDyKnhQzJz3dRSQHi/7BZ
   h6egQaToshFfNxkLIK/ihSzK0H9u1vAXnErrnaRFHjMVJkGZ6Ngwr6O4B
   yDiHTJJ2Bkn/hfYoOmXPxdRh4aD/fK6oLrKpd30EDFJDSAnEVy0hUE2DG
   UnGAnyP499F7XXfLJ8Sst9JRN0wZNCdShJMOHvIogfU4A5PXa4ZtKr/vC
   xJl4GHotDRX1ZuspAP0VkRpKxRFUhjpTr73VPJ5gKxT06uBzZiJuoqIQV
   3W3Z7PBl7LGKssOJmqBqoMjnCU20AsBBh0I/csAfJSG8PnEZ7HIgNbD8T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="449661213"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="449661213"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="871968974"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="871968974"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO binbinwu-mobl.sh.intel.com) ([10.238.1.136])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:24:49 -0700
From:   Binbin Wu <binbin.wu@linux.intel.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        binbin.wu@linux.intel.com
Subject: [PATCH v2] selftests/x86/lam: Zero out buffer for readlink()
Date:   Mon, 16 Oct 2023 14:24:46 +0800
Message-Id: <20231016062446.695-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Zero out the buffer for readlink() since readlink() does not append a
terminating null byte to the buffer.  Also change the buffer length
passed to readlink() to 'PATH_MAX - 1' to ensure the resulting string
is always null terminated.

Fixes: 833c12ce0f430 ("selftests/x86/lam: Add inherit test cases for linear-address masking")

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v1->v2:
- Change the buffer length passed to readlink() to 'PATH_MAX - 1' to ensure the
  resulting string is always null terminated. [Kirill]

 tools/testing/selftests/x86/lam.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index eb0e46905bf9..8f9b06d9ce03 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -573,7 +573,7 @@ int do_uring(unsigned long lam)
 	char path[PATH_MAX] = {0};
 
 	/* get current process path */
-	if (readlink("/proc/self/exe", path, PATH_MAX) <= 0)
+	if (readlink("/proc/self/exe", path, PATH_MAX - 1) <= 0)
 		return 1;
 
 	int file_fd = open(path, O_RDONLY);
@@ -680,14 +680,14 @@ static int handle_execve(struct testcases *test)
 		perror("Fork failed.");
 		ret = 1;
 	} else if (pid == 0) {
-		char path[PATH_MAX];
+		char path[PATH_MAX] = {0};
 
 		/* Set LAM mode in parent process */
 		if (set_lam(lam) != 0)
 			return 1;
 
 		/* Get current binary's path and the binary was run by execve */
-		if (readlink("/proc/self/exe", path, PATH_MAX) <= 0)
+		if (readlink("/proc/self/exe", path, PATH_MAX - 1) <= 0)
 			exit(-1);
 
 		/* run binary to get LAM mode and return to parent process */

base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
-- 
2.25.1

