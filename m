Return-Path: <linux-kselftest+bounces-35874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B5FAEA423
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841743B0643
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3C92EAB75;
	Thu, 26 Jun 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TkQrMjNs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04F28FFEE;
	Thu, 26 Jun 2025 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957984; cv=none; b=uCDNse1PjaXQFdCreLukhKn8nB2dQo1ZGEu3KdPOvizBlAGlc7LRIkKp6r8VzaZyBuDKBy+8+xaPpzM2rFXHzzPZ5CqBIYIsQPphoA3HTdANWi9mTSnWx4rM1PqYmTxLKYUy/ucQIN60QPHmViwoiWS6uYgMRJzwKhLWOya7718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957984; c=relaxed/simple;
	bh=HdsgE3dVEvFD0Kza/FGL4PVyH2AyEt8jTw7NRdOU/NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PXI3ervZSzRmDdtrFtHQgCM56oF2gSZYAenvBZOgmMUVZunbIgUj4tLyrtX7+0QppCQXYlFThZ4bZoIzl/ZHF7qBl5cDzpUluDPLHvwsoH/nKD+0dNbqUGobSFQhKVxxHvxUVjr7FzNDfrl3KiJmrptT+BgKKDAYbdcW5Rks4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TkQrMjNs; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fyXXUndsFU1fi1/cHrhrRGj97R8gSsjU9AE57nmvn3s=; b=TkQrMjNs4RjBXp/YeWbS3Vhgbg
	JonCqV01p1fPNrol+NpnVLdkwbDwyJT27OTBQikWIFq6hFkR9zOmri0stwuMUDfgL17nfoMAJCZKG
	I7cRTq7fQsP+cMcLnx+zUiJIkvB7+iswNLYI1Dt5VlyfYnzibMXG0ydWtf7NKKEDmAGBo+Cm5xIgZ
	riUW9sEBjeASXbwXMmPcxyGWSYR3H2beDc4yoZ0MNMyhQ2TFw8uSvssq4vp47UMc8axIjNpVkquSP
	vj7i5kqVxATKRTYKUWlmqYND3ZtK7j8o3sJ/y0OmhTfQVfO7q6er5/ACKFm/U0le3ZmGOWcyUI1ov
	9Z5/JAtA==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uUq9h-009491-Ry; Thu, 26 Jun 2025 19:12:58 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 26 Jun 2025 14:11:25 -0300
Subject: [PATCH v5 1/7] selftests/futex: Add ASSERT_ macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-tonyk-robust_futex-v5-1-179194dbde8f@igalia.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
In-Reply-To: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, kernel-dev@igalia.com, 
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


