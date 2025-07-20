Return-Path: <linux-kselftest+bounces-37727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38721B0B8D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72920189B3FA
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1C23D2BD;
	Sun, 20 Jul 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PEd5QltP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BF23C4F6;
	Sun, 20 Jul 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050587; cv=none; b=XXk1RC45uyvMhDRi84rYkShc9+ANorHoSJbTGVwvbi7HEq8a8l1kKYEk0vNsBcqzVJvt6PLCFm30i8XR0j78RPtSAouvb1v/n182g85iwXHtXqPo1gFxW6UFxf5tOMHjFYs9tmeYugAjm6rQEULhBD987DtTiHAy/onvVuduFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050587; c=relaxed/simple;
	bh=EgUUClrtZoSV2ET4K1x7vsFC2WgggJqaC7FtK4/bcfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7lpGxAml1Fpq5cpmsp1sjZ3EfpdtlxOi7o3QV2ceoMc3ojhY+2twntdF9duLn1kdH6/eVrG0CebwH7bCfLrXyC+EBNgpKVcABDEbFfsZXGhy1XLzQ3HWCtShInhj6fIUDW5MsSB17q3a4H3uWBWjoJCNQXb5E7JfuGphM+Jlks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PEd5QltP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VqE1xf94ia754U0dCq5ewRXtxwlRWZKXgbiv6ST1aXE=; b=PEd5QltPVoTWHJRr0WS4Wf2KSV
	TZ/9KJUuHKfu5lsM7h2HS88U7FZTaIZCeA/CZ6MY/bH+kgcLvjY7wjB/zjmh87zsS4uuSdtvVdWsI
	tQoKAmyF47zqbAWUGcR5Px88K1e083fhJ2608OUJEQE+ReoZTbfRXzpRJtEMxFHcGGD+ZDOcRzFTq
	2s3vG21XG8y326G2+BMwzP+F0JTl4mgBSI6zQj5pnccM+CqjpnJ4f2Islm+FLXqPyKcHtCuqoQdPt
	KZeaYvHA45EiLUnIe+UPJ5en4Yg0raUn35cAdvbsyo6eeDVbavYWPogVHA9gdz6l0x8MfwgHDTxCr
	h8G0fgOA==;
Received: from [187.57.76.50] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1udcXP-001Sqt-MV; Mon, 21 Jul 2025 00:29:43 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 20 Jul 2025 19:29:12 -0300
Subject: [PATCH v2 14/15] selftests/futex: Drop logging.h include from
 futex_numa
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250720-tonyk-robust_test_cleanup-v2-14-1f9bcb5b7294@igalia.com>
References: <20250720-tonyk-robust_test_cleanup-v2-0-1f9bcb5b7294@igalia.com>
In-Reply-To: <20250720-tonyk-robust_test_cleanup-v2-0-1f9bcb5b7294@igalia.com>
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
2.50.1


