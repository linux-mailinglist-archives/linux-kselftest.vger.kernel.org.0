Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D500212750A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2019 06:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLTFOl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 00:14:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46327 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfLTFOY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 00:14:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so8094346wrl.13;
        Thu, 19 Dec 2019 21:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tsoM+tENaiFBqsqZQ09FDA9C5Ccx/Wof1Q5+yXLoE5Y=;
        b=iDO3yFxxCOo8POg0aFkAFvfoNDhtjvMJFMaj9+uqvzl4IgLx5GGs1QW51zl0EURVqP
         8nwdXuIQhdDjwrMPq43HuJ7f0dhKm4xITkc2NSXPd+zVI96Df3RmhY68ZDvSJ0UFjqNs
         +0RPbokS2VSMmSrlLz3pcOYTneQY/9CFciQ/4JcJYucW1QlJVzX1FdG5GkMVaBsFyOeU
         QzuREpEv6lLEVDWY2tH+ui+umv6mIsQe5JIY4t+yINpONTi5Pj33/+HDtJKgYWDmnRn3
         dzWhGlZcpwoXDxK6r9AH/2KkflYwYXKVMbVt5KVIx+Q8UtrjtvlA5zxb5GjFFk7dfnPT
         KGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tsoM+tENaiFBqsqZQ09FDA9C5Ccx/Wof1Q5+yXLoE5Y=;
        b=ulKl2IT+xT5bfVtRMEaunsq6AGEy8+pbVnMUc0LCoHf6WX7FIvA6AuYNBSWKorMPRc
         HbWzzBrdNL5VTLcvEHgX26t+XERuL06EKWQ/MT0ZuELAPvyziqTDv1yZdsJ+bjV6w0+L
         +gdaieZtcy23CDtU9zN0IoMdAju+sDJbg8tfxU/4p0R68XJpBQ2Hgv3or/xtRchzK2rx
         45h66Wxe5C3xHpkXvf1w1g7KDxSd+T5Mgs3/aMYiBxTLr3LBZ2gI+wb+frCLZuz91euu
         Fa7XlfVLKg+Gf9zFbkDuL/4/YUGphI1QEXkOOxZ0M17sLawA+dIGDE9gPVpDNhvrizEZ
         0cQw==
X-Gm-Message-State: APjAAAVCTflxZle0iaO8d20uIXgIQWpRVbBTRLVipeHhWKMYKaTOB8E6
        pJu77upHxh0vYIdsUYKvo8nGgIVZ
X-Google-Smtp-Source: APXvYqwhKvQyCeqRH856GG4jVzX/chAb6GCO6SK9wi0Gwf4bHpFjmSwt3YAEys0Hoc9rUU43wZnilg==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr12921320wru.65.1576818862279;
        Thu, 19 Dec 2019 21:14:22 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id j12sm8703863wrt.55.2019.12.19.21.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 21:14:21 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     shuah@kernel.org
Cc:     brendanhiggins@google.com, corbet@lwn.net,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sj38.park@gmail.com, sjpark@amazon.com, sjpark@amazon.de
Subject: [PATCH v7 4/6] kunit: Place 'test.log' under the 'build_dir'
Date:   Fri, 20 Dec 2019 05:14:06 +0000
Message-Id: <20191220051408.3591-5-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220051408.3591-1-sjpark@amazon.de>
References: <20191220051408.3591-1-sjpark@amazon.de>
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
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

