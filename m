Return-Path: <linux-kselftest+bounces-13435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9915492C925
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 05:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC431C222CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 03:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1F1F949;
	Wed, 10 Jul 2024 03:28:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9007446CF;
	Wed, 10 Jul 2024 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582108; cv=none; b=a26NL3r2DG9SyGsFTh6Jp8fZuzUvAspMftuuHVD5roj3cVHG0WltlYwTd3k77NjefR18xa91il/6iyFhWw4X/t/1YhQI+eSWTJzkeSVXqLzn2wTe5xFZ29RzNNFeVmP8EgUSBJS7uL8lao/0bCNq3cB6KW11LZvpbqvIHH7JeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582108; c=relaxed/simple;
	bh=mpKFUkwXsZS9rCnjjAEaQIrSERfhoJMHJivnllP6KpE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dfhAqnK9DCcIy8U7XJKN2LYJRImZ1pCspjaksTKQVADjJI1xCC0+c8flS2qBOeHcu9PasElo3cmSt8jmqqOCaSl8Chas+5ewRpeWA7G+Bz1tr+GGlFNbwCBY2RF0NewbofOy1nYh2ryHoZQDA7GFaNFjPFVTOQtLKbjNqDkMN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7668dffcfe1c-28e1d;
	Wed, 10 Jul 2024 11:28:15 +0800 (CST)
X-RM-TRANSID:2ee7668dffcfe1c-28e1d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4668dffce29d-d7d7c;
	Wed, 10 Jul 2024 11:28:15 +0800 (CST)
X-RM-TRANSID:2ee4668dffce29d-d7d7c
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests:Fix printf format string in kselftest_harness.h
Date: Tue,  9 Jul 2024 20:28:13 -0700
Message-Id: <20240710032813.3782-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

'%u' in format string requires 'unsigned int' in __wait_for_test()
but the argument type is 'signed int'.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index b634969cbb6f..dbbbcc6c04ee 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1084,7 +1084,7 @@ void __wait_for_test(struct __test_metadata *t)
 		}
 	} else {
 		fprintf(TH_LOG_STREAM,
-			"# %s: Test ended in some other way [%u]\n",
+			"# %s: Test ended in some other way [%d]\n",
 			t->name,
 			status);
 	}
-- 
2.17.1




