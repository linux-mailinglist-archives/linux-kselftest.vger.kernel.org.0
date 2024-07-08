Return-Path: <linux-kselftest+bounces-13314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512292A3FA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 15:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184E3B2157A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7F2746D;
	Mon,  8 Jul 2024 13:47:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B59413C674;
	Mon,  8 Jul 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446430; cv=none; b=leJgItZ7GbJi7Nk5zc5SGun3K5ZQxqkVV9Ctuvvt/kmyAWB+iI/107HTJE1EJk6pJOIMoN4fjfOmgquEynFd2/hkZGwahjdqkb0kXRTppDYCg7jlic6MiW7IYIkVctFEvaXqS0qhTXPZQYNKAp7DfJlkLrYovA6VCeu1Wjho4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446430; c=relaxed/simple;
	bh=Z2ybd0Usyw2/wpk/t/F+xiGAID0UDg1H3MGfl9My+tM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULwpH/46JRE8r5l6HumMHHZPWIMYDW8UUHkSe5+r96e5ZuWzyRTgPmaCLR485JKL5sKB6e+Gi1bxOFlnC8QZP0q8SfQlJIteUvuapvFaxXggKWxP98SVFpMEJGbUas7b/aXHtiR86GXo3TFJbzOFEbRvFfA0mHpfYHf2volwu0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WHlfw48V3zxVbW;
	Mon,  8 Jul 2024 21:42:32 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id AF0F6180AA6;
	Mon,  8 Jul 2024 21:47:05 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 21:47:04 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <sumit.semwal@linaro.org>, <benjamin.gaignard@collabora.com>,
	<Brian.Starkey@arm.com>, <jstultz@google.com>, <tjmercier@google.com>,
	<shuah@kernel.org>, <wanghaibin.wang@huawei.com>, Zenghui Yu
	<yuzenghui@huawei.com>
Subject: [PATCH] kselftests: dmabuf-heaps: Ensure the driver name is null-terminated
Date: Mon, 8 Jul 2024 21:46:54 +0800
Message-ID: <20240708134654.1725-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Even if a vgem device is configured in, we will skip the import_vgem_fd()
test almost every time.

  TAP version 13
  1..11
  # Testing heap: system
  # =======================================
  # Testing allocation and importing:
  ok 1 # SKIP Could not open vgem -1

The problem is that we use the DRM_IOCTL_VERSION ioctl to query the driver
version information but leave the name field a non-null-terminated string.
Terminate it properly to actually test against the vgem device.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 5f541522364f..2fcc74998fa9 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -32,6 +32,8 @@ static int check_vgem(int fd)
 	if (ret)
 		return 0;
 
+	name[4] = '\0';
+
 	return !strcmp(name, "vgem");
 }
 
-- 
2.33.0


