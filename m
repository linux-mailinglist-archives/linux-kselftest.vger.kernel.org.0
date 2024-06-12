Return-Path: <linux-kselftest+bounces-11769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5744D905771
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 17:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA3F1C21492
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C5418130C;
	Wed, 12 Jun 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F59ldffT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4240180A85
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207526; cv=none; b=kid1TNMyTBGPWJXBuH+smjVR+tBJPZhGjQ80KieA2uzc2z5d//hIgDBXqofkARJuOjYj5SNV5fWSEEJluwR9RkgduhhgnwIk8y/WZM3z4Wgjdd/QTkU9NLORp+sR3Mc7ByLl92AY2VAHPGabiiB3ZkNNZuTBOrevqVV7bWTFTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207526; c=relaxed/simple;
	bh=xtBDFoQmM9KRsbYQrWoWhaDcGs4A5YynZBYJRZNzOfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TuVSbCiN0wFJpn/plBIXcVKBkOh41Uc0WmC1bQFOPJFuqmX0KJgJd4vckXsmgHr+JLqNiNjEYZtWY9eantNK4G76NPOW1WPbJX0p01QmcRYTO9/LlnI8otNH2jHZlH+aHHaSzebWRqkv7SX84EMMliH0bHkeIdYI0FkgSb/AVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F59ldffT; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45CFEv7K030677
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 08:52:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=I/Z6N+8GhYKAY2oDMx40QxjDLD0DkKbXD3UysbN8DvI=;
 b=F59ldffTNBenHKBhWMmTrYlfiDKpxNy/YcsE8FHZ5mJ0eHqKohUX/2S2n7gIHsLnH/XY
 v+tu7vrRbT7Aqa37QzcPu1YSLrCxyb3ZdPtvtEzhLkmwhlDiInTeL9MfAXXJSUFgOIyL
 M5pChy1VRE+yWbwWshmtr1yPfFi0tF/Bzw92PCu6zleAbq8FVyqHyv7gAT+FUiRFBjmn
 JMv9Px6Nhvy9x4Gy7Ir+7nq/Cv+pvkffzWKS8R0FuxVCwXO8+6rpy8H4Go6HF8TAz4/X
 hKiODwIj5mLIuvXGYsiCCPLYqM2HLjQHL+13lWsi0Jc+Ttwu4JPnvof7m7Ibc2hNE6hS Vw== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yqd9ggnu3-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 08:52:03 -0700
Received: from twshared15118.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 12 Jun 2024 15:51:58 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id DCB8BF5EA644; Wed, 12 Jun 2024 08:51:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <paulmck@kernel.org>,
        <davidgow@google.com>, <akpm@linux-foundation.org>,
        <venkat88@linux.vnet.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] list: introduce a new cutting helper
Date: Wed, 12 Jun 2024 08:51:34 -0700
Message-ID: <20240612155135.3060667-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rcurRDc1aN1LMJ56h-rVIdGtMBYDHC5I
X-Proofpoint-ORIG-GUID: rcurRDc1aN1LMJ56h-rVIdGtMBYDHC5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

Provide a helper to remove elements from a list to the end, and place
those elements in a new list.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/list.h | 20 ++++++++++++++++++++
 lib/list-test.c      | 29 +++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 5f4b0a39cf46a..f22850e854820 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -520,6 +520,26 @@ static inline void list_cut_before(struct list_head =
*list,
 	entry->prev =3D head;
 }
=20
+/**
+ * list_cut - cut a list into two from the entry
+ * @list: a new list to add all removed entries
+ * @head: a list with entries
+ * @entry: an entry within head, could be the head itself
+ *
+ * This helper removes elements from @head starting at @entry until the =
end,
+ * and appends them to @lists.
+ */
+static inline void list_cut(struct list_head *list,
+		struct list_head *head, struct list_head *entry)
+{
+	list->next =3D entry;
+	list->prev =3D head->prev;
+	head->prev =3D entry->prev;
+	entry->prev->next =3D head;
+	entry->prev =3D list;
+	list->prev->next =3D list;
+}
+
 static inline void __list_splice(const struct list_head *list,
 				 struct list_head *prev,
 				 struct list_head *next)
diff --git a/lib/list-test.c b/lib/list-test.c
index 0cc27de9cec88..1507f46cf1ade 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -382,6 +382,34 @@ static void list_test_list_is_singular(struct kunit =
*test)
 	KUNIT_EXPECT_FALSE(test, list_is_singular(&list));
 }
=20
+static void list_test_list_cut(struct kunit *test)
+{
+	struct list_head entries[3], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i =3D 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list1);
+
+	/* before: [list1] -> entries[0] -> entries[1] -> entries[2] */
+	list_cut(&list2, &list1, &entries[1]);
+	/* after: [list1] -> entries[0], [list2] -> entries[1] -> entries[2] */
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 1);
+
+	list_for_each(cur, &list2) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+}
+
 static void list_test_list_cut_position(struct kunit *test)
 {
 	struct list_head entries[3], *cur;
@@ -780,6 +808,7 @@ static struct kunit_case list_test_cases[] =3D {
 	KUNIT_CASE(list_test_list_is_singular),
 	KUNIT_CASE(list_test_list_cut_position),
 	KUNIT_CASE(list_test_list_cut_before),
+	KUNIT_CASE(list_test_list_cut),
 	KUNIT_CASE(list_test_list_splice),
 	KUNIT_CASE(list_test_list_splice_tail),
 	KUNIT_CASE(list_test_list_splice_init),
--=20
2.43.0


