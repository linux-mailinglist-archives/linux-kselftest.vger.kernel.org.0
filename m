Return-Path: <linux-kselftest+bounces-25323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401D7A20EC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D431889D63
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055BF1DE2D7;
	Tue, 28 Jan 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQ2z71nM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5271DE3A9
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082366; cv=none; b=FPz0on05di78cr+Oi8HGTM9z15hhXIO1UrUhI+XXwwCgNrpNNpLgGIUHO7A755KIM+vn1gnqMSoZbguW/hFs/eW3s4ExYBT9bt2U2/NwGvfJwEfVq8KWIZk0vmO6D5AlhHZgMjNgZCSCQkO9HGkY9P5iT3iBTVptwiDUIv4w7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082366; c=relaxed/simple;
	bh=26+fZjoj5DpFgwjWuVjxZioQ6e93bfSV9rMpdHN3BS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSfVwkFV72aCbFZKHPgW0Uk7JDifOKh/Fd8B9OxCA4kdV43J7+ljGvWzUF1YFR9ktka7Fn39BMjBpnITyWiEv3pX+XV1z2hL3lo0C42QWvaBylVoej+zaaqxnOJOCIFUT+BVuRVXxehkmvPmJmIzLSNuTxU/7AditIU3feq+uEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQ2z71nM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jctk5R+SR8nBvr4ywsdyrPgUcAu2wJfq11Wb8lyGBzU=;
	b=MQ2z71nMYX+fWN5AhVl0rJ4Vuh6WBzqLGTYSjX7EbkLycxDp4sZxMsKR2y4SJs7S7tRz11
	i1/aVJDVqMDvs/uA25/f0Lf8THArS8M0PwTX3vwEtkYQkuxirnbe3nGbWXvmvhvE90td/h
	/Ky3BHj4NHGYR+l7xRGpTMGjVOYcGCQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-pPxWYbZKM7axE1krNLqh0g-1; Tue,
 28 Jan 2025 11:39:21 -0500
X-MC-Unique: pPxWYbZKM7axE1krNLqh0g-1
X-Mimecast-MFC-AGG-ID: pPxWYbZKM7axE1krNLqh0g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B9E01800A01;
	Tue, 28 Jan 2025 16:39:20 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3602B18008D4;
	Tue, 28 Jan 2025 16:39:17 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 07/21] bcachefs: eytzinger self tests: fix cmp_u16 typo
Date: Tue, 28 Jan 2025 17:38:44 +0100
Message-ID: <20250128163859.1883260-8-agruenba@redhat.com>
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

Fix an obvious typo in cmp_u16().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 7cf319290a88..0ffbd22d3a5e 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -768,7 +768,7 @@ static inline int cmp_u16(const void *_l, const void *_r)
 {
 	const u16 *l = _l, *r = _r;
 
-	return (*l > *r) - (*r - *l);
+	return (*l > *r) - (*r > *l);
 }
 
 static void eytzinger0_find_test_val(u16 *test_array, unsigned nr, u16 search)
-- 
2.48.1


