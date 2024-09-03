Return-Path: <linux-kselftest+bounces-18205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555E97E63A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 08:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA6F1F215B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 06:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B4286A3;
	Mon, 23 Sep 2024 06:55:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F628689;
	Mon, 23 Sep 2024 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074548; cv=none; b=CCHEvTi+pf2qwONztC1SkCapUYjTF0V8eAUgARHHQLZcBAxCrhAzf7VcII4Ul8xim+QNh7GadvH6nTI5Efrf3x9VeSBaFblLtEf3Fp4yogYgBFtz+RaaQG5tladK8mHRrGStsTcuDxyC29lrOpkSMEJVm7bujp9gWLq+EpRmwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074548; c=relaxed/simple;
	bh=ZDIRqO6WtG6HsS5yy9N8e+xwUiik5Ry/e6KsvBLs3eU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYBKYiFOiccHp4JOSZm7q/pJmZD/bnn7wcHILgpgnHBv8JyjfwkILX9LKSP/s9g5U5iSIfEbXb/pWePqmziVmtHQ8+o++N+ME567fsDXxcoqb1EwgZ9rMjl3cwsk0Y4niOYlEVJldTu8JtxFqI8t2tL3XJft+nDaXG9bKnUXMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666f11032eb5-46778;
	Mon, 23 Sep 2024 14:52:35 +0800 (CST)
X-RM-TRANSID:2ee666f11032eb5-46778
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166f11022dbd-5453d;
	Mon, 23 Sep 2024 14:52:35 +0800 (CST)
X-RM-TRANSID:2ee166f11022dbd-5453d
From: Ba Jing <bajing@cmss.chinamobile.com>
To: brauner@kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] clone3: clone3_cap_checkpoint_restore: remove unused MAX_PID_NS_LEVEL macro
Date: Tue,  3 Sep 2024 11:36:28 +0800
Message-Id: <20240903033628.10306-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro MAX_PID_NS_LEVEL is never referenced in the code, so remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 31b56d625655..3c196fa86c99 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -27,8 +27,6 @@
 #include "../kselftest_harness.h"
 #include "clone3_selftests.h"
 
-#define MAX_PID_NS_LEVEL 32
-
 static void child_exit(int ret)
 {
 	fflush(stdout);
-- 
2.33.0




