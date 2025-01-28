Return-Path: <linux-kselftest+bounces-25321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF352A20EC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B064D18893CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B861DE3AC;
	Tue, 28 Jan 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePxO5tqL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C27E1DE3AA
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082363; cv=none; b=kLmSjFZ3a/c/cnAqetAtKXuoSCeY5GMSsXJl4Jg5a0ptFH12ZbFXh4v9AHHxhNFOAODyrmrIPo0V/MS1CPQPEG898+KJGmqY4lt74RCLTtZlEu0xWzPddSDDlg+6KOrjjU1+hqt0SvfMHq4xFsxPe8iRh3JiKvOdlse7nzaWMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082363; c=relaxed/simple;
	bh=uZ0aGlJuTJXH0fBO0zlo6dgQolJCoTc7xB+/waRCzzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZJzsy+Oci7kxz1ZfdOh/tkanTierAgoryuGufpXDibLMOglIT3pLpfnrS4p4fftB9oA6sv8K4+/dQxVlNjN6hLKl5mgKoLXYGNyBu625Z2GAQGTWPthQnOckIB37vLMIcVbe2KhPG6dGpX23U8QoCxfo1L0jNx3hZkTtdEVkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePxO5tqL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/GAn/SXepDYjnAlZBYdkJTu1emedkGC4rPyfHvCkE0=;
	b=ePxO5tqLkxt9DRq2FP/LJuRCPBRnfkdxRLiYFcvyEa41vE+xLRc8rg+vZHvoIGaf4eu073
	1dVG4eGWC6mn+MuV7NDfcKu6GVtDLWciQ9qgDWCTROIVd0B9TFlirMJYkvC1IMmGcDAWg7
	xqoKfLLMArNU9ZssPtAu+WzDH4DICig=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-ujW_-aM_Ps2dtK3x44ntww-1; Tue,
 28 Jan 2025 11:39:16 -0500
X-MC-Unique: ujW_-aM_Ps2dtK3x44ntww-1
X-Mimecast-MFC-AGG-ID: ujW_-aM_Ps2dtK3x44ntww
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 659FC1955DC8;
	Tue, 28 Jan 2025 16:39:15 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8605318008C8;
	Tue, 28 Jan 2025 16:39:13 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 05/21] bcachefs: eytzinger self tests: eytzinger0_for_each loop cleanups
Date: Tue, 28 Jan 2025 17:38:42 +0100
Message-ID: <20250128163859.1883260-6-agruenba@redhat.com>
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

The iterator variable of eytzinger0_for_each loops has been changed to
be locally scoped at some point, so remove variables defined outside the
loop that are now unused.  In addition and for clarity, use a different
variable inside those loops where an outside variable would be shadowed.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/util.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 9a63d971ee65..58a7b962847d 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -473,10 +473,10 @@ void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats
 		u64 last_q = 0;
 
 		prt_printf(out, "quantiles (%s):\t", u->name);
-		eytzinger0_for_each(i, NR_QUANTILES) {
-			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
+		eytzinger0_for_each(j, NR_QUANTILES) {
+			bool is_last = eytzinger0_next(j, NR_QUANTILES) == -1;
 
-			u64 q = max(quantiles->entries[i].m, last_q);
+			u64 q = max(quantiles->entries[j].m, last_q);
 			prt_printf(out, "%llu ", div64_u64(q, u->nsecs));
 			if (is_last)
 				prt_newline(out);
@@ -701,7 +701,7 @@ void memcpy_from_bio(void *dst, struct bio *src, struct bvec_iter src_iter)
 #if 1
 void eytzinger1_test(void)
 {
-	unsigned inorder, eytz, size;
+	unsigned inorder, size;
 
 	pr_info("1 based eytzinger test:");
 
@@ -734,7 +734,7 @@ void eytzinger1_test(void)
 void eytzinger0_test(void)
 {
 
-	unsigned inorder, eytz, size;
+	unsigned inorder, size;
 
 	pr_info("0 based eytzinger test:");
 
@@ -764,7 +764,7 @@ void eytzinger0_test(void)
 	}
 }
 
-static inline int cmp_u16(const void *_l, const void *_r, size_t size)
+static inline int cmp_u16(const void *_l, const void *_r)
 {
 	const u16 *l = _l, *r = _r;
 
@@ -787,8 +787,8 @@ static void eytzinger0_find_test_val(u16 *test_array, unsigned nr, u16 search)
 			c2 = test_array[i];
 
 	if (c1 != c2) {
-		eytzinger0_for_each(i, nr)
-			pr_info("[%3u] = %12u", i, test_array[i]);
+		eytzinger0_for_each(j, nr)
+			pr_info("[%3u] = %12u", j, test_array[j]);
 		pr_info("find_le(%2u) -> [%2zi] = %2i should be %2i",
 			i, r, c1, c2);
 	}
@@ -806,9 +806,9 @@ void eytzinger0_find_test(void)
 		eytzinger0_sort(test_array, nr, sizeof(test_array[0]), cmp_u16, NULL);
 
 		/* verify array is sorted correctly: */
-		eytzinger0_for_each(i, nr)
-			BUG_ON(i != eytzinger0_last(nr) &&
-			       test_array[i] > test_array[eytzinger0_next(i, nr)]);
+		eytzinger0_for_each(j, nr)
+			BUG_ON(j != eytzinger0_last(nr) &&
+			       test_array[j] > test_array[eytzinger0_next(j, nr)]);
 
 		for (i = 0; i < U16_MAX; i += 1 << 12)
 			eytzinger0_find_test_val(test_array, nr, i);
-- 
2.48.1


