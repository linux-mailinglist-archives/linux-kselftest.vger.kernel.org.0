Return-Path: <linux-kselftest+bounces-7591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F2A89FE54
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024C8288536
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EEC1836EB;
	Wed, 10 Apr 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9iSIUwG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4D1836E6;
	Wed, 10 Apr 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769619; cv=none; b=UzKpU/O/UtDs1UErulieB7HiYIkfHyjvFqGhptdW957rPgrKFVPHcoYyufnbUMtJHglpQEw1c/oC3ekssoXrXE+iVFV5ay2iJNyHJkt+L967tAqeMZEbcB8T/1TUv4vvYfu1aBTkhI95FkaufwOILzP2ukx5aba3Ik6OjSU4UGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769619; c=relaxed/simple;
	bh=FSBl7C98aqlFXG4peS5iM4e+jn59fgnArt3EFNam9lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2pSEiHNVg8xpunfrVMWIk7O++55+0Zyk4mhd6+3hz2Ha9hCbZMUeDTb4SY5P4UAAlDiEAfMxUaaD6wR0+BQ3rcWsidYG8zBoqhFpgLHBVSJNSVQTcD/sUksv3u9pHMI9HSoBFs1EiVXOV9H5lzLXoucV2z5Y0QBGyKC5P3ABRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9iSIUwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87B0C43141;
	Wed, 10 Apr 2024 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769619;
	bh=FSBl7C98aqlFXG4peS5iM4e+jn59fgnArt3EFNam9lY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C9iSIUwG4mwrq8h02oJie3JHsoibQp5LQnI29DPdJXMojNKP97Ss9y90r0MBG2kVz
	 jpU/4T2qjJV8HQVeTc2+Tm3MFUrEG4Qxa1jDPiva071RISQwBEzmTRK82YRXDClcne
	 9SHQaHxpAmK5YQlXNJxLCy/w3QHaJxE9r0W4GYeNHVdjHOYJBoh8pznfJ/eSQ5OV1N
	 IGvmulVruKhefgl8NLrW73zbnMOkrHIKkuaRMQkGSi0YmR1cHiBMooDXkVVy46/6NU
	 B6kxjoFAN2/2C2usxnBYP8MBAmwlT5ytVqEN1XpkupPwq6avk15WK0VpsqQcqn745r
	 eFX8/3OEXm6PQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:34 +0200
Subject: [PATCH 14/18] selftests/hid: tablets: also check for XP-Pen offset
 correction
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-14-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=1435;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=FSBl7C98aqlFXG4peS5iM4e+jn59fgnArt3EFNam9lY=;
 b=W4VrUeL0TzGScCiyTrWxLSy8DVLetGQt9+YlciUVU7k62L1qTrxet3yJaAe9qC7wLxXBRgUfG
 fsuykwf9WDACXvS7ZY6vJ33mTz+M1ImSRfBiZSlIgyFo5iqaBH/8qWm
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The values are taken from the HID-BPF file.
Basically we are recomputing the array provided there.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index e265f1d4e089..ae0eda9cd3d8 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -957,10 +957,24 @@ class XPPen_ArtistPro16Gen2_28bd_095b(PenDigitizer):
             pen.eraser = False
             pen.barrelswitch = False
 
-        pen.xtilt = 0
-        pen.ytilt = 0
         pen.current_state = state
 
+    def event(self, pen, test_button):
+        import math
+
+        pen_copy = copy.copy(pen)
+        width = 13.567
+        height = 8.480
+        tip_height = 0.055677699
+        hx = tip_height * (32767 / width)
+        hy = tip_height * (32767 / height)
+        if pen_copy.xtilt != 0:
+            pen_copy.x += round(hx * math.sin(math.radians(pen_copy.xtilt)))
+        if pen_copy.ytilt != 0:
+            pen_copy.y += round(hy * math.sin(math.radians(pen_copy.ytilt)))
+
+        return super().event(pen_copy, test_button)
+
 
 class XPPen_Artist24_28bd_093a(PenDigitizer):
     """

-- 
2.44.0


