Return-Path: <linux-kselftest+bounces-47784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7102CD3B3D
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 05:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BFFE300B9AE
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 04:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF9821B9C9;
	Sun, 21 Dec 2025 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fugpjq6N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6B2AEE1
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766289664; cv=none; b=qbVan7UmWYTSZ/qua90N8fX+zmMhti3BXXlYS+leTFfL19KSx8GzrWvnN6Ck3eLff5+/oBg5WLLOkwsmenv5vd33bmsreJ6xTu8MeDadrKaIYm65ztqUp0sJsiccdmpoppUG7xBajJfqEiXaxzPCmU8GV1qT9Ob2TrGvurNKoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766289664; c=relaxed/simple;
	bh=+gQAUqBB26/sPqpmvGn1oZ1lGzdsrp0MjH2qyqcurXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtXzEfcBY16Dt4Vl/9/cpMo/Qn735k76ksOYYdJTQrO14q5Gu3pOEEZfUVj2VBEuDFGX0VI8T5peFcGs4v7RZODlavcsIMXcMioaqiKv0AwFIrwMHoO5Z+a61FJOpaXrFc9XXNvMv9wwciVsPdgSLswoq+QspOrLAe1v9G4nJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fugpjq6N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766289661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9qvWdknSv9E7fxj2/6q8B1lq22rZkxKblz4jOQ4Dio=;
	b=Fugpjq6Nz4mv/GVCtHTGF+GGiRalR6vG9R8JBpGxOh2sgHTAIIjxux6JV38m++Lk3NVcmY
	i9HRHFFcLeLCRRX6hFzyjSoj8Thn2OHQVzW3i+QzGNCqEAypVKVX3beDXem50mOznj5GIG
	PyrT+vuUclMOeRCqfEt0fm7WAZImiq4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-q7VyEp1NPOWdFG_vCIl5JA-1; Sat,
 20 Dec 2025 23:00:58 -0500
X-MC-Unique: q7VyEp1NPOWdFG_vCIl5JA-1
X-Mimecast-MFC-AGG-ID: q7VyEp1NPOWdFG_vCIl5JA_1766289656
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F17C1800342;
	Sun, 21 Dec 2025 04:00:56 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4781319560B4;
	Sun, 21 Dec 2025 04:00:49 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	shuah@kernel.org,
	linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	chuhu@redhat.com,
	Luiz Capitulino <luizcap@redhat.com>
Subject: [PATCH v2 4/5] selftests/mm: va_high_addr_switch return fail when either test failed
Date: Sun, 21 Dec 2025 12:00:24 +0800
Message-ID: <20251221040025.3159990-4-chuhu@redhat.com>
In-Reply-To: <20251221040025.3159990-3-chuhu@redhat.com>
References: <20251221040025.3159990-1-chuhu@redhat.com>
 <20251221040025.3159990-2-chuhu@redhat.com>
 <20251221040025.3159990-3-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When the first test failed, and the hugetlb test passed, the result would
be pass, but we expect a fail. Fix this issue by returning fail if either
is not KSFT_PASS.

CC: Luiz Capitulino <luizcap@redhat.com>
Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 tools/testing/selftests/mm/va_high_addr_switch.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
index 02f290a69132..51401e081b20 100644
--- a/tools/testing/selftests/mm/va_high_addr_switch.c
+++ b/tools/testing/selftests/mm/va_high_addr_switch.c
@@ -322,7 +322,7 @@ static int supported_arch(void)
 
 int main(int argc, char **argv)
 {
-	int ret;
+	int ret, hugetlb_ret = KSFT_PASS;
 
 	if (!supported_arch())
 		return KSFT_SKIP;
@@ -331,6 +331,10 @@ int main(int argc, char **argv)
 
 	ret = run_test(testcases, sz_testcases);
 	if (argc == 2 && !strcmp(argv[1], "--run-hugetlb"))
-		ret = run_test(hugetlb_testcases, sz_hugetlb_testcases);
-	return ret;
+		hugetlb_ret = run_test(hugetlb_testcases, sz_hugetlb_testcases);
+
+	if (ret == KSFT_PASS && hugetlb_ret == KSFT_PASS)
+		return KSFT_PASS;
+	else
+		return KSFT_FAIL;
 }
-- 
2.49.0


