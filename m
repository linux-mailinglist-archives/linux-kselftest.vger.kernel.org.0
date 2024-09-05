Return-Path: <linux-kselftest+bounces-17190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C696CC72
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 04:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B76B23671
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 02:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC13B674;
	Thu,  5 Sep 2024 02:01:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8223DE;
	Thu,  5 Sep 2024 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725501695; cv=none; b=F/nhwad3DJOZqRTZ9T3XKRuCMM9twUnoV5n+jRshPzfrt4Mc9sZ8t91gBHJmREgxmke9TEr5BfgKHNn5oEQ+tN4T0TCwWIa9/+aLZunD4HnCNPu9qfQd2KEdZmhOFIt1K3iaDdrFn1QzS2YMuEIB07c/VrLCf/1TvxalX2Omu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725501695; c=relaxed/simple;
	bh=NTcvsGK8HUqDEKj3n0Led6TPwbzRT4RcL02NGpn34Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iTw281bdCEXDdZcbkstjiiuXbbf7xMKznIBdTVzuiShn32JI8uyjKkKm4diNYBSuCjh5WWAnLnxBY3pwheBD4gBvjVqLqT03+qhUNdwzJJLtNncPeoWcqFvpBMIPZxpya/WRhThDtQ4VffjCzJ1K+EFnhgOfgkxjVzJpdPLG5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166d910f7d17-b9619;
	Thu, 05 Sep 2024 10:01:28 +0800 (CST)
X-RM-TRANSID:2ee166d910f7d17-b9619
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee466d910f7f02-4f606;
	Thu, 05 Sep 2024 10:01:28 +0800 (CST)
X-RM-TRANSID:2ee466d910f7f02-4f606
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mingo@redhat.com,
	shuah@kernel.org,
	tglx@linutronix.de,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH v2] selftests: futex: Fix missing free in main
Date: Thu,  5 Sep 2024 10:01:25 +0800
Message-Id: <20240905020125.2830-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

By readind the code, I found there is no free() after asprintf().
Just free it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
v1->v2:
	Set a flag to determine if test_name needs free.
	
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 215c6cb539b4..d78bb5112fce 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -362,6 +362,7 @@ int main(int argc, char *argv[])
 {
 	char *test_name;
 	int c, ret;
+	int need_f = 1;
 
 	while ((c = getopt(argc, argv, "bchlot:v:")) != -1) {
 		switch (c) {
@@ -404,6 +405,7 @@ int main(int argc, char *argv[])
 		       "%s broadcast=%d locked=%d owner=%d timeout=%ldns",
 		       TEST_NAME, broadcast, locked, owner, timeout_ns);
 	if (ret < 0) {
+		need_f = 0;
 		ksft_print_msg("Failed to generate test name\n");
 		test_name = TEST_NAME;
 	}
@@ -416,5 +418,7 @@ int main(int argc, char *argv[])
 	ret = unit_test(broadcast, locked, owner, timeout_ns);
 
 	print_result(test_name, ret);
+	if (need_f)
+		free(test_name);
 	return ret;
 }
-- 
2.33.0




