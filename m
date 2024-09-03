Return-Path: <linux-kselftest+bounces-18209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9997E6E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 09:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357D71F2169A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0203F44C8C;
	Mon, 23 Sep 2024 07:53:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F37D3C485;
	Mon, 23 Sep 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077992; cv=none; b=JJF5RxnwVye2sWPsgkHHzUWdFRq0rkmqsIAuynlMG1TFeLQf0T2FxnBzmOWzRPu8hQn+pIC60yKw80fxh/4vi+DJLsj/LFZpG1DVRFjfyHVFkXACaWxB8W3/Jek32q4heUiXe2/1MN09mPSKYkmWky8kXf7FzFJpeOMqy8ll55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077992; c=relaxed/simple;
	bh=jRg49tJNENiKDtboMa16O+v8eDXX9LaNBAB+xXrRurs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xu3xu+AW68dJcBuIhacr9unNf3OVekhVNNd5xeQIsOFUVWW6dqbv86jiLMmaNzjSxpwC+56j7v0MNTtVN9+axMAopPSlp1ikFLNVtqTZqDepwDBU8ygSZDYuKgUiNMwEnudMpvb2MlORiqix8JcxjX2ITAFQu0rZlcJvj4uY/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466f11e63f3d-49834;
	Mon, 23 Sep 2024 15:53:07 +0800 (CST)
X-RM-TRANSID:2ee466f11e63f3d-49834
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366f11e53a30-5a3b9;
	Mon, 23 Sep 2024 15:53:07 +0800 (CST)
X-RM-TRANSID:2ee366f11e53a30-5a3b9
From: Ba Jing <bajing@cmss.chinamobile.com>
To: pbonzini@redhat.com
Cc: shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] hardware_disable_test: remove unused macro
Date: Tue,  3 Sep 2024 12:31:35 +0800
Message-Id: <20240903043135.11087-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro GUEST_CODE_PIO_PORT is never referenced in the code,
just remove it.

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




