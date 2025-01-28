Return-Path: <linux-kselftest+bounces-25330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37216A20ECB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C937A1BA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D300F1DE3BE;
	Tue, 28 Jan 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfvGG1k6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514191DE3BA
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082383; cv=none; b=Gv7Fngd+tDd8N+a8yJHOA460Lc/vDwf9LB2cvH/sZVH+3/759yKmmE+I593XlUlun4nFIWeJsIY3hPFnOR1VNreTdrmHf7+MaZ+MfnEchBI1iWlWM2IhF02JLymLzFPQ0N9qD/1IBQ+SAsjazXV3+RialxWpgjte42INjwKEa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082383; c=relaxed/simple;
	bh=cA0DcHmOCbjpertJ2WrDIHOP2x5boUglDbhmPkrFt9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTEq3usTWB0YjlfC3m3LVx7OVf37zJSJyag/U2KWvrBuSjGCT9UJEGozGavoXrNXIrqXZo+Iaavfx6w7oY91CEAlXj2flQ6lIB23cqsbp+qkI+nwuhVfC3ZiUZGHPLq2Wdrj/Tz2fgC3sP+nHdEu62VJZuSD6q613+rp6s00vi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfvGG1k6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZd8+r0Ld1kBa8nPrqbyJF0th13OifpvbO/JPmMcyGI=;
	b=EfvGG1k6KTubg3/vpgdWB+7LmOHLFBzQTIK3yf+V56JI5PO/KYOXAcdLg1GX1AzIPrNrCK
	zZzWA66KEYV2AD8egmrDOuIASHK6fLCNYtfnr1ls2G2mfDs8llmL8IfCq9ChQwe9i0189+
	vW7O4ogHuzkV+mFEvRJWXH7cLlDp0XY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-RWm3NFUJNJiinvZ0xkH_Dw-1; Tue,
 28 Jan 2025 11:39:38 -0500
X-MC-Unique: RWm3NFUJNJiinvZ0xkH_Dw-1
X-Mimecast-MFC-AGG-ID: RWm3NFUJNJiinvZ0xkH_Dw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A96D819560B2;
	Tue, 28 Jan 2025 16:39:36 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC2DC18008C0;
	Tue, 28 Jan 2025 16:39:34 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 14/21] bcachefs: simplify eytzinger0_find_le
Date: Tue, 28 Jan 2025 17:38:51 +0100
Message-ID: <20250128163859.1883260-15-agruenba@redhat.com>
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

Replace the over-complicated implementation of eytzinger0_find_le() by
an equivalent, simplifer version.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.h | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/fs/bcachefs/eytzinger.h b/fs/bcachefs/eytzinger.h
index 130f5fe30bd7..89a0e4192212 100644
--- a/fs/bcachefs/eytzinger.h
+++ b/fs/bcachefs/eytzinger.h
@@ -256,26 +256,12 @@ static inline int eytzinger0_find_le(void *base, size_t nr, size_t size,
 				     cmp_func_t cmp, const void *search)
 {
 	void *base1 = base - size;
-	unsigned i, n = 1;
-
-	if (!nr)
-		return -1;
-
-	do {
-		i = n;
-		n = eytzinger1_child(i, cmp(base1 + i * size, search) <= 0);
-	} while (n <= nr);
-
-	if (!(n & 1)) {
-		/*
-		 * @i was greater than @search, return previous node:
-		 *
-		 * if @i was leftmost/smallest element,
-		 * eytzinger1_prev(eytzinger1_first())) returns 0, as expected
-		 */
-		i = eytzinger1_prev(i, nr);
-	}
-	return i - 1;
+	unsigned n = 1;
+
+	while (n <= nr)
+		n = eytzinger1_child(n, cmp(base1 + n * size, search) <= 0);
+	n >>= __ffs(n) + 1;
+	return n - 1;
 }
 
 static inline int eytzinger0_find_gt(void *base, size_t nr, size_t size,
-- 
2.48.1


