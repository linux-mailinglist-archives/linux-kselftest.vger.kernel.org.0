Return-Path: <linux-kselftest+bounces-18129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3383197C892
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 13:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6E92881B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A0D19B3C3;
	Thu, 19 Sep 2024 11:22:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94E19D075
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744961; cv=none; b=E7FWZIqU4Daeg8WEMKOjT9GkfieTTilUY80hYW/ifzxzFpG8WTdLXUrXIIeyoej4OoQ0eD1b+ogyLNW01i2z9lAHG39HQuRxrc3Jpy4Zjt0qPKMbUc6/JV8mbly666XLrlWeHNG8KgbwzcFrI4nxedw20ODKHlUVc8zgqXFCZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744961; c=relaxed/simple;
	bh=9q4A+BpOjGXxp4crxWgi8OHCzkTKTnJftfdJ+o0I4fQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R169z3NpoG4D4O1BChKAwjJ8hft007211m0lR7chYM5LKmiRMSL6xvfSWtdYPZRx4AoBcTXk8JaPWGpszzHs3gMKxWYN2Vpla4go+JBRjZkgJ2A8P/avRNNI5FMQO8tsAGMwozd98xCrFrY26zEmdGO+1/9UsZHTmkZjOYYc3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X8Y4j3cHXzyRpQ;
	Thu, 19 Sep 2024 19:21:41 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B90D140134;
	Thu, 19 Sep 2024 19:22:36 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Sep
 2024 19:22:35 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <shuah@kernel.org>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>, <Jason@zx2c4.com>,
	<christophe.leroy@csgroup.eu>, <broonie@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH] selftests: vDSO: fix compile error for vdso_test_getrandom
Date: Thu, 19 Sep 2024 19:18:41 +0800
Message-ID: <20240919111841.20226-1-liaoyu15@huawei.com>
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

When building selftests/vDSO:
$ make -C tools/testing/selftests TARGETS=vDSO
I hit the following compilation error:

  vdso_test_getrandom.c:260:17: error: 'CLONE_NEWTIME' undeclared
  (first use in this function); did you mean 'CLONE_NEWIPC'?
    260 |  assert(unshare(CLONE_NEWTIME) == 0);
        |                 ^~~~~~~~~~~~~

CLONE_NEWTIME is defined in linux/sched.h, so fix this by including
<linux/sched.h>.

Fixes: 2aec90036dcd ("selftests: vDSO: ensure vgetrandom works in a time namespace")
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 72a1d9b43a84..84f2bbb2d5e0 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -19,6 +19,7 @@
 #include <sys/ptrace.h>
 #include <sys/wait.h>
 #include <sys/types.h>
+#include <linux/sched.h>
 #include <linux/random.h>
 #include <linux/compiler.h>
 #include <linux/ptrace.h>
-- 
2.33.0


