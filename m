Return-Path: <linux-kselftest+bounces-3709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8EE8415ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 23:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF291C23416
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58454276;
	Mon, 29 Jan 2024 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYLSlJDo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576751C3B;
	Mon, 29 Jan 2024 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568349; cv=none; b=YVCPCODn4QrUeEsa/xIieiZ+S+sMxAu63r/vInZIF8+BoimBSq0kuNiIbw0NKF2K8Q6QfrIgdslLMUlZvwOQdW9eo87ZTzyrH885WA13HRZqs+brZaBhIInpS1NEOzgssKP/xfxWOk2iNvsCOdKs8PxRVHGrog/GPM/YC9UM3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568349; c=relaxed/simple;
	bh=Y5QmW3rtP/uUq0/9W3YpsAMR2J1KrHWGIXa9+1PEYak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IazbBXitPJaunmz7J0MnKdKWUxmL0gDrVXDC1YAf5htv73iwv71NVt54ruLQ4Res2/xw7fxTnGbCbbkveUgTcKf1rFDQ9WK5EF1lyaiQqnIDjVl96YjXPmgAuQp2jiRm7piX+sqcoP235B67tYx4hOA3X+aVzWN4HsyGCeQn+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYLSlJDo; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783d84ecb13so328916085a.0;
        Mon, 29 Jan 2024 14:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706568345; x=1707173145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xef0hVDdHdF2jNfb1sbGTppVQNq89HdiJsXx3j0Z+RA=;
        b=MYLSlJDouqXOQJZaJTWyIzUrHYLtz/mLrII8tiA0U0lH3Gf9YYXjhl3uCDV7R1J7X/
         LOTyvM8QVSLJU6538gQ+fdp8xefEZRHSkyR/28CK4Mu++mR+SjZWTMCP9lG2+7wj44Nw
         HRxZFfrNCSaLpErAEpg2vLEHGZ7r/UDAyfvAZts5IwDx5jjeuZn73JCB8HEUnL5Y+h5S
         cVhVHm7g65pf+a3JJxNEOIcryF4DoQqTP65f5cFiJkCgqhL122aIUqu1LsL41sf+9Pb5
         jTMIhJg6bsrC98Q2pZR/vjS3BWp5k72QYe8gHZEqFLPf02j+XuSXY8c9DHrN7IXOeP+B
         3NQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568345; x=1707173145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xef0hVDdHdF2jNfb1sbGTppVQNq89HdiJsXx3j0Z+RA=;
        b=a3OW2r9HEa5eupfot1QFD7836cCWdIoF81sL4CsyEEbsYKklhSq+bmstFIeVOkj/gu
         +Yy+aTUe6HP6i6k+0XHIH7VIx/V+nrni0qD48eviwRQAsvt37psheZ+FNUkRMsW26AQF
         Lpwm85cNl3DUO/IDwKQGV4s59lfUlIUxHw2i4HPhC6iIBhMvBNBWwnNpP1ZDcTzOaIqo
         e1JclKBk26FAzxLuDc1E3fcpbcHBe4swDdZbIQfeUtnI7BPfFkfIq06GgvRZyGiCvJWQ
         Q8aDEV35iylYjEE9B7VkE1XaD8peQ5vzovF/Orr9bBwz6Ylofds5Qzw2Sk0gXARTzxPq
         g0IA==
X-Gm-Message-State: AOJu0YzNTDURTw+nadBLTHfUNb1q1EGOSH2i8pxbO8scSEWYscnD3Kfr
	ShFGbomwbG29tJI5F822+NLMY28VrFLQN/BjBYyDAB+AO7EU/KNk
X-Google-Smtp-Source: AGHT+IFA4GtOI5DVLY0CR9h66W+OqJ3ySRkcMjVMpPQ4jAh32cn+UJ5P037C4f1Ww4qSMDoHjtOsIA==
X-Received: by 2002:a05:620a:4485:b0:783:f862:88a7 with SMTP id x5-20020a05620a448500b00783f86288a7mr4466928qkp.10.1706568345431;
        Mon, 29 Jan 2024 14:45:45 -0800 (PST)
Received: from localhost (fwdproxy-nao-013.fbsv.net. [2a03:2880:23ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id p15-20020ae9f30f000000b00783f606dcf8sm1926576qkg.73.2024.01.29.14.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:45:45 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests: add test for zswapin
Date: Mon, 29 Jan 2024 14:45:42 -0800
Message-Id: <20240129224542.162599-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129224542.162599-1-nphamcs@gmail.com>
References: <20240129224542.162599-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently encountered a kernel crash on the zswapin path in our
internal kernel, which went undetected because of a lack of test
coverage for this path. Add a selftest to cover this code path,
allocating more memories than the cgroup limit to trigger
swapout/zswapout, then reading the pages back in memories several times.

Also add a variant of this test that runs with zswap disabled, to verify
swapin correctness as well.

Suggested-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 67 ++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 32ce975b21d1..86231c86dc89 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -60,17 +60,39 @@ static long get_zswpout(const char *cgroup)
 	return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
 }
 
-static int allocate_bytes(const char *cgroup, void *arg)
+static int allocate_bytes_and_read(const char *cgroup, void *arg, bool read)
 {
 	size_t size = (size_t)arg;
 	char *mem = (char *)malloc(size);
+	int ret = 0;
 
 	if (!mem)
 		return -1;
 	for (int i = 0; i < size; i += 4095)
 		mem[i] = 'a';
+
+	if (read) {
+		/* cycle through the allocated memory to (z)swap in and out pages */
+		for (int t = 0; t < 5; t++) {
+			for (int i = 0; i < size; i += 4095) {
+				if (mem[i] != 'a')
+					ret = -1;
+			}
+		}
+	}
+
 	free(mem);
-	return 0;
+	return ret;
+}
+
+static int allocate_bytes(const char *cgroup, void *arg)
+{
+	return allocate_bytes_and_read(cgroup, arg, false);
+}
+
+static int read_bytes(const char *cgroup, void *arg)
+{
+	return allocate_bytes_and_read(cgroup, arg, true);
 }
 
 static char *setup_test_group_1M(const char *root, const char *name)
@@ -133,6 +155,45 @@ static int test_zswap_usage(const char *root)
 	return ret;
 }
 
+/* Simple test to verify the (z)swapin code paths */
+static int test_zswapin_size(const char *root, char *zswap_size)
+{
+	int ret = KSFT_FAIL;
+	char *test_group;
+
+	/* Set up */
+	test_group = cg_name(root, "zswapin_test");
+	if (!test_group)
+		goto out;
+	if (cg_create(test_group))
+		goto out;
+	if (cg_write(test_group, "memory.max", "8M"))
+		goto out;
+	if (cg_write(test_group, "memory.zswap.max", zswap_size))
+		goto out;
+
+	/* Allocate and read more than memory.max to trigger (z)swap in */
+	if (cg_run(test_group, read_bytes, (void *)MB(32)))
+		goto out;
+
+	ret = KSFT_PASS;
+
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
+static int test_swapin(const char *root)
+{
+	return test_zswapin_size(root, "0");
+}
+
+static int test_zswapin_no_limit(const char *root)
+{
+	return test_zswapin_size(root, "max");
+}
+
 /*
  * When trying to store a memcg page in zswap, if the memcg hits its memory
  * limit in zswap, writeback should affect only the zswapped pages of that
@@ -309,6 +370,8 @@ struct zswap_test {
 	const char *name;
 } tests[] = {
 	T(test_zswap_usage),
+	T(test_swapin),
+	T(test_zswapin_no_limit),
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
 };
-- 
2.39.3


