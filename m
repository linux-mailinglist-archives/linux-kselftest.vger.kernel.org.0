Return-Path: <linux-kselftest+bounces-19413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D827997A05
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 03:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D551F23841
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 01:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90262207A;
	Thu, 10 Oct 2024 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="POO4iepp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA19BE68;
	Thu, 10 Oct 2024 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522727; cv=none; b=Xdd5P63hMwK0DzDNMTv3pJP1SKfFTGKMSjLrh1kt3OuFrTsDrez4kIBoqz3rjBXHhq+aUkO29TimlCju2v9kS/UISA2d00VAedzecAdoQk7DdqN7meS2HEgjhtKqJJwNSqTzJ2hLnpr/codFe9Kq5HuvVn3H+iDEMoBhMUZ/0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522727; c=relaxed/simple;
	bh=UMzGWVqsjNFJQYMrD+7KGIKKaPgS761yHnMJWviqK6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4kZBbudVvDvK8kdT8nCLwgLl+c0JeLekRHpIlZ1fbPZhAZVVN0zBMUlWK6LJV4qqEmahUXh8skPi73n0MP/GTuRftvMjCBtX9jqNOOwQ/q16kVB+z/MG4l+ta1GK0GfrxoGgq2J9K2izW3qWwjxtm7BFPQ0uj7K2CdaifDm/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=POO4iepp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9DQwSzKhW/gKIRNA1ysxIlWqSveHuN4odNFKqcLYxVA=; b=POO4ieppUGtNcSDC5Kj6SkGeBQ
	dpljonyAC4GQbBxltmW5pg9G7pi3aOYMvP3r3fTFyNiIJVA3jUpKf22N/eX4V1mA8Eb9gUA/MXwO2
	tjpiVRN15DAIbw5fYDWQZ9ltpFS9cHOfCUIl/w3EsIeamvgZEG+NZIpBT/1+e48bjhEeqWr6liEGx
	By+VIebfi8Lh8ZbN6AkOGOpNLz6tZ4YuGrgBb9mo8wFTa8PVKX4rfsPb5Td5JexQdtEcsE3Pxhv51
	zEGGnp7goE3wqr4QEIm5ta2JHIGyDkRSaa8UaXNqpHFKgJvmpKoqXF/v2n+14046BVwtH4nXidhGk
	s4rFLmVA==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syhib-0079Wq-PZ; Thu, 10 Oct 2024 03:11:54 +0200
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
Subject: [PATCH v3 1/2] selftests/futex: Add ASSERT_ macros
Date: Wed,  9 Oct 2024 22:11:41 -0300
Message-ID: <20241010011142.905297-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241010011142.905297-1-andrealmeid@igalia.com>
References: <20241010011142.905297-1-andrealmeid@igalia.com>
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
2.46.0


