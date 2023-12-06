Return-Path: <linux-kselftest+bounces-1271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17459806C7E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F181C20A06
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F4630335;
	Wed,  6 Dec 2023 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2r1IxsJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574913AEA;
	Wed,  6 Dec 2023 10:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EAFC433C8;
	Wed,  6 Dec 2023 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701859581;
	bh=MRNo+XMbxViAM6QklAQc01OfEHMsqB29e/uDsf8Pahs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F2r1IxsJUzyyuuEMG92n25mZEfBigsCHqrDAAFsmAvqPcMYEKiV6uVv2Schh/ulFv
	 82NhyYKwUegyYH/gAShHHmhZ1V8j2gNuz+9aRyET/LTPx5zLKqfWUTxrDhk2VpCjRP
	 +UXu6N7atMZTgspigJsqlq3yKWyPbUxYk7NrJ2iamGceviBbjysssKSYxKWsFlNQVq
	 GfoeDMCP8Kia0In4ykXzlLn9mpqKnO01r0HEt6XDk+TQw8+0olyb64ZmX0f7SntnNi
	 vSUrrw/r5YiNplhcr0hVrRr0VLx9TEilarfJk3ElCLHxf/mLCfmVRRGwfqRM3rjyt4
	 gzF9U6AlBVxGQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 06 Dec 2023 11:45:58 +0100
Subject: [PATCH v2 07/15] selftests/hid: tablets: do not set invert when
 the eraser is used
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-7-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=1121;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=MRNo+XMbxViAM6QklAQc01OfEHMsqB29e/uDsf8Pahs=;
 b=/+ck7Robg2xIxkHB76XRPHnYeZglxvF/1l97VSJK/2OOKxnOHCebYmmYUuYKkHAc06vYri0D4
 2j7VNM8A614Cgw+xOsZbEKOxsxLenadQ+tAWZJHew98oFcFB0eUORiv
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that the chart from Microsoft is not exactly what I got here:
when the rubber is used, and is touching the surface, invert can (should)
be set to 0...

[0] https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 27260dc02cc4..cb3955bf0ec5 100644
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


