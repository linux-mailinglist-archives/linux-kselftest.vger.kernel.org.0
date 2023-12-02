Return-Path: <linux-kselftest+bounces-996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2738018B3
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 01:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE266282154
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575F64A;
	Sat,  2 Dec 2023 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXPiW5Mb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794A7E3;
	Sat,  2 Dec 2023 00:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E4BC433CC;
	Sat,  2 Dec 2023 00:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701475692;
	bh=dA3cXZTPwGuBFjfk7vBFspKqwxyw85dB6htp3+62oIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXPiW5MbtvQcnrRYD9LYG6mn7RPYtIY3MPhQVnAIMhOAdgc6mI0apmxk5JCelCtZv
	 6Ef9xyeOkzma+9AS+KiXQD8I/La8iDXltv9baKzkgE40yj4y6v44bDlF1mayazsOI3
	 SZFeTh4Tmcj02tZnymikNK28FWnUE/o8TbsvA9jgSaCvsqcaXZZVQW4sGpyxYe9loS
	 65NI2gsSjyWNLTNdcdhF48SDc0MkwKk/ahnphuUPocqrvxadSAe2Ob54OKR3XrkyhS
	 WA+RUPrD1WxoIt4tCTJQpKbfR3p09U/4BYqfCsjWEzLdX8FSzD8WCxE124eZnpBkaY
	 E1BPJj/Hl8xpA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] selftests/damon/_damon: implement sysfs updat_schemes_tried_bytes command
Date: Sat,  2 Dec 2023 00:08:04 +0000
Message-Id: <20231202000806.46210-4-sj@kernel.org>
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

Implement update_schemes_tried_bytes command in the test-writing-purpose
DAMON sysfs interface wrapper Python module.  It is not only making the
update, but also read the updated value from the sysfs interface and
store on the Kdamond python objects so that user of the module can get
it by reading the field of the object.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon.py b/tools/testing/selftests/damon/_damon.py
index 6b99f87a5f1e..e98cf4b6a4b7 100644
--- a/tools/testing/selftests/damon/_damon.py
+++ b/tools/testing/selftests/damon/_damon.py
@@ -76,6 +76,7 @@ class Damos:
     # todo: Support quotas, watermarks, stats, tried_regions
     idx = None
     context = None
+    tried_bytes = None
 
     def __init__(self, action='stat', access_pattern=DamosAccessPattern()):
         self.action = action
@@ -284,6 +285,19 @@ class Kdamond:
         err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'on')
         return err
 
+    def update_schemes_tried_bytes(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'state'),
+                'update_schemes_tried_bytes')
+        if err != None:
+            return err
+        for context in self.contexts:
+            for scheme in context.schemes:
+                content, err = read_file(os.path.join(scheme.sysfs_dir(),
+                    'tried_regions', 'total_bytes'))
+                if err != None:
+                    return err
+                scheme.tried_bytes = int(content)
+
 class Kdamonds:
     kdamonds = []
 
-- 
2.34.1


