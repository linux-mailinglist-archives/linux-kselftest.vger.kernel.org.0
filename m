Return-Path: <linux-kselftest+bounces-25332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00484A20ECE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3E63A5232
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8775C1DE3BE;
	Tue, 28 Jan 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jr7XZohe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202D1DE3A4
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082389; cv=none; b=BghLwaWjZdADrdtCWhYoatRLecn4+eWe96cXInobtbFiu1hjMhiG9sLH9xWQStzTujmLw7sjI9ohVaUk2cP0UvlGeSTsOtUAMTv1M5F/zfRfF7LLeqhKPXjR5X3in02trTF4ahZ3bhX0oWLN5xPKGXJJ0Poejf34AiYN5CAnsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082389; c=relaxed/simple;
	bh=hCYzWmeREswyOqDKN0hO11Gqo6hqhwbVhxuhpDZUWFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGAGjEhoSZ0q5YghvRrq//8xsEI+Fq9Q7lRpFTfVVoKZ/cw5L5h79Sa9hi71aj5xMX3z2SAHYPupsD3L5RrpAcW57PXd65JTrtixAS8epeWzhvpmjP/4r8cRjxR6Lc7sOqf7jDheqgAev7Fy0fk/qBKdpxZJ4dzRvY/se5Ye3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jr7XZohe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiKzAzNKHRucdz5+dAtojCcsKcpO9nfZcdT/qXSkqrk=;
	b=Jr7XZohejkUq5bhD3EZ8ATmxtTCt51njdgSV1uF0WI7NfHbo7wXTTkRk/xdh3SiPwwqun4
	REXH4xa8whxvvV/BkB3CNnXasgsmlpUbarugCpQkWqmy4tt/s+X20QCw3DivqUFNIk6jDV
	PT9eHCO4WL/l/xTYyaaJLdNSNPrLT+o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-3ilIVotcOpOy5CXDdqeTDQ-1; Tue,
 28 Jan 2025 11:39:42 -0500
X-MC-Unique: 3ilIVotcOpOy5CXDdqeTDQ-1
X-Mimecast-MFC-AGG-ID: 3ilIVotcOpOy5CXDdqeTDQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1D8B1800268;
	Tue, 28 Jan 2025 16:39:41 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D96D3180035E;
	Tue, 28 Jan 2025 16:39:39 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 16/21] bcachefs: implement eytzinger0_find_gt directly
Date: Tue, 28 Jan 2025 17:38:53 +0100
Message-ID: <20250128163859.1883260-17-agruenba@redhat.com>
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

Instead of implementing eytzinger0_find_gt() in terms of
eytzinger0_find_le() and adjusting the result, implement it directly.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.h | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/bcachefs/eytzinger.h b/fs/bcachefs/eytzinger.h
index 89a0e4192212..a5a1abae5b13 100644
--- a/fs/bcachefs/eytzinger.h
+++ b/fs/bcachefs/eytzinger.h
@@ -264,20 +264,17 @@ static inline int eytzinger0_find_le(void *base, size_t nr, size_t size,
 	return n - 1;
 }
 
+/* return smallest node > @search, or -1 if not found */
 static inline int eytzinger0_find_gt(void *base, size_t nr, size_t size,
 				     cmp_func_t cmp, const void *search)
 {
-	ssize_t idx = eytzinger0_find_le(base, nr, size, cmp, search);
+	void *base1 = base - size;
+	unsigned n = 1;
 
-	/*
-	 * if eytitzinger0_find_le() returned -1 - no element was <= search - we
-	 * want to return the first element; next/prev identities mean this work
-	 * as expected
-	 *
-	 * similarly if find_le() returns last element, we should return -1;
-	 * identities mean this all works out:
-	 */
-	return eytzinger0_next(idx, nr);
+	while (n <= nr)
+		n = eytzinger1_child(n, cmp(base1 + n * size, search) <= 0);
+	n >>= __ffs(n + 1) + 1;
+	return n - 1;
 }
 
 static inline int eytzinger0_find_ge(void *base, size_t nr, size_t size,
-- 
2.48.1


