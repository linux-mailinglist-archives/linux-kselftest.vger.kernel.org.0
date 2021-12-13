Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84B14727F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 11:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbhLMKGO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 05:06:14 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:6510 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237866AbhLMKEK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:10 -0500
IronPort-SDR: MgIkQiG//Tf0LrLd5Dth3FEuy0dRC802hTIRZ+vgu3NgRyXm42XI9IYKIkYVuosuAcZ2TlCOYn
 kzNb8TEbj7JyJ0saKGlUxluM52emoxh744NbvYHFMaufuMrXfFdUD1e3dpfveAosXSZXaEUFDD
 DG9Hy0DSY9ruJATKR8jWYVGHX1YMd0nbmkLDfzLhcSFIS/3GvyovKGo4X/HbaWH7UrpDuKVOc1
 k7Bo8NfVHmu1cK5glpo6fCVqmwDsWvDDXXmyuzbH3yElXLkvVwe/usGIU8HT5errUWe40U7Xqi
 BXHubpix2gtlIC7KJ1fkzE+m
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="56174878"
X-IronPort-AV: E=Sophos;i="5.88,202,1635174000"; 
   d="scan'208";a="56174878"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Dec 2021 19:04:08 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 59A331FA82C;
        Mon, 13 Dec 2021 19:04:07 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E9D23D7466;
        Mon, 13 Dec 2021 19:04:06 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 80A4340467B71;
        Mon, 13 Dec 2021 19:04:06 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v2 4/5] selftests/resctrl: Change default limited time to 120 seconds for resctrl_tests
Date:   Mon, 13 Dec 2021 19:01:53 +0900
Message-Id: <20211213100154.180599-5-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit changed the default limited time(45s) to 120 seconds for
resctrl_tests by adding "setting" file.  Since 45 seconds may not be
enough on some machine environments.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/resctrl/settings

diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
new file mode 100644
index 000000000000..6091b45d226b
--- /dev/null
+++ b/tools/testing/selftests/resctrl/settings
@@ -0,0 +1 @@
+timeout=120
-- 
2.27.0

