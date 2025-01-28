Return-Path: <linux-kselftest+bounces-25325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F27A20EC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61EB3A5662
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA13E1DE3A9;
	Tue, 28 Jan 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jG7hpgcW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ECB1DE3A4
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082373; cv=none; b=T/UhD239kKa7R/ORLGrIdpYdI256WSX/B25sS/8VFb2ZCdy83JD/SargjgelwyUiFvSg15OOdX4oNJGNpgSeOGh1nQ4keMMvZzH4xQvH0DMrxg6tRma4iC/gP/ERsqH5Z0VrAeMQzlS/iZPWdYQslG1Wsd9f6C0x/PknoceepaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082373; c=relaxed/simple;
	bh=bWlS4pA1AQioApkfjVizknM0UCXQZYs07W1FkGUHMds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOtWizKY32M94kvRZZsdMSr+BYuCfqx6p8FCmxAZqWQhoXgbnKT9h0J4ol+LwwbxqcoN3TgfRLnqMlkpRW1cK/svfKdcff3JbwZa5X1Cct/mDIA39SG6ouWlgN3bF253FCP+QwUDiQLzbrdPAANVkoTGQL+DNoieDNU+PMEedus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jG7hpgcW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+t5+IyxXZJWdw4WRuFCHidcqeNnjaqNu5ZB+WiJxrw=;
	b=jG7hpgcWyuJMeIJupJt+g9wrKNl/U/7vYmTWqhCXxUqnbVdevVaUt2vwudUVpne79SOcYh
	fMxQ90+HJOiNKAyLYSuiuRNPLeD+bkBPKe66FDmduPujWM4tSjdKHX/kl5Ymiqi3RQ7vKO
	wix4Vh6qws/X2V7Han2qTflZZgrqyBs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-_VAdzJY-NJun8_8Cupr9Lg-1; Tue,
 28 Jan 2025 11:39:26 -0500
X-MC-Unique: _VAdzJY-NJun8_8Cupr9Lg-1
X-Mimecast-MFC-AGG-ID: _VAdzJY-NJun8_8Cupr9Lg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 001D7180188B;
	Tue, 28 Jan 2025 16:39:25 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0653E18008C8;
	Tue, 28 Jan 2025 16:39:22 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 09/21] bcachefs: eytzinger0_find_test improvement
Date: Tue, 28 Jan 2025 17:38:46 +0100
Message-ID: <20250128163859.1883260-10-agruenba@redhat.com>
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

In eytzinger0_find_test(), remember the smallest element seen so far
instead of comparing adjacent array elements.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/util.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 4122012ddfb2..87502e1ac7ce 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -802,15 +802,18 @@ void eytzinger0_find_test(void)
 	u16 *test_array = kmalloc_array(allocated, sizeof(test_array[0]), GFP_KERNEL);
 
 	for (nr = 1; nr < allocated; nr++) {
+		u16 prev = 0;
+
 		pr_info("testing %u elems\n", nr);
 
 		get_random_bytes(test_array, nr * sizeof(test_array[0]));
 		eytzinger0_sort(test_array, nr, sizeof(test_array[0]), cmp_u16, NULL);
 
 		/* verify array is sorted correctly: */
-		eytzinger0_for_each(j, nr)
-			BUG_ON(j != eytzinger0_last(nr) &&
-			       test_array[j] > test_array[eytzinger0_next(j, nr)]);
+		eytzinger0_for_each(j, nr) {
+			BUG_ON(test_array[j] < prev);
+			prev = test_array[j];
+		}
 
 		for (i = 0; i < U16_MAX; i += 1 << 12)
 			eytzinger0_find_test_val(test_array, nr, i);
-- 
2.48.1


