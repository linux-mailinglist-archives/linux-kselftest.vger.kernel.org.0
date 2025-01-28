Return-Path: <linux-kselftest+bounces-25326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07BA20EC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CFB1884E10
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E424B1DE3B1;
	Tue, 28 Jan 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axO6gsMo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF891DE3A4
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082375; cv=none; b=semIJzaIdDgoA2wwtS/+K6zgIX2JKbxh/wFyPib42Aalx4HBhyMxL/DqQKsFwl29pEKgk+co2xscPE6Dm9By9IHwAr60shLHXb9yMa5HzBEkqePovFCRtPhKwtzVOERIIx6EdRfUKgxtH2a1GLhZ35QW8CDxARLPO9K9h4hQ1KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082375; c=relaxed/simple;
	bh=xYYKSzeUNhktelKMGtWaDjWVNkHylHHNM7lBAJ0mpXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4DbpbLA+79H0X/+kW0kxPFno5uVgU07o2+43KBlxsW3UEUIV3FK0Rvl/0wCkliFEBKzJAfIJSL3mg8VwA2OCCImoMB2ExlNFEDf+5dfNT6dAR1kAAhX8oE5OrgFSqyxlINzs8J8WQ4z/Sw3A91lsFRTQvLGLNeiIhLDhZY3dMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axO6gsMo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSTjRU8OGvFCT9OatwrBdkc0jw3p9R5xmeWWLyB1Jg8=;
	b=axO6gsMoqRIlUH43jnoxOfr+KR2J/FnLGu9WiP2o1Z0PTz4ucjzMW5hLXn2IYljT6GsdI9
	qwKB8dRyt9dQtJ+SPlzJWMwt3p+7XhG9dqJmImzhiXX7QdHEFGulK14EDqZMQXgYwD6Tja
	ra2uajBeJICsnx1GAGDmZSLoe27vDpg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-0Me6OjgyPEOTm2bDVyCZGg-1; Tue,
 28 Jan 2025 11:39:31 -0500
X-MC-Unique: 0Me6OjgyPEOTm2bDVyCZGg-1
X-Mimecast-MFC-AGG-ID: 0Me6OjgyPEOTm2bDVyCZGg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2EE11800373;
	Tue, 28 Jan 2025 16:39:29 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD98D180035E;
	Tue, 28 Jan 2025 16:39:27 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 11/21] bcachefs: improve the eytzinger0_find_le tests
Date: Tue, 28 Jan 2025 17:38:48 +0100
Message-ID: <20250128163859.1883260-12-agruenba@redhat.com>
In-Reply-To: <20250128163859.1883260-1-agruenba@redhat.com>
References: <20250128163859.1883260-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Rename eytzinger0_find_test_val() to eytzinger0_find_test_le() and add a
new eytzinger0_find_test_val() wrapper that calls it.

We have already established that the array is sorted in eytzinger order,
so we can use the eytzinger iterator functions and check the boundary
conditions to verify the result of eytzinger0_find_le().

Only scan the entire array if we get an incorrect result.  When we need
to scan, use eytzinger0_for_each_prev() so that we'll stop at the
highest matching element in the array in case there are duplicates;
going through the array linearly wouldn't give us that.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/util.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 3fe9a3b8c696..c772629783f3 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -782,29 +782,48 @@ static inline int cmp_u16(const void *_l, const void *_r)
 	return (*l > *r) - (*r > *l);
 }
 
-static void eytzinger0_find_test_val(u16 *test_array, unsigned nr, u16 search)
+static void eytzinger0_find_test_le(u16 *test_array, unsigned nr, u16 search)
 {
-	int i, c1 = -1, c2 = -1;
-	ssize_t r;
+	int r, s;
+	bool bad;
 
 	r = eytzinger0_find_le(test_array, nr,
 			       sizeof(test_array[0]),
 			       cmp_u16, &search);
-	if (r >= 0)
-		c1 = test_array[r];
+	if (r >= 0) {
+		if (test_array[r] > search) {
+			bad = true;
+		} else {
+			s = eytzinger0_next(r, nr);
+			bad = s >= 0 && test_array[s] <= search;
+		}
+	} else {
+		s = eytzinger0_last(nr);
+		bad = s >= 0 && test_array[s] <= search;
+	}
 
-	for (i = 0; i < nr; i++)
-		if (test_array[i] <= search && test_array[i] > c2)
-			c2 = test_array[i];
+	if (bad) {
+		s = -1;
+		eytzinger0_for_each_prev(j, nr) {
+			if (test_array[j] <= search) {
+				s = j;
+				break;
+			}
+		}
 
-	if (c1 != c2) {
 		eytzinger0_for_each(j, nr)
 			pr_info("[%3u] = %12u\n", j, test_array[j]);
-		pr_info("find_le(%2u) -> [%2zi] = %2i should be %2i\n",
-			i, r, c1, c2);
+		pr_info("find_le(%12u) = %3i should be %3i\n",
+			search, r, s);
+		BUG();
 	}
 }
 
+static void eytzinger0_find_test_val(u16 *test_array, unsigned nr, u16 search)
+{
+	eytzinger0_find_test_le(test_array, nr, search);
+}
+
 void eytzinger0_find_test(void)
 {
 	unsigned i, nr, allocated = 1 << 12;
-- 
2.48.1


