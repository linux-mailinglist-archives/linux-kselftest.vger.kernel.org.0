Return-Path: <linux-kselftest+bounces-12725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9B4916FD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8FB1F23A6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9750417D37D;
	Tue, 25 Jun 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTmsSt1L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02917D36C;
	Tue, 25 Jun 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338750; cv=none; b=OEq+Q8O8/1imXzalYuwviBpkA4OmIzJ7XDl6hfCilPCePWZqyauREBLgt0zqd6RbmPF+rvJEGUCcGPIwhdyzl9+5cFmR++ODIacN3oVfCK5TGstJ372u7NZ47EaRNioLCptXlrFvTeo34LOTejVX9IPQf4AgwGatSKpB0izZ/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338750; c=relaxed/simple;
	bh=8dhvoCKICij/0wQGSNgn0SXQ/QZt5ONQbTkFqj9oMd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rmwu+WwbraASvy7MIx4ONVSJ4kgLYK6C6/aumLMEUbxgvFrPzhkm5Jefu6GPbtCqvIzUnwAY83t31tP947JNqNXErp7Gf5jbRxU+WZwKIfmdOE35Ga3CE2MyjON4OQ15qyb5vilASgvajQfYtWu1GhgEs4oA7L18jaxwJzAUm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTmsSt1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE08C4AF13;
	Tue, 25 Jun 2024 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719338749;
	bh=8dhvoCKICij/0wQGSNgn0SXQ/QZt5ONQbTkFqj9oMd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTmsSt1LplYj2gx75lsu0LsLjYr7zpzivWHZeftrLD0ikOQkOY2ldifr5MyonkG9z
	 Uf45WeUIRwFWXiAVVEGIFR5veoTR16qDvL/6I/kdKd4CfTN0aME3VwZCxrqR6zHfAG
	 /1Od2Xe0EHh3kzxZQlBtkIS4/0YW6VU6XoVvZDZLayp0Zhz1s17+PQxhTTMesi+EQp
	 0W+jIkvNvTobeeMDy23Lq3WZTQnlWOzECqfODDegNv6ji7a+UqEYbzXiGjtwro6t/1
	 O9AD4ZwQUmrF7MsdNc9208Tb6RHx8CjZuV/eFPf8lacpyPrKP1TWqkO2NyEv5YTbdq
	 1WUgDBxyxdcSA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] selftests/damon/damon_nr_regions: test online-tuned max_nr_regions
Date: Tue, 25 Jun 2024 11:05:38 -0700
Message-Id: <20240625180538.73134-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625180538.73134-1-sj@kernel.org>
References: <20240625180538.73134-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User could update max_nr_regions parameter while DAMON is running to a
value that smaller than the current number of regions that DAMON is
seeing.  Such update could be done for reducing the monitoring overhead.
In the case, DAMON should merge regions aggressively more than normal
situation to ensure the new limit is successfully applied.  Implement a
kselftest to ensure that.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../selftests/damon/damon_nr_regions.py       | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/damon/damon_nr_regions.py b/tools/testing/selftests/damon/damon_nr_regions.py
index dd2735923c59..2e8a74aff543 100644
--- a/tools/testing/selftests/damon/damon_nr_regions.py
+++ b/tools/testing/selftests/damon/damon_nr_regions.py
@@ -81,5 +81,65 @@ def main():
     # test max_nr_regions smaller than real nr regions
     test_nr_regions(15, 3, 10)
 
+    # test online-tuned max_nr_regions that smaller than real nr regions
+    sz_region = 10 * 1024 * 1024
+    proc = subprocess.Popen(['./access_memory_even', '14', '%d' % sz_region])
+
+    # stat every monitored regions
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                monitoring_attrs=_damon_sysfs.DamonAttrs(
+                    min_nr_regions=10, max_nr_regions=1000),
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(action='stat',
+                    )] # schemes
+                )] # contexts
+            )]) # kdamonds
+
+    err = kdamonds.start()
+    if err is not None:
+        proc.terminate()
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    # wait until the real regions are found
+    time.sleep(3)
+
+    attrs = kdamonds.kdamonds[0].contexts[0].monitoring_attrs
+    attrs.min_nr_regions = 3
+    attrs.max_nr_regions = 7
+    err = kdamonds.kdamonds[0].commit()
+    if err is not None:
+        proc.terminate()
+        print('commit failed: %s' % err)
+        exit(1)
+    # wait for next merge operation is executed
+    time.sleep(0.3)
+
+    err = kdamonds.kdamonds[0].update_schemes_tried_regions()
+    if err is not None:
+        proc.terminate()
+        print('tried regions update failed: %s' % err)
+        exit(1)
+
+    scheme = kdamonds.kdamonds[0].contexts[0].schemes[0]
+    if scheme.tried_regions is None:
+        proc.terminate()
+        print('tried regions is not collected')
+        exit(1)
+
+    nr_tried_regions = len(scheme.tried_regions)
+    if nr_tried_regions <= 0:
+        proc.terminate()
+        print('tried regions is not created')
+        exit(1)
+    proc.terminate()
+
+    if nr_tried_regions > 7:
+        print('fail online-tuned max_nr_regions: %d > 7' % nr_tried_regions)
+        exit(1)
+    print('pass online-tuned max_nr_regions')
+
 if __name__ == '__main__':
     main()
-- 
2.39.2


