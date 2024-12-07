Return-Path: <linux-kselftest+bounces-22958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D789E7DB5
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 02:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC621886E80
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC213FF1;
	Sat,  7 Dec 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffo.eu header.i=@steffo.eu header.b="nMk42cf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVQBVqtg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE10DDAD;
	Sat,  7 Dec 2024 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733534651; cv=none; b=JwPLkYzxztpvZ6RNdPy3b2HgcDBYCh0zTs/8+lab1watsR5fl51XRggKlZlyknclLPHRX//vMZAQ68jHqLekN2Gb/gM68wELElQfEAXmP9gF0JFE1D50SaOsRbCrJidFOQOtHZ4Ab8JLWBNX6N8swRpDtBB6YleUHPORso7BA1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733534651; c=relaxed/simple;
	bh=PoFcjLzAbYJRYSxbLlYXiOYLRzye9abGuNCylaBXdaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/F1L8Tci7WUS+T6Nb5ZeTURN2WpZdRGVKx/haDrPE+sZq6oqnwcQuORGXur9C0qXm0BWhjrTqzm5lkPXm4DIHidCYZDevnGhb7SFifULlkOhDv7Oz6UbO1M91ufvcang3djTWnbuyXj74Lzn8TlhOS3L5xv53ggq3CiWag+EFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffo.eu; spf=pass smtp.mailfrom=steffo.eu; dkim=pass (2048-bit key) header.d=steffo.eu header.i=@steffo.eu header.b=nMk42cf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XVQBVqtg; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffo.eu
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AF8181140147;
	Fri,  6 Dec 2024 20:24:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 20:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffo.eu; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1733534647; x=1733621047; bh=ElrwaWm+DWF/q4wPHrpLj
	eFjBDa+UXNQHtYh2KqkM3A=; b=nMk42cf8/6UvJaxjtXZhh2Dqct2QUsXGbGT8F
	6cFp3q/FMZ1xMmhv08IR8VaNEri8ZWgOWBvBA0FbxNEA5QoF4WZg4DqIUY0rZ89e
	BMwq1yn0b4ToFenFSJg34BJFhnwO7+RwlEJ3vp5BS08zDcVgywVSqsusEluawz3f
	1YviWx7iD3SfKwMMLdZlcisYdyJknglv3aSJ6rKci9ry77CK83Z82XV8aWy06a+T
	2jThdJfBSqNe2Vr3iaIaDj0okh605MzaClNpCmfXyPJm9DJ6OqD6X4RGMGuAbrJz
	e3U9WPGVtFvJ2CxU2Pdn9Cd1+7Yhe0WGv+RGm3YwZd5bI+tTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733534647; x=1733621047; bh=ElrwaWm+DWF/q4wPHrpLjeFjBDa+UXNQHtY
	h2KqkM3A=; b=XVQBVqtgQiJRIQGdIAS8hro79CfOKtsSWlvmBgqfun2CrE7I4TP
	AS3FIhN54WwfaWWkAVze5Q8samtPElCaWJAXc57kWXSts5u5zjnLujg7auMAglp3
	E9CX+A4ixXZrtU8ZPr1EhlwXm2hnT2tLnwiRC4hIGElkU8bjjOzfRr5TVjApPaKD
	aRUZqPeaFyFxET/L8Y/6RiSFdE6CYxZE6o/6zedNzvRXLf1K+7cNuWnsRXRj91Dp
	Ckjz7+ozXC8YbHqY+YDwrTVPGfelkGf3IyBxDq2g62o7WOpmiCdYws2BbBYDE0g2
	QjNIg5AXDm43JSvyoCHpR1u7lrqDojXt30g==
X-ME-Sender: <xms:t6NTZ6-Awdg70dKpB0cL432Ewcr1L93wH3cfVCTp6S68KdRr8hW5uw>
    <xme:t6NTZ6sgS8_TCYyeYDzxuJFgLhIDUL5RyfhmY4zxOy7CT9OzOds1dFR2PjURMliWY
    YUHziVKzwgOVBVgMBw>
X-ME-Received: <xmr:t6NTZwDjWiEgK0qNbvl1qwVdYXvsJX2CNC3MsVCy0oxJMemNsns9C5SzzwCEaEecrJBqUBEn9_RQdgHSa3JNu5bSqUFXUafWPmeH-aLLMUEW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedtgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgggfestdekredtredttdenucfhrhhomhepufhtvghfrghnohcurfhighhoiiiiihcu
    oehmvgesshhtvghffhhordgvuheqnecuggftrfgrthhtvghrnheptdfgvdekudeiheduff
    fffeeuvddujeekgedthedtjeevvdeuveeggfevleeuveetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehsthgvfhhfohdrvghupdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhurghh
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesshhtvghffhhordgvuhdprhgtph
    htthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:t6NTZycTiGQGYNlwzrwn2InweLRuz5m7ihtvc_QHYrF_Q2yuGhZ2-g>
    <xmx:t6NTZ_P1XMVq7cpbrl9TlgrRK4ulv6gnPJEW-ksxPMDalLacujuRdQ>
    <xmx:t6NTZ8mmd4TYKUb449uFWGkE-V3nxw4Qh1HkuFA-lh7OVQetyAehvQ>
    <xmx:t6NTZxsrtGjdxGd0DOErBgJkqDdB-cHbdUmXiAcJniIjkKqpMeSwDQ>
    <xmx:t6NTZ0ri17psCoSglycEDYKMRe8ocD-0ff6g-u4Y6xt-TRb8OJGwq-ZX>
Feedback-ID: i48314939:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 20:24:06 -0500 (EST)
From: Stefano Pigozzi <me@steffo.eu>
To: shuah@kernel.org
Cc: me@steffo.eu,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kselftest: Add ksft_test_result_xpass
Date: Sat,  7 Dec 2024 02:23:25 +0100
Message-ID: <20241207012325.56611-1-me@steffo.eu>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions ksft_test_result_pass, ksft_test_result_fail,
ksft_test_result_xfail, and ksft_test_result_skip already exist and are
available for use in selftests, but no XPASS equivalent is
available.

This adds a new function to that family that outputs XPASS, so that it's
available for future test writers.

Signed-off-by: Stefano Pigozzi <me@steffo.eu>
---
 tools/testing/selftests/kselftest.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 29fedf609611..685d9f9554fc 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -18,7 +18,8 @@
  *     ksft_print_msg(fmt, ...);
  *     ksft_perror(msg);
  *
- * and finally report the pass/fail/skip/xfail state of the test with one of:
+ * and finally report the pass/fail/skip/xfail/xpass state of the test
+ * with one of:
  *
  *     ksft_test_result(condition, fmt, ...);
  *     ksft_test_result_report(result, fmt, ...);
@@ -26,6 +27,7 @@
  *     ksft_test_result_fail(fmt, ...);
  *     ksft_test_result_skip(fmt, ...);
  *     ksft_test_result_xfail(fmt, ...);
+ *     ksft_test_result_xpass(fmt, ...);
  *     ksft_test_result_error(fmt, ...);
  *     ksft_test_result_code(exit_code, test_name, fmt, ...);
  *
@@ -227,6 +229,20 @@ static inline __printf(1, 2) void ksft_test_result_xfail(const char *msg, ...)
 	va_end(args);
 }
 
+static inline __printf(1, 2) void ksft_test_result_xpass(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	ksft_cnt.ksft_xpass++;
+
+	va_start(args, msg);
+	printf("ok %u # XPASS ", ksft_test_num());
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
 static inline __printf(1, 2) void ksft_test_result_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
@@ -318,6 +334,9 @@ void ksft_test_result_code(int exit_code, const char *test_name,
 	case KSFT_XFAIL:					\
 		ksft_test_result_xfail(fmt, ##__VA_ARGS__);	\
 		break;						\
+	case KSFT_XPASS:					\
+		ksft_test_result_xpass(fmt, ##__VA_ARGS__);	\
+		break;						\
 	case KSFT_SKIP:						\
 		ksft_test_result_skip(fmt, ##__VA_ARGS__);	\
 		break;						\
-- 
2.47.1


