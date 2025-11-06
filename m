Return-Path: <linux-kselftest+bounces-44929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0900C3A4C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C678B18C58E7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A403248F5A;
	Thu,  6 Nov 2025 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I89vEoVa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EBXS5erP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AD3FCC;
	Thu,  6 Nov 2025 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425176; cv=none; b=lOAq4ovIee6fELiCfyyykLYqZVU1D8KFW8BEJULVYJHm6L8hHQA66aP0vEYjOE3dpdOQGyjr1ptXJLF73szkYE0a2seA0pmZFD0M31mkwl6JJv6F42ef6V0BCIDxp8s9hb/KBj1nMyPls2IkzwEKMWQnlfX+biJeb3IM+sDsIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425176; c=relaxed/simple;
	bh=686+WgU1Vima+Hewl156LKzHi6lYO//H6D50PeewlYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SdFbn982TXSrksG9kOqY43FM8hfsD9usLPvWUrHFpIFHeZxN0uioHOsmqugR9N05MU77xz8fxKsAZdlZzULMUDIZ7s0l5C4ux6whtIXZvjoepe3i+H1+5F88JGG1w28jz+vrFk6G1pzWCoc7w/apRtVtNdqWz2ffSOChvxun9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I89vEoVa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EBXS5erP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762425172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TXiaP7DLWWBFVuVSTnZiSqijym5UD2pyzWRhAhPoJEo=;
	b=I89vEoVanJ7s1VE9NlYDYp6g6AyCCElhlmh/nt8BSgpfpJtCeruUvsgzXTEh1q0gk5Fw0I
	gsDnqUa6WLchOQXeQv1LxPMdnaks2wDOeP5PJNctBpcqvjpDr4z/DjRXfkwnyVMFsOt5Fa
	xg+mUfsIag1DU+7Xs+9tXCVDeIknjBEl/L9bh82Y5TnVvclv0xA13Mqk89NnuAhdRb6lyQ
	PU9MkkT9AM/D8cpqUcPfN4T5udLXMCcG5IvElD3fl3jP5vs99O6MnQ76QLco97C4w5uqKy
	/DtEDnErgqfenIQ3WnZbZV6Pm3qBl6OZ3irGBp7CopxgAqxEiohRzTEXAjhn7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762425172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TXiaP7DLWWBFVuVSTnZiSqijym5UD2pyzWRhAhPoJEo=;
	b=EBXS5erPNWGAqqtupE6CiwzmFfzBcWERq9pdBAX6+aQMEgGsjuRrAz9jxUcegIlRDC91SG
	Niz2tr5TM9DOiwDw==
Date: Thu, 06 Nov 2025 11:32:39 +0100
Subject: [PATCH] kunit: Make filter parameters configurable via Kconfig
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-kunit-filter-kconfig-v1-1-d723fb7ac221@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAEZ5DGkC/x3MQQqAIBBA0avErBvQIsmuEi3CZmooLLQikO6et
 HyL/xNECkIRuiJBoFui7D5DlwW4ZfQzoUzZUKmq0VoZXC8vJ7JsJwVc3e5ZZmTVWtva2rAzkNM
 jEMvzb/vhfT/Q1Od8ZgAAAA==
X-Change-ID: 20251106-kunit-filter-kconfig-f08998936fc6
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762425171; l=2765;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=686+WgU1Vima+Hewl156LKzHi6lYO//H6D50PeewlYI=;
 b=U/J+W1jfW3gmfJq5X5oZHu/zEzD3WM11KV8TeddzMtErzdFXtSSbLkSR/QZiHEKMBJiC5jaMu
 jKCwp+ghoLgCH4UpYXo7jdXMDj5idIDCjSvncyJwAF5kjJ4uEy8Ppxp
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Enable the preset of filter parameters from kconfig options, similar to
how other KUnit configuration parameters are handled already.
This is useful to run a subset of tests even if the cmdline is not
readily modifyable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/Kconfig    | 24 ++++++++++++++++++++++++
 lib/kunit/executor.c |  8 +++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 7a6af361d2fc6276b9667be8c694b0c80e33c1e8..50ecf55d2b9c8a82f2aff7a0b4156bd6179b0a2f 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -93,6 +93,30 @@ config KUNIT_AUTORUN_ENABLED
 	  In most cases this should be left as Y. Only if additional opt-in
 	  behavior is needed should this be set to N.
 
+config KUNIT_DEFAULT_FILTER_GLOB
+	string "Default value of the filter_glob module parameter"
+	help
+	  Sets the default value of kunit.filter_glob. If set to a non-empty
+	  string only matching tests are executed.
+
+	  If unsure, leave empty so all tests are executed.
+
+config KUNIT_DEFAULT_FILTER
+	string "Default value of the filter module parameter"
+	help
+	  Sets the default value of kunit.filter. If set to a non-empty
+	  string only matching tests are executed.
+
+	  If unsure, leave empty so all tests are executed.
+
+config KUNIT_DEFAULT_FILTER_ACTION
+	string "Default value of the filter_action module parameter"
+	help
+	  Sets the default value of kunit.filter_action. If set to a non-empty
+	  string only matching tests are executed.
+
+	  If unsure, leave empty so all tests are executed.
+
 config KUNIT_DEFAULT_TIMEOUT
 	int "Default value of the timeout module parameter"
 	default 300
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 0061d4c7e35170634a3c1d1cff7179037fb8ba07..02ff380ab7938cfac2be3f8c0e7630a78961cc3d 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -45,9 +45,11 @@ bool kunit_autorun(void)
 	return autorun_param;
 }
 
-static char *filter_glob_param;
-static char *filter_param;
-static char *filter_action_param;
+#define PARAM_FROM_CONFIG(config) (config[0] ? config : NULL)
+
+static char *filter_glob_param = PARAM_FROM_CONFIG(CONFIG_KUNIT_DEFAULT_FILTER_GLOB);
+static char *filter_param = PARAM_FROM_CONFIG(CONFIG_KUNIT_DEFAULT_FILTER);
+static char *filter_action_param = PARAM_FROM_CONFIG(CONFIG_KUNIT_DEFAULT_FILTER_ACTION);
 
 module_param_named(filter_glob, filter_glob_param, charp, 0600);
 MODULE_PARM_DESC(filter_glob,

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251106-kunit-filter-kconfig-f08998936fc6

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


