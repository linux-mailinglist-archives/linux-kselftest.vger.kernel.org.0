Return-Path: <linux-kselftest+bounces-17209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED58A96D41F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967171F23508
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9976919884A;
	Thu,  5 Sep 2024 09:48:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76BC198E83;
	Thu,  5 Sep 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529717; cv=none; b=mLdJOVgJwXvFgOfb1ki51e+64LuMxHRJM9A5RCmGgZyEJt6X5z+bbz4BwpF7ktVm/cDEs2PVxSH0oJJl9TiimmilrGB5Da4hJ6UpEZySDYDiwpi1jEgqFUhOGNTFmH+14oO4TqoPGVy+8l6BduTV0i1SOgi4Vi9QauYYIiJZF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529717; c=relaxed/simple;
	bh=iOzTSNxrXKQoHCTSbHVpN9lWi+BpBzCGa6QFmZ6EgdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CCKuRy5iEcMNbALcZyKBoHB0HslHYXEVDQIWOx5T9M+ZPArLJJjYF3H8FRkkAFst8YulpKD2m5WDYn8uZhYRQkrIgeoPmweUlNmCTaIxz6C1ACcV2Yl3/KfyoXspp0fY1lGlzN6ydffv4Iv/HrIR6g6Az3zPQH/SdpG+lfQQi/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466d97e6c604-beef9;
	Thu, 05 Sep 2024 17:48:29 +0800 (CST)
X-RM-TRANSID:2ee466d97e6c604-beef9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366d97e6cc49-69812;
	Thu, 05 Sep 2024 17:48:29 +0800 (CST)
X-RM-TRANSID:2ee366d97e6cc49-69812
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: anna-maria@linutronix.de
Cc: frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] Date: Remove unused macro
Date: Thu,  5 Sep 2024 16:13:25 +0800
Message-Id: <20240905081325.47673-1-zhangjiao2@cmss.chinamobile.com>
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
 tools/testing/selftests/timers/skew_consistency.c | 2 --
 1 file changed, 2 deletions(-)

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




