Return-Path: <linux-kselftest+bounces-2722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7F482791F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D91C22F5D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664E55787;
	Mon,  8 Jan 2024 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="EI0uCo4W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9675577D;
	Mon,  8 Jan 2024 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4T85C45Xtcz9tmc;
	Mon,  8 Jan 2024 20:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704745489; bh=yWYgR2g5/NR7onl+pGnMt+zTaf83mLrm74A0GDCyAIg=;
	h=From:Date:Subject:To:Cc:From;
	b=EI0uCo4W/R9lOerDcFovfE17khByuxUf+RqXtGyNyRGTh+z7LXgT5MHjfN+kEyp+D
	 LKQsj+XlcLk/QxXlFx08cz/YERVkL/t3C9Bl7hu5EStFaBNgL/KUgXziq9Lb3oZstw
	 bk8BXAkpHuMenrgwzchU8eBPCR7zfOtpR/gyQS+g=
X-Riseup-User-ID: 8B28C812D41CCC59E7EBB9A6A5B3D75B2DA2F39207C1ECE892CDC6DD37E81E94
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4T85By1zZKzFs05;
	Mon,  8 Jan 2024 20:24:41 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Mon, 08 Jan 2024 17:24:33 -0300
Subject: [PATCH v2] Documentation: KUnit: Update the instructions on how to
 test static functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-kunit-doc-export-v2-1-8f2dd3395fed@riseup.net>
X-B4-Tracking: v=1; b=H4sIAABanGUC/32NQQrDIBRErxL+uha1xcauco+SRarf5lPQoEZSg
 nevzQHKrN7AvNkhYSRMcO92iFgoUfAN5KkDM0/+hYxsY5BcXrngPXuvnjKzwTDclhAzQzTCacG
 np7pBmy0RHW2H8jE2ninlED/HQxG/9o+sCNYi9EX11nGr1RAp4bqcPWYYa61fclWsELEAAAA=
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Grillo <arthurgrillo@riseup.net>

Now that we have the VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT macros,
update the instructions to stop recommending including .c files.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
Changes in v2:
- Fix #if condition
- Link to v1: https://lore.kernel.org/r/20240108-kunit-doc-export-v1-1-119368df0d96@riseup.net
---
 Documentation/dev-tools/kunit/usage.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index c27e1646ecd9..f095c6bb76ff 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -671,19 +671,22 @@ Testing Static Functions
 ------------------------
 
 If we do not want to expose functions or variables for testing, one option is to
-conditionally ``#include`` the test file at the end of your .c file. For
-example:
+conditionally export the used symbol.
 
 .. code-block:: c
 
 	/* In my_file.c */
 
-	static int do_interesting_thing();
+	VISIBLE_IF_KUNIT int do_interesting_thing();
+	EXPORT_SYMBOL_IF_KUNIT(do_interesting_thing);
 
-	#ifdef CONFIG_MY_KUNIT_TEST
-	#include "my_kunit_test.c"
+	/* In my_file.h */
+
+	#if IS_ENABLED(CONFIG_KUNIT)
+		int do_interesting_thing(void);
 	#endif
 
+
 Injecting Test-Only Code
 ------------------------
 

---
base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
change-id: 20240108-kunit-doc-export-eec1f910ab67

Best regards,
-- 
Arthur Grillo <arthurgrillo@riseup.net>


