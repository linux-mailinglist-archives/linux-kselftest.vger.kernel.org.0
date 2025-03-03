Return-Path: <linux-kselftest+bounces-28050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9359A4C152
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 14:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F101016D31B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E771212B00;
	Mon,  3 Mar 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DZizKf0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD09211297;
	Mon,  3 Mar 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007375; cv=none; b=gkdp1CL1CjpFXt9foKVHb/z+cTaTwuErfPsVUiMhgb3goU+AAJx+zm+IrZj2HVE3xHuWnYeKsBFLWI2wlyj+KCz1nSDWYgMjLxAdSQ2pm6VCvWY8jC5bx9zx67sy7c8ahR2iVLa/9/xj0SF9/RHwj3v/MNk1XYwSDum7gVXoGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007375; c=relaxed/simple;
	bh=Q1BGVztK8kR5/ZW+9TFXncK+fkh6xuxcZierK7FxuQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiLnEerfY3exM4UVjv/pO+IEuNV+QWZdi5E5sVm07Y41git2Buu1DDLphzXo2eib6uCix524xN6YVZzj5BepzC35VnSF6p2d4xJU6gzg3eBsYS8YWbB++6SHOhdYtSiFQmr5EPCbpd1DH0ralKIEz44/SqFQo7bPvaUjPnxXTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DZizKf0I; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741007374; x=1772543374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XKenNyKlzRx3KFaAkl7fAqp0QyjUeRzS8JHs+ogdzvo=;
  b=DZizKf0IR8cY2FWnmqzBNyo4Oz8uVIntq+ZuXoO6qcJJ9WRXU8KHIAwO
   lPXMM6U9lV0jPxyPP0xQpINO03QrMWWJbGW+irYo4LG7cb+cj7Zs8cYyl
   MzdKiwOrCEPQDK0MBkcddzEZvTwx5ZIgBSm8M7pjIBgC8RAIIoe7VR+Dw
   U=;
X-IronPort-AV: E=Sophos;i="6.13,329,1732579200"; 
   d="scan'208";a="701674208"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:09:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:55265]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.48:2525] with esmtp (Farcaster)
 id f7436fc3-0ba0-4ad2-aabb-25e5142b6a4d; Mon, 3 Mar 2025 13:09:09 +0000 (UTC)
X-Farcaster-Flow-ID: f7436fc3-0ba0-4ad2-aabb-25e5142b6a4d
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:09:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:09:05 +0000
Received: from email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:09:05 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com (Postfix) with ESMTPS id 2E5D640513;
	Mon,  3 Mar 2025 13:09:03 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michael.day@amd.com>, <david@redhat.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <brijesh.singh@amd.com>,
	<michael.roth@amd.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [v3 PATCH 2/2] KVM: selftests: update guest_memfd write tests
Date: Mon, 3 Mar 2025 13:08:38 +0000
Message-ID: <20250303130838.28812-3-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303130838.28812-1-kalyazin@amazon.com>
References: <20250303130838.28812-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

This is to reflect that the write syscall is now implemented for
guest_memfd.

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 85 +++++++++++++++++--
 1 file changed, 79 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 38c501e49e0e..b07221aa54c9 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -20,18 +20,90 @@
 #include "kvm_util.h"
 #include "test_util.h"
 
-static void test_file_read_write(int fd)
+static void test_file_read(int fd)
 {
 	char buf[64];
 
 	TEST_ASSERT(read(fd, buf, sizeof(buf)) < 0,
 		    "read on a guest_mem fd should fail");
-	TEST_ASSERT(write(fd, buf, sizeof(buf)) < 0,
-		    "write on a guest_mem fd should fail");
 	TEST_ASSERT(pread(fd, buf, sizeof(buf), 0) < 0,
 		    "pread on a guest_mem fd should fail");
-	TEST_ASSERT(pwrite(fd, buf, sizeof(buf), 0) < 0,
-		    "pwrite on a guest_mem fd should fail");
+}
+
+static void test_file_write(int fd, size_t total_size)
+{
+	size_t page_size = getpagesize();
+	void *buf = NULL;
+	int ret;
+
+	ret = posix_memalign(&buf, page_size, total_size);
+	TEST_ASSERT_EQ(ret, 0);
+
+	/* Check arguments correctness checks work as expected */
+
+	ret = pwrite(fd, buf, page_size - 1, 0);
+	TEST_ASSERT(ret == -1, "write unaligned count on a guest_mem fd should fail");
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	ret = pwrite(fd, buf, page_size, 1);
+	TEST_ASSERT(ret == -1, "write unaligned offset on a guest_mem fd should fail");
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	ret = pwrite(fd, buf, page_size, total_size);
+	TEST_ASSERT(ret == -1, "writing past the file size on a guest_mem fd should fail");
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	ret = pwrite(fd, NULL, page_size, 0);
+	TEST_ASSERT(ret == -1, "supplying a NULL buffer when writing a guest_mem fd should fail");
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Check double population is not allowed */
+
+	ret = pwrite(fd, buf, page_size, 0);
+	TEST_ASSERT(ret == page_size, "page-aligned write on a guest_mem fd should succeed");
+
+	ret = pwrite(fd, buf, page_size, 0);
+	TEST_ASSERT(ret == -1, "write on already populated guest_mem fd should fail");
+	TEST_ASSERT_EQ(errno, ENOSPC);
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	/* Check population is allowed again after punching a hole */
+
+	ret = pwrite(fd, buf, page_size, 0);
+	TEST_ASSERT(ret == page_size, "page-aligned write on a punched guest_mem fd should succeed");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	/* Check population of already allocated memory is allowed */
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, page_size);
+	TEST_ASSERT(!ret, "fallocate with aligned offset and size should succeed");
+
+	ret = pwrite(fd, buf, page_size, 0);
+	TEST_ASSERT(ret == page_size, "write on a preallocated guest_mem fd should succeed");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	/* Check population works until an already populated page is encountered */
+
+	ret = pwrite(fd, buf, total_size, 0);
+	TEST_ASSERT(ret == total_size, "page-aligned write on a guest_mem fd should succeed");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	ret = pwrite(fd, buf, total_size, 0);
+	TEST_ASSERT(ret == page_size, "write on a guest_mem fd should not overwrite data");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, total_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+
+	free(buf);
 }
 
 static void test_mmap_allowed(int fd, size_t total_size)
@@ -233,7 +305,8 @@ void test_vm_type(unsigned long type, bool is_shared)
 
 	fd = vm_create_guest_memfd(vm, total_size, 0);
 
-	test_file_read_write(fd);
+	test_file_read(fd);
+	test_file_write(fd, total_size);
 
 	if (is_shared)
 		test_mmap_allowed(fd, total_size);
-- 
2.47.1


