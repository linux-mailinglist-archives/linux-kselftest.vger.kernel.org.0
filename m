Return-Path: <linux-kselftest+bounces-2805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A792829F5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 18:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4909F283F6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 17:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191CF4CE1A;
	Wed, 10 Jan 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="f9SIZXN/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A464CB4E;
	Wed, 10 Jan 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4T9FRX2QMFz9x54;
	Wed, 10 Jan 2024 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704908376; bh=/3ieUSPDCtVqH9T3w3PB7MTKo77k/gatkBOL9tmqqsc=;
	h=From:Date:Subject:To:Cc:From;
	b=f9SIZXN/UtWynuh574nJRON412qgn99Gc/E9x6iFR/aiiI6U0zWyUFdBlyGvVwqtc
	 Z0ne9S8flYNNjdS6NPFsV1m0tuvgw8EB8A1kCQKVQjrU26a0GCur4iXa/gtSQhlXHB
	 4FqR2YybKt3XvIxjZlhb1FlE8X6IM11qOApF30Mw=
X-Riseup-User-ID: 9C3CCADC7C9C36867288DF9C044829AFC3062AC692DF9283689F2DA18DCAC7E7
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4T9FRT4Wn3zFsZS;
	Wed, 10 Jan 2024 17:39:33 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Wed, 10 Jan 2024 14:39:28 -0300
Subject: [PATCH v3] Documentation: KUnit: Update the instructions on how to
 test static functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240110-kunit-doc-export-v3-1-9b4221763401@riseup.net>
X-B4-Tracking: v=1; b=H4sIAE/WnmUC/4XNzQ6CMAzA8VchOzuzD0XGyfcwHpB20phsZBsLh
 vDuDm5eND39m/TXhUUMhJG11cICZorkXQl9qFg/dO6JnKA0U0KdhBQNf02OEgffc5xHHxJH7KU
 1UnSP+sLK2RjQ0ryTt3vpgWLy4b1/yHLb/sCy5GWk0XUDVoCpr4EiTuPRYWKbltU/QRWhsQpAa
 3O2CF/Cuq4fMVVnAfMAAAA=
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Grillo <arthurgrillo@riseup.net>

Now that we have the VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT macros,
update the instructions to recommend this way of testing static
functions.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
Changes in v3:
- Maintain the old '#include' way
- Link to v2: https://lore.kernel.org/r/20240108-kunit-doc-export-v2-1-8f2dd3395fed@riseup.net

Changes in v2:
- Fix #if condition
- Link to v1: https://lore.kernel.org/r/20240108-kunit-doc-export-v1-1-119368df0d96@riseup.net
---
 Documentation/dev-tools/kunit/usage.rst | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index c27e1646ecd9..8e35b94a17ec 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -671,8 +671,23 @@ Testing Static Functions
 ------------------------
 
 If we do not want to expose functions or variables for testing, one option is to
-conditionally ``#include`` the test file at the end of your .c file. For
-example:
+conditionally export the used symbol. For example:
+
+.. code-block:: c
+
+	/* In my_file.c */
+
+	VISIBLE_IF_KUNIT int do_interesting_thing();
+	EXPORT_SYMBOL_IF_KUNIT(do_interesting_thing);
+
+	/* In my_file.h */
+
+	#if IS_ENABLED(CONFIG_KUNIT)
+		int do_interesting_thing(void);
+	#endif
+
+Alternatively, you could conditionally ``#include`` the test file at the end of
+your .c file. For example:
 
 .. code-block:: c
 

---
base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
change-id: 20240108-kunit-doc-export-eec1f910ab67

Best regards,
-- 
Arthur Grillo <arthurgrillo@riseup.net>


