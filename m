Return-Path: <linux-kselftest+bounces-25329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC6A20ECA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85213A5DB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6EE1DE3AE;
	Tue, 28 Jan 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzWpAc8l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FD1DE3A4
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082382; cv=none; b=L2F3yoCxuFOXw1WDYl48klMYyqviHnLnfiTut8zOIGppdxXC3Niygvyb24QYAYF0U8hdqGwuTTF6HDcUnMI5Gx8rMorWYiWF7oVDqhLz3boPZ1jplAlFh9kT5eGOgp5ZBdWZmh1bqMn4Q+eE/MLb0t4d13bG8Q4tlkNIAToK4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082382; c=relaxed/simple;
	bh=to7YVz+ZP9wZQ/hf5G31EeF2GtYmyr37A/IQfP8eOd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2jjZ1W6atuII4GPfubWCC6pronjxV36TEHtB3B0zOagpKWvWTybIAa7POrixdNImf+xpUPop97IBxbLzqlpqnu7Hz+1wdog/Oe83wPQ5RAaHxZJMIRWXV7TdhB9lK5qUqu73prlaGAb1ScMR5cucvU6kYefzwm3TBE++N64WlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzWpAc8l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1q5oEad9tu+f1M8WQTNmmoY3EsgfSb3rycHQaS+bJ9k=;
	b=RzWpAc8lDRMwmxGQ0790+QMN6lJYA9czPGbN9RjKHSbNFnHlRDxKUqR2B/gN+NHkoAynm1
	5PguNSPB6nIQDPohOkpCHDtYwEwRZxmy/p7FFv7upunQdEHwqmSDwmdW+WueoQ/E12L3sn
	2JeVmATbFiC/p1Qz1slt/uFSKc/lQ44=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-8H8nEUDlMuitbEhniwwn7w-1; Tue,
 28 Jan 2025 11:39:35 -0500
X-MC-Unique: 8H8nEUDlMuitbEhniwwn7w-1
X-Mimecast-MFC-AGG-ID: 8H8nEUDlMuitbEhniwwn7w
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52FAA18009B7;
	Tue, 28 Jan 2025 16:39:34 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C754180035E;
	Tue, 28 Jan 2025 16:39:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 13/21] bcachefs: convert eytzinger0_find_le to be 1-based
Date: Tue, 28 Jan 2025 17:38:50 +0100
Message-ID: <20250128163859.1883260-14-agruenba@redhat.com>
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

eytzinger0_find_le() is also easy to concert to 1-based eytzinger (but
see the next commit).

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/bcachefs/eytzinger.h b/fs/bcachefs/eytzinger.h
index d3e8b9edf335..130f5fe30bd7 100644
--- a/fs/bcachefs/eytzinger.h
+++ b/fs/bcachefs/eytzinger.h
@@ -255,27 +255,27 @@ static inline unsigned inorder_to_eytzinger0(unsigned i, unsigned size)
 static inline int eytzinger0_find_le(void *base, size_t nr, size_t size,
 				     cmp_func_t cmp, const void *search)
 {
-	unsigned i, n = 0;
+	void *base1 = base - size;
+	unsigned i, n = 1;
 
 	if (!nr)
 		return -1;
 
 	do {
 		i = n;
-		n = eytzinger0_child(i, cmp(base + i * size, search) <= 0);
-	} while (n < nr);
+		n = eytzinger1_child(i, cmp(base1 + i * size, search) <= 0);
+	} while (n <= nr);
 
-	if (n & 1) {
+	if (!(n & 1)) {
 		/*
 		 * @i was greater than @search, return previous node:
 		 *
 		 * if @i was leftmost/smallest element,
-		 * eytzinger0_prev(eytzinger0_first())) returns -1, as expected
+		 * eytzinger1_prev(eytzinger1_first())) returns 0, as expected
 		 */
-		return eytzinger0_prev(i, nr);
-	} else {
-		return i;
+		i = eytzinger1_prev(i, nr);
 	}
+	return i - 1;
 }
 
 static inline int eytzinger0_find_gt(void *base, size_t nr, size_t size,
-- 
2.48.1


