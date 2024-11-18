Return-Path: <linux-kselftest+bounces-22165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B69D0821
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 04:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B5D1F21CBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 03:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C8282E1;
	Mon, 18 Nov 2024 03:15:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1452C81E;
	Mon, 18 Nov 2024 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731899735; cv=none; b=tN5sQlbQ5InE0mjjzuz8Kn8YQEZg5sPJdidHZ8XpYooWV2pyANw+SWRx0Imr89VaDSPKdnZDn+LfonfiJ9Nb3GyQg4734dg0HqCEytZUE84JzScrTMerB5RcwVS+Ieuvb+mHRp+EyvD/wj809kK8I1piIXFeXPRMeST0emOZJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731899735; c=relaxed/simple;
	bh=w1qxhsXl8XNFjekIRAAEivDUwiyXVGbnjK+lzNbasi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2+nuEpjbcjbc+R4LzuWz1zGrju1/YZh6j9MTG+/+L4H2315/XnVGWApKSLaITD75GFT3ymbu/NoFQE0W3pbwQM4icaRIq9psQtt918WB+ZV4pd/tVHxpmdZ42qS+QizxLr8DZtlkY6UQpG2saPl+YyF3F5Dc7hEK2ZYUncQMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4673ab14ad20-0d629;
	Mon, 18 Nov 2024 11:15:22 +0800 (CST)
X-RM-TRANSID:2ee4673ab14ad20-0d629
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3673ab13cc84-ad126;
	Mon, 18 Nov 2024 11:15:22 +0800 (CST)
X-RM-TRANSID:2ee3673ab13cc84-ad126
From: Ba Jing <bajing@cmss.chinamobile.com>
To: pbonzini@redhat.com
Cc: shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] kvm: hardware_disable_test: remove unused macro
Date: Mon, 18 Nov 2024 11:15:02 +0800
Message-Id: <20241118031502.2102-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After reviewing the code, it was found that the macro GUEST_CODE_PIO_PORT
is never referenced in the code. Just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/kvm/hardware_disable_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index bce73bcb973c..94bd6ed24cf3 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -20,7 +20,6 @@
 #define SLEEPING_THREAD_NUM (1 << 4)
 #define FORK_NUM (1ULL << 9)
 #define DELAY_US_MAX 2000
-#define GUEST_CODE_PIO_PORT 4
 
 sem_t *sem;
 
-- 
2.33.0




