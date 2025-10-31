Return-Path: <linux-kselftest+bounces-44554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C785C26E38
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 21:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 124024F2031
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44C328623;
	Fri, 31 Oct 2025 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnfmtsd/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8330DD01
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942162; cv=none; b=WYJFqhGaVNaavezf6gaNEj4jXxtWysJICqgi5HLUUZ5YUS8dNmthGAjgzl+pnKNV7CgOLfscF85zPUEVD+h/Xleyr8byhf4jiygbMkvsAhY2hRqeDpN1KXuYPhQAqz760Z7YYRJ7UvrL7GXZc8SeyqphHG5J2bl20Gbm1OODnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942162; c=relaxed/simple;
	bh=xG56qsMH2WuZG3c7wHt0lGtWrKdZNmLha+U2JMxWS24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QSvz02orWUQ/0pU/vFrC9PlN/N6AN+Uks+khnsJYkO0YE0d+IIEfGUfZnVeow0jfA6Zf6RNKmTb6HAH78tmGB4/nePvDsLCClDJLQ2g/M0fM26oK1zksbA3xAIGO8Ka3fNfyeNVcAVlf5D6rMZZXAp7l+e7m591xcrQHSA2q/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnfmtsd/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-592fa38fe60so3467864e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761942158; x=1762546958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsZcwQVtwdhCivWDhKm/5zaUeqA1jP6eTb4+KpUSqwc=;
        b=Dnfmtsd/2UPto3N512HWy0p6HVN4bGZjYL80D0TJsw80Lzob49WkluayNIGeEEMG7s
         QIfpZvrkdhauNgYGLYvl7JdcAl4dio8McASFWffevhouzftHdwx0Gc+bVy263Lec9jGd
         A3r5C3il4z78pHaDC7EItw1PhSBe0uvi2uv2wAxCCz3Pl97oSmh4WX1keL+NC/u1f9mP
         zBhfZbD9pjr/2r0GKPwnDXLmUFCrSxEkt9A7FlxX+3v+uMbiy4ZXjrDF3i49MeeM0JQb
         39+Eoc8bWsdxq9PNVmnzrwPrTNDKUzhaar+1Fswsu9bL5xp03+kd8B8fwAZgpmQGDKld
         OGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942158; x=1762546958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsZcwQVtwdhCivWDhKm/5zaUeqA1jP6eTb4+KpUSqwc=;
        b=LF+s0dUKDEIjKLGBBAn4bWLY8IODvLbidoDao6gPmZcsglCBamw9t4Uy+U5/1/SRML
         W8tZ4ndlkEVcQVZiSPOy63OE6+JRIu0wahLf/iELBOfCIwYp1Pf1Q89VZ/ryJL+/v+M/
         1aRnK8ADC8Qzm/M9CHtOxaoXJimMJVzEAJUz9LLyilTZA4SkZ0soM+oiChQxLiqAMO5t
         pgRz91umbo7Qbz7a/7MbnHkUzayY+QhSpNxMKEErhqgPHZ3w4eU0T9t6uaupTTxMReMO
         TPMCWxWczXVEGWLrCMZVXrsAIs4hfmeB2PCvwiSt94EA/I0RV1R1vEpZpejtNX8+T4vZ
         ja/g==
X-Forwarded-Encrypted: i=1; AJvYcCV0hhIkfAfPK6MEbHR/asbt7N4Y9XO3uVCfS7gl7foLAWfuFNbxbJPcjCFfH4/PdZ6Ty4p7S9mpEccaiWQ8S5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKCYNaB2ouSf8Lq2rxUH7t/y1BwXqPEnRG5XRYaEHXyaw72X5
	PQMNE2Z1Z11b38gG+omIfoVN+FyK8pMdOzOln7cbyZjCpy7ypmJHRthiDC/Wn227
X-Gm-Gg: ASbGnctEDLKVRCcI3zl6557gyvt9WOIocbZp+XTva3aRJy7ZBr/Cu9IWimMGLd02Zdq
	5fucBtUpcalBDKoG0qz8d0kQLem43GXk0TR5YTFezf+QyKSak14D/skrH4FfKISXAbZX9OjcIx/
	c5/cBQLR1Y0Eaekv0qYaZY+oZRD1GdqznwlOwppA0t6cc/phwEscr9ZSfiiKcpkipunAlACKZ9X
	zg8AgURmR10ommrDeeq1r+H45nbrQj3zmUbuKXRnEeyBtiAIgpK5daFvh64jFG+T8Y7Len9L3ks
	vEvIN4SnVL2zlJoG/36/lOJJ60vro38ltTgR4MHqAWIfZtExfQa8iT53drt4pVMgPIokCTpZH/X
	6mK/CrD3oo3frud5khrX3OIDLs/j4aaJuhFGNkbyR4D/d05Xz6zV7eSIGs0NDmXGULIRjuJF00t
	tk3mk=
X-Google-Smtp-Source: AGHT+IEFROwv14v4VtNeXmBx07IO0llOFTdpkWeY0h878Ddr9Ngru7QFo7D5rPTu2YYfmOzcxZIaTQ==
X-Received: by 2002:a05:6512:1384:b0:592:f814:7c94 with SMTP id 2adb3069b0e04-5941d5079a9mr1680972e87.1.1761942158041;
        Fri, 31 Oct 2025 13:22:38 -0700 (PDT)
Received: from archlinux ([109.234.31.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5b5d3csm706058e87.68.2025.10.31.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:22:36 -0700 (PDT)
From: zntsproj <vacacax16@gmail.com>
X-Google-Original-From: zntsproj <vseokaktusah7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: bamv2005@gmail.com,
	shuah@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: [PATCH] gpio-selftests: replace fixed sleep with polling+timeout
Date: Fri, 31 Oct 2025 23:22:26 +0300
Message-ID: <20251031202226.7148-1-vseokaktusah7@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the hard-coded sleep 0.1 with a polling loop with timeout
to check the sysfs GPIO value. This avoids timing-dependent
flaky failures in CI and on slower machines.
---
 .../testing/selftests/gpio/gpio-aggregator.sh | 59 +++++++++++++++----
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-aggregator.sh b/tools/testing/selftests/gpio/gpio-aggregator.sh
index 9b6f80ad9..1e81e62e9 100755
--- a/tools/testing/selftests/gpio/gpio-aggregator.sh
+++ b/tools/testing/selftests/gpio/gpio-aggregator.sh
@@ -671,26 +671,59 @@ teardown_4() {
 	agg_configfs_cleanup
 }
 
+# helper: wait for sysfs file to become a given value (timeout in seconds)
+wait_for_sysfs_value() {
+    file="$1"
+    expected="$2"
+    timeout="${3:-2}"   # seconds
+    interval="0.01"     # seconds per poll
+    max=$((timeout * 100))
+    i=0
+
+    while [ "$i" -lt "$max" ]; do
+        if [ "$(cat "$file")" = "$expected" ]; then
+            return 0
+        fi
+        sleep "$interval"
+        i=$((i + 1))
+    done
+
+    return 1
+}
+
 echo "4.1. Forwarding set values"
 setup_4
 OFFSET=0
 for SETTING in $SETTINGS; do
-	CHIP=$(echo "$SETTING" | cut -d: -f1)
-	BANK=$(echo "$SETTING" | cut -d: -f2)
-	LINE=$(echo "$SETTING" | cut -d: -f3)
-	DEVNAME=$(cat "$CONFIGFS_SIM_DIR/$CHIP/dev_name")
-	CHIPNAME=$(cat "$CONFIGFS_SIM_DIR/$CHIP/$BANK/chip_name")
-	VAL_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio${LINE}/value"
-	test $(cat $VAL_PATH) = "0" || fail "incorrect value read from sysfs"
-	$BASE_DIR/gpio-mockup-cdev -s 1 "/dev/$(agg_configfs_chip_name agg0)" "$OFFSET" &
-	mock_pid=$!
-	sleep 0.1 # FIXME Any better way?
-	test "$(cat $VAL_PATH)" = "1" || fail "incorrect value read from sysfs"
-	kill "$mock_pid"
-	OFFSET=$(expr $OFFSET + 1)
+    CHIP=$(echo "$SETTING" | cut -d: -f1)
+    BANK=$(echo "$SETTING" | cut -d: -f2)
+    LINE=$(echo "$SETTING" | cut -d: -f3)
+    DEVNAME=$(cat "$CONFIGFS_SIM_DIR/$CHIP/dev_name")
+    CHIPNAME=$(cat "$CONFIGFS_SIM_DIR/$CHIP/$BANK/chip_name")
+    VAL_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio${LINE}/value"
+
+    test "$(cat "$VAL_PATH")" = "0" || fail "incorrect value read from sysfs"
+
+    $BASE_DIR/gpio-mockup-cdev -s 1 "/dev/$(agg_configfs_chip_name agg0)" "$OFFSET" &
+    mock_pid=$!
+
+    # wait up to 2s for value to flip to "1"
+    if ! wait_for_sysfs_value "$VAL_PATH" "1" 2; then
+        kill "$mock_pid" 2>/dev/null || true
+        wait "$mock_pid" 2>/dev/null || true
+        fail "timeout waiting for $VAL_PATH to become 1"
+    fi
+
+    test "$(cat "$VAL_PATH")" = "1" || fail "incorrect value read from sysfs"
+
+    kill "$mock_pid" 2>/dev/null || true
+    wait "$mock_pid" 2>/dev/null || true
+
+    OFFSET=$((OFFSET + 1))
 done
 teardown_4
 
+
 echo "4.2. Forwarding set config"
 setup_4
 OFFSET=0
-- 
2.51.2


