Return-Path: <linux-kselftest+bounces-36808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 106A3AFE3A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CCD1BC1AB8
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B13D283FDC;
	Wed,  9 Jul 2025 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2X+6Oh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FE283FD6;
	Wed,  9 Jul 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052145; cv=none; b=L0rHTRY3xQxeHFp5BIxJF9LubfaWFyLHh/96EIid0DKM7yoFcjn5SQ7Oe7E3s8xBlsvC39/NFWKBsMB1hz97yatF9ElS/j3ogVIo88imrMdJaQKiqyFeSp1bm5dX+FaOXneR1NowPBhBd/5bEdY5MPqyVqa8/6+zVSEf26E3c+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052145; c=relaxed/simple;
	bh=S4gKVd2RXqJivgfT0NIOHWaYEeaOZa0ICJGTbHaj0mA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E3gREeK0FMpz06drRkar+JapMgVKre/OJ90+dGmhJYmo8D1afCa9pZ+Oc0xf7QPbU79rGJRpS3J3feT+ZXtiEdJ16gsbTmqDzSFRXMQkUqq4xn754U4bKBqD5YTkOzS0pBOnheoCiZw0HbuOASqu3PVCaphRj7soTqJJgenZYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2X+6Oh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F505C4CEEF;
	Wed,  9 Jul 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752052144;
	bh=S4gKVd2RXqJivgfT0NIOHWaYEeaOZa0ICJGTbHaj0mA=;
	h=From:Subject:Date:To:Cc:From;
	b=b2X+6Oh9vrFxI3TVIXHzZDCltzyP2tkpp8cXqiRlS6koheloNi8Xz2Tl1rh6/xXHo
	 ju+mimQk4uSAhXEAm5q4Ay9h200+vUk05FX+AOMTlIo7uLfjEg801gBNlcdNzDfDrv
	 uCBadN2OIMwKX89lxYiqyN5UwIq1dCJOKz35BmQde8eFNaRpAVBNrZDCYYF0iWwiMy
	 macsiFQB+DObtYDzed98F0BR+a0D9eggBZ+aP6dqBdXO888joj9/atv/fmz9FStEWP
	 +bW/qGzGk0guLkpipY1JZXeTIhIlOepTK6FQvJ5uMY1Zf+lplGW/q0F3T49dEsJNAX
	 7KcW+dx6KsMqw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/3] selftests/hid: upgrade the python scripts to match
 hid-tools 0.10
Date: Wed, 09 Jul 2025 11:08:48 +0200
Message-Id: <20250709-wip-fix-ci-v1-0-b7df4c271cf8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKAxbmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNL3fLMAt20zArd5EzdFAPjpBQDszRzc4tUJaCGgqJUoAzYsOjY2lo
 AeEob7lwAAAA=
X-Change-ID: 20250709-wip-fix-ci-d03bd06f778e
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752052142; l=1427;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=S4gKVd2RXqJivgfT0NIOHWaYEeaOZa0ICJGTbHaj0mA=;
 b=2NTYepscuWcL6mYihHlo4NUgOIosOIEmrj9fJMg4xWpb5yDzFLJBio0wAEVs2+Bddfa73ucwZ
 xNBKZRSElTMDq5moC0LY2RtOCMUoo/xX4J5mdViCQPhHyH/9gCa0bbZ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

hid-tools 0.10 fixed a test regression introduced in 6.16-rc1: the
kernel might communicate with the uhid node while the test suite opens
the evdev node. This leads to a full test-suite time which used to run
in 6 minutes into an hour.

Merge the upstream hid-tools project in the selftest kernel dir to
reduce that time to something manageable again.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (3):
      selftests/hid: run ruff format on the python part
      selftests/hid: sync the python tests to hid-tools 0.8
      selftests/hid: sync python tests to hid-tools 0.10

 tools/testing/selftests/hid/tests/base.py          |  46 ++-
 tools/testing/selftests/hid/tests/base_device.py   |  49 ++-
 .../selftests/hid/tests/test_apple_keyboard.py     |   3 +-
 tools/testing/selftests/hid/tests/test_gamepad.py  |   3 +-
 .../selftests/hid/tests/test_ite_keyboard.py       |   3 +-
 .../testing/selftests/hid/tests/test_multitouch.py |   2 +-
 tools/testing/selftests/hid/tests/test_sony.py     |   7 +-
 tools/testing/selftests/hid/tests/test_tablet.py   |  11 +-
 .../selftests/hid/tests/test_wacom_generic.py      | 445 +++++++++++++++------
 9 files changed, 412 insertions(+), 157 deletions(-)
---
base-commit: 2043ae9019e0f75c7785048230586c3f3ca0a2a4
change-id: 20250709-wip-fix-ci-d03bd06f778e

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


