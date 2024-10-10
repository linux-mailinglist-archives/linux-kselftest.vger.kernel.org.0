Return-Path: <linux-kselftest+bounces-19423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA68997D8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 08:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37EAB20E97
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 06:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656781A01C6;
	Thu, 10 Oct 2024 06:46:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2B32F50;
	Thu, 10 Oct 2024 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542775; cv=none; b=DqcRfD3EwK9hVRNL6hxum9Q6i2A6l/2ZWbCKODmXeUKspdz48rDzQIqpq5DtmTZ3Spq9TWE8ZNFR73FTVt09SuJRXmLxRdNN+oDeIsJX7vneyPcqbU9FuH4etWwPaQ0JSUYHKAQSQyhN0pRFDRHW6nM2CgMHrkpw5FLnOjPo/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542775; c=relaxed/simple;
	bh=D5BRSPBPiILM4yEAvVbU5zoG52ij8jUvL4aJwkls0Jo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ie1Xz1X2LrY5Ct/5p/x+9RoDruOvq5Xjv/HrSPbapwgYCPfyWKSvZ1zt0htnIrWKHYrHmaCbuwXtBXlPWbscI8zVUHmjB30tLRwqz5Ll0sLgN5qNlNMgYPjLP0cNsIgRaYt0CgRUBTguUXM0K8kTka+5uboYEBZVVgZ32N4WTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96707782a492-fb49f;
	Thu, 10 Oct 2024 14:46:02 +0800 (CST)
X-RM-TRANSID:2ee96707782a492-fb49f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee167077828a81-3baa6;
	Thu, 10 Oct 2024 14:46:02 +0800 (CST)
X-RM-TRANSID:2ee167077828a81-3baa6
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com,
	mykolal@fb.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH] selftests/bpf: Removed redundant variable
Date: Wed,  9 Oct 2024 23:46:00 -0700
Message-Id: <20241010064600.4574-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The error check is no longer needed for this test case,
simplifying the code.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/prog_tests/signal_pending.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/signal_pending.c b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
index 70b49da5ca0a..8920fadb3aa9 100644
--- a/tools/testing/selftests/bpf/prog_tests/signal_pending.c
+++ b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
@@ -36,7 +36,7 @@ static void test_signal_pending_by_type(enum bpf_prog_type prog_type)
 	err = setitimer(ITIMER_REAL, &timeo, NULL);
 	ASSERT_OK(err, "test-run-signal-timer");
 
-	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_LE(topts.duration, 500000000 /* 500ms */,
 		  "test-run-signal-duration");
 
-- 
2.17.1




