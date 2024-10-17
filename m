Return-Path: <linux-kselftest+bounces-19917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710F29A1AA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 08:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30141C22379
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 06:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF5317BB03;
	Thu, 17 Oct 2024 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RbgVqPK4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8C13D24C;
	Thu, 17 Oct 2024 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146478; cv=none; b=BD9h3CKRYx2dZuduUtAmOGyC47oNyGCcR1ZBLJx/fo5Qd7kdupUe4X6yED8P/JPsWswD4dQ3aeAW/EXpWsu7joBT2uf+0brzAbU89+OW72WOufdHxoDZLQ3GnWx7T5C/G1LLsxrxHMwckTcCszvi5Da9sYLrHQiX+tXWZ1q3iJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146478; c=relaxed/simple;
	bh=1YI1JIVndbHN3TKQD/LWLay/ZA2uNlvsG+CjzvtLf+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gKzVsB6oy3OZdfT8L9rxfhuvY1a6ptyoIMAjGf9CvhJ83OzadUSavr9/pbfcxm1QYgriPQxyiCk5ptKb1LPBMicKSXc8jWVXMPITAPgpA02aFKyRMjcY9iptbf6IoB2vKJe4jJBoiNwZBJoATmejR2exKYHBvnBk+qsXvO1gTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RbgVqPK4; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729146471; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8EBMqCDG2unLVRrpCMVLspUXgdimrDi8kQNyWhFTdQM=;
	b=RbgVqPK4DUbj0K2q+G2vrKUX3ILa1Ul9MFzYO4flr9Nkzg9spwWDSybsumiaZZUTcmSXB8xQX3yf4RPTsSpSIwrOHUvQ2qEkU4hKHOtxK/ylDXXm8OUyNdDV1uzeDVgenAg5Pj/NIn45xAvYJ7MLB2mxrNdPTc3+jeg/5Mx46+Q=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WHJop7U_1729146460 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 14:27:50 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: anna-maria@linutronix.de
Cc: frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] selftests:timers: remove unneeded semicolon
Date: Thu, 17 Oct 2024 14:27:36 +0800
Message-Id: <20241017062737.98466-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./tools/testing/selftests/timers/nanosleep.c:63:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11407
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/timers/nanosleep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 252c6308c569..36f9b97f232a 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -60,7 +60,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
-- 
2.32.0.3.g01195cf9f


