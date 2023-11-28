Return-Path: <linux-kselftest+bounces-702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BFA7FB6F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 11:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECE1282A9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B619B4D5B9;
	Tue, 28 Nov 2023 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmtrnMny"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C7FE1
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 02:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701166599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2mlv9LGhIVFVkJH7cobh6u5ej8q8EOjabrk7WGvxaI4=;
	b=NmtrnMnyVTwjfirAxJmEm768LC6Ur4ZHRXoyGNS4urgu+5KNNcMF+NPPZrrM0MFDpjwTAw
	GaObJ83/Edmde2mFFOi2YgIrPYcbT7PNotHCqHvDBjq0auMqH8iXC8iFTs8pKPgZbECP2v
	XXbMkcjDNb5R7GWSVbhTOKyjq+zssF0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-6MLmy9f7P2yZL9aaJj-GTg-1; Tue, 28 Nov 2023 05:16:38 -0500
X-MC-Unique: 6MLmy9f7P2yZL9aaJj-GTg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4083717431eso30639745e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 02:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166597; x=1701771397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mlv9LGhIVFVkJH7cobh6u5ej8q8EOjabrk7WGvxaI4=;
        b=ccFV54wWBw79uIZm+40LTv6k4/9hgUCKSmtNCjWosHcZZIjdJIJ4m4F+SjS3dBAl+k
         Kv+29aTKNYiVsyxbVfHEo4U6nAcvE3NBvmwf6Srx/dsWWcz9ST+IEaI5GT+YNEFMWf3l
         MU7VrghRoiuzKMOjsjKGaE1tcmrTqad8+32Z5YJ6F/Zm/GUcmQO6JFuNzA8TOumiGd6t
         /QMO91PFRbjQsTtFRpBO/hP6DMPIC8KQMl9mZXmsy8YahioHNI9Sfi/1TOQ+YOYog/Jt
         lBROdITMQzTj+FzYl1T9tEuTfMHZDo5+KoKjT+M1k1im2+Y7p1CQB/OWEGPV06OMYm1P
         8X2Q==
X-Gm-Message-State: AOJu0YxECFdnvvS72ewh3Duje8wkoNlnilQ7e/F7A77a4ivW7u03mjje
	YnpZLGUSEJKTn4vrOFnhEhf/Wpnbpg2O5nHuBx/8Ix8LVNLI4MZABSRZxFVfmdWSJMdrYTARscw
	hgwZKfjJVDW6I2K9lv5g94+olfPPQEJIY2P8=
X-Received: by 2002:a05:600c:3550:b0:40b:415e:c044 with SMTP id i16-20020a05600c355000b0040b415ec044mr7207116wmq.37.1701166597194;
        Tue, 28 Nov 2023 02:16:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEILSD8tbDrDa+Fc2ASqSInMsptxAUayy6eFXUNFydDRl5MiOIb/oAt4B2WgrYpNGeoBPQZlA==
X-Received: by 2002:a05:600c:3550:b0:40b:415e:c044 with SMTP id i16-20020a05600c355000b0040b415ec044mr7207105wmq.37.1701166596883;
        Tue, 28 Nov 2023 02:16:36 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c220f00b003fe1fe56202sm16584252wml.33.2023.11.28.02.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:16:36 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kunit: run test suites only after module initialization completes
Date: Tue, 28 Nov 2023 11:16:27 +0100
Message-ID: <20231128101627.65399-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.42.0
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

v2:
- add include <linux/mm.h>

Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 lib/kunit/test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f2eb71f1a66c..0e829b9f8ce5 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -16,6 +16,7 @@
 #include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 
 #include "debugfs.h"
 #include "hooks-impl.h"
@@ -737,12 +738,14 @@ static void kunit_module_exit(struct module *mod)
 	};
 	const char *action = kunit_action();
 
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
@@ -752,12 +755,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
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

base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
-- 
2.42.0


