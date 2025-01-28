Return-Path: <linux-kselftest+bounces-25336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB61A20ED1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188361888D59
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FE91DE3C4;
	Tue, 28 Jan 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2sIk1D4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969F1DE3AC
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082396; cv=none; b=iDYhtHwGxCohGLD61cd9XKgOvCqAseUWKL1oCptZix6ddWuBdfF0MjUtX0Xhnrv4wgcKSf67VNUSxZxE8chmLTQvPbDB0nSpvsXhXfBVTY1n9LDxxyGVqJab+ZR3aW5mooO8MQc6OvbbAfIpEt6+mbVBE1XaQP+A2o8aMoqaXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082396; c=relaxed/simple;
	bh=8tQ6XBEMYbx9V0iHjreFT9NgZ5mT2GIi/oiDgPetvHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zyd4BHeG4K+Je2p1xHp2UfxkjY1HJfG5eRophJc91iJlSa8rNvTlyL2Y5azWN7p20lbaFzQSnW7G05+6GGyPu2kVBagZ0DwftcwP9YtlWtM7fUhf+yO2Sp22MxprwfXba5vtzhN6PCS2ScZdEUXes/ZDLl4O7yw3QvCNKWcXt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2sIk1D4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNmPQEOvHYWrUX4j7maHpPPS+nivyRuwSBqiMy5hzYE=;
	b=h2sIk1D4BSXVy81dRV/fLVBddL06EGBxAgFjF4fWb5j44vwPZ65JekuoiI4HRj9FlKmId+
	sysDQeLifGC2K72OqLlCPYlhrzUv80KwK2oJ4wZU4wHY1XgqWo2RqI2LHEglhcq/g3AYfb
	kgd9eapS9NiRLaZhoOK8/8M5kjIJEAA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-jGpuxaPmPfGE9fbCFRERiA-1; Tue,
 28 Jan 2025 11:39:52 -0500
X-MC-Unique: jGpuxaPmPfGE9fbCFRERiA-1
X-Mimecast-MFC-AGG-ID: jGpuxaPmPfGE9fbCFRERiA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BCB819560B4;
	Tue, 28 Jan 2025 16:39:51 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 455DF180035E;
	Tue, 28 Jan 2025 16:39:49 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 20/21] bcachefs: convert eytzinger sort to be 1-based (2)
Date: Tue, 28 Jan 2025 17:38:57 +0100
Message-ID: <20250128163859.1883260-21-agruenba@redhat.com>
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

In this second step, transform the eytzinger indexes i, j, and k in
eytzinger1_sort_r() from 0-based to 1-based.  This step looks a bit
messy, but the resulting code is slightly better.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
index 93a5819a6878..00cc5f0826e3 100644
--- a/fs/bcachefs/eytzinger.c
+++ b/fs/bcachefs/eytzinger.c
@@ -170,7 +170,7 @@ static void eytzinger1_sort_r(void *base1, size_t n, size_t size,
 			      swap_r_func_t swap_func,
 			      const void *priv)
 {
-	int i, j, k;
+	unsigned i, j, k;
 
 	/* called from 'sort' without swap function, let's pick the default */
 	if (swap_func == SWAP_WRAPPER && !((struct wrapper *)priv)->swap_func)
@@ -186,46 +186,46 @@ static void eytzinger1_sort_r(void *base1, size_t n, size_t size,
 	}
 
 	/* heapify */
-	for (i = n / 2 - 1; i >= 0; --i) {
+	for (i = n / 2; i >= 1; --i) {
 		/* Find the sift-down path all the way to the leaves. */
-		for (j = i; k = j * 2 + 1, k + 1 < n;)
-			j = eytzinger1_do_cmp(base1, n, size, cmp_func, priv, k + 1, k + 2) > 0 ? k : k + 1;
+		for (j = i; k = j * 2, k < n;)
+			j = eytzinger1_do_cmp(base1, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
 
 		/* Special case for the last leaf with no sibling. */
-		if (j * 2 + 2 == n)
-			j = j * 2 + 1;
+		if (j * 2 == n)
+			j *= 2;
 
 		/* Backtrack to the correct location. */
-		while (j != i && eytzinger1_do_cmp(base1, n, size, cmp_func, priv, i + 1, j + 1) >= 0)
-			j = (j - 1) / 2;
+		while (j != i && eytzinger1_do_cmp(base1, n, size, cmp_func, priv, i, j) >= 0)
+			j /= 2;
 
 		/* Shift the element into its correct place. */
 		for (k = j; j != i;) {
-			j = (j - 1) / 2;
-			eytzinger1_do_swap(base1, n, size, swap_func, priv, j + 1, k + 1);
+			j /= 2;
+			eytzinger1_do_swap(base1, n, size, swap_func, priv, j, k);
 		}
 	}
 
 	/* sort */
-	for (i = n - 1; i > 0; --i) {
-		eytzinger1_do_swap(base1, n, size, swap_func, priv, 1, i + 1);
+	for (i = n; i > 1; --i) {
+		eytzinger1_do_swap(base1, n, size, swap_func, priv, 1, i);
 
 		/* Find the sift-down path all the way to the leaves. */
-		for (j = 0; k = j * 2 + 1, k + 1 < i;)
-			j = eytzinger1_do_cmp(base1, n, size, cmp_func, priv, k + 1, k + 2) > 0 ? k : k + 1;
+		for (j = 1; k = j * 2, k + 1 < i;)
+			j = eytzinger1_do_cmp(base1, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
 
 		/* Special case for the last leaf with no sibling. */
-		if (j * 2 + 2 == i)
-			j = j * 2 + 1;
+		if (j * 2 + 1 == i)
+			j *= 2;
 
 		/* Backtrack to the correct location. */
-		while (j && eytzinger1_do_cmp(base1, n, size, cmp_func, priv, 1, j + 1) >= 0)
-			j = (j - 1) / 2;
+		while (j >= 1 && eytzinger1_do_cmp(base1, n, size, cmp_func, priv, 1, j) >= 0)
+			j /= 2;
 
 		/* Shift the element into its correct place. */
-		for (k = j; j;) {
-			j = (j - 1) / 2;
-			eytzinger1_do_swap(base1, n, size, swap_func, priv, j + 1, k + 1);
+		for (k = j; j > 1;) {
+			j /= 2;
+			eytzinger1_do_swap(base1, n, size, swap_func, priv, j, k);
 		}
 	}
 }
-- 
2.48.1


