Return-Path: <linux-kselftest+bounces-30822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8CA89464
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 09:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E046188DF41
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523242741D5;
	Tue, 15 Apr 2025 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QbTgfbdE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YbYqichZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BC274FEF;
	Tue, 15 Apr 2025 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700598; cv=none; b=CPgmahjAEAN0EM1uWJ2CkR8CvbQ37Rea3Fz+H8EexIFSow9UJCyje76HKIyDH4nIRbLNS+xYMqhLbyD2bI8EbYkWMiEpaXrQpMs+1jqxz8nGpPcPSefAYLbS4niqRQK3IBdwl1jkhQTMtmxjdWDiyy+KlWd+LUfL4+Mk3xYQFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700598; c=relaxed/simple;
	bh=ri2/FdDgnHYoSagqsehG8IUT30nY6l8hvJEpmZx8KfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qnip2wN++X/GFBpTp8+iZvlxSgoukHFiQiiH3Cxv/H1BW+iDiQDSoeygm3RW4oUaNLIfdQVKAYoTccs0wR7kbX1RRZJ7zUmYlJcfIIeM6Fk566UCgMUf6gOAszhA04xC2IA1kGL3+SkBaYhuYUIW+4DDsnQj6RuiLyKPjzJ0Zz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QbTgfbdE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YbYqichZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744700594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YoDhzFmNYm+a5jDtp+aEomb9UL1SFg+w2sGeqO7jwLM=;
	b=QbTgfbdEHY2v3qi20vMYsefZXpA+hsVgUVcO9peK0iQkwYDZ266HqJ0ExJ+oZVW1cxT47e
	0DWurKnEvYxfQwxi7qCYQUmHE6rO3WVtBOzKdRA0pPUi3tuAYyoBrTseuNg1Q4qjodpBZS
	GKxDtj3GR5mNEDFa7tJodmUKgFwQzJG7ktfA4ARMljpfkY+zr7/BUeb3W7+AtIn474AA3o
	yTvxNG8rZfQ8Up/NfA4rYezgEPMYR1lKdGlNgg6Z9j7/0K6aJ0YyEV9vSafc+0JL0XYJId
	k+izY0XVH0tiqUp5dFaXUrw6rtc7NXsufnJl6ksrnKxAOFNSMKJc8NLYKcRkdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744700594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YoDhzFmNYm+a5jDtp+aEomb9UL1SFg+w2sGeqO7jwLM=;
	b=YbYqichZtkXHuf3bMh9q6U0pkx2t1tbU2puY9IOA0ZNHPOLSgZ1zjYF6R8DV0RcDW8ry10
	SePfLdFy7IRmOGBQ==
Date: Tue, 15 Apr 2025 09:03:06 +0200
Subject: [PATCH v2] kunit: tool: Implement listing of available
 architectures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-kunit-list-v2-1-aa452cd317ae@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAKkE/mcC/22Myw7CIBBFf6WZtRhmUnyt/A/TRYXRTmyoAUpqG
 v5d7NrlubnnrBA5CEe4NCsEzhJl8hVo14Adev9kJa4ykCajibR6zV6SGiUmZQz1J+usRmSowjv
 wQ5YtdusqD/U0hc/Wzvhb/2YyKlStvp+dObR4ZL6O4ucUJi/L3jF0pZQvGrou4agAAAA=
X-Change-ID: 20250220-kunit-list-552a8cdc011e
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744700591; l=2723;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ri2/FdDgnHYoSagqsehG8IUT30nY6l8hvJEpmZx8KfY=;
 b=vfbaiAZA5LG0KdWUDgQag41kfti5zhIx1N5RO2S94wepjh72RCXZrSdOW0pgUGhP/204HShf/
 tZVDYETOfmCBg1Rxt8E63aEZ8ITh8E7tO3iMrquyhclw5iub8zKdrdI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To implement custom scripting around kunit.py it is useful to get a list of
available architectures. While it is possible to manually inspect
tools/testing/kunit/qemu_configs/, this is annoying to implement and
introduces a dependency on a kunit.py implementation detail.

Introduce 'kunit.py run --arch help' which lists all known architectures
in an easy to parse list. This is equivalent on how QEMU implements
listing of possible argument values.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Rae Moar <rmoar@google.com>
---
Changes in v2:
- Pick up review from Rae
- Link to v1: https://lore.kernel.org/r/20250220-kunit-list-v1-1-40b9d56417ee@linutronix.de
---
 Documentation/dev-tools/kunit/run_wrapper.rst | 2 ++
 tools/testing/kunit/kunit_kernel.py           | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 19ddf5e07013314c608b570e297a8ff79a8efe7f..6697c71ee8ca020b8ac7e91b46e29ab082d9dea0 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -182,6 +182,8 @@ via UML. To run tests on qemu, by default it requires two flags:
   is ignored), the tests will run via UML. Non-UML architectures,
   for example: i386, x86_64, arm and so on; run on qemu.
 
+  ``--arch help`` lists all valid ``--arch`` values.
+
 - ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
   same argument as passed to the ``CROSS_COMPILE`` variable used by
   Kbuild. As a reminder, this will be the prefix for the toolchain
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index d3f39bc1ceec7eab23925ff1b852e996a715f3d5..260d8d9aa1db4ac3c04fa755fb738dd834b976db 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,6 +14,7 @@ import os
 import shlex
 import shutil
 import signal
+import sys
 import threading
 from typing import Iterator, List, Optional, Tuple
 from types import FrameType
@@ -201,6 +202,13 @@ def _default_qemu_config_path(arch: str) -> str:
 		return config_path
 
 	options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
+
+	if arch == 'help':
+		print('um')
+		for option in options:
+			print(option)
+		sys.exit()
+
 	raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
 
 def _get_qemu_ops(config_path: str,

---
base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
change-id: 20250220-kunit-list-552a8cdc011e

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


