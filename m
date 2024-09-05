Return-Path: <linux-kselftest+bounces-17212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F285796D6A3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316791C235FD
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ACC1991B0;
	Thu,  5 Sep 2024 11:02:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8357119413B;
	Thu,  5 Sep 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534164; cv=none; b=HFkh/SeBVBT4ujcWWouMLycupe2PtbYXpH4k9olaJkQZIXYCcbDCt+WqjJKiF18aKrbGjDwxIK+Rwmmj7xteLJ/Azshrgbw5erB+j2LOvSN3kEH7+ajxEge9IHEymYwx8FSCA9tp/LFhanPkQrHys2HZN1Ros/Ztj426kzl24UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534164; c=relaxed/simple;
	bh=qFSEslGlI4eDeIwvChR5MyKFYPOyNbkC0+Gdcoc/IkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lf9G0RJnhGUtkbEUHYQjs3FZMRL4iLOKPr8zFx8gTGURGbeSDvi42u8sM3QVXS+6iqD4nSs6ycLL9bX4sTyWzP2p8riVy+P28k4cCdQxg+YW3Do+QRTOIf5keEHwudNtC1me/r2LcamFIHaakrhzCDcLVyWICTdNeVlJ7xvrPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866d98fcbf66-29f9a;
	Thu, 05 Sep 2024 19:02:37 +0800 (CST)
X-RM-TRANSID:2ee866d98fcbf66-29f9a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee966d98fcc31d-6ba6e;
	Thu, 05 Sep 2024 19:02:37 +0800 (CST)
X-RM-TRANSID:2ee966d98fcc31d-6ba6e
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: jstultz@google.com,
	tglx@linutronix.de,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] Date: Remove unused macro
Date: Thu,  5 Sep 2024 16:52:30 +0800
Message-Id: <20240905085230.48438-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

This macro NSEC_PER_SEC is never referenced in the code.
Just remove it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/testing/selftests/timers/change_skew.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/timers/change_skew.c b/tools/testing/selftests/timers/change_skew.c
index 4421cd562c24..18e794a46c23 100644
--- a/tools/testing/selftests/timers/change_skew.c
+++ b/tools/testing/selftests/timers/change_skew.c
@@ -30,9 +30,6 @@
 #include <time.h>
 #include "../kselftest.h"
 
-#define NSEC_PER_SEC 1000000000LL
-
-
 int change_skew_test(int ppm)
 {
 	struct timex tx;
-- 
2.33.0




