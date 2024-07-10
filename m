Return-Path: <linux-kselftest+bounces-13443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BC292CC25
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B521C214CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0701C83CD7;
	Wed, 10 Jul 2024 07:43:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3042E79B7E;
	Wed, 10 Jul 2024 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597405; cv=none; b=ulM69bTcMLmCZd/ATBQlIc02TEA4iXe7gGA7JJI3ZMUH+I8+1Zl517Y7AOSrDX5urn0FDWDIa2LAEO/NP4FL9mpxVaQfxl9njBu2anG4idc3TtbLLQ212wmHrYW2cAba8IazeX17sPMTa3+VinAmFrfBvI9tGX+XoGxFlLKgJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597405; c=relaxed/simple;
	bh=DKKa3yJUW4vJcw1PWPSPXxw+/72l9NEX86PYVGZ8hDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uhhpoee8PcX302ykeB0G4beVbJxx6jQ9tJ/0lpdZGFz/GKBdL9073lw4IjFrN55aKATG7aYxpbh7UUEqRNRtCfGGjnuPgYz2GUV7pV6iMqh8KV8IQ4ZFvqOmff0613JTL85YbrX5+mtLugS5IQqBqlkHM1/ERCGNqN827oBgS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9668e3b8eb4b-30b4b;
	Wed, 10 Jul 2024 15:43:12 +0800 (CST)
X-RM-TRANSID:2ee9668e3b8eb4b-30b4b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7668e3b8e0f4-de78b;
	Wed, 10 Jul 2024 15:43:12 +0800 (CST)
X-RM-TRANSID:2ee7668e3b8e0f4-de78b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: alexandre.belloni@bootlin.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	shuah@kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v2] selftests/rtc:Fix a resource leak
Date: Wed, 10 Jul 2024 00:43:09 -0700
Message-Id: <20240710074309.6647-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240710071650f7265b40@mail.local>
References: <20240710071650f7265b40@mail.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The opened file should be closed before exit, otherwise resource leak
will occur that this problem was discovered by code reading

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
From a good programming practice perspective, especially in more complex programs, 
explicitly freeing allocated memory is a good habit!


 tools/testing/selftests/rtc/setdate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rtc/setdate.c b/tools/testing/selftests/rtc/setdate.c
index b303890b3de2..17a00affb0ec 100644
--- a/tools/testing/selftests/rtc/setdate.c
+++ b/tools/testing/selftests/rtc/setdate.c
@@ -65,6 +65,7 @@ int main(int argc, char **argv)
 	retval = ioctl(fd, RTC_RD_TIME, &current);
 	if (retval == -1) {
 		perror("RTC_RD_TIME ioctl");
+		close(fd);
 		exit(errno);
 	}
 
-- 
2.17.1




