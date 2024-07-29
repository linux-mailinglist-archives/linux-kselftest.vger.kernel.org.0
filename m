Return-Path: <linux-kselftest+bounces-14347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5558F93EB8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 04:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D229283360
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 02:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7466879B9D;
	Mon, 29 Jul 2024 02:46:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A0A1E49E;
	Mon, 29 Jul 2024 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221181; cv=none; b=iyL3aBtmMA88vaXC9jsyUT49FLihooom9NvzwL9RlqOCHqSbOywkDySc6J8DBvvHW2hCYiOB1Oauvk0y/yr2KD1oQFlO1d+QyeuqlpQjeLvAUUXMc73gWMrOtZyxrNn87P9KcQtqEyomU5V0ysMK/2RMLoNuu36rHc4VSurJsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221181; c=relaxed/simple;
	bh=FSF5xeNzAjX1piM425d0v2L4nVOpwYSnjtMrdLDWcMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e1EwUEyQ/2MoArlpFshnJ2DXpeSuJ6NfTdj8gADZKQU5UjTV0DyGKCBl6h2jsFJIP2XqB1Zr0qDEoF6hDSNJp6E7HBV9Joa/ihkuHxdfDjc8e8xdgcOefpgQ/Qs8UXqXGaLtWzPIvpziWr++6OyZA+Vm+GuoeWGEGKe/VjruhtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WXN142Df4z20krH;
	Mon, 29 Jul 2024 10:42:00 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 432FE1A0190;
	Mon, 29 Jul 2024 10:46:16 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 10:46:15 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <sumit.semwal@linaro.org>, <benjamin.gaignard@collabora.com>,
	<Brian.Starkey@arm.com>, <jstultz@google.com>, <tjmercier@google.com>,
	<shuah@kernel.org>, <wanghaibin.wang@huawei.com>, Zenghui Yu
	<yuzenghui@huawei.com>
Subject: [PATCH v2] kselftests: dmabuf-heaps: Ensure the driver name is null-terminated
Date: Mon, 29 Jul 2024 10:46:04 +0800
Message-ID: <20240729024604.2046-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

While at it, let's check the length of the driver name is exactly 4 bytes
and return early otherwise (in case there is a name like "vgemfoo" that
gets converted to "vgem\0" unexpectedly).

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
* From v1 [1]:
  - Check version.name_len is exactly 4 bytes and return early otherwise

[1] https://lore.kernel.org/r/20240708134654.1725-1-yuzenghui@huawei.com

P.S., Maybe worth including the kselftests file into "DMA-BUF HEAPS
FRAMEWORK" MAINTAINERS entry?

 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 5f541522364f..5d0a809dc2df 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -29,9 +29,11 @@ static int check_vgem(int fd)
 	version.name = name;
 
 	ret = ioctl(fd, DRM_IOCTL_VERSION, &version);
-	if (ret)
+	if (ret || version.name_len != 4)
 		return 0;
 
+	name[4] = '\0';
+
 	return !strcmp(name, "vgem");
 }
 
-- 
2.33.0


