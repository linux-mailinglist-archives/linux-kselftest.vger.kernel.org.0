Return-Path: <linux-kselftest+bounces-22594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65BC9DB2B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 07:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EAC166BE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 06:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDBF13D244;
	Thu, 28 Nov 2024 06:05:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7273FD4;
	Thu, 28 Nov 2024 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773934; cv=none; b=XBIMAtue4JfqjOJZHZn8bve3q0du1fPx2cw34Zu2ovL2Bobd411GjkH1bHTAeiUfvKX8hMg/lf/9gmRK2K4bJqWKqQQ3yc2hBqUHCcmlEAUnN5CA7tn5QdbKgI7Pf4XiWG4OdSYsu2pRR1slQdyiODLUu/7vbxCfNTOnh7VPQ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773934; c=relaxed/simple;
	bh=Vy8LaqyYOPiDhw6c5eppX6zPxrX135MYfLamvagSqWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CEDcXMoJQxVTH+gDY89z1djPqQwAZcfaxEnE9c090iJNmV0otXk+GAZC0xq943aPj8WSTgzXQ7pmoXbqRX3Hd7eJgx1gx+9xclLXfZ3cUJyNzYOeJ2IGi3jpoykLkBPPDeyXWl5M9n9foaQIdmK7AAROo+5NEu4n5OX2mz4WFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3674808200fe-65927;
	Thu, 28 Nov 2024 14:05:21 +0800 (CST)
X-RM-TRANSID:2ee3674808200fe-65927
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6674808202bb-8d1f4;
	Thu, 28 Nov 2024 14:05:21 +0800 (CST)
X-RM-TRANSID:2ee6674808202bb-8d1f4
From: liujing <liujing@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] selftests/timens: Add fclose(proc) to prevent memory leaks
Date: Thu, 28 Nov 2024 14:05:12 +0800
Message-Id: <20241128060512.3948-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fopen succeeds, the fscanf function is called to read the data.
Regardless of whether fscanf is successful, you need to run
fclose(proc) to prevent memory leaks.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index 1833ca97eb24..e47844a73c31 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -79,9 +79,11 @@ static int read_proc_uptime(struct timespec *uptime)
 	if (fscanf(proc, "%lu.%02lu", &up_sec, &up_nsec) != 2) {
 		if (errno) {
 			pr_perror("fscanf");
+			fclose(proc);
 			return -errno;
 		}
 		pr_err("failed to parse /proc/uptime");
+		fclose(proc);
 		return -1;
 	}
 	fclose(proc);
-- 
2.27.0




