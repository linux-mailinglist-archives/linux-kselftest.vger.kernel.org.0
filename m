Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C53B44BDD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 10:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhKJJgt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 04:36:49 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47]:62495 "EHLO
        esa1.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230513AbhKJJgs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 04:36:48 -0500
IronPort-SDR: qwabvvmXmXMsZ6Uged9VN3Zdmzq+u2GIE/6vgKI8uZ8tFbhwx0KyRILaQuhPuTzE6N4p0OajWL
 w1XrJxSaoYOkWZy+QMU7iBNJYU35omjjplqk+0W5MYW3rmCOabbZpfujgzdMvJ67av2O09SGrO
 owpBcssdlsbvD9sJtxfY3dmRtu4Ye19ciAjUPvSS8mAro8R3991iK/vbeSt6MQsRXvhBTqjXkl
 uNYIeRC35qhyT8PEJXmCeeXyti8TypDwXU/XMi/X4gE0wY/zsppBtucHjpNn2P6+a6BBixBLa4
 kR3hTmaERAY+/qh0X30c4F6r
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="52113929"
X-IronPort-AV: E=Sophos;i="5.87,223,1631545200"; 
   d="scan'208";a="52113929"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 10 Nov 2021 18:33:59 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4F3B41013B7;
        Wed, 10 Nov 2021 18:33:58 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9B04BA56E6;
        Wed, 10 Nov 2021 18:33:57 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 85F254006B62C;
        Wed, 10 Nov 2021 18:33:56 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH 2/3] selftests/resctrl: Return KSFT_SKIP(4) if resctrl filessystem is not supported or resctrl is not run as root
Date:   Wed, 10 Nov 2021 18:33:14 +0900
Message-Id: <20211110093315.3219191-3-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>

To unify the return code of resctrl_tests with the return code of
selftest set, return KSFT_SKIP (4) if resctrl filessystem is not
supported or resctrl is not run as root.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 973f09a..3be0895 100644
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
1.8.3.1

