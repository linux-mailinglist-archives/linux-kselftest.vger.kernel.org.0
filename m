Return-Path: <linux-kselftest+bounces-17038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254E6969980
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CEF1F22E64
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B619F41D;
	Tue,  3 Sep 2024 09:51:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8756D1A0BF2;
	Tue,  3 Sep 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357079; cv=none; b=MHdH1KT9+cLzFDh8tdborzwpbUGHBAZgLge17q/lPQ74oH3YPuVwSy3jI/LPYmmB9n1wBXXsvylz7AsnGO0Fp7go89zpJ2WmiMiV/shiLtL6Ah+ZlLQ+YE8FCzqebwB3pzea4ilCmOBkCVVcY0XPlnINiYfqU1VdlRCRZjTo2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357079; c=relaxed/simple;
	bh=ZEEb8Ts2Geg03O5VWO0y2Q6TSJ7QN5btw8o7LPflcCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qds9VYczCInwF5KzlkSOcUZXN7nh8tk2fn8ftXjnBpcWSFuGyHu/LV52fLqvv6n87XsIzNBv+QumOwKQ3N8QU/HhqRA6qn9maODDia87Z54ugmwEpgIj/F784nS5zkLIiTzc16UFpoeicR1YjLLj6mbuBiZjo7qzK6p033+ObvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166d6dc12870-ac172;
	Tue, 03 Sep 2024 17:51:14 +0800 (CST)
X-RM-TRANSID:2ee166d6dc12870-ac172
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee666d6dc11f2a-e0df0;
	Tue, 03 Sep 2024 17:51:14 +0800 (CST)
X-RM-TRANSID:2ee666d6dc11f2a-e0df0
From: Liu Jing <liujing@cmss.chinamobile.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] selftests/net: do_setcpu function not need to have a return value
Date: Tue,  3 Sep 2024 17:51:11 +0800
Message-Id: <20240903095111.7204-1-liujing@cmss.chinamobile.com>
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




