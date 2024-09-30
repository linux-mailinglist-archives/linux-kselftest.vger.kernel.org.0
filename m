Return-Path: <linux-kselftest+bounces-18560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C248F9898F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 03:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6121F21971
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 01:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3215C3;
	Mon, 30 Sep 2024 01:28:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2A363D5;
	Mon, 30 Sep 2024 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727659692; cv=none; b=YpW4UqpiNo5AnPsUn+roDQCetu/NqQK5Bogtn0eRV6QXol65ys6c/vJg1cCEuUnjFqldzRs5b7QPr7A/ZikjUSZLOIX15b/1HecWfWWltfY2c6RE4Hr4jePeJ/uguVwlYIKbH+IsA/ZmFu36UoCCJdR4tsdkNdY6633qt5IBEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727659692; c=relaxed/simple;
	bh=XlW7xZsiSgFr8ZYbY1/SaS2cZveC155rdkRFUKRHJW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JhddPsY8z9AtwDQ9uSySTbsrFl74VxZLkj6N5E+IZToiXSB9wsFfARwonwuhpFEStX+QYI23wGNyIWaD/RwaejlOG1f5xG5v2whR2fPKLiZZvgQCkyNjhGmbbVq2x7cpEjQe5XFR46Dqg5FO6YpxYk0qNmLB/mftfAa+HkbomfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee266f9fe9f4af-e94bc;
	Mon, 30 Sep 2024 09:27:59 +0800 (CST)
X-RM-TRANSID:2ee266f9fe9f4af-e94bc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866f9fe9e252-c65b7;
	Mon, 30 Sep 2024 09:27:59 +0800 (CST)
X-RM-TRANSID:2ee866f9fe9e252-c65b7
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: ritesh.list@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au,
	shuah@kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH v2] selftests/powerpc: Remove the path after initialization.
Date: Mon, 30 Sep 2024 09:27:57 +0800
Message-Id: <20240930012757.2395-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

If there were no anamolies noted, then we can
simply remove the log file and return.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
v1->v2:
	Remove the path after initialization.

 tools/testing/selftests/powerpc/mm/tlbie_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
index 48344a74b212..35f0098399cc 100644
--- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
+++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
@@ -313,16 +313,16 @@ static inline void end_verification_log(unsigned int tid, unsigned nr_anamolies)
 
 	fclose(f);
 
-	if (nr_anamolies == 0) {
-		remove(path);
-		return;
-	}
-
 	sprintf(logfile, logfilename, tid);
 	strcpy(path, logdir);
 	strcat(path, separator);
 	strcat(path, logfile);
 
+	if (nr_anamolies == 0) {
+		remove(path);
+		return;
+	}
+
 	printf("Thread %02d chunk has %d corrupted words. For details check %s\n",
 		tid, nr_anamolies, path);
 }
-- 
2.33.0




