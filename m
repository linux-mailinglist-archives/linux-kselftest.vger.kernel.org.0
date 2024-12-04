Return-Path: <linux-kselftest+bounces-22814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC0A9E34E5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 09:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C763F161D1C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 08:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0318F2DD;
	Wed,  4 Dec 2024 08:01:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64419047F;
	Wed,  4 Dec 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299319; cv=none; b=ner1/cWJ0WcROqgXtxs6G93jvIhpt3/vKVLWBb16wVL462iX1wSvz/V8wUOkXs4CJuSiGKHHNDege7V/EsdzAfT7Eteb7jmnIzIg5loYOfh0iQ7aOVymy0+ULOFr9KPHqLIE1bpf+IQCmGq5tJifbUA5xbDahb1GYEiS2D0zB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299319; c=relaxed/simple;
	bh=+SyfrVOzTF52umO7rURP8zoCcdna21q1NEA2b2McNUg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fSSqxsF4jXyzuwF+Qw16Dtb6ur2iriw/31c8PBr32uOnlFZo7aV7DICOJ9pPpuVXmShG06SRe+C5JSdT1z8XjvITz3m9AuNd+82h/6NJInQ44syk3gAVh6VNQ7RxLnTfjr4IAtS9+EPJGSrcvVvZ2sTwUbSEUZfN//+JPcoVYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee367500c70e46-99670;
	Wed, 04 Dec 2024 16:01:52 +0800 (CST)
X-RM-TRANSID:2ee367500c70e46-99670
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee767500c6e1f3-5ee0f;
	Wed, 04 Dec 2024 16:01:51 +0800 (CST)
X-RM-TRANSID:2ee767500c6e1f3-5ee0f
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] selftests/powerpc: Fix typo in test-vphn.c
Date: Wed,  4 Dec 2024 00:01:49 -0800
Message-Id: <20241204080149.11759-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The word 'accross' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/powerpc/vphn/test-vphn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/vphn/test-vphn.c b/tools/testing/selftests/powerpc/vphn/test-vphn.c
index 81d3069ff..f348f5491 100644
--- a/tools/testing/selftests/powerpc/vphn/test-vphn.c
+++ b/tools/testing/selftests/powerpc/vphn/test-vphn.c
@@ -275,7 +275,7 @@ static struct test {
 		}
 	},
 	{
-		/* Parse a 32-bit value split accross two consecutives 64-bit
+		/* Parse a 32-bit value split across two consecutives 64-bit
 		 * input values.
 		 */
 		"vphn: 16-bit value followed by 2 x 32-bit values",
-- 
2.17.1




