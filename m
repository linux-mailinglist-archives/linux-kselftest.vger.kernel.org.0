Return-Path: <linux-kselftest+bounces-18449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADC7987E5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 08:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7E11F235C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 06:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABB5175D48;
	Fri, 27 Sep 2024 06:25:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA68E172BB9;
	Fri, 27 Sep 2024 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727418337; cv=none; b=Nrdxyrs9+wnvYkAjvUG35tzfv3s1WNj+kPPcOo9n8FNW1JfMNgtpE34VIs634nZ7O1msJ/5KtNmZF5SOw0VpXpT55NGGvkM/L5YcbmygWKS/C7kBTCEWQuBhZGfBHBByEYpkcwfFv9TnYXB3DgIdTP4m3Pr/uigxghk3SeURBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727418337; c=relaxed/simple;
	bh=eyKByRvV9buFVBy8oC2fQjfe9Iizy+BFIviGrB/LRF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=idnZITGsZHy5CB9Oho9hbaDUYvL3rBb0onRu/YtQeg1ocdOd4GPiZ/1nvhzFQCIoEYd1HpBsNMIGIQVG5nR1PVDxiX3MEg/1iNuCGUo3W4MsB4ue+PvTagxlln682Kv1BE0SpNjiPmkeQYotqNDO6YdRICX4QXFSTkqZDldZBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee266f64fda2bc-d42c9;
	Fri, 27 Sep 2024 14:25:30 +0800 (CST)
X-RM-TRANSID:2ee266f64fda2bc-d42c9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866f64fda322-3205d;
	Fri, 27 Sep 2024 14:25:30 +0800 (CST)
X-RM-TRANSID:2ee866f64fda322-3205d
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] selftests/powerpc: Rm the unnecessary remove function.
Date: Fri, 27 Sep 2024 12:31:25 +0800
Message-Id: <20240927043125.8199-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Path is not initialized before use,
remove the unnecessary remove function.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/testing/selftests/powerpc/mm/tlbie_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
index 48344a74b212..fd1456d16a7d 100644
--- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
+++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
@@ -314,7 +314,6 @@ static inline void end_verification_log(unsigned int tid, unsigned nr_anamolies)
 	fclose(f);
 
 	if (nr_anamolies == 0) {
-		remove(path);
 		return;
 	}
 
-- 
2.33.0




