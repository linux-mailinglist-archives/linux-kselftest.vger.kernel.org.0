Return-Path: <linux-kselftest+bounces-17129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DF96BF12
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49ECB25FCE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0541DC059;
	Wed,  4 Sep 2024 13:43:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B751DA310;
	Wed,  4 Sep 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457392; cv=none; b=mxxlFY7AEv434R4BXaNtinNy3uZzfZ5bhzZpq7msufgCj315bL/LjbFvVLBMiomp/BydX33z2P0n9w+6tBGGFOKc99zvA/EnApInNwwZdmaITCVKBOajOOfNezLs0l3jXZKWNc9rsRvg8z8CzbGA+s4+91xBaXLS0HCvnS3MTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457392; c=relaxed/simple;
	bh=gvmVdM1YXMS1NjbCSjcvrD/VQqDsvIj8glzy0W8Z544=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihRV8G3szHEqg80xQ8pio9eqOVUZ2xd+FQ/NECIspGHnkS9ulEFuXsnUM5/1GOFa5K/vXRo9NVIQ4cLL537xuPb70b9UDLQamYxPRgVvRuRUvwqia+RxdQuJ3dSZo6nQlV78F582TuBor5jc6P2GfEtdvHpsYZDb0L35Wfs8MCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WzNwR4ZQZz1j839;
	Wed,  4 Sep 2024 21:42:47 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id EDD221A016C;
	Wed,  4 Sep 2024 21:43:07 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:43:07 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>, David Gow
	<davidgow@google.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/3] list: test: Add a test for hlist_cut_number()
Date: Wed, 4 Sep 2024 21:41:51 +0800
Message-ID: <20240904134152.2141-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20240904134152.2141-1-thunder.leizhen@huawei.com>
References: <20240904134152.2141-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Test cases cover all possible situations:
1. The cut number is invalid: zero or negative
2. Partially cut.
3. Cut all.
4. The cut number is greater than the number of nodes in the old list.
5. The old list is empty.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/list-test.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 37cbc33e9fdb380..3c60a6458545452 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -1172,6 +1172,56 @@ static void hlist_test_for_each_entry_safe(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, hlist_empty(&list));
 }
 
+static void hlist_test_cut_number(struct kunit *test)
+{
+	struct hlist_node a[4], *last;
+	HLIST_HEAD(old);
+	HLIST_HEAD(new);
+	int cnt;
+
+	hlist_add_head(&a[3], &old);
+	hlist_add_head(&a[2], &old);
+	hlist_add_head(&a[1], &old);
+	hlist_add_head(&a[0], &old);
+
+	/* The cut number is less than 0 or zero */
+	cnt = hlist_cut_number(&new, &old, -1, &last);
+	KUNIT_EXPECT_EQ(test, cnt, 0);
+	KUNIT_EXPECT_EQ(test, hlist_count_nodes(&old), 4);
+	cnt = hlist_cut_number(&new, &old, 0, &last);
+	KUNIT_EXPECT_EQ(test, cnt, 0);
+	KUNIT_EXPECT_EQ(test, hlist_count_nodes(&old), 4);
+
+	/* The cut number is less than the number of nodes in the old list. */
+	cnt = hlist_cut_number(&new, &old, 2, &last);
+	KUNIT_EXPECT_EQ(test, cnt, 2);
+	KUNIT_EXPECT_EQ(test, hlist_count_nodes(&old), 2);
+	KUNIT_EXPECT_EQ(test, hlist_count_nodes(&new), 2);
+	KUNIT_EXPECT_PTR_EQ(test, last, &a[1]);
+	hlist_splice_init(&new, last, &old);
+
+	/* The cut number is equal to the number of nodes in the old list. */
+	cnt = hlist_cut_number(&new, &old, 4, &last);
+	KUNIT_EXPECT_EQ(test, cnt, 4);
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&old));
+	KUNIT_EXPECT_EQ(test, hlist_count_nodes(&new), 4);
+	KUNIT_EXPECT_PTR_EQ(test, last, &a[3]);
+	hlist_splice_init(&new, last, &old);
+
+	/* The cut number is greater than the number of nodes in the old list. */
+	cnt = hlist_cut_number(&new, &old, 5, &last);
+	KUNIT_EXPECT_EQ(test, cnt, 4);
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&old));
+	KUNIT_EXPECT_EQ(test, hlist_count_nodes(&new), 4);
+	KUNIT_EXPECT_PTR_EQ(test, last, &a[3]);
+
+	/* The old list is empty. */
+	cnt = hlist_cut_number(&new, &old, 1, &last);
+	KUNIT_EXPECT_EQ(test, cnt, 0);
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&old));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&new));
+}
+
 
 static struct kunit_case hlist_test_cases[] = {
 	KUNIT_CASE(hlist_test_init),
@@ -1192,6 +1242,7 @@ static struct kunit_case hlist_test_cases[] = {
 	KUNIT_CASE(hlist_test_for_each_entry_continue),
 	KUNIT_CASE(hlist_test_for_each_entry_from),
 	KUNIT_CASE(hlist_test_for_each_entry_safe),
+	KUNIT_CASE(hlist_test_cut_number),
 	{},
 };
 
-- 
2.34.1


