Return-Path: <linux-kselftest+bounces-1779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13242810736
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 02:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26081F21711
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4F519C;
	Wed, 13 Dec 2023 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35b7wDiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E229DD0
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 17:02:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db5416d0fccso4544384276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 17:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702429347; x=1703034147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5lVM/dVKeVFErFd3K5fREWS3rUw2b6FfvKCy8RqIqw=;
        b=35b7wDiIAe5ALWKl2T7A/ZPjqEPfv8jasQy6+XoPJzR9nnFNYtFZOmRc2FKIa7Ypl8
         VhOIkJ1MoQ2jwnuLMfmuzXfhCGM5n3kOMIqjIYx4qjwXrSGcqakVwFdiGei/HgxTuWZX
         HOHT+0wan4r5P9fgiwkVwGX1SZLgv7ZvcewzhoSt72c1KpB375K3O7nZsOLCk1T2KYAD
         IIXmxTqnSezpsTBHJiUizo9nf0ESrCMEuvRnSbF9Oj+HxkLc7/udGj/KhP2cE0Xk/eN/
         BlUgpJDBlMqycWDGTRTEzEADMQw9Y5ouPQeCGJ/WsKE93kPvIkb618Uf4/muR+d4CuSG
         71AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429347; x=1703034147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5lVM/dVKeVFErFd3K5fREWS3rUw2b6FfvKCy8RqIqw=;
        b=i88wEmWbYi07fOpkFQla/7uzzWKPuw95RBfmxBQZolgeU63a6NjUvGGB6G/ZZuZRe4
         Oh9YA3Xx3XfRXW+RPeuZOx9t5hbAa8N724EhUUSC+HacnTho08QqH5COsh5gFkayEJ4m
         VA08uBeDuNcVu5dsZFSLQODUSNF1ZpYTcxTqAhYAGkGNtHyS2gVT7MiS+33Ma4IyvZx0
         npxobrbjWUPKfmQrPZUp84jCMs2bXxs8lGy5OSTGSGydGJ/hnL6aX7bhxaK0gv9rLuBd
         lORN6cSyj+LggFumt1kjM5zJ87Ut2o9kPTqOVD+v+WwTsxV9SzBi6yxHZDUD+H6Zwdya
         DvMw==
X-Gm-Message-State: AOJu0YxY8R9ejxwtO48ZeHp2V1sSXNZyJNM0+fiteLkKDZ9/kX06/njm
	q8KbPRQuvgxgG2x0FTU+Eh4cBy2L4A==
X-Google-Smtp-Source: AGHT+IGr1w0qw3F7kxqazx8LvpOGQye9waZfDeApENdjX5TDzrAeuVg5Q14ZVN024te9phQXIHT74WOGhg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:f10:b0:dbc:b4dc:fdfc with SMTP id
 et16-20020a0569020f1000b00dbcb4dcfdfcmr15137ybb.8.1702429346872; Tue, 12 Dec
 2023 17:02:26 -0800 (PST)
Date: Wed, 13 Dec 2023 01:02:01 +0000
In-Reply-To: <20231213010201.1802507-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231213010201.1802507-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213010201.1802507-6-rmoar@google.com>
Subject: [PATCH v4 6/6] Documentation: Add debugfs docs with run after boot
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Expand the documentation on the KUnit debugfs filesystem on the
run_manual.rst page.

Add section describing how to access results using debugfs.

Add section describing how to run tests after boot using debugfs.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v3:
- Change the introduction of the debugfs section
- Add detail to not being able to run concurrently or run with init data

 Documentation/dev-tools/kunit/run_manual.rst | 51 ++++++++++++++++++--
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
index e7b46421f247..699d92885075 100644
--- a/Documentation/dev-tools/kunit/run_manual.rst
+++ b/Documentation/dev-tools/kunit/run_manual.rst
@@ -49,9 +49,52 @@ loaded.
 
 The results will appear in TAP format in ``dmesg``.
 
+debugfs
+=======
+
+KUnit can be accessed from userspace via the debugfs filesystem (See more
+information about debugfs at Documentation/filesystems/debugfs.rst).
+
+If ``CONFIG_KUNIT_DEBUGFS`` is enabled, the KUnit debugfs filesystem is
+mounted at /sys/kernel/debug/kunit. You can use this filesystem to perform
+the following actions.
+
+Retrieve Test Results
+=====================
+
+You can use debugfs to retrieve KUnit test results. The test results are
+accessible from the debugfs filesystem in the following read-only file:
+
+.. code-block :: bash
+
+	/sys/kernel/debug/kunit/<test_suite>/results
+
+The test results are printed in a KTAP document. Note this document is separate
+to the kernel log and thus, may have different test suite numbering.
+
+Run Tests After Kernel Has Booted
+=================================
+
+You can use the debugfs filesystem to trigger built-in tests to run after
+boot. To run the test suite, you can use the following command to write to
+the ``/sys/kernel/debug/kunit/<test_suite>/run`` file:
+
+.. code-block :: bash
+
+	echo "any string" > /sys/kernel/debugfs/kunit/<test_suite>/run
+
+As a result, the test suite runs and the results are printed to the kernel
+log.
+
+However, this feature is not available with KUnit suites that use init data,
+because init data may have been discarded after the kernel boots. KUnit
+suites that use init data should be defined using the
+kunit_test_init_section_suites() macro.
+
+Also, you cannot use this feature to run tests concurrently. Instead a test
+will wait to run until other tests have completed or failed.
+
 .. note ::
 
-	If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
-	be accessible from the ``debugfs`` filesystem (if mounted).
-	They will be in ``/sys/kernel/debug/kunit/<test_suite>/results``, in
-	TAP format.
+	For test authors, to use this feature, tests will need to correctly initialise
+	and/or clean up any data, so the test runs correctly a second time.
-- 
2.43.0.472.g3155946c3a-goog


