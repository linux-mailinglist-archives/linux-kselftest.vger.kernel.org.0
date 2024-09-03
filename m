Return-Path: <linux-kselftest+bounces-17108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE5096B180
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 08:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB99285F86
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 06:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1F132117;
	Wed,  4 Sep 2024 06:26:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA32D12CD88;
	Wed,  4 Sep 2024 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431197; cv=none; b=qVtjJAjPHhlu19+GfSw7JpjM/QlZ8EdGEbPuEShGIcdidBJ+Q+HLUSPR05ZIbnRpIsRWf978FrfQlu/4KdLTJvLYs9LLxXfRaUXbtY7+QOLeZH0NYMBy7+GZ1QUu7jLaHmVD4lJROdJO8iYiCaEI5FFnmRuIWluoMzf3du+Zcyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431197; c=relaxed/simple;
	bh=5dFgjk/oabilpVeol8G0eWL9U9/xLN3c1TXk+PgZ3AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nVcJ1UzelB5MQBpSpn5LXcLJgc+a2WTpooH9QEqkWoPXgd8dpDoKV9e8QDAvq7R7dSdFZFRu9VwHXoAWriuzBi+y9cE3Yg5txvsmfcUBn6LPBGdQo7jlX9nLq9qlDmqmoLZpwLvOOG7YlBoakkSuSfSic1oq7lh2YnsC0w3oaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466d7fd8fcc5-b35b9;
	Wed, 04 Sep 2024 14:26:25 +0800 (CST)
X-RM-TRANSID:2ee466d7fd8fcc5-b35b9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66d7fd908e5-15f73;
	Wed, 04 Sep 2024 14:26:24 +0800 (CST)
X-RM-TRANSID:2eea66d7fd908e5-15f73
From: Liu Jing <liujing@cmss.chinamobile.com>
To: jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	shuah@kernel.org,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] iommufd/selftest:fix a resource leak
Date: Wed,  4 Sep 2024 04:08:06 +0800
Message-Id: <20240903200806.9803-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the file fails to open, not only return return1 but also close the file descriptor,otherwise resource
leak will occur

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 .../selftests/iommu/iommufd_fail_nth.c        | 143 ++++++++++--------
 1 file changed, 83 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index c5d5e69452b0..ff4e5d8aad57 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -237,10 +237,10 @@ TEST_FAIL_NTH(basic_fail_nth, basic)
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
-		return -1;
+		goto close;
 
 	{
 		struct iommu_ioas_iova_ranges ranges_cmd = {
@@ -250,7 +250,7 @@ TEST_FAIL_NTH(basic_fail_nth, basic)
 			.allowed_iovas = (uintptr_t)ranges,
 		};
 		if (ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd))
-			return -1;
+			goto close;
 	}
 
 	{
@@ -264,13 +264,13 @@ TEST_FAIL_NTH(basic_fail_nth, basic)
 		ranges[0].start = 16*1024;
 		ranges[0].last = BUFFER_SIZE + 16 * 1024 * 600 - 1;
 		if (ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd))
-			return -1;
+			goto close;
 	}
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
 				 IOMMU_IOAS_MAP_WRITEABLE |
 					 IOMMU_IOAS_MAP_READABLE))
-		return -1;
+		goto close;
 
 	{
 		struct iommu_ioas_copy copy_cmd = {
@@ -284,15 +284,19 @@ TEST_FAIL_NTH(basic_fail_nth, basic)
 		};
 
 		if (ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd))
-			return -1;
+			goto close;
 	}
 
 	if (_test_ioctl_ioas_unmap(self->fd, ioas_id, iova, BUFFER_SIZE,
 				   NULL))
-		return -1;
+		goto close;
 	/* Failure path of no IOVA to unmap */
 	_test_ioctl_ioas_unmap(self->fd, ioas_id, iova, BUFFER_SIZE, NULL);
 	return 0;
+
+close:
+	close(self->fd);
+	return -1;
 }
 
 /* iopt_area_fill_domains() and iopt_area_fill_domain() */
@@ -305,30 +309,33 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
-		return -1;
+		goto close;
 
 	fail_nth_enable();
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
 				 IOMMU_IOAS_MAP_WRITEABLE |
 					 IOMMU_IOAS_MAP_READABLE))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_destroy(self->fd, stdev_id))
-		return -1;
+		goto close;
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
-		return -1;
+		goto close;
 	return 0;
+close:
+	close(self->fd);
+	return -1;
 }
 
 TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
@@ -342,40 +349,43 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
-		return -1;
+		goto close;
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
-		return -1;
+		goto close;
 
 	fail_nth_enable();
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
 				  NULL))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
 				 IOMMU_IOAS_MAP_WRITEABLE |
 					 IOMMU_IOAS_MAP_READABLE))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_destroy(self->fd, stdev_id))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_destroy(self->fd, stdev_id2))
-		return -1;
+		goto close;
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
-		return -1;
+		goto close;
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
 				  NULL))
-		return -1;
+		goto close;
 	return 0;
+close:
+	close(self->fd);
+	return -1;
 }
 
 TEST_FAIL_NTH(basic_fail_nth, access_rw)
@@ -387,23 +397,23 @@ TEST_FAIL_NTH(basic_fail_nth, access_rw)
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
 				 IOMMU_IOAS_MAP_WRITEABLE |
 					 IOMMU_IOAS_MAP_READABLE))
-		return -1;
+		goto close;
 
 	fail_nth_enable();
 
 	if (_test_cmd_create_access(self->fd, ioas_id, &self->access_id, 0))
-		return -1;
+		goto close;
 
 	{
 		struct iommu_test_cmd access_cmd = {
@@ -418,22 +428,22 @@ TEST_FAIL_NTH(basic_fail_nth, access_rw)
 		// READ
 		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
 			  &access_cmd))
-			return -1;
+			goto close;
 
 		access_cmd.access_rw.flags = MOCK_ACCESS_RW_WRITE;
 		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
 			  &access_cmd))
-			return -1;
+			goto close;
 
 		access_cmd.access_rw.flags = MOCK_ACCESS_RW_SLOW_PATH;
 		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
 			  &access_cmd))
-			return -1;
+			goto close;
 		access_cmd.access_rw.flags = MOCK_ACCESS_RW_SLOW_PATH |
 					     MOCK_ACCESS_RW_WRITE;
 		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
 			  &access_cmd))
-			return -1;
+			goto close;
 	}
 
 	{
@@ -449,12 +459,15 @@ TEST_FAIL_NTH(basic_fail_nth, access_rw)
 
 		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
 			  &access_cmd))
-			return -1;
+			goto close;
 	}
 	if (_test_cmd_destroy_access(self->access_id))
 		return -1;
 	self->access_id = 0;
 	return 0;
+close:
+	close(self->fd);
+	return -1;
 }
 
 /* pages.c access functions */
@@ -466,22 +479,22 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin)
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
 				 IOMMU_IOAS_MAP_WRITEABLE |
 					 IOMMU_IOAS_MAP_READABLE))
-		return -1;
+		goto close;
 
 	if (_test_cmd_create_access(self->fd, ioas_id, &self->access_id,
 				    MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES))
-		return -1;
+		goto close;
 
 	fail_nth_enable();
 
@@ -497,18 +510,21 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin)
 
 		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
 			  &access_cmd))
-			return -1;
+			goto close;
 		access_pages_id = access_cmd.access_pages.out_access_pages_id;
 	}
 
 	if (_test_cmd_destroy_access_pages(self->fd, self->access_id,
 					   access_pages_id))
-		return -1;
+		goto close;
 
 	if (_test_cmd_destroy_access(self->access_id))
 		return -1;
 	self->access_id = 0;
 	return 0;
+close:
+	close(self->fd);
+	return -1;
 }
 
 /* iopt_pages_fill_xarray() */
@@ -522,25 +538,25 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
-		return -1;
+		goto close;
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
 				 IOMMU_IOAS_MAP_WRITEABLE |
 					 IOMMU_IOAS_MAP_READABLE))
-		return -1;
+		goto close;
 
 	if (_test_cmd_create_access(self->fd, ioas_id, &self->access_id,
 				    MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES))
-		return -1;
+		goto close;
 
 	fail_nth_enable();
 
@@ -556,21 +572,24 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 
 		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
 			  &access_cmd))
-			return -1;
+			goto close;
 		access_pages_id = access_cmd.access_pages.out_access_pages_id;
 	}
 
 	if (_test_cmd_destroy_access_pages(self->fd, self->access_id,
 					   access_pages_id))
-		return -1;
+		goto close;
 
 	if (_test_cmd_destroy_access(self->access_id))
 		return -1;
 	self->access_id = 0;
 
 	if (_test_ioctl_destroy(self->fd, stdev_id))
-		return -1;
+		goto close;
 	return 0;
+close:
+	close(self->fd);
+	return -1;
 }
 
 /* device.c */
@@ -586,45 +605,49 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
-		return -1;
+		goto close;
 
 	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id2))
-		return -1;
+		goto close;
 
 	iova = MOCK_APERTURE_START;
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, PAGE_SIZE, &iova,
 				 IOMMU_IOAS_MAP_FIXED_IOVA |
 					 IOMMU_IOAS_MAP_WRITEABLE |
 					 IOMMU_IOAS_MAP_READABLE))
-		return -1;
+		goto close;
 	if (_test_ioctl_ioas_map(self->fd, ioas_id2, buffer, PAGE_SIZE, &iova,
 				 IOMMU_IOAS_MAP_FIXED_IOVA |
 					 IOMMU_IOAS_MAP_WRITEABLE |
 					 IOMMU_IOAS_MAP_READABLE))
-		return -1;
+		goto close;
 
 	fail_nth_enable();
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL,
 				  &idev_id))
-		return -1;
+		goto close;
 
 	if (_test_cmd_get_hw_info(self->fd, idev_id, &info, sizeof(info), NULL))
-		return -1;
+		goto close;
 
 	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, 0, &hwpt_id,
 				 IOMMU_HWPT_DATA_NONE, 0, 0))
-		return -1;
+		goto close;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
-		return -1;
+		goto close;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, hwpt_id, NULL))
-		return -1;
+		goto close;
 	return 0;
+close:
+	close(self->fd);
+	return -1;
+
 }
 
 TEST_HARNESS_MAIN
-- 
2.33.0




