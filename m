Return-Path: <linux-kselftest+bounces-22169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C989D0BDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC23283ED3
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDEA191F79;
	Mon, 18 Nov 2024 09:34:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A401514A4F9;
	Mon, 18 Nov 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922496; cv=none; b=b8tcsUXB9M4NnrryJ0JTiRWXrV99+yeQ8uD6LRawETsMNDBk7zWx+QrMdr8Tl+ggB0FyuNIB4uBINmA3Hx+OJn3KlzMqu/B73dOjiDpi23i00PqVytIlQYmXSnW94GWQ41zE45TgyAZdF8A1pqmBqdw/izfImYmpxU8u+g5QUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922496; c=relaxed/simple;
	bh=IC71n9xEgu3ehrv5LbXU43hTN0PW9OMJQTo2OPAXPVc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TVpdMluY8mRLJ/U88PymoGBR9spkcDMk22tRxDvB7zPsKac3UFDx4ZX+Dlg0RdlJJDXouIYEGGZ0+rzBSpVw/CWYbYXqzFmhisO9VDUrhk83VTkPsXg6dNN2YuvBqxym1jyVv5WAF+iSMw6Bn7yKMc3ViBZrfEb3mxVmHpAJSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6673b0a3307c-0f94d;
	Mon, 18 Nov 2024 17:34:43 +0800 (CST)
X-RM-TRANSID:2ee6673b0a3307c-0f94d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7673b0a31571-ca70e;
	Mon, 18 Nov 2024 17:34:43 +0800 (CST)
X-RM-TRANSID:2ee7673b0a31571-ca70e
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com,
	martin.lau@linux.dev,
	ast@kernel.org
Subject: [PATCH] selftests/bpf: Remove unused variable
Date: Mon, 18 Nov 2024 01:34:40 -0800
Message-Id: <20241118093440.2818-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

the variable is never referenced in the code, just remove them.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/prog_tests/log_buf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
index 27676a04d0b6..5d1678b15d8b 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -191,7 +191,6 @@ static void bpf_prog_load_log_buf(void)
 	ASSERT_LT(fd, 0, "bad_fd");
 	if (fd >= 0)
 		close(fd);
-	fd = -1;
 
 	free(log_buf);
 }
@@ -259,7 +258,6 @@ static void bpf_btf_load_log_buf(void)
 	ASSERT_LT(fd, 0, "bad_fd");
 	if (fd >= 0)
 		close(fd);
-	fd = -1;
 
 cleanup:
 	free(log_buf);
-- 
2.17.1




