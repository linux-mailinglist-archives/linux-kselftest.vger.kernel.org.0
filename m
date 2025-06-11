Return-Path: <linux-kselftest+bounces-34664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1190AD5025
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 11:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2893E7A91C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86896267709;
	Wed, 11 Jun 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FdeFSPUb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XEs1E128"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F426529B;
	Wed, 11 Jun 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634610; cv=none; b=N+qmMTBfeJxjej+dzVEvdY/Ks069n3HWaKMvflHlNeIyonU2gxO6pndMHeEQu0G+ByvcTdxr3zTNo8xVGVUZHq8b42GH6w+kSGJcgZNgGg4+8BQkd0FBl1Lt+utzU8AJKd3zSsNL1x0U4t1npJ0dwm/iH/T6vPxjuFZ4XVp04r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634610; c=relaxed/simple;
	bh=mVfyXIP9JLUrBFl7GsD5f1SXSqA4+C74McYsvCIxMFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VsT7o4tEbVgNxHB5FUGmWPJlkckn8zmHQa7CQEFaoqlog10eTOcMiOGBKQMAuoI7gJfSukA1QhIfigZbE+VLrI5Q7dbwpvHVHxP7VHfT2poH/4Ri5y7xVE/kihfdtuSujWlIk9Uf0wL0P8+m/CJRcDRfB9HSDjOMWc6oZ3MuRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FdeFSPUb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XEs1E128; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GFksH9LPMmP7bYyfX4IW1QhQb97MRGe7VJvXQH5Qf8E=;
	b=FdeFSPUbQlIjY88c25kRBegK96msaEAPvepPEoyamCBClJGY9Oycct/bzJGK6BmgLVkYM0
	LyE/Q7wHK+5ICZwADHqv7FQ1crjnD3M+eWbGlh9AQcB61C1ptdS6QTvnV3TePXi4E4jo3+
	xWFKmaDksVQQ65uqqc1/5Dg47cexbY0vjJm5mU0eTd+WW/kcR1Bzs/tPbZaw8byIsgOYgE
	X+nfiWMO/EhZHpdPfTjeYeSYPiIn6UWG0X+kP9k2E5d5ZJyypv7Ow/WMR6ZQ9MUyeFyCd9
	vmF5uj8Ij4RC7oG9eNiDtYN5+lOI/bxc1DqT1o/D6qI2H+tK8FWY3F9moqK4lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GFksH9LPMmP7bYyfX4IW1QhQb97MRGe7VJvXQH5Qf8E=;
	b=XEs1E128R+ew11J/9X4/Dg7rMJNr6Mga4qU9oa91HKqgncmbaeIrB7zt+2mtr+l4V5Jyqj
	OAY1ey/tJipwEPCQ==
Date: Wed, 11 Jun 2025 11:36:35 +0200
Subject: [PATCH] Documentation: kunit: fix argument of MODULE_IMPORT_NS()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-example-v1-1-cf2a1a80518f@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACJOSWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0ND3ezSvMwS3dSKxNyCnFTdFENL01QTw2SDJGMTJaCegqLUtMwKsHn
 RsbW1AGflkKhfAAAA
X-Change-ID: 20250611-kunit-example-d195e41c0b34
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749634606; l=1138;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=mVfyXIP9JLUrBFl7GsD5f1SXSqA4+C74McYsvCIxMFg=;
 b=VPkKhJXccGFHvBS/kfawZMHVmi0l4KnKzIRjNgp8MsiNCqbezdx9nHFfBFaHE+m2nMW0wzW4F
 zK1q8ktwjAACw60SLIrhyPnWJdze9N82/a858uSM0yWefP4Pyed4okv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The argument to MODULE_IMPORT_NS() should be a string literal.
See commit cdd30ebb1b9f ("module: Convert symbol namespace to string literal")

Fixes: d208025db6d6 ("Documentation: kunit: improve example on testing static functions")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Documentation/dev-tools/kunit/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 038f480074fd7aaa1f8e1b344bc74bf3426cc173..066ecda1dd98e73a01d50545e79c38a99a3e05a2 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -699,7 +699,7 @@ the template below.
 	#include <kunit/visibility.h>
 	#include <my_file.h>
 	...
-	MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+	MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 	...
 	// Use do_interesting_thing() in tests
 

---
base-commit: f09079bd04a924c72d555cd97942d5f8d7eca98c
change-id: 20250611-kunit-example-d195e41c0b34

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


