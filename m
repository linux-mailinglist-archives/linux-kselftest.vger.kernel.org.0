Return-Path: <linux-kselftest+bounces-22619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6235E9DE696
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 13:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2330528121C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99CE19D06D;
	Fri, 29 Nov 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a2XTX5kb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9469119AA68;
	Fri, 29 Nov 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884008; cv=none; b=eo72ngOBkKUZujtmxCUKNH9NgaFnjKcO49vlItdupXeYAF3mraGJstX3BCM/To0YLZapujRg4BqVfNwLUBmU+bRbpyvSRsfPKIuxQ9Whos6Nb4FXUgEDphdDKQ8N9mhLoIRswIMh68HoqFyJiTmphcb6c8pqndeCRnKHKELwhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884008; c=relaxed/simple;
	bh=4vPipVyS9DaWT9LKbSFhyJUObq0C5SL88ge4vwdZdCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nU1R/mvutg5aaJU1+V4Vk03tlufBEFRUZS7bBWfbWqDtONcv38nyfryuZO2pU+NGbDtGCPkPEMBoWx2Ivl0Vq10FRIPQgHHUK2ZIuRslamKMiOAJL9OfT0ufNlqL9E8xpeuXOaYCGeqGQhd9mnOGDguZpuq6mJ8Cv5LkEjRjlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=a2XTX5kb; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732884007; x=1764420007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pUJY8dTjFf+Uw5/C4D+44Y0A859zY36PuFsL3IHnPw=;
  b=a2XTX5kbJrZnlPalsn0tTuMXMjiRzGepiPlPGKea+k0xKSPy3jfPYn6t
   3AUfYEVztdvnufnvOoB2Owrg4iakNrU3MXS0NMyL0wUlMHFHRNIR9YGR6
   DyvVRh5eFstp9nDzuwneKAC4wtEOBGy5gsqPD1Vvk/AzkrfBOCrr7l+vU
   A=;
X-IronPort-AV: E=Sophos;i="6.12,195,1728950400"; 
   d="scan'208";a="441805293"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 12:40:04 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:12475]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.23.253:2525] with esmtp (Farcaster)
 id 4a00d189-7d5b-47bc-ae41-4835ef36fc4b; Fri, 29 Nov 2024 12:40:03 +0000 (UTC)
X-Farcaster-Flow-ID: 4a00d189-7d5b-47bc-ae41-4835ef36fc4b
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 12:40:02 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 12:40:01 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 29 Nov 2024 12:40:01 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTPS id 6C72CA0379;
	Fri, 29 Nov 2024 12:39:58 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <pbonzini@redhat.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, <michael.day@amd.com>, <david@redhat.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <brijesh.singh@amd.com>,
	<michael.roth@amd.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [RFC PATCH v2 2/2] KVM: selftests: update guest_memfd write tests
Date: Fri, 29 Nov 2024 12:39:29 +0000
Message-ID: <20241129123929.64790-3-kalyazin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241129123929.64790-1-kalyazin@amazon.com>
References: <20241129123929.64790-1-kalyazin@amazon.com>
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
index ce687f8d248f..e10d0f51da93 100644
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
 
 static void test_mmap(int fd, size_t page_size)
@@ -189,7 +261,8 @@ int main(int argc, char *argv[])
 
 	fd = vm_create_guest_memfd(vm, total_size, 0);
 
-	test_file_read_write(fd);
+	test_file_read(fd);
+	test_file_write(fd, total_size);
 	test_mmap(fd, page_size);
 	test_file_size(fd, page_size, total_size);
 	test_fallocate(fd, page_size, total_size);
-- 
2.40.1


