Return-Path: <linux-kselftest+bounces-4165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8732884A99E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 23:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0041C26914
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 22:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F354A9A5;
	Mon,  5 Feb 2024 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTaCl+gl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA6482CD;
	Mon,  5 Feb 2024 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173775; cv=none; b=Qi3HCP2GlYjZ+/Qr26XqSFKiznf6a2EaZanzJqLUIljGl3KkGwWMIlNca1NyJrLqatPwN8s75bByFa5D8GscmsuBN6qmNYQVi+U62XfFKD2y4M8aPigISyArt+TPqbMcGnmk8ritaizLUZUvfbMsQNDYvcErw3FurIug1cCYXgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173775; c=relaxed/simple;
	bh=Tie7E5mz6Z/lTyy1A0uRA2fDXZNOAArdxEQCEDzT0do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BfOt7DvuMB6G5UoRzb1kSLsOKXA6W92F0Q+QD1OmAe6bcDv+XBwa9L31XjkB1uHb+GfClBb7Azt4csoobRQKZGebll0TvXtzHsK++YctGxQBS6DwFhhJTji5GZX4rNqxhKHJOnVeOOIHTSSPQ0Chkb3FmQ62mByi9ja0tsKi6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTaCl+gl; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42ab7522c75so28861251cf.0;
        Mon, 05 Feb 2024 14:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707173772; x=1707778572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HqWjgU6D10aye5QHEqX+OBFLhtZ/fQssfKAsKXBKvY=;
        b=mTaCl+glq5+P0E/uvDegW3hvaSAfJWv8eJA61HO8+76+lv9C/vbGob+qhaARnzpKPo
         Oj8YalEnBSZsEAFMtZlV3oETUmglose3w0jy+6TZ+XA1QsLuUZuZjXyoAK20mmi87Ek4
         o+fnaWLeTNycZE7rsw3qJfw1WGIq3zFMHDK9WUAvlmqW+g+ryLMDA+d41FqRlpN7ysAM
         JDQutzmFpijK5RHfX9Hr7K7xYWnemj0YxAYcsgusRNO/nJ3nbu14Id6hsgLia9oVVYoH
         YqRPhunMB/bwNgsvTemLqWSWruDIxgQqsYuN2spp1itduEL6Aj8RGdR28RAGs0GlNGeV
         zM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173772; x=1707778572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HqWjgU6D10aye5QHEqX+OBFLhtZ/fQssfKAsKXBKvY=;
        b=p7DQ1XqgkxXOkxAdmbeVFBgR2F2x+BZFbLBQl+jOCqQWWtWQHIJZQZvFQBs72w9jBz
         2oRT9NGEbXh6MVYcGLP2D9PpIyTQpNL0Ul8L8gnSEh3P/8TMNhNYsrzCq3Wkm3QchRbG
         PqdAMYsbctyDNwmOwBwFh3bzHnpl0A+E0zHqSGn0cvMPTj72ciQ9YqVTVtojMEoP3pl4
         dH3ndwKKnMx2S30fk604xhRecsYMchTXa8EUdqjNgqkoT7tXM4cidIizJBZ3/gVt8Isu
         TLAEWMJwD6QCha+uFNxe5Mc1myw+k86sdIifGaiKlfQKcrORospimpjlL7pe5RIXFXIG
         WJLg==
X-Gm-Message-State: AOJu0Yw3R3WPK+Nou0a4t6u1AnYpapSCl0ZeCm/Fq3jrmC72D34ZktAy
	XD9EhdRrUSK/taoRtsTlRkmQHkyrXFgDY8XTF90mXGaBRMjTp3mS
X-Google-Smtp-Source: AGHT+IGCJNv8Ji8AU8IubQXBQCs37V3e6UKJOoL7efbPjiM7OFm3oBHUGScLF4gh82NdJqEYVnvINw==
X-Received: by 2002:a05:622a:48c:b0:42a:4350:64c7 with SMTP id p12-20020a05622a048c00b0042a435064c7mr856118qtx.68.1707173772351;
        Mon, 05 Feb 2024 14:56:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUqJ/8EC/uAZwZYtWAjBIdqbUeGbSxx64XcNJIk/q+Br0fd2ZnF42wZpS0SYMUietCy0wo5VDpFFrErX3imrvpZO7WUNzR0srWRl30TV27h+6vc/IS6iQWrv4/WZwlIoPcLjhVHGiLlYCHcOhLHtmU/XHgKHVHhuxMDRGoHmyQMpIEtQEnWW34EFfNe4blyDBX6rzDg4TWP0sFRajPTZJgN3taO51FviZbbDsTb2g6pQs2CZ1VtBqISF4HUt3BAYXagM3lV6duO/3YsUmZC9mGd1ykVuOVgbrKn5/IrLdfdhnCAgZS9LRo7X/PgcaV4z62Tujb6K1xdzYVGR7dc+ZgfZgASlu5mhpHQiT4/C7oRjIHVukimfyzDAXIBatf/OZoWz0Lci4ZJjl5Ne7STXbQ=
Received: from localhost (fwdproxy-nao-001.fbsv.net. [2a03:2880:23ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id e2-20020ac845c2000000b0042c2034c54fsm367932qto.17.2024.02.05.14.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:56:12 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: riel@surriel.com,
	shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/3] selftests: add zswapin and no zswap tests
Date: Mon,  5 Feb 2024 14:56:08 -0800
Message-Id: <20240205225608.3083251-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205225608.3083251-1-nphamcs@gmail.com>
References: <20240205225608.3083251-1-nphamcs@gmail.com>
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
 tools/testing/selftests/cgroup/test_zswap.c | 120 +++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 32ce975b21d1..c263610a4a60 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -60,6 +60,27 @@ static long get_zswpout(const char *cgroup)
 	return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
 }
 
+static int allocate_and_read_bytes(const char *cgroup, void *arg)
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
@@ -100,7 +121,6 @@ static int test_zswap_usage(const char *root)
 	int ret = KSFT_FAIL;
 	char *test_group;
 
-	/* Set up */
 	test_group = cg_name(root, "no_shrink_test");
 	if (!test_group)
 		goto out;
@@ -133,6 +153,102 @@ static int test_zswap_usage(const char *root)
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
+	long swap_peak, zswpout;
+
+	test_group = cg_name(root, "no_zswap_test");
+	if (!test_group)
+		goto out;
+	if (cg_create(test_group))
+		goto out;
+	if (cg_write(test_group, "memory.max", "8M"))
+		goto out;
+	if (cg_write(test_group, "memory.zswap.max", "0"))
+		goto out;
+
+	/* Allocate and read more than memory.max to trigger swapin */
+	if (cg_run(test_group, allocate_and_read_bytes, (void *)MB(32)))
+		goto out;
+
+	/* Verify that pages are swapped out, but no zswap happened */
+	swap_peak = cg_read_long(test_group, "memory.swap.peak");
+	if (swap_peak < 0) {
+		ksft_print_msg("failed to get cgroup's swap_peak\n");
+		goto out;
+	}
+
+	if (swap_peak == 0) {
+		ksft_print_msg("pages should be swapped out\n");
+		goto out;
+	}
+
+	zswpout = get_zswpout(test_group);
+	if (zswpout < 0) {
+		ksft_print_msg("failed to get zswpout\n");
+		goto out;
+	}
+
+	if (zswpout > 0) {
+		ksft_print_msg("zswapout > 0 when memory.zswap.max = 0\n");
+		goto out;
+	}
+
+	ret = KSFT_PASS;
+
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
+/* Simple test to verify the (z)swapin code paths */
+static int test_zswapin(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *test_group;
+	long zswpin;
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
+	if (cg_run(test_group, allocate_and_read_bytes, (void *)MB(32)))
+		goto out;
+
+	zswpin = cg_read_key_long(test_group, "memory.stat", "zswpin ");
+	if (zswpin < 0) {
+		ksft_print_msg("failed to get zswpin\n");
+		goto out;
+	}
+
+	if (zswpin == 0) {
+		ksft_print_msg("zswpin should not be 0\n");
+		goto out;
+	}
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
@@ -309,6 +425,8 @@ struct zswap_test {
 	const char *name;
 } tests[] = {
 	T(test_zswap_usage),
+	T(test_swapin_nozswap),
+	T(test_zswapin),
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
 };
-- 
2.39.3

