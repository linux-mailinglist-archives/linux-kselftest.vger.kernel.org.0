Return-Path: <linux-kselftest+bounces-25335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF3CA20ED0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668423A6304
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4111DE3B1;
	Tue, 28 Jan 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtsO/AMR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD91DE3C3
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082395; cv=none; b=UWI0fL3W2m5UU5V9AHJlNUqS/Xf0sjitaV4EcX49PGv6Ep5CnuNKvdxd2pELICsRiB//BoXSWgl0VTLhcVXBScKM/yxIHH+dg5lMy0oeHIxsCP4OTJTZrkx3HErAlFVRfBTYu5DIVwVeEO4iYtx1dX0BcvIHUmAVMhaE1UfsY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082395; c=relaxed/simple;
	bh=tJkAXjEvufeX/5dKW+3RT/KX1TbldSWqPOBH1co00lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHDIW9VDLZf2Q553fAnRLR5ZrN5MlEDs6BCfRkow7yky633Ak0pAZJcU9KTWbc4w1cKS4CcB3WpH+jzdriceI9j2VyOuD5MKcbKFOQl+ELIqTxnueKJ+tdU26PorWuHocLSuDRz7PGA6L2xB1S7pxEZhrCVSVTe2h45l8MecwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtsO/AMR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ltYxlBO7b3sbhJky1/A71Z0Wfo/ecXnBT4MAz0bUNU=;
	b=gtsO/AMR+vci+S5BJzF7OfK4CHcx3B4fq2MsmNGH8eamVVjx0rDdOHPnYCmPiohhurTIvn
	MZVq0wR/kl2uZ3VxNpBHH+lxRvRc3uvdUvOpl9qoNGn94qw71q2wE1WwsyAZY8lohRPUYC
	GrE5dYOSZqIWN5CRE7geTGpC853nUI0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-YEwM4907PKG855x_XNCrPA-1; Tue,
 28 Jan 2025 11:39:49 -0500
X-MC-Unique: YEwM4907PKG855x_XNCrPA-1
X-Mimecast-MFC-AGG-ID: YEwM4907PKG855x_XNCrPA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0F8619560BB;
	Tue, 28 Jan 2025 16:39:48 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E11A218008D8;
	Tue, 28 Jan 2025 16:39:46 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 19/21] bcachefs: convert eytzinger sort to be 1-based (1)
Date: Tue, 28 Jan 2025 17:38:56 +0100
Message-ID: <20250128163859.1883260-20-agruenba@redhat.com>
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

In this first step, convert the eytzinger sort functions to use 1-based
primitives.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.c | 48 +++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
index 08549ab3c18e..93a5819a6878 100644
--- a/fs/bcachefs/eytzinger.c
+++ b/fs/bcachefs/eytzinger.c
@@ -147,28 +147,28 @@ static int do_cmp(const void *a, const void *b, cmp_r_func_t cmp, const void *pr
 	return cmp(a, b, priv);
 }
 
-static inline int eytzinger0_do_cmp(void *base, size_t n, size_t size,
+static inline int eytzinger1_do_cmp(void *base1, size_t n, size_t size,
 			 cmp_r_func_t cmp_func, const void *priv,
 			 size_t l, size_t r)
 {
-	return do_cmp(base + inorder_to_eytzinger0(l, n) * size,
-		      base + inorder_to_eytzinger0(r, n) * size,
+	return do_cmp(base1 + inorder_to_eytzinger1(l, n) * size,
+		      base1 + inorder_to_eytzinger1(r, n) * size,
 		      cmp_func, priv);
 }
 
-static inline void eytzinger0_do_swap(void *base, size_t n, size_t size,
+static inline void eytzinger1_do_swap(void *base1, size_t n, size_t size,
 			   swap_r_func_t swap_func, const void *priv,
 			   size_t l, size_t r)
 {
-	do_swap(base + inorder_to_eytzinger0(l, n) * size,
-		base + inorder_to_eytzinger0(r, n) * size,
+	do_swap(base1 + inorder_to_eytzinger1(l, n) * size,
+		base1 + inorder_to_eytzinger1(r, n) * size,
 		size, swap_func, priv);
 }
 
-void eytzinger0_sort_r(void *base, size_t n, size_t size,
-		       cmp_r_func_t cmp_func,
-		       swap_r_func_t swap_func,
-		       const void *priv)
+static void eytzinger1_sort_r(void *base1, size_t n, size_t size,
+			      cmp_r_func_t cmp_func,
+			      swap_r_func_t swap_func,
+			      const void *priv)
 {
 	int i, j, k;
 
@@ -177,9 +177,9 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
 		swap_func = NULL;
 
 	if (!swap_func) {
-		if (is_aligned(base, size, 8))
+		if (is_aligned(base1, size, 8))
 			swap_func = SWAP_WORDS_64;
-		else if (is_aligned(base, size, 4))
+		else if (is_aligned(base1, size, 4))
 			swap_func = SWAP_WORDS_32;
 		else
 			swap_func = SWAP_BYTES;
@@ -189,47 +189,57 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
 	for (i = n / 2 - 1; i >= 0; --i) {
 		/* Find the sift-down path all the way to the leaves. */
 		for (j = i; k = j * 2 + 1, k + 1 < n;)
-			j = eytzinger0_do_cmp(base, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
+			j = eytzinger1_do_cmp(base1, n, size, cmp_func, priv, k + 1, k + 2) > 0 ? k : k + 1;
 
 		/* Special case for the last leaf with no sibling. */
 		if (j * 2 + 2 == n)
 			j = j * 2 + 1;
 
 		/* Backtrack to the correct location. */
-		while (j != i && eytzinger0_do_cmp(base, n, size, cmp_func, priv, i, j) >= 0)
+		while (j != i && eytzinger1_do_cmp(base1, n, size, cmp_func, priv, i + 1, j + 1) >= 0)
 			j = (j - 1) / 2;
 
 		/* Shift the element into its correct place. */
 		for (k = j; j != i;) {
 			j = (j - 1) / 2;
-			eytzinger0_do_swap(base, n, size, swap_func, priv, j, k);
+			eytzinger1_do_swap(base1, n, size, swap_func, priv, j + 1, k + 1);
 		}
 	}
 
 	/* sort */
 	for (i = n - 1; i > 0; --i) {
-		eytzinger0_do_swap(base, n, size, swap_func, priv, 0, i);
+		eytzinger1_do_swap(base1, n, size, swap_func, priv, 1, i + 1);
 
 		/* Find the sift-down path all the way to the leaves. */
 		for (j = 0; k = j * 2 + 1, k + 1 < i;)
-			j = eytzinger0_do_cmp(base, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
+			j = eytzinger1_do_cmp(base1, n, size, cmp_func, priv, k + 1, k + 2) > 0 ? k : k + 1;
 
 		/* Special case for the last leaf with no sibling. */
 		if (j * 2 + 2 == i)
 			j = j * 2 + 1;
 
 		/* Backtrack to the correct location. */
-		while (j && eytzinger0_do_cmp(base, n, size, cmp_func, priv, 0, j) >= 0)
+		while (j && eytzinger1_do_cmp(base1, n, size, cmp_func, priv, 1, j + 1) >= 0)
 			j = (j - 1) / 2;
 
 		/* Shift the element into its correct place. */
 		for (k = j; j;) {
 			j = (j - 1) / 2;
-			eytzinger0_do_swap(base, n, size, swap_func, priv, j, k);
+			eytzinger1_do_swap(base1, n, size, swap_func, priv, j + 1, k + 1);
 		}
 	}
 }
 
+void eytzinger0_sort_r(void *base, size_t n, size_t size,
+		       cmp_r_func_t cmp_func,
+		       swap_r_func_t swap_func,
+		       const void *priv)
+{
+	void *base1 = base - size;
+
+	return eytzinger1_sort_r(base1, n, size, cmp_func, swap_func, priv);
+}
+
 void eytzinger0_sort(void *base, size_t n, size_t size,
 		     cmp_func_t cmp_func,
 		     swap_func_t swap_func)
-- 
2.48.1


