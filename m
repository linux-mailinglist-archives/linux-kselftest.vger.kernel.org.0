Return-Path: <linux-kselftest+bounces-47470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D309CB7C14
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22DD9300F8BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84022FF665;
	Fri, 12 Dec 2025 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ujb6hVgg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A42D249E;
	Fri, 12 Dec 2025 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509917; cv=none; b=snG7EToE44sAdEdXcWWTGyk8aFL8G/gAXCvCzYt5IF+/Yn6SoIydlZxjd33ZICLzdmteM66ad4Wxk50GtkyzgRS3W9of43K0qiIniOo97n5o6J6DTSJITw1qinQWdt7SvDYRKA3tUmdUGFyEuZ22bGUkX3CRlP8OzMu4G1IjfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509917; c=relaxed/simple;
	bh=86jM6/8ayfHPNKCYQQ/v+Gxswje4pbMb7uGQHheHd4c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=j8saPZQ6vUSuvcu/p8VO3ArwceUS7pnrIwT2jwRarqtfXJmgpSHJFa0FrSWcc6FlRWXlktVHtb2/sNEaLLw+rFYkN0xbfC150OP2plJaeE3A5UqYSm2Bve20xoqcVURU2bXWiFm9YnTN87B/MSJ3RO1zR9r+IgnQqwWnApXn9ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ujb6hVgg; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765509889;
	bh=zDJ4Agqgm0IgPliNwt9ogn6DK+Rs7gCySxS9/AzULK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ujb6hVggTY2nHKlqqid8hfyCRlDAu+Sgzkr8INUDXFe7lDIbvipprvemNoK1ExX/y
	 0NMlFJJEkGxiTy5o5/QK8WES2yT7k+JFcK3h+pV7jE8o34PGVzR9nS7dP4YzixFw1D
	 JxUpYOyo8pIm+ArM+BgQCHEB0+doRoXVDXBvE3ZM=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 62D0A691; Fri, 12 Dec 2025 11:24:45 +0800
X-QQ-mid: xmsmtpt1765509885tx9osn5q6
Message-ID: <tencent_A4A4E388AEB0E748796A5FF75DB44514DC08@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahNutEhg7U/YbeXwgFTuUg16/TPFrcGtq4DET8roumfz4m93Nei4
	 bKhb/WEsn2kFahhSIdFLM1dn4AXOmSy89BqyC45ht4rZqjm0e7KfbzLo9Jop29D/zWe28lXkFTh1
	 PG+i+G35qgh67IjKsEK2Y+zn4f55kuVTB3Bp2EhVD7szzEpLwRO9vkmD5zIeDedSDbiEzDAwMogF
	 uZswScFJwbvxY6tyRbZ73RW/83RgIeELKpIhmEo/d+ymsJmiHXKVHhIXJ4HD6WwRwAuK1l+6I9Xe
	 tPBQmlC2saOGq/bq8KAXQewaLGyFsLFrH3Wp1Qswh1CwEQS3F8+9lMOlawqsxTWH7G5GX4Vo/WNL
	 XUAwYU3dQcTRsAfmQN8JmgNf6u5ofs0wTTUdmMSd5mNQiAGPMyJmzNKUJCuKkRomT8md+SAYJGnJ
	 4nXVHhHOSKESVNqV/EudODj0ueKFRBHBc6hLjpawdw1wxvyERoEHEw95/4yZBisMoSfk1PaC9U9B
	 Hms6HSEtXX8wRnPCM+0St+p1lq8z2u7k0dafnU1n3yx+TW4UNyh3MKbI2cSuzfZ8I8bvE2gagZbk
	 GqYSiRWeSZW83CWdWieNsER62trw03bbvgNeanLwov+BiMm+dMhn1lNmnh+7nQ4RfYNADFpB0TO2
	 zhQ8FIYExLPPWqr2Lf1gcaWiXkKeOls/ObyrWsN0qgzaWITAL3IUTvHUzrirYEwLgspvNy3s3us7
	 xdSHryApLOPl5MkrjtErLWhzH6Y8IKc8WLSUu4fVTFNuMYff8QFZtCw4YL9sHY+T+KYlx85bTokT
	 74Wf5bPv1+ktxn4Ix8R0NRXES7dmS1FBmgVTc4PwBLKEEJqt+DsFP+ucSJODOk+lUb8hvRIVKbC8
	 sVBazZ/YSTTV2BKnrvMsc/kD7uhcMTYAOIjJZMQznGRs4YWw+xnvIhNJX62ipyck0YkrNYHgGsX7
	 bhB8kFvCugbHZLIDNPJvBfYLthjueioYW438fYVTxpvmotXIpX5Tm1aJc+9djf02a8dQbQkvQvtQ
	 caKFuwGmTFQmK4yvzBiaL07gLqZL2tS9+FmFn3dbhvMsLl9r4tOfoinle6fXtIqI1G9dHPfDFO0T
	 8758hoT27DjtcdnNo8uq8pHw7Z6A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: andrealmeid@igalia.com,
	bigeasy@linutronix.de,
	colin.i.king@gmail.com,
	dave@stgolabs.net,
	dvhart@infradead.org,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com
Subject: [PATCH v2 1/5] selftests/futex: reduce array declarations in the requeue_single
Date: Fri, 12 Dec 2025 11:24:43 +0800
X-OQ-MSGID: <20251212032443.1842375-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_E8629E1FE67D7F457479179170238F07B90A@qq.com>
References: <tencent_E8629E1FE67D7F457479179170238F07B90A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the requeue_single function, the variable "waits" only uses
one element. There is no need to use an array.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 tools/testing/selftests/futex/functional/futex_requeue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
index 69e2555b60399..1807465de2144 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -33,7 +33,7 @@ TEST(requeue_single)
 {
 	volatile futex_t _f1 = 0;
 	volatile futex_t f2 = 0;
-	pthread_t waiter[10];
+	pthread_t waiter;
 	int res;
 
 	f1 = &_f1;
@@ -41,7 +41,7 @@ TEST(requeue_single)
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
-	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
 		ksft_exit_fail_msg("pthread_create failed\n");
 
 	usleep(WAKE_WAIT_US);
-- 
2.34.1


