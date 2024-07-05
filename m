Return-Path: <linux-kselftest+bounces-13232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F089283BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 10:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AA52859A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A3146A60;
	Fri,  5 Jul 2024 08:35:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AFD146018;
	Fri,  5 Jul 2024 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168528; cv=none; b=I1Yz8apR6OQTzjTZXW3HYRakzLWhctcCq2A/Dk4bKP/k+X8WtfVXL3SbEC0rI6093Kk808jv+RTeTngTmpDprXN/Qq78/A7v7u8PzgfCj/ihW2daFFyXvLIVYqcx84KC7E7M8RRm9scoyzqOadQkRyZhCUtUHegrdf6TUjR76MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168528; c=relaxed/simple;
	bh=ZEEb8Ts2Geg03O5VWO0y2Q6TSJ7QN5btw8o7LPflcCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bJT0RHng2/Cp61V303JsZvsT8BzuC91+ZDoyfCLtxu8RxHKGbI794ZIFSXCX/yNax1lJ2VV7yS0XRMtutebt74Bgt7Xq1FderWz4H6NoRKnG8NogVh+5rAa8xZe8M97NzdqR+D+xsYzhQ7mZo4AIb5KP9csEzquF5Sdb0wlbCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46687b042ac0-d73af;
	Fri, 05 Jul 2024 16:35:15 +0800 (CST)
X-RM-TRANSID:2ee46687b042ac0-d73af
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26687b042064-10196;
	Fri, 05 Jul 2024 16:35:15 +0800 (CST)
X-RM-TRANSID:2ee26687b042064-10196
From: Liu Jing <liujing@cmss.chinamobile.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing@cmss.chinamobile.com
Subject: [PATCH] selftests/net: do_setcpu function not need to have a return value
Date: Fri,  5 Jul 2024 16:35:12 +0800
Message-Id: <20240705083512.7108-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in the do_setcpu, this function does not need to have a return value,
which is meaningless

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 tools/testing/selftests/net/msg_zerocopy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e8..0b54f2011449 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -118,7 +118,7 @@ static uint16_t get_ip_csum(const uint16_t *start, int num_words)
 	return ~sum;
 }
 
-static int do_setcpu(int cpu)
+static void do_setcpu(int cpu)
 {
 	cpu_set_t mask;
 
@@ -129,7 +129,6 @@ static int do_setcpu(int cpu)
 	else if (cfg_verbose)
 		fprintf(stderr, "cpu: %u\n", cpu);
 
-	return 0;
 }
 
 static void do_setsockopt(int fd, int level, int optname, int val)
-- 
2.33.0




