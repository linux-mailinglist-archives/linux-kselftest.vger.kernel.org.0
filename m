Return-Path: <linux-kselftest+bounces-25334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F965A20ECD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679651888966
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F52F1DE3BF;
	Tue, 28 Jan 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI8A3DN/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5671DE3A4
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082391; cv=none; b=nY3LsZX2rRC3h5iWm7HqzKJ1joW+ZN3NMvNpbjFvhCopJIZ6MgOt6K8Lwz+UY+PZ3KNsgLmVsyjiisGLEhD2/QFolvI8sOYlYvIRc4YYgC5lkZwG+ms12aX1s8d2bZodfGDqXo5VNve+v4zAppGoUWsDFIOxbzS0PamAfcINpTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082391; c=relaxed/simple;
	bh=WT6LDUTqjhajsR2GRb9lcoCB8LRksI0PepNobb98dHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHa6YjKQeJRhqbwHlV5DIP0+/nIxk+CWHSPYq8um8TQDsue2kWkJ/dRqlhqCFUQ6R6HwF9VtqDBcliZ5TyZ9KW5woBv2V4YTdaga9Opnc0d24kUdjEnliA3xWuM+rJ2j3CH2v+zsk8pyl8LBzbE3LjcyOcQXWp6FEaYIGghz4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EI8A3DN/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQtguPtI0hZKEL7ASRVQSa5xY2NgHNYjl1fv4dXwRLM=;
	b=EI8A3DN/GQfrHWJFxsEjijDT63Ho1/Esr7yspiut0HhDmOp89FRRxeYHsPeHa+7Ugljz5i
	hfD2MIZ1gfUcu9IpdspJVySnfeP5R2U12aJmbLNF4K1zD1DfImgB7C7eMTGc6xdWaeYeju
	PsaGHfpjPXL/rBkbDrv9HRr31B5ReIk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-OQEGotc_MWaqkZKWCeUkkA-1; Tue,
 28 Jan 2025 11:39:47 -0500
X-MC-Unique: OQEGotc_MWaqkZKWCeUkkA-1
X-Mimecast-MFC-AGG-ID: OQEGotc_MWaqkZKWCeUkkA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 682051801882;
	Tue, 28 Jan 2025 16:39:46 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 888A618008C8;
	Tue, 28 Jan 2025 16:39:44 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 18/21] bcachefs: implement eytzinger0_find_ge directly
Date: Tue, 28 Jan 2025 17:38:55 +0100
Message-ID: <20250128163859.1883260-19-agruenba@redhat.com>
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

Implement eytzinger0_find_ge() directly instead of implementing it in
terms of eytzinger0_find_le() and adjusting the result.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/bcachefs/eytzinger.h b/fs/bcachefs/eytzinger.h
index a5a1abae5b13..6a363b12bd21 100644
--- a/fs/bcachefs/eytzinger.h
+++ b/fs/bcachefs/eytzinger.h
@@ -277,15 +277,17 @@ static inline int eytzinger0_find_gt(void *base, size_t nr, size_t size,
 	return n - 1;
 }
 
+/* return smallest node >= @search, or -1 if not found */
 static inline int eytzinger0_find_ge(void *base, size_t nr, size_t size,
 				     cmp_func_t cmp, const void *search)
 {
-	ssize_t idx = eytzinger0_find_le(base, nr, size, cmp, search);
-
-	if (idx < nr && !cmp(base + idx * size, search))
-		return idx;
+	void *base1 = base - size;
+	unsigned n = 1;
 
-	return eytzinger0_next(idx, nr);
+	while (n <= nr)
+		n = eytzinger1_child(n, cmp(base1 + n * size, search) < 0);
+	n >>= __ffs(n + 1) + 1;
+	return n - 1;
 }
 
 #define eytzinger0_find(base, nr, size, _cmp, search)			\
-- 
2.48.1


