Return-Path: <linux-kselftest+bounces-17128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B296BEF1
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBC81F26A97
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9891B1DB942;
	Wed,  4 Sep 2024 13:43:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C01DA303;
	Wed,  4 Sep 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457391; cv=none; b=eK984l4QqX8gWngcGd2EucnV0Xpc5tkQmnhhEhEn8tcRdsJIYps0EcSrqgnXm5riN+2xLy5KLq6kvi+me+n4In8Hub6BsVD/7aTj5XXQKbfWQCWPBmU5EMGwJcmvrp0sSZjH2o8J97shNgcf5C2odUb5PLVuXosYOA0e3lJET90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457391; c=relaxed/simple;
	bh=zS7Bd1F6TyouI0FF6oVCRjYUdMQdBm2rMja85e/c3+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUgsCjdWYMwx+DuMZdPtKkZ+h8hw8pettc6+f/crlmr6O73ghsN5ZT/gMMeRy6PbBlyVhYiyEDUUpwVYUYeGSiP2a64yJvoge7Z/WXxvm8YAiqtXA97jYooTB1q9WB36YRcBOYPPdbbY15ykb/vBpjZUo6fWlE0RZIIIqjYMrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WzNrq5bJsz1HFqw;
	Wed,  4 Sep 2024 21:39:39 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 638DC1402CC;
	Wed,  4 Sep 2024 21:43:07 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:43:06 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>, David Gow
	<davidgow@google.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/3] list: add hlist_cut_number()
Date: Wed, 4 Sep 2024 21:41:50 +0800
Message-ID: <20240904134152.2141-2-thunder.leizhen@huawei.com>
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

Add a function to pull a sub list containing up to @cnt nodes from @old
list. This is beneficial to performance in scenarios where N free nodes
are pulled from the global list to the local list, or N free nodes are
pushed from the local list to the global list. Because the old sub list
is no longer split and then spliced into the new list one by one, this
also enhances readability.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/list.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 5f4b0a39cf46a37..9fb58cbceb1245c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -1210,4 +1210,48 @@ static inline size_t hlist_count_nodes(struct hlist_head *head)
 	return count;
 }
 
+/**
+ * hlist_cut_number - cut a list into two
+ * @new: a new list to add all removed entries
+ * @old: a list with entries
+ * @cnt: maximum of nodes need to be cut
+ * @last: save the last node of the new list
+ *
+ * This helper moves the initial part of @old, maximum of @cnt nodes, from
+ * @old to @new. @new should be an empty list or a list you do not care about
+ * losing its data.
+ *
+ * Returns the number of nodes in the @new list, maybe zero.
+ *
+ */
+static inline int hlist_cut_number(struct hlist_head *new,
+		struct hlist_head *old, int cnt, struct hlist_node **last)
+{
+	int nr = 0;
+	struct hlist_node *tmp, *pos = NULL;
+
+	if (cnt <= 0)
+		return 0;
+
+	hlist_for_each(tmp, old) {
+		nr++;
+		pos = tmp;
+		if (nr >= cnt)
+			break;
+	}
+
+	*last = pos;
+	new->first = old->first;
+
+	if (pos) {
+		new->first->pprev = &new->first;
+		old->first = pos->next;
+		if (old->first)
+			old->first->pprev = &old->first;
+		pos->next = NULL;
+	}
+
+	return nr;
+}
+
 #endif
-- 
2.34.1


