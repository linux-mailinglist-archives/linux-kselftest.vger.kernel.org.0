Return-Path: <linux-kselftest+bounces-17712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C8974A75
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145B81C255AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D67346D;
	Wed, 11 Sep 2024 06:35:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5182BAE3;
	Wed, 11 Sep 2024 06:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036513; cv=none; b=aPbKaeP4MVT6zS2vJICJJOsgxCueyz2Qz4X5+4ZjpT2kgi7j7zvNRI4qybbtkQwkAc+iBH3p3fxrY81MbcW/Mm2EVnQ0tlD7hPpMppzkLUrjgAlkuOTXZSBFvQ2VGttM46hoUeFNhK/IOSuNxW1NaoFiB3LAclALBCBeXYz4QlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036513; c=relaxed/simple;
	bh=1VKqkrnmDAcEEEvDJ1qM2+gPceUM2kDlEd+u4SanOf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I6AJ4rUmgl+Nb1vlp5MZ5BLJP+3x9sMv7PieI8q2mVLCAW4VvacvETsoNoDn7PojLq45Ew3663JMYpa/0foHqmMYIaw+/Ixb4qvjO02HOsg3KNV6NtXFBgvcqAfiWKdXrqsq4KE+lKPfeyM6k1/VWIwPYBDuC8Q5sNUc2kGijIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766e13a11683-1c689;
	Wed, 11 Sep 2024 14:35:00 +0800 (CST)
X-RM-TRANSID:2ee766e13a11683-1c689
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166e13a13661-b812f;
	Wed, 11 Sep 2024 14:35:00 +0800 (CST)
X-RM-TRANSID:2ee166e13a13661-b812f
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] selftests: kselftest: Use strerror() on nolibc
Date: Wed, 11 Sep 2024 12:42:30 +0800
Message-Id: <20240911044230.5914-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Nolibc gained an implementation of strerror() recently.
Use it and drop the ifndef.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/testing/selftests/kselftest.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index e195ec156859..29fedf609611 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -373,15 +373,7 @@ static inline __noreturn __printf(1, 2) void ksft_exit_fail_msg(const char *msg,
 
 static inline __noreturn void ksft_exit_fail_perror(const char *msg)
 {
-#ifndef NOLIBC
 	ksft_exit_fail_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
-#else
-	/*
-	 * nolibc doesn't provide strerror() and it seems
-	 * inappropriate to add one, just print the errno.
-	 */
-	ksft_exit_fail_msg("%s: %d)\n", msg, errno);
-#endif
 }
 
 static inline __noreturn void ksft_exit_xfail(void)
-- 
2.33.0




