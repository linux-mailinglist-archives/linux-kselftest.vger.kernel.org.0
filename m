Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC811113E10
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 10:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfLEJfU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 04:35:20 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:37911 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbfLEJfT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 04:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575538519; x=1607074519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=RrthRCcMi+yKCvsOW6MQckhRdJwt49061MYJsENxmg0=;
  b=Ck8gzm/nF5IPZB6tcKCZPHmQDGlMT+Utjfy/7XJ32i6ifx70s/OuRFLw
   J8FXeSoinf6xMiSvKo6Rxh2pbWLYcgSpTe+tKbZEAquLiW5NBcrssv70e
   hxeM1lGO5tbhWpq+qKXx+yh/+f/z5+dxaZ31AydR+V08/+iXJXTg0judR
   8=;
IronPort-SDR: FkPH8b9QKu8gqn9J9kTgX0/zpN2AED6j7jB11vwU/AlJezZBHsFwiZP8OttdA+jJSB5+IvpyhJ
 TVfh4gOLFj6Q==
X-IronPort-AV: E=Sophos;i="5.69,280,1571702400"; 
   d="scan'208";a="3361142"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 05 Dec 2019 09:35:16 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 4F51FA2024;
        Thu,  5 Dec 2019 09:35:15 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:35:14 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.180) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:35:10 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     <sj38.park@gmail.com>, <corbet@lwn.net>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <sjpark@amazon.de>
Subject: [PATCH v5 4/6] kunit: Place 'test.log' under the 'build_dir'
Date:   Thu, 5 Dec 2019 10:34:38 +0100
Message-ID: <20191205093440.21824-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205093440.21824-1-sjpark@amazon.com>
References: <20191205093440.21824-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D23UWC001.ant.amazon.com (10.43.162.196) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

'kunit' writes the 'test.log' under the kernel source directory even
though a 'build_dir' option is given.  As users who use the option might
expect the outputs to be placed under the specified directory, this
commit modifies the logic to write the log file under the 'build_dir'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit.py           | 2 +-
 tools/testing/kunit/kunit_kernel.py    | 4 ++--
 tools/testing/kunit/kunit_tool_test.py | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5b222418eacd..e4250c4b06fb 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -105,7 +105,7 @@ def main(argv, linux=None):
 	run_parser.add_argument('--build_dir',
 				help='As in the make command, it specifies the build '
 				'directory.',
-				type=str, default=None, metavar='build_dir')
+				type=str, default='', metavar='build_dir')
 
 	run_parser.add_argument('--defconfig',
 				help='Uses a default kunitconfig.',
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index c04a12e2f711..a10c0c787bc1 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -140,10 +140,10 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def run_kernel(self, args=[], timeout=None, build_dir=None):
+	def run_kernel(self, args=[], timeout=None, build_dir=''):
 		args.extend(['mem=256M'])
 		process = self._ops.linux_bin(args, timeout, build_dir)
-		with open('test.log', 'w') as f:
+		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
 			for line in process.stdout:
 				f.write(line.rstrip().decode('ascii') + '\n')
 				yield line.rstrip().decode('ascii')
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index a2a8ea6beae3..22f16e66b3c1 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -199,7 +199,7 @@ class KUnitMainTest(unittest.TestCase):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=None, timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 if __name__ == '__main__':
-- 
2.17.1

