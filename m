Return-Path: <linux-kselftest+bounces-829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257797FDB41
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 16:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AB91C2094A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84E381B1;
	Wed, 29 Nov 2023 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjfaA5lG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9623032E;
	Wed, 29 Nov 2023 15:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C383C433D9;
	Wed, 29 Nov 2023 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701271515;
	bh=ALQSUwIpXqcEh03ppshskh+FaGQmb8S9LPkrgK0UVXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pjfaA5lG4wRnePTeuMezTeQNR3cQJMV+w9wh7qyCxTfSh6HoR2K587L8Gq9hpx0n7
	 uEwbK6mH1stOabGtj/fUMIf4ZqOty9O96MhUWSmBfe8nHraYdmYpHZQw0D4g1YfNlA
	 jckFEC2XQ2BWf1wIUrX4H7/jJSTui7qNmQeZBd4LRrfAA/0sEm7i5tbEeTHEA2XHVn
	 fPuWhSk3a+aHdaAO7ncU88ZQaIlo3Nn9ulhFrJWSBnBX5lYtCPi076CQOOcCr55b39
	 ozIgyrKLSd5GV20l7uMyuv/nUEM5l4QRrtLlG/iOtQPRhiwAExMOVaXX41uiBDRjS/
	 NDVoLiegViOtQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 29 Nov 2023 16:24:32 +0100
Subject: [PATCH 07/12] selftests/hid: tablets: do not set invert when the
 eraser is used
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-7-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=1038;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ALQSUwIpXqcEh03ppshskh+FaGQmb8S9LPkrgK0UVXM=;
 b=Ww9wUd/GRVTn1WpgOseXPPpOG+0ScJMar5njGQwo+gu43hi61Hw4ji4jWyhXEkih6ES2OAmJA
 RTNvk9zuLSEBut7pBFs6A9moqRluGVPc7wrwJCOk1f4lYJZpQ+tLIs2
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that the chart from Microsoft is not exactly what I got here:
when the rubber is used, and is touching the surface, invert can (should)
be set to 0...

[0] https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 44a004ca69d1..f93dfbb2a3e5 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -382,7 +382,7 @@ class PenDigitizer(base.UHIDTestDevice):
         elif state == PenState.PEN_IS_ERASING:
             pen.tipswitch = False
             pen.inrange = True
-            pen.invert = True
+            pen.invert = False
             pen.eraser = True
 
         pen.current_state = state

-- 
2.41.0


