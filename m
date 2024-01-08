Return-Path: <linux-kselftest+bounces-2721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282C78278F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8742841A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711055777;
	Mon,  8 Jan 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="r+6nvLZT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD555C0B;
	Mon,  8 Jan 2024 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4T84pJ0tPMzDqnS;
	Mon,  8 Jan 2024 20:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704744419; bh=GvBZ4MO6PTyVXhkHH8RCr66B+FmBvQMByIVByVjvfpk=;
	h=From:Date:Subject:To:Cc:From;
	b=r+6nvLZTiiOwQwHKUoZo6pEpmQc66R0LYGLXaxUYFyo/IwfawAFnjrL9Rtz0SAWbk
	 qPzmkQ6OKRVVntbtPWQi0JvAIUQ1mzoZrIEI8IgWWE2tGTGrrTg8d/8hWccAqNMxZY
	 8PxfuV3KBpqdCbVwVBN8ThUEWRDARSnTxy/d3bDI=
X-Riseup-User-ID: 9517D74B558B75BB0763739553289EED4191B568DB0FD6AB058503A17AEBDC39
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4T84pD34PBzFrsf;
	Mon,  8 Jan 2024 20:06:44 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Mon, 08 Jan 2024 17:06:38 -0300
Subject: [PATCH] Documentation: KUnit: Update the instructions on how to
 test static functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-kunit-doc-export-v1-1-119368df0d96@riseup.net>
X-B4-Tracking: v=1; b=H4sIAM1VnGUC/x3MTQqAIBBA4avIrBvQiP6uEi3MphoCDbUQpLsnL
 b/FexkCeaYAo8jg6eHAzhaoSoA5tN0JeS2GWtaNVLLH87YccXUGKV3ORyQyahuU1EvbQckuTxu
 nfznN7/sBFZ23F2IAAAA=
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Grillo <arthurgrillo@riseup.net>

Now that we have the VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT macros,
update the instructions to stop recommending including .c files.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 Documentation/dev-tools/kunit/usage.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index c27e1646ecd9..7410b39ec5b7 100644
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
+
+	/* In my_file.h */
 
 	#ifdef CONFIG_MY_KUNIT_TEST
-	#include "my_kunit_test.c"
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


