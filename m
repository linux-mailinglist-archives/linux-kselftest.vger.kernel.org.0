Return-Path: <linux-kselftest+bounces-25337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB6FA20ED2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442543A5558
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5291DE3BE;
	Tue, 28 Jan 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehtt5vjk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE391DE3BC
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082401; cv=none; b=LoNomRNsQIlni3dYcMd9bNesQzqPaliJ0pzGAIKf4/HEHlrYqCTHFpA9oC9r4DYkkTr3zScS4CJBmYEMeHXwrSNYhNw4ExZFUhY9lke8jOJZupWQQfmKgNFrbTjaIaGfmqAE1OhWhbTxU0/CDHKFXfki0/dIu4C5NJR9pv1olAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082401; c=relaxed/simple;
	bh=YNzhwcYPDLV67byFZgoIbQn00IWONldLlQseNt6ENKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDXrE87gRv5CCB2+VR6xrjrUyPiRBfrWA7tsTFgLaEn3ADM7zPkCUfvze2vG8Rz+4k6DbmBWOQtDS9U2qtvDYPUjwhv84NK7H5oPHucu1zbXC8KEv95I2dxt7KuYaXeDrZ9/KODf9rOJ5SA2Qrv0hAZbR00n7wx+1PUO41f586E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehtt5vjk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/H6mEbuvMQmYWFYf4QRWAbACluB3EmA21tCT2XkWd8=;
	b=ehtt5vjkCV3nAth4TLpFwvoYs8tOrk13EOBQiziznbDGp11trmKxGnIUiz0OcuNDGUgMZu
	Vyhj58NZqC2XeepQB2WbVATJJzxCrSZn1F2ECrgsfpER87du5yiQrzndahb9Ui2dcFRUuU
	knLN0/TO02jFNJLyM1WfQ9rmaXAQIC8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-dYBTKi9lNyaakQnTa0g_mg-1; Tue,
 28 Jan 2025 11:39:54 -0500
X-MC-Unique: dYBTKi9lNyaakQnTa0g_mg-1
X-Mimecast-MFC-AGG-ID: dYBTKi9lNyaakQnTa0g_mg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB4571955DCC;
	Tue, 28 Jan 2025 16:39:53 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 961D518008C0;
	Tue, 28 Jan 2025 16:39:51 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 21/21] bcachefs: eytzinger1_{next,prev} cleanup
Date: Tue, 28 Jan 2025 17:38:58 +0100
Message-ID: <20250128163859.1883260-22-agruenba@redhat.com>
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

From: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>

The eytzinger code was previously relying on the following wrap-around
properties and their "eytzinger0" equivalents:

  eytzinger1_prev(0, size) == eytzinger1_last(size)
  eytzinger1_next(0, size) == eytzinger1_first(size)

However, these properties are no longer relied upon and no longer
necessary, so remove the corresponding asserts and forbid the use of
eytzinger1_prev(0, size) and eytzinger1_next(0, size).

This allows to further simplify the code in eytzinger1_next() and
eytzinger1_prev(): where the left shifting happens, eytzinger1_next() is
trying to move i to the lowest child on the left, which is equivalent to
doubling i until the next doubling would cause it to be greater than
size.  This is implemented by shifting i to the left so that the most
significant bits align and then shifting i to the right by one if the
result is greater than size.

Likewise, eytzinger1_prev() is trying to move to the lowest child on the
right; the same applies here.

The 1-offset in (size - 1) in eytzinger1_next() isn't needed at all, but
the equivalent offset in eytzinger1_prev() is surprisingly needed to
preserve the 'eytzinger1_prev(0, size) == eytzinger1_last(size)'
property.  However, since we no longer support that property, we can get
rid of these offsets as well.  This saves one addition in each function
and makes the code less confusing.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.h | 18 ++++--------------
 fs/bcachefs/util.c      | 12 ------------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/fs/bcachefs/eytzinger.h b/fs/bcachefs/eytzinger.h
index 6a363b12bd21..e600a7d52001 100644
--- a/fs/bcachefs/eytzinger.h
+++ b/fs/bcachefs/eytzinger.h
@@ -59,24 +59,14 @@ static inline unsigned eytzinger1_last(unsigned size)
 	return rounddown_pow_of_two(size + 1) - 1;
 }
 
-/*
- * eytzinger1_next() and eytzinger1_prev() have the nice properties that
- *
- * eytzinger1_next(0) == eytzinger1_first())
- * eytzinger1_prev(0) == eytzinger1_last())
- *
- * eytzinger1_prev(eytzinger1_first()) == 0
- * eytzinger1_next(eytzinger1_last()) == 0
- */
-
 static inline unsigned eytzinger1_next(unsigned i, unsigned size)
 {
-	EYTZINGER_BUG_ON(i > size);
+	EYTZINGER_BUG_ON(i == 0 || i > size);
 
 	if (eytzinger1_right_child(i) <= size) {
 		i = eytzinger1_right_child(i);
 
-		i <<= __fls(size + 1) - __fls(i);
+		i <<= __fls(size) - __fls(i);
 		i >>= i > size;
 	} else {
 		i >>= ffz(i) + 1;
@@ -87,12 +77,12 @@ static inline unsigned eytzinger1_next(unsigned i, unsigned size)
 
 static inline unsigned eytzinger1_prev(unsigned i, unsigned size)
 {
-	EYTZINGER_BUG_ON(i > size);
+	EYTZINGER_BUG_ON(i == 0 || i > size);
 
 	if (eytzinger1_left_child(i) <= size) {
 		i = eytzinger1_left_child(i) + 1;
 
-		i <<= __fls(size + 1) - __fls(i);
+		i <<= __fls(size) - __fls(i);
 		i -= 1;
 		i >>= i > size;
 	} else {
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index e75329399c6e..0257a4c3bb4e 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -713,12 +713,6 @@ void eytzinger1_test(void)
 		if (!(size % 4096))
 			pr_info("tree size %u\n", size);
 
-		BUG_ON(eytzinger1_prev(0, size) != eytzinger1_last(size));
-		BUG_ON(eytzinger1_next(0, size) != eytzinger1_first(size));
-
-		BUG_ON(eytzinger1_prev(eytzinger1_first(size), size)	!= 0);
-		BUG_ON(eytzinger1_next(eytzinger1_last(size), size)	!= 0);
-
 		inorder = 1;
 		eytzinger1_for_each(eytz, size) {
 			BUG_ON(__inorder_to_eytzinger1(inorder, size, extra) != eytz);
@@ -747,12 +741,6 @@ void eytzinger0_test(void)
 		if (!(size % 4096))
 			pr_info("tree size %u\n", size);
 
-		BUG_ON(eytzinger0_prev(-1, size) != eytzinger0_last(size));
-		BUG_ON(eytzinger0_next(-1, size) != eytzinger0_first(size));
-
-		BUG_ON(eytzinger0_prev(eytzinger0_first(size), size)	!= -1);
-		BUG_ON(eytzinger0_next(eytzinger0_last(size), size)	!= -1);
-
 		inorder = 0;
 		eytzinger0_for_each(eytz, size) {
 			BUG_ON(__inorder_to_eytzinger0(inorder, size, extra) != eytz);
-- 
2.48.1


