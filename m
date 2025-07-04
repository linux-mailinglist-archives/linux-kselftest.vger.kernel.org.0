Return-Path: <linux-kselftest+bounces-36593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF5AF964F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0940544F77
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E9315508;
	Fri,  4 Jul 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r8n9cDJM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621330E83B;
	Fri,  4 Jul 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641566; cv=none; b=tpFYE6K3R4JtSAMoiTUZWzcj6jh7JRXdfjiCKwdqzBha///RItu/pZG8PbdsxxW60H9baDSO5XXkna14VneNAv2t+BamxoOF5AMAM7R8cEyCTYsFEW8F+2TRlVgwCn9iS543bxOireJVCJrSeBGqAdbWV0vZGPJJaNDjoVoPvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641566; c=relaxed/simple;
	bh=IGx6RA/qSGDnUuqoITgyVlrWelS8o+WS5T5N7bVta6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HmfZfmQMLFyMP7Qj3jrVujxSXZlaBozlDMIxgAgG63iX8IwOobF3eyfzGG1i698KxWyI+NSVIhOaX4jhWDwi+cwP0f4WxGG7OGJxN9qVSDkJ+NL6lNRV+YPJFuG5p7JVsk3TWTPllMMfG9ee+GV30WaG6cjjAD1SpeOnAmKhccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r8n9cDJM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IQAthR6ECHpnnSjG9/Db3T6k6+4p4GhEJ3Vk90bWF+U=; b=r8n9cDJMo1iEUmoC21xIVVzBAq
	ePztTWWuKQQkYW0nvwJ0k+BZTn1cgcDiZfdF0DICvvS09AFe+8ANLG61PdziISf1IIvZ7eXa2/fMu
	jHaMemkVNsrA3IZBe2MJVXSeAp8KzhbWMQp7MgCLXPwoNTRgHEc9HbdP09ealo0TP1KsHMKNOTf4Q
	P+CqoyjK1T986EDy3x2vOEXtF4aaygOOKPqo8RswDs24UMEPQ73A6tQSrBvic8Asn+JV6CpBhJCDz
	DltFtpNwqan7mgJ+GXTlW2ITr4zlf3Wov6Q1OdhcMXWBnOQkYXdTV+O1detB+/epRqBN8NRD+8gMI
	f1DTB6SA==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhzG-00CTWt-SX; Fri, 04 Jul 2025 17:06:03 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:18 -0300
Subject: [PATCH 14/15] selftests/futex: Drop logging.h include from
 futex_numa
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-14-c0ff4f24c4e1@igalia.com>
References: <20250704-tonyk-robust_test_cleanup-v1-0-c0ff4f24c4e1@igalia.com>
In-Reply-To: <20250704-tonyk-robust_test_cleanup-v1-0-c0ff4f24c4e1@igalia.com>
To: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

futex_numa doesn't really use logging.h helpers, it's only need two
includes from this file. So drop it and include the two missing
includes.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 tools/testing/selftests/futex/functional/futex_numa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa.c b/tools/testing/selftests/futex/functional/futex_numa.c
index f29e4d627e7942bd0bc8f031f9c0ad59c157c536..e0a33510ccb60c799275cdc8b41254c8161f8090 100644
--- a/tools/testing/selftests/futex/functional/futex_numa.c
+++ b/tools/testing/selftests/futex/functional/futex_numa.c
@@ -5,9 +5,10 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <time.h>
 #include <assert.h>
-#include "logging.h"
 #include "futextest.h"
 #include "futex2test.h"
 

-- 
2.49.0


