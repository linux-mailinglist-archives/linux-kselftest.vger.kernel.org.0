Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 791D9113E49
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 10:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfLEJiz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 04:38:55 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55684 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfLEJiw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 04:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575538733; x=1607074733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=MiFuavq5Qnjsk7KrDh/upooxJoiEUmzFTrl7IlXIUqw=;
  b=ECN7i7g06pIiVPa7rsFuPX36xqd/va0c5Jap2E5+owf+j/KcMWwD+vZI
   /h1ubV2jcp88QSsYxCL72+aokNrV2SgfxcTZkzQqWq77Z6RA+BtOlbrun
   ei++Bo4XnIdhSbRkA+hBLNTbJ7qrvYY/BvXRoHIrwUAl9XBkj9Dq6bBN+
   g=;
IronPort-SDR: 5PPOhAW7haH6EKJQEUeZiV1/p09w4tUcgXN3MGy0udA95frYz634gZcjrchm6JYYI7SstiQM18
 XnmLmRmNJvkw==
X-IronPort-AV: E=Sophos;i="5.69,280,1571702400"; 
   d="scan'208";a="7181812"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Dec 2019 09:38:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (Postfix) with ESMTPS id 1A82FA1E55;
        Thu,  5 Dec 2019 09:38:50 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:38:49 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:38:45 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     <sj38.park@gmail.com>, <corbet@lwn.net>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <sjpark@amazon.de>
Subject: [PATCH v5 6/6] kunit/kunit_tool_test: Test '--build_dir' option run
Date:   Thu, 5 Dec 2019 10:38:31 +0100
Message-ID: <20191205093831.22925-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205093440.21824-1-sjpark@amazon.com>
References: <20191205093440.21824-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D05UWC003.ant.amazon.com (10.43.162.226) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds kunit tool test for the '--build_dir' option.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit_tool_test.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 22f16e66b3c1..cba97756ac4a 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -174,6 +174,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_fail(self):
@@ -202,5 +203,12 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	def test_run_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['run', '--build_dir', build_dir], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
 if __name__ == '__main__':
 	unittest.main()
-- 
2.17.1

