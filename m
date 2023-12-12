Return-Path: <linux-kselftest+bounces-1702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB6980F637
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499A8B20EB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD281E26;
	Tue, 12 Dec 2023 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwumpu7p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC380053;
	Tue, 12 Dec 2023 19:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48521C433C9;
	Tue, 12 Dec 2023 19:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702408336;
	bh=KLuaGh8EwddqX7r2J8YW9fbCxq8vkVUE+TA3xcNvnkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwumpu7pqmpvnDomf+Hqsnh0almVLDis4X1s3RgGsNDBz1ZNxaQgGZbkGcHD2x/om
	 J9NHY7Nzm0oEjemCVbKBPT7iOAW3johkbPXm490MuyodKOhYIuS5rsfTARZVtZU1E5
	 O0kOzVSh0a+F09ETl+b3CSjG7q+9sd3xzsgXymt5ebJVzKRQJFLuL/Kao+V7ppEse+
	 eg2aB2v3Z5oWVnQDpYZqszt1gRobfnX8MahYjx5ZdRL1mJJw+IPIoRr07D4ilPKjIV
	 Bft87B19yWmf4YZud7k7g/adUKpw/LAVDb87F0MOmJoi+ySJPPFGcHbGB5tIFddkKL
	 TRJHV+KZqehZQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] selftests/damon/_damon_sysfs: implement updat_schemes_tried_bytes command
Date: Tue, 12 Dec 2023 19:12:04 +0000
Message-Id: <20231212191206.52917-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212191206.52917-1-sj@kernel.org>
References: <20231212191206.52917-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement update_schemes_tried_bytes command of DAMON sysfs interface in
_damon_sysfs.py.  It is not only making the update, but also read the
updated value from the sysfs interface and store it in the Kdamond
python objects so that the user of the module can easily get the value.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 6b99f87a5f1e..e98cf4b6a4b7 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
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


