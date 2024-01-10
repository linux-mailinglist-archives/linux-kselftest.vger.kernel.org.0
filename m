Return-Path: <linux-kselftest+bounces-2804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA1F829E17
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 17:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F471C2206A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2D14C3DB;
	Wed, 10 Jan 2024 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMrsvWd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41E4C3A5
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704902397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XQnGeG1QGEu/QBtp4/TBUL4MRasK2rgYQhSF+ZicemU=;
	b=WMrsvWd17oLCmT/9W6JkzBX+p+Dwzb92qj4j0s9uP0n4VX1sypNbxsfYP8DxSPwXQAFEae
	bWJRlV7xpx51URsfSw9KX7i/TRIMQymeXTlobh+GH5Dhrm3K3Kw2bL08krkh9TP4tNpkUd
	6NhQlHlUaYKwcnXiNK/1FMYx3q8ttHc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-AjRjoeYRO7-moMEMwbISoQ-1; Wed, 10 Jan 2024 10:59:56 -0500
X-MC-Unique: AjRjoeYRO7-moMEMwbISoQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7831be985c0so517707685a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 07:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704902395; x=1705507195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQnGeG1QGEu/QBtp4/TBUL4MRasK2rgYQhSF+ZicemU=;
        b=D+zMMkTD5vn4hB/f9y0JQjlPb0BantH5dCqpbrsrQ6CUxaPG+ysUCdZabfp3WBa/ID
         RVg7RJ3NhxwlwHXO4Mh1EyqY+EzorUQTyi00A3KsB4PR2CqGoOppagPEcf4tv4dIdlf5
         kbyIkhBGvgWv1qtqgnpRPoa8K811N70IxzcFsH2e7OhmavgC9sz/EFZwUNsCBlpQdYmk
         c9gRpqlAaCGzT2FOyU2U/H3Qxi22heMsYZu/455Gb66PEpV5e57GiCy3Hfl/iY3915Z+
         pGsy7vkB6oMQjCvUS8wU5R87bc+pJunZA1PBNPp8P0M1AD+u5TLilHex3eICVRWiYcev
         O1ug==
X-Gm-Message-State: AOJu0YxfGhCJ7RoAGa4AG+mPRoPmVcd2olXs4nKTPJnwS8JUHF7e1U6r
	X69FSqm0zHUPYPs+Iq7SEQbkwpajAfFdqeIVDlG9Nji1dPDJttc1D1Mds/wr0oVYlzKf+thoqS+
	Rwcaw2RlCzBFLQGEoK6uf0E+4lDuBpK+Fk7E=
X-Received: by 2002:a05:620a:5604:b0:781:a2bc:3211 with SMTP id vu4-20020a05620a560400b00781a2bc3211mr1186461qkn.128.1704902395533;
        Wed, 10 Jan 2024 07:59:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/bzCATczOMB0vRgD1epB1FaXF/PgxKumauea4s3H5r12+zW5Kxf78GIo1oE4XXqbp03PmNA==
X-Received: by 2002:a05:620a:5604:b0:781:a2bc:3211 with SMTP id vu4-20020a05620a560400b00781a2bc3211mr1186454qkn.128.1704902395222;
        Wed, 10 Jan 2024 07:59:55 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id z11-20020a05620a08cb00b00783206b9fedsm1691930qkz.86.2024.01.10.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:59:54 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] kunit: run test suites only after module initialization completes
Date: Wed, 10 Jan 2024 16:59:47 +0100
Message-ID: <20240110155948.90964-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
kunit_free_suite_set()") fixed a wild-memory-access bug that could have
happened during the loading phase of test suites built and executed as
loadable modules. However, it also introduced a problematic side effect
that causes test suites modules to crash when they attempt to register
fake devices.

When a module is loaded, it traverses the MODULE_STATE_UNFORMED and
MODULE_STATE_COMING states before reaching the normal operating state
MODULE_STATE_LIVE. Finally, when the module is removed, it moves to
MODULE_STATE_GOING before being released. However, if the loading
function load_module() fails between complete_formation() and
do_init_module(), the module goes directly from MODULE_STATE_COMING to
MODULE_STATE_GOING without passing through MODULE_STATE_LIVE.

This behavior was causing kunit_module_exit() to be called without
having first executed kunit_module_init(). Since kunit_module_exit() is
responsible for freeing the memory allocated by kunit_module_init()
through kunit_filter_suites(), this behavior was resulting in a
wild-memory-access bug.

Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
kunit_free_suite_set()") fixed this issue by running the tests when the
module is still in MODULE_STATE_COMING. However, modules in that state
are not fully initialized, lacking sysfs kobjects. Therefore, if a test
module attempts to register a fake device, it will inevitably crash.

This patch proposes a different approach to fix the original
wild-memory-access bug while restoring the normal module execution flow
by making kunit_module_exit() able to detect if kunit_module_init() has
previously initialized the tests suite set. In this way, test modules
can once again register fake devices without crashing.

This behavior is achieved by checking whether mod->kunit_suites is a
virtual or direct mapping address. If it is a virtual address, then
kunit_module_init() has allocated the suite_set in kunit_filter_suites()
using kmalloc_array(). On the contrary, if mod->kunit_suites is still
pointing to the original address that was set when looking up the
.kunit_test_suites section of the module, then the loading phase has
failed and there's no memory to be freed.

v4:
- rebased on 6.8
- noted that kunit_filter_suites() must return a virtual address
v3:
- add a comment to clarify why the start address is checked
v2:
- add include <linux/mm.h>

Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
Reviewed-by: David Gow <davidgow@google.com>
Tested-by: Rae Moar <rmoar@google.com>
Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 lib/kunit/executor.c |  4 ++++
 lib/kunit/test.c     | 14 +++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 717b9599036b..689fff2b2b10 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -146,6 +146,10 @@ void kunit_free_suite_set(struct kunit_suite_set suite_set)
 	kfree(suite_set.start);
 }
 
+/*
+ * Filter and reallocate test suites. Must return the filtered test suites set
+ * allocated at a valid virtual address or NULL in case of error.
+ */
 struct kunit_suite_set
 kunit_filter_suites(const struct kunit_suite_set *suite_set,
 		    const char *filter_glob,
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f95d2093a0aa..31a5a992e646 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -17,6 +17,7 @@
 #include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 
 #include "debugfs.h"
 #include "device-impl.h"
@@ -801,12 +802,19 @@ static void kunit_module_exit(struct module *mod)
 	};
 	const char *action = kunit_action();
 
+	/*
+	 * Check if the start address is a valid virtual address to detect
+	 * if the module load sequence has failed and the suite set has not
+	 * been initialized and filtered.
+	 */
+	if (!suite_set.start || !virt_addr_valid(suite_set.start))
+		return;
+
 	if (!action)
 		__kunit_test_suites_exit(mod->kunit_suites,
 					 mod->num_kunit_suites);
 
-	if (suite_set.start)
-		kunit_free_suite_set(suite_set);
+	kunit_free_suite_set(suite_set);
 }
 
 static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
@@ -816,12 +824,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_LIVE:
+		kunit_module_init(mod);
 		break;
 	case MODULE_STATE_GOING:
 		kunit_module_exit(mod);
 		break;
 	case MODULE_STATE_COMING:
-		kunit_module_init(mod);
 		break;
 	case MODULE_STATE_UNFORMED:
 		break;

base-commit: 539e582a375dedee95a4fa9ca3f37cdb25c441ec
-- 
2.43.0


