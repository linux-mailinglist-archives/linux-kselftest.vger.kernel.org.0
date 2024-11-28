Return-Path: <linux-kselftest+bounces-22595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D179DB2BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 07:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDA41678AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 06:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DF41422B8;
	Thu, 28 Nov 2024 06:18:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30FD1FAA;
	Thu, 28 Nov 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732774725; cv=none; b=J9Qjeq8HOhKHU9NUf5P+lOuIFCYTnGwSOp/5aeesckXwN/szeTVGkd9ejlm9JoVpKRV2BSc3FPnCKhGwAbyW7eS1/qMhsPldvJhu0rfmaa+FXuBIpFo03bHCNy3pX6oqb7WulrKr03kaUaJEj4yth6tHGFxY9bHhK6ykfw2uVEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732774725; c=relaxed/simple;
	bh=kWHBcIa6P8JOmdNak5q0hq9xMFavhtFBDsc9be/BnmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=khYmP2BQMy4D5BTJa1NNhg7qm/9MThDXnfP2Q6L1lbFoQiIyG2OXqT9s+AFT7H1CWq2lJTnbB8hu751Da9lRGkMBfPAbbte+bvilVAyj+OF8I0Cwzbvr1FdSpeVamLqeSWtCO5b5akn5ycdhXJT4JJpF2AEAqIjNt7Gn6giCXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee867480b3a715-d2761;
	Thu, 28 Nov 2024 14:18:34 +0800 (CST)
X-RM-TRANSID:2ee867480b3a715-d2761
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee467480b3aaad-8edd3;
	Thu, 28 Nov 2024 14:18:34 +0800 (CST)
X-RM-TRANSID:2ee467480b3aaad-8edd3
From: liujing <liujing@cmss.chinamobile.com>
To: shuah@kernel.org,
	osmtendev@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] selftests: prctl: Fix resource leaks
Date: Thu, 28 Nov 2024 14:18:27 +0800
Message-Id: <20241128061827.4165-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After using the fopen function successfully, you need to call
fclose to close the file before finally returning.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
index 562f707ba771..7be7afff0cd2 100644
--- a/tools/testing/selftests/prctl/set-process-name.c
+++ b/tools/testing/selftests/prctl/set-process-name.c
@@ -66,9 +66,12 @@ int check_name(void)
 		return -EIO;
 
 	fscanf(fptr, "%s", output);
-	if (ferror(fptr))
+	if (ferror(fptr)) {
+		fclose(fptr);
 		return -EIO;
+	}
 
+	fclose(fptr);
 	int res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
 
 	if (res < 0)
-- 
2.27.0




