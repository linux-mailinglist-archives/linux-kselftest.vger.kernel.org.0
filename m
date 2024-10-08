Return-Path: <linux-kselftest+bounces-19189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BA3993CF5
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 04:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77CF1F25E0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A1F1E519;
	Tue,  8 Oct 2024 02:37:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A47125A9;
	Tue,  8 Oct 2024 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728355049; cv=none; b=NNVE6zcY4IXaKBR5nAfpOLWNCRaG4Tllr7Tp+vnq34FMsC+BrkQE4BY7wj+evYQ5WIt8IhsCx/YXVqDNk6lfvfpzuLy8bFleZB5ScYa6QYIQGT88OcIKy6gLuLwH4/z/FJKj2Jv/2YIOibh7J07zLv4gh4x6X7RLotxRiDpc050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728355049; c=relaxed/simple;
	bh=MhryKg8t9kCSdejNzP1qUC9XlwaiG2Kq6zfPkvWFk60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dtTML5VZGT2KNn9UNwL7QZpYy941IOlIPbXeRX3EHlcpib/rpvkrjGKPSyBioGGxJELjMJBujfFRgN5Y02rUvxmD9+SEETU2zW289Ul4lGJZ/HQnG1aXf+eHOFhQPEVvcKc1j5fhbtI1GteCRtmxTfP/XK5qfJINt5xSoaDF9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XN0XK5T3zzCt3S;
	Tue,  8 Oct 2024 10:36:49 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 1483A1800CF;
	Tue,  8 Oct 2024 10:37:25 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 10:37:24 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <shuah@kernel.org>
CC: <liaoyu15@huawei.com>, <xiexiuqi@huawei.com>, <Jason@zx2c4.com>,
	<christophe.leroy@csgroup.eu>, <broonie@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] selftests: vDSO: Explicitly include sched.h
Date: Tue, 8 Oct 2024 10:33:32 +0800
Message-ID: <20241008023332.19902-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)

The previous commit introduced the use of CLONE_NEWTIME without including
<sched.h> which contains its definition.

Add an explicit include of <sched.h> to ensure that CLONE_NEWTIME
is correctly defined before it is used.

Fixes: 2aec90036dcd ("selftests: vDSO: ensure vgetrandom works in a time namespace")
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
Changes in v2:
- Include <sched.h> instead of <linux/sched.h>

v1: https://lore.kernel.org/all/20240919111841.20226-1-liaoyu15@huawei.com/

 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 72a1d9b43a84..ddf37e3ab18b 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <time.h>
 #include <unistd.h>
+#include <sched.h>
 #include <signal.h>
 #include <sys/auxv.h>
 #include <sys/mman.h>
-- 
2.33.0


