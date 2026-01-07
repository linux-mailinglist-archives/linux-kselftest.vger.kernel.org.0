Return-Path: <linux-kselftest+bounces-48386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C781CFCE66
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 10:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 483C7301EFF3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9F30748B;
	Wed,  7 Jan 2026 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="x6NoTkP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32D305046;
	Wed,  7 Jan 2026 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777974; cv=none; b=nB45T3ZFxeC07/4lMvobVVa30hTskfccTc6iyULceo7Z9Lnp252cJCpaJ6g6U05f7oWg0V81dp3nBzV9sQn7pxoiVDJJQeoOHkq0uAq7BaqxOa2M7jyQWYHCk23gGcyoVR9SRqIzTh1izMFDr6CuLTa8K3tJgNAvJXH3SBdDly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777974; c=relaxed/simple;
	bh=UVNaZyOPwKTnYlmZrI7llgAYO55dvCZcTSKhqFFyApE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3GZmf1piYt/9/oswyKfleVw/KZG0C7dewCSAicGw2N7YsaJrze1wXU/PbJ2qIG5XxlDsOt1hbvSrkozDBWnkFGwNP6OGkAN6zi2xZjURuX640tXBcYVVpr8DzAIW6DzzyLi8cYhlbfL2Iz7bMp4oPO0vO4dJUjXmAzYp0Psfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=x6NoTkP2; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QdA7XvgLoWm60aQUE7Q0jUzx2rLp0cqWsZwG36r5gHk=;
	b=x6NoTkP2vUXNi06Ad8aDcxoarEMnBZrylRz/gspddPAupT76sZQgUF/vFJ0pJsDLOAM0gndVM
	N8hQV04E+dyt61aDKpFkJMngjfrIKjOgK0RNFBoq6vT6WSri87toUQu56cSj2BX3BxnoB81kMcq
	k5ogkGBxUdf2PTg1Y4+g0v0=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dmMyc6zkWz12LFj;
	Wed,  7 Jan 2026 17:23:04 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 463E240538;
	Wed,  7 Jan 2026 17:26:09 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 17:26:09 +0800
Received: from huawei.com (10.173.125.37) by kwepemq500010.china.huawei.com
 (7.202.194.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 7 Jan
 2026 17:26:08 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <shuah@kernel.org>
CC: <david@kernel.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <nao.horiguchi@gmail.com>,
	<linmiaohe@huawei.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH 2/3] selftests/mm: add memory failure clean pagecache test
Date: Wed, 7 Jan 2026 17:37:09 +0800
Message-ID: <20260107093710.3928374-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260107093710.3928374-1-linmiaohe@huawei.com>
References: <20260107093710.3928374-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

This patch adds a new testcase to validate memory failure handling for
clean pagecache. This test performs similar operations as anonymous
pages except allocating memory using mmap() with a file fd.

This test helps ensure that memory failure handling for clean pagecache
works correctly, including unchanged page content, page isolation, and
recovery paths.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 tools/testing/selftests/mm/memory-failure.c | 46 +++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/mm/memory-failure.c b/tools/testing/selftests/mm/memory-failure.c
index 37806a58f4b4..41bc669cef60 100644
--- a/tools/testing/selftests/mm/memory-failure.c
+++ b/tools/testing/selftests/mm/memory-failure.c
@@ -10,6 +10,7 @@
 #include <sys/mman.h>
 #include <linux/mman.h>
 #include <linux/string.h>
+#include <unistd.h>
 #include <signal.h>
 #include <setjmp.h>
 #include <unistd.h>
@@ -24,7 +25,9 @@ enum inject_type {
 
 enum result_type {
 	MADV_HARD_ANON,
+	MADV_HARD_CLEAN_PAGECACHE,
 	MADV_SOFT_ANON,
+	MADV_SOFT_CLEAN_PAGECACHE,
 };
 
 static jmp_buf signal_jmp_buf;
@@ -154,6 +157,8 @@ static void check(struct __test_metadata *_metadata, FIXTURE_DATA(memory_failure
 
 	switch (type) {
 	case MADV_SOFT_ANON:
+	case MADV_HARD_CLEAN_PAGECACHE:
+	case MADV_SOFT_CLEAN_PAGECACHE:
 		/* It is not expected to receive a SIGBUS signal. */
 		ASSERT_EQ(setjmp, 0);
 
@@ -236,4 +241,45 @@ TEST_F(memory_failure, anon)
 	ASSERT_EQ(munmap(addr, self->page_size), 0);
 }
 
+TEST_F(memory_failure, clean_pagecache)
+{
+	const char *fname = "./clean-page-cache-test-file";
+	int fd;
+	char *addr;
+	int ret;
+
+	fd = open(fname, O_RDWR | O_CREAT, 0664);
+	if (fd < 0)
+		SKIP(return, "failed to open test file.\n");
+	unlink(fname);
+	ftruncate(fd, self->page_size);
+
+	addr = mmap(0, self->page_size, PROT_READ | PROT_WRITE,
+		    MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED)
+		SKIP(return, "mmap failed, not enough memory.\n");
+	memset(addr, 0xce, self->page_size);
+	fsync(fd);
+
+	prepare(_metadata, self, addr);
+
+	ret = sigsetjmp(signal_jmp_buf, 1);
+	if (!self->triggered) {
+		self->triggered = true;
+		ASSERT_EQ(variant->inject(self, addr), 0);
+		FORCE_READ(*addr);
+	}
+
+	if (variant->type == MADV_HARD)
+		check(_metadata, self, addr, MADV_HARD_CLEAN_PAGECACHE, ret);
+	else
+		check(_metadata, self, addr, MADV_SOFT_CLEAN_PAGECACHE, ret);
+
+	cleanup(_metadata, self, addr);
+
+	ASSERT_EQ(munmap(addr, self->page_size), 0);
+
+	ASSERT_EQ(close(fd), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.33.0


