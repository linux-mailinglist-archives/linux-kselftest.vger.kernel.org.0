Return-Path: <linux-kselftest+bounces-9520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C16CF8BD06B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F066E1C22795
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68F152500;
	Mon,  6 May 2024 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COVf006+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B6C393;
	Mon,  6 May 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006190; cv=none; b=N453hYpxke5bPIzRo/KaqkLDGohZWIFBLSeCLbc4I7kn25xfh+uO7gvBd1M8y1HmjV7CrDvP6ewHj/dOvU11td6UDMNcdujaxlAScI2N911syqSlPtlWiWAbmsIoYa2PIfosYsvGp33YzBR27K0N1qEboyN2QxUHsaWtZe9y3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006190; c=relaxed/simple;
	bh=epnKmSLmSfc49HA+0nn+hCuYqMrBtCrmccfzKmBeUjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4ZdmzhLOhr1aylN5LCnMxktY8J3W1aw1RUftgT9aNhkK44fow9wOj9mCl3+zLQnICOcuFRadUUq6eGkyfylbuduWj/9x/Y40NdsN58jNEQT7ZeOO9ym2uWuI70aIzpkgBgimOT75jWhR7O6fZoa4ZTlRGjk2ezPYhEQX7tKaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COVf006+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068BFC116B1;
	Mon,  6 May 2024 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715006190;
	bh=epnKmSLmSfc49HA+0nn+hCuYqMrBtCrmccfzKmBeUjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COVf006+4LUh9tpH9/x1fyFrKQB4M58metJs3z4CDtyVj9gd0FPOtjLgwP8q2u0PP
	 MvAkeQr835kn7NUTaQ6NGCLDMmTino4vsX1SfOnLwgfZ09eOSEknM12iUdoF89fovm
	 l8LRQ4eFv2UxvMJX31UVlYfqxzYQEszz54qmTzK86eOLQbauHEGQvqGKaVFZm5D0rp
	 n3xFRaxUQUa/9G66kN1tWJ2N269uSbergwrOR/fuB4q5k+dT0DfX8ThhiIjgoS2Hkv
	 Cg2eXaI25JVkcogM2HeYuNhfaXOLDB/ggM/2GruBHJqDlfE9sUT06x7avGJFNTgOsL
	 VXGub0uvz6uRQ==
From: bentiss@kernel.org
To: Jiri Kosina <jikos@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Martin Sivak <mars@montik.net>,
	Ping Cheng <pinglinux@gmail.com>,
	Jason Gerecke <killertofu@gmail.com>,
	Aaron Armstrong Skomra <skomra@gmail.com>,
	Joshua Dickens <Joshua@joshua-dickens.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 19/18] selftests/hid: skip tests with HID-BPF if udev-hid-bpf is not installed
Date: Mon,  6 May 2024 16:36:12 +0200
Message-ID: <20240506143612.148031-1-bentiss@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Tissoires <bentiss@kernel.org>

udev-hid-bpf is still not installed everywhere, and we should probably
not assume it is installed automatically.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---

I wanted to apply this series given that it wasn't reviewed in a month,
but I thought that maybe I should not enforce ude-hid-bpf to be
installed everywhere.

I'll probably push this series tomorrow so it makes the 6.10 cut.

Cheers,
Benjamin

 tools/testing/selftests/hid/tests/base.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/base.py b/tools/testing/selftests/hid/tests/base.py
index 2d006c0f5fcd..3a465768e507 100644
--- a/tools/testing/selftests/hid/tests/base.py
+++ b/tools/testing/selftests/hid/tests/base.py
@@ -8,6 +8,7 @@
 import libevdev
 import os
 import pytest
+import shutil
 import subprocess
 import time
 
@@ -240,6 +241,10 @@ class BaseTestCase:
             root_dir = (script_dir / "../../../../..").resolve()
             bpf_dir = root_dir / "drivers/hid/bpf/progs"
 
+            udev_hid_bpf = shutil.which("udev-hid-bpf")
+            if not udev_hid_bpf:
+                pytest.skip("udev-hid-bpf not found in $PATH, skipping")
+
             wait = False
             for _, rdesc_fixup in self.hid_bpfs:
                 if rdesc_fixup:
-- 
2.44.0


