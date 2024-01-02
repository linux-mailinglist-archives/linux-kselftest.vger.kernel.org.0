Return-Path: <linux-kselftest+bounces-2567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382C821D7B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 15:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4612833B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D205810955;
	Tue,  2 Jan 2024 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cNdkDTx+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FAE10785;
	Tue,  2 Jan 2024 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704204996;
	bh=FShN6Yxi9g1ih4M05TksRobciGeTbu+YjfYSPWSxjL4=;
	h=From:To:Cc:Subject:Date:From;
	b=cNdkDTx+B33wt206oH7WpK7uXAgVfgcYPmGM9szkyu11u2P8NRU/20/dJY3PytdXA
	 zYzp56m5DDleZsXrPHy8oTSaIZ/m2pNMQLm2VvTvjsLpUlQgc2jL6KSeKDqCd2L+x0
	 mh0m5h8AORik8OZKsiQlani5S6W1zMKos/RVU1r4YqCiLec++BeJJ1eGs1wvcywr5A
	 YmN1Ks/P1pCwZO13kl98CAWqyn04OzLNU3Cxdv2z62tlh7hXjLVGHWlzPNEEOUsj/z
	 jLcQv0bT6AYYXhDh2zkN34/avpZ5j0+hG8ye3iYFpUZSadhA39zz61s4eWviIHS9zd
	 zTzWJi8rGfj/g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 735433781FDF;
	Tue,  2 Jan 2024 14:16:35 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	"Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH] selftests: Move KTAP bash helpers to selftests common folder
Date: Tue,  2 Jan 2024 15:15:28 +0100
Message-Id: <20240102141528.169947-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move bash helpers for outputting in KTAP format to the common selftests
folder. This allows kselftests other than the dt one to source the file
and make use of the helper functions.
Define pass, fail and skip codes in the same file too.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 tools/testing/selftests/Makefile                          | 1 +
 tools/testing/selftests/dt/Makefile                       | 2 +-
 tools/testing/selftests/dt/test_unprobed_devices.sh       | 6 +-----
 tools/testing/selftests/{dt => kselftest}/ktap_helpers.sh | 6 ++++++
 4 files changed, 9 insertions(+), 6 deletions(-)
 rename tools/testing/selftests/{dt => kselftest}/ktap_helpers.sh (94%)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b2061d1c1a5..976e96013c91 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -251,6 +251,7 @@ ifdef INSTALL_PATH
 	install -m 744 kselftest/module.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
+	install -m 744 kselftest/ktap_helpers.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
 	rm -f $(TEST_LIST)
 	@ret=1;	\
diff --git a/tools/testing/selftests/dt/Makefile b/tools/testing/selftests/dt/Makefile
index 62dc00ee4978..2d33ee9e9b71 100644
--- a/tools/testing/selftests/dt/Makefile
+++ b/tools/testing/selftests/dt/Makefile
@@ -4,7 +4,7 @@ ifneq ($(PY3),)
 
 TEST_PROGS := test_unprobed_devices.sh
 TEST_GEN_FILES := compatible_list
-TEST_FILES := compatible_ignore_list ktap_helpers.sh
+TEST_FILES := compatible_ignore_list
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/dt/test_unprobed_devices.sh b/tools/testing/selftests/dt/test_unprobed_devices.sh
index b07af2a4c4de..f2307ee443a6 100755
--- a/tools/testing/selftests/dt/test_unprobed_devices.sh
+++ b/tools/testing/selftests/dt/test_unprobed_devices.sh
@@ -15,16 +15,12 @@
 
 DIR="$(dirname $(readlink -f "$0"))"
 
-source "${DIR}"/ktap_helpers.sh
+source "${DIR}"/../kselftest/ktap_helpers.sh
 
 PDT=/proc/device-tree/
 COMPAT_LIST="${DIR}"/compatible_list
 IGNORE_LIST="${DIR}"/compatible_ignore_list
 
-KSFT_PASS=0
-KSFT_FAIL=1
-KSFT_SKIP=4
-
 ktap_print_header
 
 if [[ ! -d "${PDT}" ]]; then
diff --git a/tools/testing/selftests/dt/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
similarity index 94%
rename from tools/testing/selftests/dt/ktap_helpers.sh
rename to tools/testing/selftests/kselftest/ktap_helpers.sh
index 8dfae51bb4e2..dd79d96f3b5a 100644
--- a/tools/testing/selftests/dt/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -9,6 +9,12 @@ KTAP_CNT_PASS=0
 KTAP_CNT_FAIL=0
 KTAP_CNT_SKIP=0
 
+KSFT_PASS=0
+KSFT_FAIL=1
+KSFT_XFAIL=2
+KSFT_XPASS=3
+KSFT_SKIP=4
+
 ktap_print_header() {
 	echo "TAP version 13"
 }
-- 
2.30.2


