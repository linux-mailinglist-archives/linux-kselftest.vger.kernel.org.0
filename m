Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F45E1D8A7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgERWN7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:13:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:46546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWN6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:13:58 -0400
IronPort-SDR: 63vdUwZ0YhO5l7mmyqnmoWykf8GuNWunO4b8X98lkAB9pRQg0sdXx09KkNo0YF/6o3gEiCY61h
 HfahrNiFskCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:13:58 -0700
IronPort-SDR: Y2M3KODyaSWKrmvFPg6dzMyriR7G9pEz4s7n1gCqGu9HYpD5dkfTruCqaQCz9HqA7BG5H51qcE
 30sBNDQiQkZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420367"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:13:57 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 09/19] selftests/resctrl: Fix missing options "-n" and "-p"
Date:   Mon, 18 May 2020 15:08:29 -0700
Message-Id: <ab5511e788b3440769152fbd1a748bdcb598ac85.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Add missing options "-n" and "-p" in getopt() so that the options can take
action. Other code related to the options is in place already and no
change is needed.

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index d24de546d4ef..cab69ed8c67d 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -73,7 +73,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	while ((c = getopt(argc_new, argv, "ht:b:")) != -1) {
+	while ((c = getopt(argc_new, argv, "ht:b:n:p:")) != -1) {
 		char *token;
 
 		switch (c) {
-- 
2.19.1

