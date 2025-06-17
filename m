Return-Path: <linux-kselftest+bounces-35225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0EADDB64
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 20:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFED17C537
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF272DFF3F;
	Tue, 17 Jun 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="br0MBrsR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4E2853E0;
	Tue, 17 Jun 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185328; cv=none; b=QLe+kd5vB+/HyoNLtPny7wTra8pwCh/WmjFp/+9wMSThAwjCae2SoL1DCjhHlspgBSyw0057JIYiIJOolF1TaKCxw78L422K4Aj5DTfzK0Y3dV5z1AMn2YxrhE8sI9Cnlypykmyqr/j6HoLqxJJ7T5800pWP4IGNc25dfHRg1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185328; c=relaxed/simple;
	bh=HdsgE3dVEvFD0Kza/FGL4PVyH2AyEt8jTw7NRdOU/NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GvZTNKS94tRjulDB8D3t+c8Uw8z1iz1eK6e8Tdy6zLFnM8zko0hWWgZfYI828BAouxv/h9MEwtvwAo4WAvL0/jJSpH9hEqChLfYZb1b8iu0lI2yIBkpiw7SY7QxlHP1/eV6mq98mbdsbUecDHYChucqhZxMb0iN9YJv9Y1YB84s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=br0MBrsR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fyXXUndsFU1fi1/cHrhrRGj97R8gSsjU9AE57nmvn3s=; b=br0MBrsRE9RK8fS/T57MdHP6H4
	VnkGANwToBV2D1zevNfDTTWSDoOPoy1ShzfxLKrwc5GF14DrnhOr8nBiocgx32niK86/sJlXd8Baa
	S7RxASIfpWCLgwhGOQPHwt17orkvOPoMIMTYrJ6dffwKTOeNvrSOm6UDLn/N6GK4qFGtXqh+z0X9s
	tvvb9jhye2eef45j1saJ0Qrg12Ts9yN37X4U7QtsVu7hI+lRbfX/M6W3xVoyznfmZvWvI/zeB/l0L
	pHhjTxNNbotVsY09/v5gRHd4DumcGXP2gjlBYJncOJ8xgzHRA7eUYv6WyQy5zInMuwptirP3heBzo
	72QjImgQ==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uRb9D-004j89-3M; Tue, 17 Jun 2025 20:35:03 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 17 Jun 2025 15:34:18 -0300
Subject: [PATCH RESEND v4 1/7] selftests/futex: Add ASSERT_ macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250617-tonyk-robust_futex-v4-1-6586f5fb9d33@igalia.com>
References: <20250617-tonyk-robust_futex-v4-0-6586f5fb9d33@igalia.com>
In-Reply-To: <20250617-tonyk-robust_futex-v4-0-6586f5fb9d33@igalia.com>
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


