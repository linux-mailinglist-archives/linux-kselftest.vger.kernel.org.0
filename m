Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389874727F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 11:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhLMKGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 05:06:18 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:19255 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237076AbhLMKEP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:15 -0500
IronPort-SDR: VdqbBJIheXs0VE/AdTLa77zW0Dx1vM3WaNFsBwQcqo0BM6e6CFbwvbEugrZg15doZidICzt/DD
 AKCNCI2oiScz2TZ4oHbN9GOla7OtEWkAyUSUPqSvV+5x4APWQQSBllxhgaWCN70VnNZplWlGcO
 E99G2HzHje4sjWiz5GFUhn4IdJ0FOq9JcRsygOjPgDZopPfPUFepaPJl5k3yeHrs3zrB4uOOUz
 GTHxQw7opvr6vtwS5M4Q28db3+ijXS/54Va9r7XRyFLolHpdu2AM1IN9YjcaWufHnzW6zqjZ+v
 q2SrC9VHjcm18mVALUC1JgI4
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="35759563"
X-IronPort-AV: E=Sophos;i="5.88,202,1635174000"; 
   d="scan'208";a="35759563"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Dec 2021 19:04:09 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id B4FFEE6881;
        Mon, 13 Dec 2021 19:04:08 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0567FE6A52;
        Mon, 13 Dec 2021 19:04:08 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id DB15A40467B4A;
        Mon, 13 Dec 2021 19:04:07 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v2 5/5] selftests/resctrl: Return KSFT_SKIP(4) if resctrlfile system is not supported or resctrl is not run as root
Date:   Mon, 13 Dec 2021 19:01:54 +0900
Message-Id: <20211213100154.180599-6-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To unify the return code of resctrl_tests with the return code of
selftest set, return KSFT_SKIP (4) if resctrl file system is not
supported or resctrl is not run as root.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 973f09a66e1e..3be0895c492b 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -205,7 +205,7 @@ int main(int argc, char **argv)
 	 * 2. We execute perf commands
 	 */
 	if (geteuid() != 0)
-		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
+		return ksft_exit_skip("Not running as root, abort testing.\n");
 
 	/* Detect AMD vendor */
 	detect_amd();
@@ -235,7 +235,7 @@ int main(int argc, char **argv)
 	sprintf(bm_type, "fill_buf");
 
 	if (!check_resctrlfs_support())
-		return ksft_exit_fail_msg("resctrl FS does not exist\n");
+		return ksft_exit_skip("resctrl FS does not exist\n");
 
 	filter_dmesg();
 
-- 
2.27.0

