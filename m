Return-Path: <linux-kselftest+bounces-3918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8740A844FAF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 04:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0591C24F1B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 03:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A73C08E;
	Thu,  1 Feb 2024 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsMZfNxn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57E3B18C;
	Thu,  1 Feb 2024 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758046; cv=none; b=gM5PnzqvZTmik7dnJ8nUFSoW/uEY8I6PWlbdtOSVfQa4dQSNW9WTHlms3zoDFLZzxrOkKGapVan41y4G+7qzHP0NnrKng3/NIDDUCuR5cY1KAgMMsTMjsFLyDVdEehuKte+A1wqip9OLBorOFHpKb8ywxaMRZhB+O11scjWRcbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758046; c=relaxed/simple;
	bh=SleVqChczJMQNB2boi8n5e6NvqX3ckStjnVVeEsnqB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWNtqRi6JZosdlRfpOBqFrFI0YlkyJ0jvb8BTcyh2xJaO1CGyYOk5Ru2KXE+ktOjhtpjDwSI+l17z7E3+hHtEIjGPCo9gAn/QYyp1BtROm5CaAu7JADE03G1k/WaKWzUF5Fye88JB+ajnshf5PNFf1+IhlgKAU3J4NTuDuOseZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsMZfNxn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783d4b3a00bso35896185a.3;
        Wed, 31 Jan 2024 19:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706758041; x=1707362841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTqBj0H08VxjpoFeh5ezYndc7+HSVccdU5yqVd6FGXw=;
        b=lsMZfNxnU3DyZ0qa+sQcgHVt65mxjGI0htzzqP9s7p7UaYHh/7T17kOK39Mi+soR57
         NVOJ8FzS39P6rTlAS8z4lcIrI9THUbogVFIg9K0ENjZSc4xMR8Nb5ijx+R0GjS5kYxMb
         DMPbWtbE4yk3XQGtNC5koYhuUIuWUrrBzU2Plqf1l7HP0LrzjKe7w4v62Tegk9RToZLT
         NjjFxPgYliGwYU63Jzt8KXSzfATm6QnJXYgz/8i4mKbFUt0i4mLJqBqhJ/IBzrD8vUl8
         /Q9fOkVguGWyUmWLehPeq/HTgmVv4lasKxcgMWOsPiDvALuwdF6bqMuiLkemLU4enmyy
         YbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706758041; x=1707362841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTqBj0H08VxjpoFeh5ezYndc7+HSVccdU5yqVd6FGXw=;
        b=evQLl67v42pF1HCHuf2WrB7Gt1e2r1JTQsfRgfOHoAsIMygcVhpu9HbKRskLIaArh7
         NA5IRr8ETPqupcQsWhM/vT9YZuqA16cidSC5g4ftBZcq+Fkf/iqJmW3SQa+kPEaqaufG
         s6RSKJA/PMqCQ1GobfXGZotbuOzg4lsAjbLMJ5XraKAwpL1lToFKb8tC1HME24ciCVQT
         RK5aK35U43lkFVPxRtZpr+uK1UFkjQW8YIFa2DKJaAE4xONcMbTPfhZ0eV/kExfa3u0f
         /f6dmvmb1MbTx2HlPJ53tUFsUPNLt3LRqQ/DqRGO2ZBfVUVWZyNst/PFPJpFfOPc5FB1
         ktBg==
X-Gm-Message-State: AOJu0YzgsuOv3hmmVnAZnTT6KymNgGWfebzzB548eQPpjBQh8UKZPm1z
	l1991ift+CA+ef5RrIXFv+OlqGF/7a7xV4pKrv7mqeSnfjb6W+BN
X-Google-Smtp-Source: AGHT+IHPWXSjkdUZuigp/9B7j6ivfpKy5HxAUMa6O9hLIMzhBIt/uWnFjXMQetpqhcvAu9PSMKwhVQ==
X-Received: by 2002:a05:620a:4148:b0:785:46f0:615b with SMTP id k8-20020a05620a414800b0078546f0615bmr358625qko.2.1706758041672;
        Wed, 31 Jan 2024 19:27:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUIv71tJwO29OMitKPFnpPOCXCL8BuVktI6doG1tJVc7/qR+y0O1AXR3wBOmsC4Qpffj7sUQ/KvOHDJ3cjhityaWK8c6DQta2mok58PQKzyNMRYi0NBxE+fudr705gyldiLvtVDxeVD4Y/YBHb0b/QTNJBIXuB6UgcZyUeKMza5ekf49cqVqrwZ+yFdNzpD4eR3WySWDx0k6eHPjVEjtMAYQMMFpHdujzSNJ24YQgSlib3EdrjukJE9XYj5tQUTBP7eM86wjlW/Eo9XAjgXgVqReu2zzRc0V4aBxOGW8RQSM8/9+pDlticWA+KTxQANd6ZrLRySCqgVqZR+0qhBBavYdTkV8LgIibWRilyUHyT/2lAZKZI/
Received: from localhost (fwdproxy-nao-009.fbsv.net. [2a03:2880:23ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id v18-20020ae9e312000000b0078535190648sm1450417qkf.67.2024.01.31.19.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:27:21 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: riel@surriel.com,
	shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/3] selftests: add zswapin and no zswap tests
Date: Wed, 31 Jan 2024 19:27:18 -0800
Message-Id: <20240201032718.1968208-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240201032718.1968208-1-nphamcs@gmail.com>
References: <20240201032718.1968208-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to cover the zswapin code path, allocating more memory
than the cgroup limit to trigger swapout/zswapout, then reading the
pages back in memory several times. This is inspired by a recently
encountered kernel crash on the zswapin path in our internal kernel,
which went undetected because of a lack of test coverage for this path.

Add a selftest to verify that when memory.zswap.max = 0, no pages can go
to the zswap pool for the cgroup.

Suggested-by: Rik van Riel <riel@surriel.com>
Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 97 +++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 32ce975b21d1..14d1f18f1098 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -60,6 +60,27 @@ static long get_zswpout(const char *cgroup)
 	return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
 }
 
+static int allocate_bytes_and_read(const char *cgroup, void *arg)
+{
+	size_t size = (size_t)arg;
+	char *mem = (char *)malloc(size);
+	int ret = 0;
+
+	if (!mem)
+		return -1;
+	for (int i = 0; i < size; i += 4095)
+		mem[i] = 'a';
+
+	/* go through the allocated memory to (z)swap in and out pages */
+	for (int i = 0; i < size; i += 4095) {
+		if (mem[i] != 'a')
+			ret = -1;
+	}
+
+	free(mem);
+	return ret;
+}
+
 static int allocate_bytes(const char *cgroup, void *arg)
 {
 	size_t size = (size_t)arg;
@@ -133,6 +154,80 @@ static int test_zswap_usage(const char *root)
 	return ret;
 }
 
+/*
+ * Check that when memory.zswap.max = 0, no pages can go to the zswap pool for
+ * the cgroup.
+ */
+static int test_swapin_nozswap(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *test_group;
+	long zswpout;
+
+	/* Set up */
+	test_group = cg_name(root, "no_zswap_test");
+
+	if (!test_group)
+		goto out;
+	if (cg_create(test_group))
+		goto out;
+	if (cg_write(test_group, "memory.max", "8M"))
+		goto out;
+	/* Disable zswap */
+	if (cg_write(test_group, "memory.zswap.max", "0"))
+		goto out;
+
+	/* Allocate and read more than memory.max to trigger swapin */
+	if (cg_run(test_group, allocate_bytes_and_read, (void *)MB(32)))
+		goto out;
+
+	/* Verify that no zswap happened */
+	zswpout = get_zswpout(test_group);
+	if (zswpout < 0) {
+		ksft_print_msg("Failed to get zswpout\n");
+		goto out;
+	} else if (zswpout > 0) {
+		ksft_print_msg(
+			"Pages should not go to zswap when memory.zswap.max = 0\n");
+		goto out;
+	}
+	ret = KSFT_PASS;
+
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
+/* Simple test to verify the (z)swapin code paths */
+static int test_zswapin_no_limit(const char *root)
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
+	if (cg_write(test_group, "memory.zswap.max", "max"))
+		goto out;
+
+	/* Allocate and read more than memory.max to trigger (z)swap in */
+	if (cg_run(test_group, allocate_bytes_and_read, (void *)MB(32)))
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
 /*
  * When trying to store a memcg page in zswap, if the memcg hits its memory
  * limit in zswap, writeback should affect only the zswapped pages of that
@@ -309,6 +404,8 @@ struct zswap_test {
 	const char *name;
 } tests[] = {
 	T(test_zswap_usage),
+	T(test_swapin_nozswap),
+	T(test_zswapin_no_limit),
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
 };
-- 
2.39.3

