Return-Path: <linux-kselftest+bounces-19918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB679A1AAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 08:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB7B1C2240F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 06:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BABD18C03F;
	Thu, 17 Oct 2024 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SVwPVHTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193318BB98;
	Thu, 17 Oct 2024 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146483; cv=none; b=NrA/475GRo94QJnsvpIagLcKHm0yCp9ITDX1xgC8BUJW2pGMUMg2C53hmEi59C6V8QxuFS3NMiI2U5K6o/ZS2GPm/ASFDtktBASSoL8YMP3brjTcmofd0CWKx3CL0nRW3mEZQd/s+qUUvn7rA/BgxG9pO8YtT47uI8r1HvK6sEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146483; c=relaxed/simple;
	bh=LqFDqAgEJSoHz4hoVg7qMEkHhjiZJWeS8yESL/ny9pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBCw35ennsOO4qwIAUrpUhUgxkdwgAD1yuS5eW74oFab6arEi/I9Lu0fyMGAgRL134f7s6JHpxcx8iHJSrNLgu1paO6FJ0cLg6Dh8H0anP28gLlO3nfkB6udkO4ce2Phf3d7bmkeoHxSw3Zb4sxz+K18lvoWQoCCBfzo89xvBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SVwPVHTy; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729146475; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9kyIRu3z25zanOchYPPkgKpLrSn2+dwGxCbPeyMqtpI=;
	b=SVwPVHTyT4xzWBr7g4aqLJBAVDZcaT0xy3Cnd310HjAhsXRuNXtt2sx5tTEETkRcvIM9xqoz7Yev6OUwLTF/UUrYuNw3bHbY+xAQiUWjKjYNOuxrqYxQhIGMJRYhQQu+wzdOV85QkKb9WoFWQ4hNMYd3a/s4QuM5AREPH4L9ZdY=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WHJqgVq_1729146473 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 14:27:55 +0800
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
Subject: [PATCH -next 2/2] selftests:timers: remove unneeded semicolon
Date: Thu, 17 Oct 2024 14:27:37 +0800
Message-Id: <20241017062737.98466-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241017062737.98466-1-jiapeng.chong@linux.alibaba.com>
References: <20241017062737.98466-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./tools/testing/selftests/timers/nsleep-lat.c:62:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11406
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/timers/nsleep-lat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index de23dc0c9f97..6f7f7d682439 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -59,7 +59,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
-- 
2.32.0.3.g01195cf9f


