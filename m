Return-Path: <linux-kselftest+bounces-10443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EAD8CA17D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 19:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D801C20E36
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 17:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B196137C3C;
	Mon, 20 May 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1DAarIjl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946CA2D;
	Mon, 20 May 2024 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226913; cv=none; b=rwXKylQDclLi+5dChvPgjfiiXACJDEHn1Gcbd0c0hFQXRr5kxlhlVTNHywJl2cVZRExJthJjTdCD8iSKImWEtCQSYO4PyPfc3hoZhfI22WmwxJvUEIU9cJCW05imUvegk9so3RIrX+pMjIlhq0y0Udnd9A/5gdedf+FRJKPkItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226913; c=relaxed/simple;
	bh=USAnQFsFIAz4NTK1Wi/gNcItGq8+FboBq9Sm3p6WVJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fbaiWSWHx0oE5qRHz8T/tK64v1EfhJBktP0q7hd50I2siz5TwB88AJ86gOhracSRepgnQ7KkP527VrV8pbyOFFLlJrtZSk5BGWm22cOcDW+xQ5nGe30tBf+tG8kfoiB+BHc+m3UvalzV8rxIxMq9Rb2Lq4EC5py6YMxOO5djAlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1DAarIjl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716226909;
	bh=USAnQFsFIAz4NTK1Wi/gNcItGq8+FboBq9Sm3p6WVJE=;
	h=From:To:Cc:Subject:Date:From;
	b=1DAarIjlKy2Zl60w7NfmP/MqF+2Vf/lBvTyq/6hDi9OQDKknjDXzFHqpwgOc+lUjA
	 pphsH/zdCrKHAHbKSZ23D//Eca5Y3tqf5q/o6FJuyEeG5utOgnD/ano+hUgn4j9gBN
	 985FZoqwm8oJcQR22Ds6awEbQptqdojjls4+AqLvJz4fXuykXdEvusxo2qAUVJ9APi
	 I5NMO2wdKnu9z4NXjcdMw1JsDF/8pF1qCdzxKcoKubfulihtrzqImF0E3+kTDKIsfC
	 1cvwoN9Mr2GFIii68eYdsOK+YJWALUX9iBLyUsWizv3g9WVl9KPrb56bji59IhTDA7
	 HpNToWom1Nqmw==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 09AC0378107D;
	Mon, 20 May 2024 17:41:47 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: firmware: conform test to TAP
Date: Mon, 20 May 2024 09:37:57 -0700
Message-Id: <20240520163759.1427653-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.
Without using TAP messages, the passed/failed/skip test names cannot be
found. This is a prepartory patch, more patches will be sent to comform
the test completely.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../selftests/firmware/fw_run_tests.sh        | 63 ++++++++++++-------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
index f6d95a2d51249..5063c75345680 100755
--- a/tools/testing/selftests/firmware/fw_run_tests.sh
+++ b/tools/testing/selftests/firmware/fw_run_tests.sh
@@ -6,6 +6,9 @@
 
 set -e
 
+DIR="$(dirname $(readlink -f "$0"))"
+source "${DIR}"/../kselftest/ktap_helpers.sh
+
 TEST_DIR=$(dirname $0)
 source $TEST_DIR/fw_lib.sh
 
@@ -26,54 +29,68 @@ run_tests()
 	proc_set_force_sysfs_fallback $1
 	proc_set_ignore_sysfs_fallback $2
 	$TEST_DIR/fw_upload.sh
+
+	ktap_test_pass "Completed"
 }
 
 run_test_config_0001()
 {
-	echo "-----------------------------------------------------"
-	echo "Running kernel configuration test 1 -- rare"
-	echo "Emulates:"
-	echo "CONFIG_FW_LOADER=y"
-	echo "CONFIG_FW_LOADER_USER_HELPER=n"
-	echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
+	ktap_print_msg "-----------------------------------------------------"
+	ktap_print_msg "Running kernel configuration test 1 -- rare"
+	ktap_print_msg "Emulates:"
+	ktap_print_msg "CONFIG_FW_LOADER=y"
+	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER=n"
+	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
 	run_tests 0 1
 }
 
 run_test_config_0002()
 {
-	echo "-----------------------------------------------------"
-	echo "Running kernel configuration test 2 -- distro"
-	echo "Emulates:"
-	echo "CONFIG_FW_LOADER=y"
-	echo "CONFIG_FW_LOADER_USER_HELPER=y"
-	echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
+	ktap_print_msg "-----------------------------------------------------"
+	ktap_print_msg "Running kernel configuration test 2 -- distro"
+	ktap_print_msg "Emulates:"
+	ktap_print_msg "CONFIG_FW_LOADER=y"
+	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER=y"
+	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
 	proc_set_ignore_sysfs_fallback 0
 	run_tests 0 0
 }
 
 run_test_config_0003()
 {
-	echo "-----------------------------------------------------"
-	echo "Running kernel configuration test 3 -- android"
-	echo "Emulates:"
-	echo "CONFIG_FW_LOADER=y"
-	echo "CONFIG_FW_LOADER_USER_HELPER=y"
-	echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y"
+	ktap_print_msg "-----------------------------------------------------"
+	ktap_print_msg "Running kernel configuration test 3 -- android"
+	ktap_print_msg "Emulates:"
+	ktap_print_msg "CONFIG_FW_LOADER=y"
+	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER=y"
+	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y"
 	run_tests 1 0
 }
 
+ktap_print_header
+
 check_mods
 check_setup
 
-echo "Running namespace test: "
-$TEST_DIR/fw_namespace $DIR/trigger_request
-echo "OK"
-
 if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
+	ktap_set_plan "4"
+
 	run_test_config_0001
 	run_test_config_0002
 	run_test_config_0003
 else
-	echo "Running basic kernel configuration, working with your config"
+	ktap_set_plan "2"
+
+	ktap_print_msg "Running basic kernel configuration, working with your config"
 	run_tests
 fi
+
+ktap_print_msg "Running namespace test: "
+$TEST_DIR/fw_namespace $DIR/trigger_request
+if [ $? -eq 0 ]; then
+    ktap_test_pass "fw_namespace completed successfully"
+else
+    ktap_test_fail "fw_namespace failed"
+fi
+
+ktap_finished
-- 
2.39.2


