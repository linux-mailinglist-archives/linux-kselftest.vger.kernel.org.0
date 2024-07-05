Return-Path: <linux-kselftest+bounces-13261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B1928F90
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 01:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A421F22D33
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 23:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E0416DC0D;
	Fri,  5 Jul 2024 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jGjk7yPL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C391474AF;
	Fri,  5 Jul 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720222214; cv=none; b=t6JSjlJXBbbMZRtTUNboXtnuk5VGF+sF+TYMx4z1ZwcKKNKiA0zAAZuuurLWnas5hfLzZOS0BR3FwvhrMKeT08ls7UzthPLC50DlfNLE282eS/CuG/1wT38jBKE2BDescgIDJnHVMXO3/SFMAUqaT63vTWKPrJ7jkBH/lpX0OkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720222214; c=relaxed/simple;
	bh=b7rCEd2uhHL8+s2zLp8duj9amCJ1UnPquiE+ouQCNGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxi0cGxyINGdlCYY/JpXZpQ7oK4tywg2OtUbYxUYChPvh4iv7rg8ce7XVHy9ueSs5If4ZUdYMy9cIgnafrj20C2aeilbCHTrfBRq47LC92jWjLcZy0UfC4cbV6hRDFw0PTa1NGCHumDnFh6VBqysSu5jN7zvU3nuUNU8MXuWtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jGjk7yPL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720222210;
	bh=b7rCEd2uhHL8+s2zLp8duj9amCJ1UnPquiE+ouQCNGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jGjk7yPLl8AoA2ENzIMf5xkOi4iMWjpKyE6WVCicokbMgQhcgaqj1RyJmpHmW4eAa
	 r4agbZCCS8kCl0AW/ehCyaBHQRdw4UQsmNNTOD/NLxDa2BHbD4umpvc/ZM3+ddllhN
	 fIw1SMjsQ1yf2unY6iro8++rWtAHl/cSK85HsAjxz74QNHowOffuviwuhr2wESPC3A
	 M2cCJ2ZkNZjvhi+dmePLCAsWzQV9lRGcputZIQ3JQZPePJlDzooUzhVvzIW8up+Dyg
	 PCy9wLcWgZOBd1dlKxLiNoaYJSB8P0kOCM6bSoliJ6DjkYzG/q8tlDBkK2kl9MO7+G
	 KOekdlh8HkwMg==
Received: from [192.168.1.238] (tango.collaboradmins.com [167.235.144.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B437B3782200;
	Fri,  5 Jul 2024 23:30:09 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 05 Jul 2024 19:29:55 -0400
Subject: [PATCH v2 2/3] kselftest: Move ksft helper module to common
 directory
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240705-dev-err-log-selftest-v2-2-163b9cd7b3c1@collabora.com>
References: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
In-Reply-To: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernelci@lists.linux.dev, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

Move the ksft python module, which provides generic helpers for
kselftests, to a common directory so it can be more easily shared
between different tests.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/Makefile                                   | 1 +
 tools/testing/selftests/devices/probe/Makefile                     | 2 +-
 tools/testing/selftests/devices/probe/test_discoverable_devices.py | 7 ++++++-
 tools/testing/selftests/{devices/probe => kselftest}/ksft.py       | 0
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 37214201d974..7bd78b9f5cdd 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -251,6 +251,7 @@ ifdef INSTALL_PATH
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/ktap_helpers.sh $(INSTALL_PATH)/kselftest/
+	install -m 744 kselftest/ksft.py $(INSTALL_PATH)/kselftest/
 	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
 	rm -f $(TEST_LIST)
 	@ret=1;	\
diff --git a/tools/testing/selftests/devices/probe/Makefile b/tools/testing/selftests/devices/probe/Makefile
index 7a6eaa031cfe..f630108c3fdf 100644
--- a/tools/testing/selftests/devices/probe/Makefile
+++ b/tools/testing/selftests/devices/probe/Makefile
@@ -1,4 +1,4 @@
 TEST_PROGS := test_discoverable_devices.py
-TEST_FILES := boards ksft.py
+TEST_FILES := boards
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/devices/probe/test_discoverable_devices.py b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
index 8f2200540a1f..d94a74b8a054 100755
--- a/tools/testing/selftests/devices/probe/test_discoverable_devices.py
+++ b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
@@ -16,12 +16,17 @@
 
 import argparse
 import glob
-import ksft
 import os
 import re
 import sys
 import yaml
 
+# Allow ksft module to be imported from different directory
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../../kselftest/"))
+
+import ksft
+
 pci_controllers = []
 usb_controllers = []
 
diff --git a/tools/testing/selftests/devices/probe/ksft.py b/tools/testing/selftests/kselftest/ksft.py
similarity index 100%
rename from tools/testing/selftests/devices/probe/ksft.py
rename to tools/testing/selftests/kselftest/ksft.py

-- 
2.45.2


