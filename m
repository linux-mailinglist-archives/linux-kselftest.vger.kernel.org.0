Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9674727F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 11:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhLMKGR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 05:06:17 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:19252 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237213AbhLMKEK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:10 -0500
IronPort-SDR: aOVFJMKbL92M9prUSKctYmiUt85C8r+XrZeWPgo6mPEVyHr02euAGs9RHOC1gziAaUZlsdqxlZ
 5pxHt8fGZNIoTfzNf+qO8VJ8h2ZaZ1hbMQzXIC8BTTVG/JUOmgdyiOdHfSTOHi6n6SMW/yf9bX
 3p3GoSBb1hneZ84wQX5LzVtLwhgOLqrFxNNc7Ea5DUbn0c2WvECSqdMPmKOb4VVu/DdBJTGmMw
 tejLKp871VJ/WJ0Ux8LeK3qMdMVj0KONVqC0gw/3oiiQqLDGVPQ1DeEt60XJon/rVo4IjCOH/4
 5W/2yU47LYZAYhlfw7j/FZgh
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="35759555"
X-IronPort-AV: E=Sophos;i="5.88,202,1635174000"; 
   d="scan'208";a="35759555"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Dec 2021 19:04:06 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C8F811FA82F;
        Mon, 13 Dec 2021 19:04:05 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0969ADD76E;
        Mon, 13 Dec 2021 19:04:05 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id DDA7D40425CD3;
        Mon, 13 Dec 2021 19:04:04 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v2 3/5] selftests/resctrl: Add license to resctrl_test Makefile
Date:   Mon, 13 Dec 2021 19:01:52 +0900
Message-Id: <20211213100154.180599-4-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add Software Package Data Exchange license information to resctrl_test Makefile.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index c9e8540fc594..adfd92145e12 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,3 +1,5 @@
+#SPDX-License-Identifier: GPL-2.0
+
 CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
 
 TEST_GEN_PROGS := resctrl_tests
-- 
2.27.0

