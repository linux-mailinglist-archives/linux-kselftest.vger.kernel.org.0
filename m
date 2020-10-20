Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FF52945A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439379AbgJTXvh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:11170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439373AbgJTXvg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:36 -0400
IronPort-SDR: L3m76nZB5HpKSU54W36mhI+kaBgit+KQpftrv8M78NmypG4F6ZmjnWGqS0aHVZdbSpd/3dl3jo
 xhDz7dkGDL5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486363"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486363"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:31 -0700
IronPort-SDR: Vxe1TAE6T12CTP0Vci295Q82Z8txNq3SEfDBI3qWyrg8o149QBh5beRD73orz/GcJIYclAKQmi
 SkRLVtp+Ix1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833850"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:31 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Binderman <dcb314@hotmail.com>
Subject: [PATCH v3 12/21] selftests/resctrl: Enable gcc checks to detect buffer overflows
Date:   Tue, 20 Oct 2020 23:51:17 +0000
Message-Id: <20201020235126.1871815-13-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David reported a buffer overflow error in the check_results() function of
the cmt unit test and he suggested enabling _FORTIFY_SOURCE gcc compiler
option to automatically detect any such errors.

Feature Test Macros man page describes_FORTIFY_SOURCE as below

"Defining this macro causes some lightweight checks to be performed to
detect some buffer overflow errors when employing various string and memory
manipulation functions (for example, memcpy, memset, stpcpy, strcpy,
strncpy, strcat, strncat, sprintf, snprintf, vsprintf, vsnprintf, gets, and
wide character variants thereof). For some functions, argument consistency
is checked; for example, a check is made that open has been supplied with a
mode argument when the specified flags include O_CREAT. Not all problems
are detected, just some common cases.

If _FORTIFY_SOURCE is set to 1, with compiler optimization level 1 (gcc
-O1) and above, checks that shouldn't change the behavior of conforming
programs are performed.

With _FORTIFY_SOURCE set to 2, some more checking is added, but some
conforming programs might fail.

Some of the checks can be performed at compile time (via macros logic
implemented in header files), and result in compiler warnings; other checks
take place at run time, and result in a run-time error if the check fails.

Use of this macro requires compiler support, available with gcc since
version 4.0."

Fix the buffer overflow error in the check_results() function of the cmt
unit test and enable _FORTIFY_SOURCE gcc check to catch any future buffer
overflow errors.

Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Reported-by: David Binderman <dcb314@hotmail.com>
Suggested-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/Makefile   | 2 +-
 tools/testing/selftests/resctrl/cmt_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index d585cc1948cc..6bcee2ec91a9 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,5 +1,5 @@
 CC = $(CROSS_COMPILE)gcc
-CFLAGS = -g -Wall
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 SRCS=$(wildcard *.c)
 OBJS=$(SRCS:.c=.o)
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 6ffb56c6a1e2..282ba7fcf17c 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -86,7 +86,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 		return errno;
 	}
 
-	while (fgets(temp, 1024, fp)) {
+	while (fgets(temp, sizeof(temp), fp)) {
 		char *token = strtok(temp, ":\t");
 		int fields = 0;
 
-- 
2.29.0

