Return-Path: <linux-kselftest+bounces-25327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7703BA20EC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49333A62A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AD51DE3BA;
	Tue, 28 Jan 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JN2GbuWc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBF1DE3AC
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082377; cv=none; b=O31kCX6F9oyoBW+Un5xO55QZD+anLzy/lC2uo3xpBEAGgF7nq/TFV5BW5sJJ2mLIAW0MaKLnVcZBo69Nyy0NKkI5ItDeI5KhCqSbbMC3bAI/FtjK4biDpo0VNvHfZ3AD4n+XAYKMfooE+bQeS6jmcWQxzaZuWyjNPYQgC0vGwg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082377; c=relaxed/simple;
	bh=Q4L+OrPQw64EmyoWqeElIQQS4K6CLQeCegeDdBXVELc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joAOWSK5/EDEH0jrmFAz2/q2HC1wA8GCGqFAToO9/D4EPVyWZv3S0vtg7YYfM0O8fO3H6rIbkCu7GczJIjTjNvMIeFqmmaWVvW/tVr/Xbq6txn8um2OL6Qek7rjO+uc/s9EbwW30jwm16G0CwsDDuWpziuSRsF7u/djCGtJvTOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JN2GbuWc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STYFZq9yGDZAcEa5KK0r23b7pY53kibk/xnRBI6F77I=;
	b=JN2GbuWcGJCu+q58NBGt2/yVi6bDA4JSmV/ak6U+Lp/sGnt0sth+weURbnzdbu0fo9juPx
	/D7m+2vnuT2NJLYaKWhFR3qQYlf6uwJCPnAmhfzJePGrhYyWea3AG/cTUivXG2puRQie1z
	/0uhaC3wuRmIMJqj6BYbYOdAlckdmmU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-DhthYg2JPcaI-lC5nhuTGA-1; Tue,
 28 Jan 2025 11:39:31 -0500
X-MC-Unique: DhthYg2JPcaI-lC5nhuTGA-1
X-Mimecast-MFC-AGG-ID: DhthYg2JPcaI-lC5nhuTGA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73E8C19560AB;
	Tue, 28 Jan 2025 16:39:27 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D676180035E;
	Tue, 28 Jan 2025 16:39:25 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 10/21] bcachefs: add eytzinger0_for_each_prev
Date: Tue, 28 Jan 2025 17:38:47 +0100
Message-ID: <20250128163859.1883260-11-agruenba@redhat.com>
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

Add an eytzinger0_for_each_prev() macro for iterating through an
eytzinger array in reverse.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.h | 5 +++++
 fs/bcachefs/util.c      | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/fs/bcachefs/eytzinger.h b/fs/bcachefs/eytzinger.h
index 6fa6d51a5420..f25c895aa184 100644
--- a/fs/bcachefs/eytzinger.h
+++ b/fs/bcachefs/eytzinger.h
@@ -246,6 +246,11 @@ static inline unsigned inorder_to_eytzinger0(unsigned i, unsigned size)
 	     (_i) != -1;				\
 	     (_i) = eytzinger0_next((_i), (_size)))
 
+#define eytzinger0_for_each_prev(_i, _size)		\
+	for (unsigned (_i) = eytzinger0_last((_size));	\
+	     (_i) != -1;				\
+	     (_i) = eytzinger0_prev((_i), (_size)))
+
 /* return greatest node <= @search, or -1 if not found */
 static inline int eytzinger0_find_le(void *base, size_t nr, size_t size,
 				     cmp_func_t cmp, const void *search)
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 87502e1ac7ce..3fe9a3b8c696 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -763,6 +763,15 @@ void eytzinger0_test(void)
 			inorder++;
 		}
 		BUG_ON(inorder != size);
+
+		inorder = size - 1;
+		eytzinger0_for_each_prev(eytz, size) {
+			BUG_ON(eytz != eytzinger0_first(size) &&
+			       eytzinger0_next(eytzinger0_prev(eytz, size), size) != eytz);
+
+			inorder--;
+		}
+		BUG_ON(inorder != -1);
 	}
 }
 
-- 
2.48.1


