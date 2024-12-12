Return-Path: <linux-kselftest+bounces-23272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5819EFDDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 22:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F75E283F35
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A41B6CEF;
	Thu, 12 Dec 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UEvVN2iq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087C13FD72;
	Thu, 12 Dec 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037508; cv=none; b=a+vt8HJVw43+nIhW3Tyaiciw80LIojVvdqQ3f0yn0rFIt6lMsAyd6sYJU57tl8fqhoGlEJK85OLm/Lkn3qTsnCiq68BxOFNrfJTj2O7PhDR9yOdPiz+QZjsAeSSL1ukl4dvBjRqgpJEdY2XJ3iAnaWePAbjIWMh/+3LJqZw8Wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037508; c=relaxed/simple;
	bh=3j+9DrNL6OZYRLzZbq3/0oJDOxXSqGc1dTNQDXX0Nj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0+OZbW+sS5BjAAM2mz7NaW1BllyOx54mlfalvC6/rzrYRBIDe5/yJVlM/sNYn+4tvPvSdOACpyiaAi0o6vou2e2OGRy147W4PJ2Auu3wZFbykdfrtbpAzWLAQupTKz9RtovnY6c+TTrB9XOrxt5bpkIWyoaHRbmw2XJuCuQxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UEvVN2iq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XH/7TD+XIvuKpfWtxGg+t2/qLNZHM0U4IFCyBqEli8k=; b=UEvVN2iqIK+mI8qvENlahLME1O
	xk6Q7gMydvG+KBxj9JhQ4B8DOJnZJmTktw9Cue0BQ6vxnRMlE2BdybtNwsFbFQ2Ib1eRWyY2Bh36w
	xODoqiAaHMSYnszLlzPqObvu5sXI7OrK/r2O1XIq7jBgjijPnmzhfRl92wpNGwI1W7r+akB+dHskL
	GCK2ZEUEjg0bB7umVNG0Z8DGabiCzVN1WYR1I7rbrWjSH4T+dpxRX7putpPKZ/kJ+GGZYH+u4Jl6c
	hX/oh29WVLgDuicbJyq20SnleN5qMn40QO2SHUdMFco85HmBulsmqt1qO8R61LdhvwElQji4DhBci
	TRlLteOg==;
Received: from [179.193.1.214] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tLqMW-002Oni-GQ; Thu, 12 Dec 2024 22:04:44 +0100
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
Subject: [PATCH v4 1/2] selftests/futex: Add ASSERT_ macros
Date: Thu, 12 Dec 2024 18:04:35 -0300
Message-ID: <20241212210436.112076-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212210436.112076-1-andrealmeid@igalia.com>
References: <20241212210436.112076-1-andrealmeid@igalia.com>
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
 .../testing/selftests/futex/include/logging.h | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/futex/include/logging.h b/tools/testing/selftests/futex/include/logging.h
index 874c69ce5cce..a7070e7cf313 100644
--- a/tools/testing/selftests/futex/include/logging.h
+++ b/tools/testing/selftests/futex/include/logging.h
@@ -23,6 +23,34 @@
 #include <linux/futex.h>
 #include "kselftest.h"
 
+#define ASSERT_EQ(var, value) \
+	if (var != value) { \
+		ksft_test_result_fail("%s: expected %ld, but %s has %ld\n", \
+				      __func__, (long int) value, #var, (long int) var); \
+		return; \
+	}
+
+#define ASSERT_NE(var, value) \
+	if (var == value) { \
+		ksft_test_result_fail("%s: expected not %ld, but %s has %ld\n", \
+				      __func__, (long int) value, #var, (long int) var); \
+		return; \
+	}
+
+#define ASSERT_TRUE(var) \
+	if ((var) == 0) { \
+		ksft_test_result_fail("%s: expected %s to be true\n", \
+				      __func__, #var); \
+		return; \
+	}
+
+#define ASSERT_FALSE(var) \
+	if (var) { \
+		ksft_test_result_fail("%s: expected %s to be false\n", \
+				      __func__, #var); \
+		return; \
+	}
+
 /*
  * Define PASS, ERROR, and FAIL strings with and without color escape
  * sequences, default to no color.
-- 
2.47.1


