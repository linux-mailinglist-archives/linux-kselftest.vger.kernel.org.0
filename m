Return-Path: <linux-kselftest+bounces-1292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDCF80735D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 16:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CC3B209A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3EF3F8FE;
	Wed,  6 Dec 2023 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwmK8f6M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C54D5E
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 07:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701875265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/JBJQVO5XBoc9lUdPYm1Dkdtmlp9iMHA1ds5P3k5wtk=;
	b=ZwmK8f6MG3e+pj60gXhnHee/Q+gIVkbIgcsi3KvU2w3WBZudRtDfiDawaCdM3TMv4bUrsm
	Am/7K+i+pnml0NTU1MHlZWoj1w776fmTHrbOjHc3YOJBnRUb4FO/zyYZPqtZzkiJXeke2d
	4tTyE4j3qponnpk+9ABzNu9HVXJHi3U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-AlBOJGdcP-mJHxUmNtr5YQ-1; Wed, 06 Dec 2023 10:07:40 -0500
X-MC-Unique: AlBOJGdcP-mJHxUmNtr5YQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33347dc610dso792258f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 07:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875258; x=1702480058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JBJQVO5XBoc9lUdPYm1Dkdtmlp9iMHA1ds5P3k5wtk=;
        b=VAgr/pZeK7SOeSHdUJoPwB9BZuS34dhemUfuDXBAgZclMYVcwZDpnqhK2klpWIm41Z
         8mwtRt4EDlyVyIbWD7+S3SuF/wxBxEz1LvXxaa+vuBLCgQYVMwklF06GXz/7A2QOsHKh
         qEIxJB3EiWTKXXaWfaZ7NfYL1BWel2RdGfm4ZWe0K0cYz0WRFyzHptUaahchmr9r2naC
         M4N61QKBukpOEoyhRmZc8j6CwMf4gsCf+tTJGaqzdY9k9BjkEaPLR8d0hvVWs3iLReXF
         pWqZc9UsaqRKzHGIw3/eo34z1RgBivjtzRYsxViEp8sdMX94i/SBMRH+VbytlVxyuCpP
         0rqQ==
X-Gm-Message-State: AOJu0YzqjDyLTePAuZXhSCwKSSP8KBGt1N6/MWSA8biRfydbHwV4vaAd
	7ZdkgrjVw3UDuTgy7S7Y82FVahJ+M4Hvd0SPCWbkJe38+qIaYIqCPPWSg3PHRulyYtZBlYBEVKp
	RQExl0SUbgh+CWuurYBD6aOFKbJc=
X-Received: by 2002:a5d:4009:0:b0:333:5258:68ef with SMTP id n9-20020a5d4009000000b00333525868efmr692838wrp.68.1701875258351;
        Wed, 06 Dec 2023 07:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLa1/yFQDJ3QsgPuJIOsVfygTgkEWMxKZQhHwYBT6FHhXNXPic4hIBJCiXWvnVGxjbXDr5Dw==
X-Received: by 2002:a5d:4009:0:b0:333:5258:68ef with SMTP id n9-20020a5d4009000000b00333525868efmr692834wrp.68.1701875257975;
        Wed, 06 Dec 2023 07:07:37 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-38.cust.vodafonedsl.it. [2.34.30.38])
        by smtp.gmail.com with ESMTPSA id c1-20020adfa301000000b003333a216682sm11896497wrb.97.2023.12.06.07.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:37 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Rae Moar <rmoar@google.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] kunit: run test suites only after module initialization completes
Date: Wed,  6 Dec 2023 16:07:28 +0100
Message-ID: <20231206150729.54604-1-marpagan@redhat.com>
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

v3:
- add a comment to clarify why the start address is checked
v2:
- add include <linux/mm.h>

Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 lib/kunit/test.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 7aceb07a1af9..3263e0d5e0f6 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -16,6 +16,7 @@
 #include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 
 #include "debugfs.h"
 #include "hooks-impl.h"
@@ -775,12 +776,19 @@ static void kunit_module_exit(struct module *mod)
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
@@ -790,12 +798,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
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

base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
-- 
2.43.0


