Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449BA1D8A7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgERWOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:14:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:46546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWOA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:14:00 -0400
IronPort-SDR: 4ZNaAmWfdR8rmh370XDL1zypLCvN9yS5YUtXlI8IWKyGljWocBXCswUS9SHY98Iu4OkhzUN3eq
 Pjni+W5qFwbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:14:00 -0700
IronPort-SDR: v5qWe2tEz67Z9QmPClF29+xGaOBewSBKJquyGFvwU7Fl9Us+IvAxi30UcX0oRlG1vz63Ldd73B
 sg14wNeX8WJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420386"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:13:59 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 12/19] selftests/resctrl: Enable gcc checks to detect buffer overflows
Date:   Mon, 18 May 2020 15:08:32 -0700
Message-Id: <a53033f871303fae931f9f170ec225dd07b639f6.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Feature Test Macros man page says the below about _FORTIFY_SOURCE

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

Enable this gcc check to catch buffer overflow bugs like the one in CMT
test.

Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Reported-by: David Binderman <dcb314@hotmail.com>
Suggested-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
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
2.19.1

