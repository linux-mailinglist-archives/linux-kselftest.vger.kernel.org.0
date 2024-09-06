Return-Path: <linux-kselftest+bounces-17348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BF396E7E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 04:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FAA51F24118
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 02:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB138384;
	Fri,  6 Sep 2024 02:53:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A1E3398E;
	Fri,  6 Sep 2024 02:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725591192; cv=none; b=o69zHPKHWI1SC1Q5H0u/1nGx7QkisIB99KasBXffCHaUBWz/iLJlO5NgMARC5x+KmHvZ80sfn1Vc6S0vwg1q1tIarNs7F3h35mirjoX+GqYfn6viydYOPcXg+zBEzqC3PropoPsx0cNWVQIQ++6L+ttpORgnZ5xDI3xWvXxW4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725591192; c=relaxed/simple;
	bh=COmPxaiYh3arXa5lsQlqe24eEgzTUbWn2Xp/xKo+FjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gw/cKl/Ch+UmcQh9/T1bsOcL6BtSsHkg5FjuJ0cPO4a6v8lhylg+g25k68eutEb4tpVnQW5fBpFkqnc1VuEHxjPu/BeCByAW2efgC+Q1yTTFSA1u+JW+8/R1wLMsAREbrqGZ1Y0PDnmLEI/lSBSqvrQ8QMvuKlRWh28nH/1monA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766da6e8c807-f380d;
	Fri, 06 Sep 2024 10:53:01 +0800 (CST)
X-RM-TRANSID:2ee766da6e8c807-f380d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866da6e8c774-8f30f;
	Fri, 06 Sep 2024 10:53:01 +0800 (CST)
X-RM-TRANSID:2ee866da6e8c774-8f30f
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: skhan@linuxfoundation.org
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH v2] selftests/timers: Remove unused NSEC_PER_SEC macro
Date: Fri,  6 Sep 2024 10:52:59 +0800
Message-Id: <20240906025259.3822-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

By readind the code, I found the macro NSEC_PER_SEC
is never referenced in the code. Just remove it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
v1->v2:
	Put together files with similar problems

 tools/testing/selftests/timers/change_skew.c      | 3 ---
 tools/testing/selftests/timers/skew_consistency.c | 2 --
 2 files changed, 5 deletions(-)

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
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index c8e6bffe4e0a..83450145fe65 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -36,8 +36,6 @@
 #include <sys/wait.h>
 #include "../kselftest.h"
 
-#define NSEC_PER_SEC 1000000000LL
-
 int main(int argc, char **argv)
 {
 	struct timex tx;
-- 
2.33.0




