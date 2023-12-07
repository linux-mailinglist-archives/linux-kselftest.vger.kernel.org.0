Return-Path: <linux-kselftest+bounces-1347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F3808799
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 13:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B857B21ADF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D14A39AFE;
	Thu,  7 Dec 2023 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRuAepFh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4AA39AF6;
	Thu,  7 Dec 2023 12:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB499C433C8;
	Thu,  7 Dec 2023 12:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701951764;
	bh=epH6N4HOQY9d/F5eZFuiUiKcD6erclTqiNFuoeHNibM=;
	h=From:Date:Subject:To:Cc:From;
	b=ZRuAepFhfUG/d4JUckztQmMS323WJgPb0oGVjoiVT16Sw9k3gd2mcP1s2X+UCQhvm
	 TTX8vLZ/lNjgv68XatsoQiJNDp2Kmmq9H854ivI9VPmVLP9p70meAooJGYxI1LJTgL
	 QT/RAmD1b14G3rSJqRc4372ZDLz6i5nKmz2lsxe4xSDv12Y2ByD3xiexVsFxncGrDS
	 TOt/qKsUYnZ/laPTjMCTRn0sqo0B84C9zuiZ566wL1mJ04fGJnN8aY5gdcLCG56hkV
	 9aevdE7LoYOLkHTHMomf0iLxG91JcLifQyl1l9vrt/8PZHvaTouWNw3vypYTYqvEE0
	 ss+Dg2q8YUkIQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 07 Dec 2023 13:22:39 +0100
Subject: [PATCH] selftests/hid: fix failing tablet button tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-b4-wip-selftests-v1-1-c4e13fe04a70@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA65cWUC/x3MQQ5AMBBA0avIrE2i1SKuIha0g0kE6QiSxt01l
 m/xfwShwCTQZhECXSy8bwkqz8AtwzYTsk8GXehS6aLG0eDNBwqt00lyCjplK+uNN7ZuIGVHoIm
 ff9n17/sBuP0ArGIAAAA=
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: Jiri Kosina <jkosina@suse.com>, Benjamin Tissoires <bentiss@kernel.org>, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701951762; l=1894;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=epH6N4HOQY9d/F5eZFuiUiKcD6erclTqiNFuoeHNibM=;
 b=n/90PDIVzBVYmex40erDeyr8UfBLYJJvGN2LIAvfkl2wkUtPc4ZONsXa4LXWuHGuUhRNjEr3t
 S29RzIxWhgoCbx0SJBI78CjhJjrx8MqBr1/El5ybpfDF2e1WRSpLa54
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

An overlook from commit 74452d6329be ("selftests/hid: tablets: add
variants of states with buttons"), where I don't use the Enum...

Fixes: 74452d6329be ("selftests/hid: tablets: add variants of states with buttons")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Not sure what happened, but I mustn't have run the tests before
sending the series, and they fail blatently.
I'm deeply sorry for that, I thought these failures were fixed.

Cheers,
Benjamin
---
 tools/testing/selftests/hid/tests/test_tablet.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index dc8b0fe9e7f3..903f19f7cbe9 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -115,7 +115,7 @@ class PenState(Enum):
         # we take only the highest button in account
         for b in [libevdev.EV_KEY.BTN_STYLUS, libevdev.EV_KEY.BTN_STYLUS2]:
             if bool(evdev.value[b]):
-                button = b
+                button = BtnPressed(b)
 
         # the kernel tends to insert an EV_SYN once removing the tool, so
         # the button will be released after
@@ -155,7 +155,7 @@ class PenState(Enum):
                 if button_found:
                     raise ValueError(f"duplicated BTN_STYLUS* in {events}")
                 button_found = True
-                button = ev.code if ev.value else None
+                button = BtnPressed(ev.code) if ev.value else None
 
         # the kernel tends to insert an EV_SYN once removing the tool, so
         # the button will be released after

---
base-commit: f556aa957df8cb3e98af0f54bf1fa65f59ae47a3
change-id: 20231207-b4-wip-selftests-c1565d4d4578

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


