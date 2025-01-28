Return-Path: <linux-kselftest+bounces-25331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF2A20ECC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1CC3A56E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D8C1DE3BA;
	Tue, 28 Jan 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rvj2adIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4481DE3B1
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082388; cv=none; b=GAa9sGuFG2UAXKXdKpHbQfn2+9Bq6ilVNKK0ID7HVsABP7SMdVIlLd7k+MSUkan1iGMKa8XT7rfjwQmfQJKlg8aPiDPwsRjw/ELoXe93qG1P3SEvy/z5sPSHYu0Ma3/fTSiSZBjMCxekNZGnRU1wCpkSXOBIFMy/wc0WrsFPgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082388; c=relaxed/simple;
	bh=gD2MOqZe8ovnHyS3V8WoY1tpKSobqoC+vaRjGdjO01A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzIbss81m+60DcJu3blH46kuK4tJ2EALCDdvdf9HHFlfvjJAXK+q36iOFL+mArFBzQQGDay4z2mNexIdIKznc8mrgZqdBxxvdFpTJWEXOvpTOI7Xei6qwHD0CSENP5aBzOUbKFDKaAsesJ1Uvag0UU2XP8vPBpOsy7cJVFa3MPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rvj2adIU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zVELwI01VWAwpCtMhLCBjEE0cAM4DjBjLNjy0PGD28=;
	b=Rvj2adIU9kViPCZCqdbjm2FYONQX83fPtson5JZsUMnnHod3+nnrIjDVaplPQgaazAwBKo
	/kYYUJB24JNTfI5lBKfW+6mpxn3CK8Z59khdt7O/dyjF2fbhBIUBtEEZW71oYgtY2JU95L
	DMu9E22w0rc7JeWo0CUanS+fz+y8AlY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-H4hacxvaPoGPcm4bJc962A-1; Tue,
 28 Jan 2025 11:39:40 -0500
X-MC-Unique: H4hacxvaPoGPcm4bJc962A-1
X-Mimecast-MFC-AGG-ID: H4hacxvaPoGPcm4bJc962A
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60A7A19560B7;
	Tue, 28 Jan 2025 16:39:39 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3151C18008C0;
	Tue, 28 Jan 2025 16:39:36 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 15/21] bcachefs: add eytzinger0_find_gt tests
Date: Tue, 28 Jan 2025 17:38:52 +0100
Message-ID: <20250128163859.1883260-16-agruenba@redhat.com>
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

Add eytzinger0_find_gt() tests similar to the eytzinger0_find_le()
tests.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/util.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index c772629783f3..d84632870b56 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -819,9 +819,47 @@ static void eytzinger0_find_test_le(u16 *test_array, unsigned nr, u16 search)
 	}
 }
 
+static void eytzinger0_find_test_gt(u16 *test_array, unsigned nr, u16 search)
+{
+	int r, s;
+	bool bad;
+
+	r = eytzinger0_find_gt(test_array, nr,
+			       sizeof(test_array[0]),
+			       cmp_u16, &search);
+	if (r >= 0) {
+		if (test_array[r] <= search) {
+			bad = true;
+		} else {
+			s = eytzinger0_prev(r, nr);
+			bad = s >= 0 && test_array[s] > search;
+		}
+	} else {
+		s = eytzinger0_first(nr);
+		bad = s >= 0 && test_array[s] > search;
+	}
+
+	if (bad) {
+		s = -1;
+		eytzinger0_for_each(j, nr) {
+			if (test_array[j] > search) {
+				s = j;
+				break;
+			}
+		}
+
+		eytzinger0_for_each(j, nr)
+			pr_info("[%3u] = %12u\n", j, test_array[j]);
+		pr_info("find_gt(%12u) = %3i should be %3i\n",
+			search, r, s);
+		BUG();
+	}
+}
+
 static void eytzinger0_find_test_val(u16 *test_array, unsigned nr, u16 search)
 {
 	eytzinger0_find_test_le(test_array, nr, search);
+	eytzinger0_find_test_gt(test_array, nr, search);
 }
 
 void eytzinger0_find_test(void)
-- 
2.48.1


