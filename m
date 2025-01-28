Return-Path: <linux-kselftest+bounces-25333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB0BA20ECF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E011884F4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61D31DE3B1;
	Tue, 28 Jan 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akSRlHzo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553C1DE3AC
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082390; cv=none; b=CsT8Hdp4y+1NE3R6CWy7aA1YzHGabYooUEK6aUMsvw1AwsR7FTDIvepNQ2iHJlLBiqrbDfZgXvpSp5Z8ePHYjDMocJJaHAotphvurKZiOGRnkEHYqjdzFIDKF41UbbvrUTkBh9TJ5ElsQGVDcuJPLvANwvPOyhODvhGgFdd6Pgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082390; c=relaxed/simple;
	bh=KsiPRQhSWT9pPQiGEox7uuCGsif9fmMpan+bE+vvNqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZDy/hbQbJVhlgA6MKMZQovZbjgs9pkqJd9UmdLs2PIO/FawhDb8yK+qM+uA0m3MEDEy1/lyi7QdH7Pueinda2sHWBAMrcwjlo35HDvMO0rTaqLP6jG/GKDHhkOf1rN+Iq6JxhBhpbcVQ35U4+vHnO7GKXDhYLWp5uG5527ebuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akSRlHzo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWFaJg/6twIrbICir/G61SugpATzgaIb6ENB42VFtQA=;
	b=akSRlHzobecYOenvJSpl+OKrl/ivaHT+CNnjz/oXO9SPU4OcREMS0tlOihxZVpSKhNKA+R
	ueLk4A5eOA+bf01RHsgyB5ei4Lv7WfF8MgT4Y6yDth0dKU7/dB8BOo8sQHsaoVu5VtKwzW
	MP1ryUor+cg3wYgPM453jQymLa3mBuE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-iEm3Ih-1MnKLU4ItbBFLDA-1; Tue,
 28 Jan 2025 11:39:45 -0500
X-MC-Unique: iEm3Ih-1MnKLU4ItbBFLDA-1
X-Mimecast-MFC-AGG-ID: iEm3Ih-1MnKLU4ItbBFLDA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10F241956087;
	Tue, 28 Jan 2025 16:39:44 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3955F180035E;
	Tue, 28 Jan 2025 16:39:41 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 17/21] bcachefs: add eytzinger0_find_ge tests
Date: Tue, 28 Jan 2025 17:38:54 +0100
Message-ID: <20250128163859.1883260-18-agruenba@redhat.com>
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

Add eytzinger0_find_ge() tests similar to the eytzinger0_find_gt()
tests.

Note that the current implementation of eytzinger0_find_ge() doesn't
always find the first element >= @search, so the tests will occasionally
fail.  The next commit fixes that.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/util.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index d84632870b56..e75329399c6e 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -856,10 +856,48 @@ static void eytzinger0_find_test_gt(u16 *test_array, unsigned nr, u16 search)
 	}
 }
 
+static void eytzinger0_find_test_ge(u16 *test_array, unsigned nr, u16 search)
+{
+	int r, s;
+	bool bad;
+
+	r = eytzinger0_find_ge(test_array, nr,
+			       sizeof(test_array[0]),
+			       cmp_u16, &search);
+	if (r >= 0) {
+		if (test_array[r] < search) {
+			bad = true;
+		} else {
+			s = eytzinger0_prev(r, nr);
+			bad = s >= 0 && test_array[s] >= search;
+		}
+	} else {
+		s = eytzinger0_first(nr);
+		bad = s >= 0 && test_array[s] >= search;
+	}
+
+	if (bad) {
+		s = -1;
+		eytzinger0_for_each(j, nr) {
+			if (test_array[j] >= search) {
+				s = j;
+				break;
+			}
+		}
+
+		eytzinger0_for_each(j, nr)
+			pr_info("[%3u] = %12u\n", j, test_array[j]);
+		pr_info("find_ge(%12u) = %3i should be %3i\n",
+			search, r, s);
+		BUG();
+	}
+}
+
 static void eytzinger0_find_test_val(u16 *test_array, unsigned nr, u16 search)
 {
 	eytzinger0_find_test_le(test_array, nr, search);
 	eytzinger0_find_test_gt(test_array, nr, search);
+	eytzinger0_find_test_ge(test_array, nr, search);
 }
 
 void eytzinger0_find_test(void)
-- 
2.48.1


