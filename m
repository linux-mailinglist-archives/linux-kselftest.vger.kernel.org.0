Return-Path: <linux-kselftest+bounces-994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ABF8018B2
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 01:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EDF1C21002
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE319A;
	Sat,  2 Dec 2023 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftiBRtoD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B82196;
	Sat,  2 Dec 2023 00:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2B1C433C8;
	Sat,  2 Dec 2023 00:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701475690;
	bh=GC7hLao6eamt5j9k8hcen8vPzgOkrgeme7Xf5lpgbH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftiBRtoD5yl3wEraHqbN9wNqd+G6GNBLIgbbxpKOrAHe8oFCL7SBEpqsjBQ3FBZjl
	 kJ0M6ueGJRGdyNixjGCs/yCwrSiN7nBkW5cf+rEdlaQjsoqvMrJtS6mUTqdMYIUrWG
	 duoCJbg0mJe1uhfD2luVEvn0EEQBvfItemXsQ8n24Xxtl1H/RsVHr3Kj0QU4Wz+mUM
	 9zSYm9L2V6rsZyDO5M2QQmhJldTJuxZGroKBuSpCk5DHoBxirlz8Csr0eOaiPeLFmM
	 MHlCMPu6dHhXS7RgkofjSyJaxpu2deByYIQbzJC6XJolAfJ8xa8JM9pIzZOPL0nDHA
	 LsMkoitTUar3g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] selftests/damon: add a DAMON interface wrapper python module
Date: Sat,  2 Dec 2023 00:08:02 +0000
Message-Id: <20231202000806.46210-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202000806.46210-1-sj@kernel.org>
References: <20231202000806.46210-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface supports almost every DAMON functionality.  For
that, it provides a number of files and hierarchies that not simple to
be manually manipulated, or writing shell script every time.  For the
reason, DAMON is not having good functionality selftests.  Adding an
existing DAMON user space tool and using it could also be a way, but it
would add unnecessarily huge change that not essential for the test
purpose.  Write a minimum python module that can further extended to be
used as an easy-to-use DAMON functionality test purpose DAMON user
interface wrapper.

Note that this commit is implementing only basic data structures for
representing the sysfs files.  More operations will be implemented by
following commits, as needed for specific real test cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon.py | 102 ++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/damon/_damon.py

diff --git a/tools/testing/selftests/damon/_damon.py b/tools/testing/selftests/damon/_damon.py
new file mode 100644
index 000000000000..78101846ab66
--- /dev/null
+++ b/tools/testing/selftests/damon/_damon.py
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0
+
+class DamosAccessPattern:
+    size = None
+    nr_accesses = None
+    age = None
+    scheme = None
+
+    def __init__(self, size=None, nr_accesses=None, age=None):
+        self.size = size
+        self.nr_accesses = nr_accesses
+        self.age = age
+
+        if self.size == None:
+            self.size = [0, 2**64 - 1]
+        if self.nr_accesses == None:
+            self.nr_accesses = [0, 2**64 - 1]
+        if self.age == None:
+            self.age = [0, 2**64 - 1]
+
+class Damos:
+    action = None
+    access_pattern = None
+    # todo: Support quotas, watermarks, stats, tried_regions
+    idx = None
+    context = None
+
+    def __init__(self, action='stat', access_pattern=DamosAccessPattern()):
+        self.action = action
+        self.access_pattern = access_pattern
+        self.access_pattern.scheme = self
+
+class DamonTarget:
+    pid = None
+    # todo: Support target regions if test is made
+    idx = None
+    context = None
+
+    def __init__(self, pid):
+        self.pid = pid
+
+class DamonAttrs:
+    sample_us = None
+    aggr_us = None
+    update_us = None
+    min_nr_regions = None
+    max_nr_regions = None
+    context = None
+
+    def __init__(self, sample_us=5000, aggr_us=100000, update_us=1000000,
+            min_nr_regions=10, max_nr_regions=1000):
+        self.sample_us = sample_us
+        self.aggr_us = aggr_us
+        self.update_us = update_us
+        self.min_nr_regions = min_nr_regions
+        self.max_nr_regions = max_nr_regions
+
+class DamonCtx:
+    ops = None
+    monitoring_attrs = None
+    targets = None
+    schemes = None
+    kdamond = None
+    idx = None
+
+    def __init__(self, ops='paddr', monitoring_attrs=DamonAttrs(), targets=[],
+            schemes=[]):
+        self.ops = ops
+        self.monitoring_attrs = monitoring_attrs
+        self.monitoring_attrs.context = self
+
+        self.targets = targets
+        for idx, target in enumerate(self.targets):
+            target.idx = idx
+            target.context = self
+
+        self.schemes = schemes
+        for idx, scheme in enumerate(self.schemes):
+            scheme.idx = idx
+            scheme.context = self
+
+class Kdamond:
+    state = None
+    pid = None
+    contexts = None
+    idx = None      # index of this kdamond between siblings
+    kdamonds = None # parent
+
+    def __init__(self, contexts=[]):
+        self.contexts = contexts
+        for idx, context in enumerate(self.contexts):
+            context.idx = idx
+            context.kdamond = self
+
+class Kdamonds:
+    kdamonds = []
+
+    def __init__(self, kdamonds=[]):
+        self.kdamonds = kdamonds
+        for idx, kdamond in enumerate(self.kdamonds):
+            kdamond.idx = idx
+            kdamond.kdamonds = self
-- 
2.34.1


