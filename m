Return-Path: <linux-kselftest+bounces-22813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A82469E34FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 09:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9927B356E8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F1918FDDB;
	Wed,  4 Dec 2024 07:58:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E822218D643;
	Wed,  4 Dec 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299088; cv=none; b=GeSEEWm+RORXqQBRFXclFajbaKHDKeADkBt1Q2dAu37NXJCdFuGtWv6hz1h53/cOa5o09EUw7iNYgSjKZ1/v6fN13tIwffRwkr4BFbYkbn94zuWxBhWZieTFmuOdayF7UKJ+gWUH68ktXB18X6tFYyDcjRuc054H4UEfoX6kosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299088; c=relaxed/simple;
	bh=u9UZqRvVKWEC/pg2GFoXW2vJ2O5nN2XcCDWIEaob9S8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=p1AOW5pbgC+GopSnt4K/8aZMmF5mjy6Joz4T4f1uCfkZG0RaVRR3RshssObSMGYc7YMbwkv5+0jk4Zm5Pc2UA5KGOWlv1wuNTrMtc187PV3tvTjpaUCroGs5dsRnUIsuYYWcmV1EUtDB7lEzcazzOkp2jwmmIv7907dgkN1pfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee267500b871c6-011e6;
	Wed, 04 Dec 2024 15:57:59 +0800 (CST)
X-RM-TRANSID:2ee267500b871c6-011e6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee167500b861a4-5f465;
	Wed, 04 Dec 2024 15:57:59 +0800 (CST)
X-RM-TRANSID:2ee167500b861a4-5f465
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests: net: Fix typo in psock_tpacket.c
Date: Tue,  3 Dec 2024 23:57:56 -0800
Message-Id: <20241204075756.11561-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The word 'accross' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/net/psock_tpacket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 404a2ce75..221270cee 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -12,7 +12,7 @@
  *
  * Datapath:
  *   Open a pair of packet sockets and send resp. receive an a priori known
- *   packet pattern accross the sockets and check if it was received resp.
+ *   packet pattern across the sockets and check if it was received resp.
  *   sent correctly. Fanout in combination with RX_RING is currently not
  *   tested here.
  *
-- 
2.17.1




