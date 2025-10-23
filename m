Return-Path: <linux-kselftest+bounces-43842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E2EBFED8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E2D3AA89E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD8242D97;
	Thu, 23 Oct 2025 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEC19Zx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BB19C54F;
	Thu, 23 Oct 2025 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182746; cv=none; b=OPjKmKF2gW3mi6Diz9cxUvktGZWfQLrDksQQ1e+BKAAPf7kx6mOhRkAHQikBQPPGGZhHnvvdcuxLa+Nq8SNYGgvkZTEfsduEo+a8KaycU6xaBHDyhXle88mK0yR3KgfxCC/NiJQGcVyJ2Yt2y3vV1SHWozIDANf/BHqIPAb5dfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182746; c=relaxed/simple;
	bh=mizIUChAFsqpIHY6nU9Fx3Ot5p8OeQz4ge3WLnGs1IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL0FSzaLdrgsEwSd3jC0KXOCfW+Cp7hljXF1W961BSq00CswvKSaowAaGVarYu1Svp/pptBPvmasnzZCNFSKVqtc8Tg00sC5eKzZObM9qAU7idT5LAEWQUGZh7VnvTohbO0K6yRaNrZwXjjUi/fNUEVsUrzi7P537NuBhqQSy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEC19Zx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9DEC4CEF5;
	Thu, 23 Oct 2025 01:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182746;
	bh=mizIUChAFsqpIHY6nU9Fx3Ot5p8OeQz4ge3WLnGs1IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEC19Zx5pg5krCxzuGcALpzBIgJ6qxXP6/2C8Uf6glMamZ7D9BRYKj115ySio1fuf
	 L5wRsksk56d3RlbZEr/CGXziGLKEIglLy1r8XJz7BPIog3T9em2X7ycXDpkxA75XcX
	 TuG1/kuGVN1WH6pJZHLeRAMwoa5mMed1mKlhtRW1c67mhQXzS6Wyslzg7phVLJtTpa
	 FgVPQOwv8MTGvJYESIoeMPgl4vgVkE668l/Kptr7SZlfRsqGFhVA1yKwZLhRTO9wli
	 HDkQvHDkgF67ccEGcxs/hDFYlGZ9qbeAsYTDc9m+pxhLsG9msCwHGOlgGaXVNpQKJ4
	 E8BTvG3MYgalw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 9/9] selftests/damon/sysfs: add obsolete_target test
Date: Wed, 22 Oct 2025 18:25:33 -0700
Message-ID: <20251023012535.69625-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023012535.69625-1-sj@kernel.org>
References: <20251023012535.69625-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new DAMON sysfs file for pin-point target removal, namely
obsolete_target, has been added.  Add a test for the functionality.  It
starts DAMON with three monitoring target processes, mark one in the
middle as obsolete, commit it, and confirm the internal DAMON status is
updated to remove the target in the middle.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index fd8d3698326e..b34aea0a6775 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -279,5 +279,42 @@ def main():
 
     kdamonds.stop()
 
+    # test obsolete_target.
+    proc1 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
+                             stderr=subprocess.PIPE)
+    proc2 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
+                             stderr=subprocess.PIPE)
+    proc3 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
+                             stderr=subprocess.PIPE)
+    kdamonds = _damon_sysfs.Kdamonds(
+            [_damon_sysfs.Kdamond(
+                contexts=[_damon_sysfs.DamonCtx(
+                    ops='vaddr',
+                    targets=[
+                        _damon_sysfs.DamonTarget(pid=proc1.pid),
+                        _damon_sysfs.DamonTarget(pid=proc2.pid),
+                        _damon_sysfs.DamonTarget(pid=proc3.pid),
+                        ],
+                    schemes=[_damon_sysfs.Damos()],
+                    )])])
+    err = kdamonds.start()
+    if err is not None:
+        print('kdamond start failed: %s' % err)
+        exit(1)
+    kdamonds.kdamonds[0].contexts[0].targets[1].obsolete = True
+    kdamonds.kdamonds[0].commit()
+
+    status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
+        kdamonds.stop()
+        exit(1)
+
+    del kdamonds.kdamonds[0].contexts[0].targets[1]
+
+    assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
+
+    kdamonds.stop()
+
 if __name__ == '__main__':
     main()
-- 
2.47.3

