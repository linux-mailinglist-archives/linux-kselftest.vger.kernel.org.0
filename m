Return-Path: <linux-kselftest+bounces-26465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E656A326A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 14:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152B13A6BFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823CA20E01F;
	Wed, 12 Feb 2025 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CCjZmYMd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C202046B5;
	Wed, 12 Feb 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365913; cv=none; b=e4I7NuffdbjdMl/SezDZnS8hYh0Dn57+7vhV5c2H3w5CLqouXR99lmFLwOJeqwlYy1tXFenKs2JOYUyMBP/WJdZkcXSQXkkSNVWt4XZLsEE/bg2AAR/a00Og3XW+j2BRRS22dOT8Vr5DVgunL3xsc0h2i2Ui3rEMQkjRO5Nb/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365913; c=relaxed/simple;
	bh=MJkQSs7W56DntpFG833Qo2alB3cF2jQt/JSCooTwuuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WuUlfXuIN5Hzb0JD6XHQPiTs1jp+Y3COAXHnGIbSf69NS3Z8Rh9N9NMicgcovcLENVKoBw+Gi1Bl0bGSLI2eTP8JuwfizrAtCQi/hSId6lZsTK9wVDc6q/ftz2Ehmv7COWad/kpbOPftvFj5P1jwzCxELfgiBnh1f4HI9S8NxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CCjZmYMd; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7amUHixUhNOLRTzsdFIHV7qYWqyvs1dl4k9EN17Jmro=; b=CCjZmYMd1OKnomXEoEBV2wQXtM
	zsBqi4UiqCh10IEkQLXyAyQByh5c/+GgQXOJkcQrYy/ElWnZ3nutFPM9qHLTdwPXKDWVJTU1DdEaB
	H76XpvSCk1EjMN9Y/6Tj0+nJJp53Whq41S+vZ+NR+5QM0Oixcp3dLEaD+paMLLRAWsJbcDyrA8Ei6
	xzYp/TK0FR5KIbR/XUbg810r0awK1oNQiEv1D+itEesGCakPIT5uOx3RS3hKho70iZRwEmUJY+JLr
	STawaPpMC2HZ/AfiBCjr5CM8ZhKKT1gl0CDxBDhH0zg1aCD7LXF32LHu1CVRCLrwxuA3PHsv/rnyP
	vXzSuvzw==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tiCWQ-008HIt-Us; Wed, 12 Feb 2025 14:11:29 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 1/2] selftests/futex: Add ASSERT_ macros
Date: Wed, 12 Feb 2025 10:11:22 -0300
Message-ID: <20250212131123.37431-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create ASSERT_{EQ, NE, TRUE, FALSE} macros to make test creation easier.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../testing/selftests/futex/include/logging.h | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/futex/include/logging.h b/tools/testing/selftests/futex/include/logging.h
index 874c69ce5cce..a19755622a87 100644
--- a/tools/testing/selftests/futex/include/logging.h
+++ b/tools/testing/selftests/futex/include/logging.h
@@ -23,6 +23,44 @@
 #include <linux/futex.h>
 #include "kselftest.h"
 
+#define ASSERT_EQ(var, value)	\
+do {				\
+	if (var != value) {	\
+		ksft_test_result_fail("%s: expected %ld, but %s has %ld\n", \
+				      __func__, (long) value, #var, \
+				      (long) var); \
+		return;		\
+	}			\
+} while (0)
+
+#define ASSERT_NE(var, value)	\
+do {				\
+	if (var == value) {	\
+		ksft_test_result_fail("%s: expected not %ld, but %s has %ld\n", \
+				      __func__, (long) value, #var, \
+				      (long) var); \
+		return; \
+	}		\
+} while (0)
+
+#define ASSERT_TRUE(var)	\
+do {				\
+	if ((var) == 0) {	\
+		ksft_test_result_fail("%s: expected %s to be true\n", \
+				      __func__, #var); \
+		return;		\
+	}			\
+} while (0)
+
+#define ASSERT_FALSE(var)	\
+do {				\
+	if (var) {		\
+		ksft_test_result_fail("%s: expected %s to be false\n", \
+				      __func__, #var); \
+		return;		\
+	}			\
+} while (0)
+
 /*
  * Define PASS, ERROR, and FAIL strings with and without color escape
  * sequences, default to no color.
-- 
2.48.1


