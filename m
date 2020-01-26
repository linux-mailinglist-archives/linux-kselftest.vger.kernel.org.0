Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64212149873
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2020 02:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAZB7c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jan 2020 20:59:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34656 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAZB7c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jan 2020 20:59:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so6818562wrr.1;
        Sat, 25 Jan 2020 17:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SdVs3dPIiiIIcXjoO9Xv21aA/w8JkSjwfU51yGxLE6A=;
        b=ExoCsI3q2nebn41pv8In6nPDsjOf8kNEcVEzCYhpX30KaEJzP+/HROWaaTShwp0+7d
         uoEOFpkFBTk7gyv6VsoZN7sDudeGPbcgxYO2RMw82uTtKXsDiaq/kiGLnrOBKzi4gFFJ
         3Dq9pujmhPqYaCMni36tLk9wZC1y4Kt+1kk2yy+jKgCFc/uk8CpXLzw3pEjqaERqhRXb
         MektIhtL8cgY5snjPwCptcw63Eg/u2DMxxTi9AEUueajuLewb8roEjrpNtLt5Xb/hV7A
         uLr06yfOaLnDAiWO7idT4YN1pzNPZmCEaBmVQsw1rT7l7quRs9rcCclRHwOF6/WKqgQn
         XiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SdVs3dPIiiIIcXjoO9Xv21aA/w8JkSjwfU51yGxLE6A=;
        b=qjG8wzfYwBKf6FXhD4R3OVCes2OFafWnGS6EiucUWVrcEVVz+v98Ox+39gD99AUoUr
         RJ4xFeK++Fdtyafygh/SwOepBB+fbFVRd0Qqe9WWczB3G3Rf2LbnIEVJGieKZtKP62Pp
         zfldPnvES0CkMyJ/jMDWO1FrBVwNntnmqp3p44U1fIhJj5SPCtjbLN0KcrLsuEadW6g5
         ZGgI3hACAyBq/ZLRE9zq+8mt2WvxlbhWOUpL+AB51RRRvtHoOw5g9YrinF0FwSe6hsBf
         AhvAu3AdQ1rTV0An4XG69EElgGoHweg3QaBaXpnXn0bVhIWrTep1j2MxBtANt631xy4b
         aPYQ==
X-Gm-Message-State: APjAAAU5lKBegSheQ1j3afHv5jlbcxXL2z9USeKUutyMWtNqUxRM+SCf
        LLLCEtBPQO9wfiGR37EGeigtYJvD
X-Google-Smtp-Source: APXvYqxIw3mhhJft1s/vf8mq7u6dtiCZPcquS1iCHkBN36p+61TVQSAcy1TBWNssgtE3EcJhReQd3w==
X-Received: by 2002:adf:cf12:: with SMTP id o18mr12803406wrj.361.1580003969994;
        Sat, 25 Jan 2020 17:59:29 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-10-173.cust.telecolumbus.net. [86.56.10.173])
        by smtp.gmail.com with ESMTPSA id u16sm12542241wmj.41.2020.01.25.17.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 17:59:29 -0800 (PST)
From:   sj38.park@gmail.com
To:     brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] kunit/kunit_kernel: Rebuild .config if .kunitconfig is modified
Date:   Sun, 26 Jan 2020 01:59:24 +0000
Message-Id: <20200126015924.4198-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Deletions of configs in the '.kunitconfig' is not applied because kunit
rebuilds '.config' only if the '.config' is not a subset of the
'.kunitconfig'.  To allow the deletions to applied, this commit modifies
the '.config' rebuild condition to addtionally check the modified times
of those files.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit_kernel.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index cc5d844ecca1..a3a5d6c7e66d 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -111,17 +111,22 @@ class LinuxSourceTree(object):
 		return True
 
 	def build_reconfig(self, build_dir):
-		"""Creates a new .config if it is not a subset of the .kunitconfig."""
+		"""Creates a new .config if it is not a subset of, or older than the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
 			existing_kconfig = kunit_config.Kconfig()
 			existing_kconfig.read_from_file(kconfig_path)
-			if not self._kconfig.is_subset_of(existing_kconfig):
-				print('Regenerating .config ...')
-				os.remove(kconfig_path)
-				return self.build_config(build_dir)
-			else:
+			subset = self._kconfig.is_subset_of(existing_kconfig)
+
+			kunitconfig_mtime = os.path.getmtime(kunitconfig_path)
+			kconfig_mtime = os.path.getmtime(kconfig_path)
+			older = kconfig_mtime < kunitconfig_mtime
+
+			if subset and not older:
 				return True
+			print('Regenerating .config ...')
+			os.remove(kconfig_path)
+			return self.build_config(build_dir)
 		else:
 			print('Generating .config ...')
 			return self.build_config(build_dir)
-- 
2.17.1

