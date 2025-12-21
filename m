Return-Path: <linux-kselftest+bounces-47812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4945BCD476E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 00:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7E903001C08
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2483130F80F;
	Sun, 21 Dec 2025 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uogptWpF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD693090DB;
	Sun, 21 Dec 2025 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766360623; cv=none; b=nXUMesESgS+BycO1u3vThcDbOcUYUGSp5/+dnpQKw8rc11n5TgoHhPGUXui/CeW9VG7yKYvJf9aWce9hyguDxXai3HaD1fU/cOYAp/bFavP1GWniIzLzXf38eJnr5iHcx1sxkarX+2nlLjOjVbd3+hbnl4crvl7fTzt4/g3xjms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766360623; c=relaxed/simple;
	bh=TvL0lYhwjEOU5SVFqrUXzUoQOFLX3XGhJeHQ5qsjSXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wh6sgEn7adxcT4dv8EzctmiezHFRmkiKOnr76FO4I2JgLnBO5BwTL7Nvii2EdESkgQjInmcXyzhVUY6lUW+6VoI53wfp+sYmIWOwdfzv0hkGQ5fY1/luVDEPndWSeYoohQiZjIPVUW8hN+oFalZN2+Zwlez2BaqVtwA4j2wCncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uogptWpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE416C116B1;
	Sun, 21 Dec 2025 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766360622;
	bh=TvL0lYhwjEOU5SVFqrUXzUoQOFLX3XGhJeHQ5qsjSXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uogptWpFb5ZOJTMa+25BcPIAMnxcoZZsRM2H1MWSU9sVeaoqhYFNGY8fYXdVVsiN/
	 UOp4L2wPsQXtO4BFLaPWegXN70DM8roDOQLVnQYZIASuSohMFuc1pb42X3iWtuk3rU
	 zhlPko2kEkSZzNJ5beEmU/2Zg+zsXTdOPUlG8EWYGnDN0oIEEvPHpU5RfSbSf2nnBV
	 7Abk1Ov6s3MyGBRSc9hpGVqcXEHTJsdGUi8T9aLZULDQBw1CFM0yrvsvfLu+2DT0tL
	 JnaoDrMIrelnTvneGpX2UTK9OF6ect1tTy1YEmNYdryUKfQdlej5YmZzymYhcNwmSK
	 BOdMDVYdfBrNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A075EE67497;
	Sun, 21 Dec 2025 23:43:42 +0000 (UTC)
From: Peter Hutterer via B4 Relay <devnull+peter.hutterer.who-t.net@kernel.org>
Date: Mon, 22 Dec 2025 09:43:35 +1000
Subject: [PATCH v2 2/4] selftests/hid: require hidtools 0.12
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-wip-hid-pressurepad-v2-2-054ac9689bb7@who-t.net>
References: <20251222-wip-hid-pressurepad-v2-0-054ac9689bb7@who-t.net>
In-Reply-To: <20251222-wip-hid-pressurepad-v2-0-054ac9689bb7@who-t.net>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766360621; l=1582;
 i=peter.hutterer@who-t.net; s=20251222; h=from:subject:message-id;
 bh=fQfZ3bxD/S+hRVj/cWNhZRvET046tgfhHw/kZkeYAeY=;
 b=Irf3O3Ipe4uzQyaldbyIlJrFDIdATLmhxOxoFK34R4jPutdlLj+xqvfUayd2FfGJSlaVrs57k
 3T3JnOS2PzlCswCpdK9yGzd1KHN3kAWnapvEox5b8+UOSC/cCFFxij+
X-Developer-Key: i=peter.hutterer@who-t.net; a=ed25519;
 pk=QoL66HDbFudb9Xt36p2XxsSohZSHVHesRR9c0pI28a4=
X-Endpoint-Received: by B4 Relay for peter.hutterer@who-t.net/20251222 with
 auth_id=582
X-Original-From: Peter Hutterer <peter.hutterer@who-t.net>
Reply-To: peter.hutterer@who-t.net

From: Peter Hutterer <peter.hutterer@who-t.net>

Not all our tests really require it but since it's likely pip-installed
anyway it's trivial to require the new version, just in case we want to
start cleaning up other bits.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 tools/testing/selftests/hid/tests/conftest.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/conftest.py b/tools/testing/selftests/hid/tests/conftest.py
index 1361ec981db6f79a58cf91e8732dcd7c05c47d38..985a535324b2fbe322e754e561d7af6898345b27 100644
--- a/tools/testing/selftests/hid/tests/conftest.py
+++ b/tools/testing/selftests/hid/tests/conftest.py
@@ -5,6 +5,7 @@
 # Copyright (c) 2017 Benjamin Tissoires <benjamin.tissoires@gmail.com>
 # Copyright (c) 2017 Red Hat, Inc.
 
+from packaging.version import Version
 import platform
 import pytest
 import re
@@ -14,6 +15,19 @@ from .base import HIDTestUdevRule
 from pathlib import Path
 
 
+@pytest.fixture(autouse=True)
+def hidtools_version_check():
+    HIDTOOLS_VERSION = "0.12"
+    try:
+        import hidtools
+
+        version = hidtools.__version__  # type: ignore
+        if Version(version) < Version(HIDTOOLS_VERSION):
+            pytest.skip(reason=f"have hidtools {version}, require >={HIDTOOLS_VERSION}")
+    except Exception:
+        pytest.skip(reason=f"hidtools >={HIDTOOLS_VERSION} required")
+
+
 # See the comment in HIDTestUdevRule, this doesn't set up but it will clean
 # up once the last test exited.
 @pytest.fixture(autouse=True, scope="session")

-- 
2.51.1



