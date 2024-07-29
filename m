Return-Path: <linux-kselftest+bounces-14356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F9693EF8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2102C1C21E14
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C88139580;
	Mon, 29 Jul 2024 08:12:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AC78C98;
	Mon, 29 Jul 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240761; cv=none; b=imcKzmOWo3ioikGzGp9BHuxHfhmjsjkWd+g4r2VsrXFcka5/xTnx7j9ttBi6iBAJ7r0xntY7bdjXy4vvoFFjOzZXdyoPPjv2H+sW1NnvPe/QBuudzClN3r0s0II7R8fpNmW4Lfi1iE0d5Ny2z0Agu6Ve4B8rIwKbq2rttziQdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240761; c=relaxed/simple;
	bh=fbee8ZvgQqqsI9NkcJnrSLLkFeWKBCsg5hBSBrT+o8Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pTSzaJOdy1NmMn0peqT34HcAv4Ns+z64Z0skE6QBpUH3foBNTwIOOajP5VzRG11b6LhjiYOqKGofS493iCKnROddTF+cRcsw8PQIS5ydBgJSrQjIzUKZP541eYoUk7QOkyCBFNlFiDSopzux2veghT6SvhqxmlIDa5XlCvusfnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WXWFG3YGrz2Clf0;
	Mon, 29 Jul 2024 16:08:02 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id B71A81400DB;
	Mon, 29 Jul 2024 16:12:33 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 16:12:32 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <sumit.semwal@linaro.org>, <benjamin.gaignard@collabora.com>,
	<Brian.Starkey@arm.com>, <jstultz@google.com>, <tjmercier@google.com>,
	<shuah@kernel.org>, <daniel.vetter@ffwll.ch>, <wanghaibin.wang@huawei.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] MAINTAINERS: Add selftests to DMA-BUF HEAPS FRAMEWORK entry
Date: Mon, 29 Jul 2024 16:12:02 +0800
Message-ID: <20240729081202.937-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Include dmabuf-heaps selftests in the correct entry so that updates to it
can be sent to the right place.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..b7f24c9fb0e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6660,6 +6660,7 @@ F:	drivers/dma-buf/dma-heap.c
 F:	drivers/dma-buf/heaps/*
 F:	include/linux/dma-heap.h
 F:	include/uapi/linux/dma-heap.h
+F:	tools/testing/selftests/dmabuf-heaps/
 
 DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422
 M:	Lukasz Luba <lukasz.luba@arm.com>
-- 
2.33.0


