Return-Path: <linux-kselftest+bounces-41779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A64AB81F5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5F8721023
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6818A311956;
	Wed, 17 Sep 2025 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SInbxa2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC922311599;
	Wed, 17 Sep 2025 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144215; cv=none; b=S1fwZwgSLmikgskehMPKv/8W584bHxejrZsEKAl9ZPWZ23R41c7HlLF53Q4cJ4zuSU2ndI/Oj7i/BBqjFuOunRcoiQssmifU5Zs6GtmL5hGJ6i/JbmH8/yWxkurLKbK5F80SiIRB01i0Sl2si93mHlOCYQmyeNrjUBUMw8chaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144215; c=relaxed/simple;
	bh=O29zyrKwo9zuXGS1w5tGY35J087SKVfJ1Df8kLr+7RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAhzDKceeh0tgz59s9ssBFEHQFPzaPF2Behif/Y956n8RPnhH8FV9K0MbasT1QFisZhpHzMLtpGbCCACJzmQjfhL+aiGffOeuSG/GdWPVg4Mzy28MAOcJFCc+FErqfSLnj9uOc0l+l6Ti/1P7NqRZOAnXdsMw3V8tNXnZbr9DuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SInbxa2o; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yk8aHpsdu2xG8cIHGwA0qvy5SqjAdyxpb0ZZ8nebi6E=; b=SInbxa2olQ/KkgiDJCqJwqw4sP
	BuwTNpFUQvqT3nOwAHd0srTEvvM0VZz5wxlgawWDI032en/Og9Yeop0a4zx5rluZvtF3NNKMTlWyW
	uUP5FvitvzTMuLvdtGFaw8OzcnDXMjKD6hkQ/BG+ocis2EkLF8a7hShc3F07xv4SxbYI/fUCX5LN4
	duzz7cSyxBOU3LmPqBcvcLiEf4MNse9kkMcE3e4kH2I7a/+XKyOfdwSchuumTNoQe+ZJ+mR5wo9da
	JpAt85z7t/F2ivjpqSZfVtNHvaT5iXewlhTpZM+zOoqeDdMWG+O+f8ATDOl+PVV6YvWU0299gyYWG
	eu7am4wg==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzch-00CsMq-H1; Wed, 17 Sep 2025 23:23:31 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:53 -0300
Subject: [PATCH v3 14/15] selftests/futex: Drop logging.h include from
 futex_numa
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-14-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-0-306b373c244d@igalia.com>
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-0-306b373c244d@igalia.com>
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
2.51.0


