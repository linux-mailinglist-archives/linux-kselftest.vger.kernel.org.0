Return-Path: <linux-kselftest+bounces-33428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C03EABE51B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 22:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7AB4C67F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167D1FAC23;
	Tue, 20 May 2025 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f24I04oa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FCC157487;
	Tue, 20 May 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774157; cv=none; b=juAITO+VAS8V/ISPW5jBUj3cZNJzN99zMl+YKlqNVYm55WooX4FbFzciz6IMIsVaxF5YlS3wX5JyTHSUiugc3wz/QJnOCinfEic/jFAJfq7wFQCtj+Gjl4PvEBnyi/Sy0kzaf8m1tP1xDg2RTyGQcr48+sVLtlOa4VB8YhEH5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774157; c=relaxed/simple;
	bh=HdsgE3dVEvFD0Kza/FGL4PVyH2AyEt8jTw7NRdOU/NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5VKV+BeC4o2tODyP/A2RIvN/gcsIICNW49LshnSAXj/cXimTcR7XGHsoDhZH5qqrOfepASmYkQv2ZmdkACYvwmPXuIFLJlaZNpI0BSc9sF6vq+KjQ11RPsTSk+RVlONwO/Xwa3PEzNe3QwIpS9K29tm2QX4ga7ZsttNzFPNH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f24I04oa; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fyXXUndsFU1fi1/cHrhrRGj97R8gSsjU9AE57nmvn3s=; b=f24I04oaBlDBxUow8TjGfmH9+y
	4Wz5r5AIV7+/o3E2jCggtxFXHtVmiLhYADxxBpB2osEMw6yhlTq2FlH7Pg2pXoVV6LO1jzexdLA3u
	RBHCAyrQioZnUNxDk4SXoY5blOwu9YJT+6aljlvLK162sxahupMzAhz2b8xqM6gRwKZatlwA/U6gB
	DK5S3oCtfs6TrywV3vtNqT4VmcEybraHicH7cJDmOVHg2IyMYiHb4qJMMaBqaYygJYDZV7ViOfAo1
	kcisLCDjWcXhG4q4DIlD23s9shub124faPTnS8BlK3IU87KEqQzqMwVasAhurqMTFLloWqBNZtkXP
	5c1EIn7g==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uHTtZ-00AsVE-Kb; Tue, 20 May 2025 22:49:05 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 20 May 2025 17:48:34 -0300
Subject: [PATCH v4 1/7] selftests/futex: Add ASSERT_ macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250520-tonyk-robust_futex-v4-1-1123093e59de@igalia.com>
References: <20250520-tonyk-robust_futex-v4-0-1123093e59de@igalia.com>
In-Reply-To: <20250520-tonyk-robust_futex-v4-0-1123093e59de@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Create ASSERT_{EQ, NE, TRUE, FALSE} macros to make test creation easier.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 tools/testing/selftests/futex/include/logging.h | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/futex/include/logging.h b/tools/testing/selftests/futex/include/logging.h
index 874c69ce5cce9efa3a9d6de246f5972a75437dbf..a19755622a877932884570c8f58aaee7371d5f8f 100644
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
2.49.0


