Return-Path: <linux-kselftest+bounces-17097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545CD96AED1
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 04:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCCA2861E2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 02:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2FF3B782;
	Wed,  4 Sep 2024 02:56:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642610A12;
	Wed,  4 Sep 2024 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418581; cv=none; b=G1oNAZMmGzZ+Ad6KYFcMkLBLCF1aTJ90qfg02RwZ4susE6P4fIBZr1kX8HL+9PyRT+fn2TtaPVH0obOgIHnHZSjDgrEvsFEnmrcDUnYQn++U53AI/fh3YJJqii3US/ZgNGJhwE1QF6hI/9YM5J1fTL3r3Z5T7FjkODYKBc3pILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418581; c=relaxed/simple;
	bh=kaU8G4j18/Cs1qi+f4jau5uVWrEEoDcVM2xUt9D7oLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r8lVV8La50OiE0q1jg/me2Nnt1z2b+QKJ7r3rQzgPHY82OCvwys04+CB4afmpeoJjsyaGNozXZbbP5yLSezdmMrDXT8JEe+DFYV3YiQGGiGYCRfH+nLf7kIyx9sQgFicni9DFg+BNH9L5ryzNnSKclYaG48Bf4Z7x99roxklbcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666d7cc4e6e6-affa8;
	Wed, 04 Sep 2024 10:56:15 +0800 (CST)
X-RM-TRANSID:2ee666d7cc4e6e6-affa8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866d7cc4e1b0-09756;
	Wed, 04 Sep 2024 10:56:15 +0800 (CST)
X-RM-TRANSID:2ee866d7cc4e1b0-09756
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: tglx@linutronix.de
Cc: mingo@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] selftests: futex: Fix missing free in main
Date: Wed,  4 Sep 2024 10:55:59 +0800
Message-Id: <20240904025559.7356-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Free string allocated by asprintf().

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 215c6cb539b4..fb2dab46087f 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -416,5 +416,8 @@ int main(int argc, char *argv[])
 	ret = unit_test(broadcast, locked, owner, timeout_ns);
 
 	print_result(test_name, ret);
+	if (strlen(test_name) > strlen(TEST_NAME))
+		free(test_name);
+
 	return ret;
 }
-- 
2.33.0




