Return-Path: <linux-kselftest+bounces-1272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF16806C82
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667DC281A2F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF13033B;
	Wed,  6 Dec 2023 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otx5oY/7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2913AEA;
	Wed,  6 Dec 2023 10:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89C7C433CD;
	Wed,  6 Dec 2023 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701859583;
	bh=4zleTS1syp3MMWCgpz68nisdsjLtNx642uQ5ALXPbwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=otx5oY/7aOYzUCHm0+Wal4grzP0hALifiz/kblIrGWFMdrlKLNZXNQ1jYyOI6FGgd
	 CBMEdpiBDbPuk01/0Y8tIwQtFePt7FhXYp/ItEq5Ib4n/qyJyVuS4wHNByXzceg2BZ
	 1zSmoeHqeSG2u4dI2qVJ1a+TKAW/kqsXCcHpeEfJhOazEyt6umNIrP9YwMOQokevp8
	 Kv5J7LNG+rxdz/YZ0lzUYnnIn+n1QIVLf3YShrMG017Nd4X0/t38YDK6KYvqLFMpWY
	 JhTUuZuZac+rCJtG0sBVBJ9is0WeEjlVzfzf9YPOjmQbUsHstWz42JVDEo6Fw9UFlG
	 e+gWswO6Uy6WA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 06 Dec 2023 11:45:59 +0100
Subject: [PATCH v2 08/15] selftests/hid: tablets: set initial data for
 tilt/twist
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-8-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=1669;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=4zleTS1syp3MMWCgpz68nisdsjLtNx642uQ5ALXPbwU=;
 b=wFyaODHbKOxoT5j8xyDHC2qJHzmHuEprhItc8UzFlNeXgJ0cKsxGN/s1i6P464tR5E5LIipA9
 kGaSwNjeaujBXRroxcW2ahvrOKt0aUXWsX4NnvDwU62jds6r2il1ZIh
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Avoids getting a null event when these usages are set

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index cb3955bf0ec5..0ddf82695ed9 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -276,9 +276,9 @@ class Pen(object):
         self.barrelswitch = False
         self.invert = False
         self.eraser = False
-        self.x_tilt = 0
-        self.y_tilt = 0
-        self.twist = 0
+        self.xtilt = 1
+        self.ytilt = 1
+        self.twist = 1
         self._old_values = None
         self.current_state = None
 
@@ -292,8 +292,8 @@ class Pen(object):
                 "width",
                 "height",
                 "twist",
-                "x_tilt",
-                "y_tilt",
+                "xtilt",
+                "ytilt",
             ]:
                 setattr(self, i, getattr(self._old_values, i))
 
@@ -361,8 +361,8 @@ class PenDigitizer(base.UHIDTestDevice):
             pen.height = 0
             pen.invert = False
             pen.eraser = False
-            pen.x_tilt = 0
-            pen.y_tilt = 0
+            pen.xtilt = 0
+            pen.ytilt = 0
             pen.twist = 0
         elif state == PenState.PEN_IS_IN_RANGE:
             pen.tipswitch = False

-- 
2.41.0


