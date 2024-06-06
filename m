Return-Path: <linux-kselftest+bounces-11291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7005C8FE842
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D42428543B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2D19643E;
	Thu,  6 Jun 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="BDWcwQmU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399E195998;
	Thu,  6 Jun 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682324; cv=none; b=pjN2yk0HNudjeS6QJNpzcZcIWhcdCwWXYXdf2AQkJwIXoPWq+TfDMugbCXutCYwoyFY4u1dTTgPRaOyVA6mxN5+2B01k6TMq5Sipb7zQuVaOhFGTR9p7JlOxM5zijvWakIqk7Dykn6VtVpt5N7XgyiWZ1r5j+x4IBTgHA89O+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682324; c=relaxed/simple;
	bh=MkKdWp1DH6rZYpVhyfrhbNRL1RdkZrfVr8CnJwLN9B4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XugVzE/WMdebDrruvFPC4lRqjeS1zH4Fo2+cpveGCRk4jXrl8Z9e9dGs714xkKGqLlWsX4dM60arP5AP8swnhGWHS/ND8G9EslKdIwsu/kYvxgaqDDL5KaaWd1/pfSKJCi8e3nmfSQLi/0D8vxKlSWIrBEtPVkHhhAbQJWYQD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=BDWcwQmU; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Vw5XG22d5z9sNf;
	Thu,  6 Jun 2024 15:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717682318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1iDkPnfnZMS40yIV9/CmRJHkK83eQzknGbWpCBWUML0=;
	b=BDWcwQmU75+ss4BO0UXwg1SIFt9vMRwYX5YqWN8mqqeYift6qlgeRYT4m5OGzYFg7JZAMv
	K+jqqNpQsLZEmbBDY6tO+1DWfqKKt04KoqsbREZc+D6U7GzTx3IEmExZSaVpas2ORRenoU
	vxtCLOUutow5aM49q2OJkynjbO0GYw/J/39k0o8U2AZtDb+RNmieKb0GwX3QypCQHrldD4
	pQVZO5abZZHkJL4hmbTWjIqRNca3XmivhdP9ux6D/Hl2nJR7xu/BavANcq3ovyvVvmi6Hd
	Obz33AcwjtkUbviEk1RrPnvKW6ztoxo4bLtGuWQ5TV7V7oNKM846A4LwFI8IEQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel@pankajraghav.com,
	gost.dev@samsung.com,
	mcgrof@kernel.org,
	linux-kselftest@vger.kernel.org,
	Zi Yan <zi.yan@sent.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] selftests/mm: use volatile keyword to not optimize mmap read variable
Date: Thu,  6 Jun 2024 13:58:35 +0000
Message-ID: <20240606135835.600022-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

create_pagecache_thp_and_fd() in split_huge_page_test.c used the
variable dummy to perform mmap read.

However, this test was skipped even on XFS which has large folio
support. The issue was compiler (gcc 13.2.0) was optimizing out the
dummy variable, therefore, not creating huge page in the page cache.

Add volatile keyword to force compiler not to optimize out the loop
where we read from the mmaped addr.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index d3c7f5fb3e7b..c573a58f80ab 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 		char **addr)
 {
 	size_t i;
-	int __attribute__((unused)) dummy = 0;
+	volatile int __attribute__((unused)) dummy = 0;
 
 	srand(time(NULL));
 

base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
-- 
2.44.1


