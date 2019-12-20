Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C35127503
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2019 06:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLTFOb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 00:14:31 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41335 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfLTFO0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 00:14:26 -0500
Received: by mail-wr1-f41.google.com with SMTP id c9so8136500wrw.8;
        Thu, 19 Dec 2019 21:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wvc6mp8TpYnIrD2kv/SKRsGHLV9BbyYFN352NxRckX0=;
        b=CPvicxW9ofjoU9RfDadM9o6pV/o7TIeOb7amdLqoW7zVXt7a8iWmfEw/USKNBoLotT
         SN6+a8nBjwd9H3rD14fcR2In5tc+SyPy0m+Wit28PlEJ+B7shdkrizIfKNXkI1RF/dSp
         bkRxZbMUQEkVfJ/XTsbt15fMvuaq8AycVp2RG8wTeuAyo5vzLhXvDY32QLRhdwkQtrAY
         B/kEaxyXDrCj+HmlgPq7Tr99t5dpXl600taZWePd+7KB8CHfiPGSJVeN8sHMxzjEDyW4
         bjPYSy3141YPvyBLFYMWXEe66kZ+aA/TX72hikxnDbaN0VSivx3/vXh7nEByqZqyFGdt
         oMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wvc6mp8TpYnIrD2kv/SKRsGHLV9BbyYFN352NxRckX0=;
        b=e5ruXRYFG/wP1HDCqnHLgrQMdpav0CxOMKJtk/qa+kb5HDi3EOjH7Ozb10bLe3l9+M
         IczuZ1fuCjztCAz5EE0onu1XBjJS5V88QqPQrfEL0ItRrmJWPMrS7kHem/24H4+p747g
         9HJY/ixe0Z1FJLMDjA0uiE08I/xu5Ogr6xx/8zgx9FzGOXXE1JwEfgwTQj/WPqzWk4r/
         9QGtLUqjYe+IAQaNhARbDIXfPFxaTtxyJ47MYB/YRYyhRDMPfn2l7/ppBjmgRpEQzXV9
         bKpx6R6AsEiCsWm9UiT7ETM6wLzab3oDEV6dHJUmTLYAqvWP7ays4rOitD/VKD1zWD81
         3inA==
X-Gm-Message-State: APjAAAV+aF8woP4JQzCj+Rq9NKsPxBOxiPpMM8k3sHkk7a2bhaGrQ/8x
        +1w6gtpeDrPUqmCOIQXXixY=
X-Google-Smtp-Source: APXvYqxBnPAvPA9JEkJThZNdOy1K1asm1Hw77D3N+Npjpi6OIwkyCiYRLJzJXr9mB0JzRciXSaLOBw==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr12462934wrq.137.1576818864742;
        Thu, 19 Dec 2019 21:14:24 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id j12sm8703863wrt.55.2019.12.19.21.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 21:14:24 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     shuah@kernel.org
Cc:     brendanhiggins@google.com, corbet@lwn.net,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sj38.park@gmail.com, sjpark@amazon.com, sjpark@amazon.de
Subject: [PATCH v7 6/6] kunit/kunit_tool_test: Test '--build_dir' option run
Date:   Fri, 20 Dec 2019 05:14:08 +0000
Message-Id: <20191220051408.3591-7-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220051408.3591-1-sjpark@amazon.de>
References: <20191220051408.3591-1-sjpark@amazon.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds kunit tool test for the '--build_dir' option.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
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

