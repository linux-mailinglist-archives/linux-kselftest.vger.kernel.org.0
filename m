Return-Path: <linux-kselftest+bounces-47378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF7CB4A73
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 04:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA68F300EE49
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 03:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF121CC71;
	Thu, 11 Dec 2025 03:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CiKNCl6H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F432C8B;
	Thu, 11 Dec 2025 03:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765424932; cv=none; b=tdvGdRRWxDWRX47BQ33qWidy8YytAZG548iYGl2a6ew/GEAnoabdrzCJYZsFYcuu6jf0bhrecIuPIPZljyPaOnwu30bYPu6DgCMdRAWPtNNci3m+CRIja+fGAs/FNuyF5UXFBnbA3pHloWZSXO85rMryvOpzevbK49YcDatgSbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765424932; c=relaxed/simple;
	bh=P/mRXhxojwzAaDBRdCIqSNqvcH8X9/vWjmUzYUbeX7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwEBjEUWHonJ5eDnzMtDw5y2WX6Y7IYKK7EQNmU/GMSndSl0P0Or5eEnfDImARbuiwtQfPygUzpZAhU7m/+UKL1SN9o+NJjIL2asJQlPYEdmm+U/h6+XsKcyWYWyhC5uJ0/KQXbAAl0/OO06xOLAK3+AIr0WoVdzv4T0qNDLCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CiKNCl6H; arc=none smtp.client-ip=47.90.199.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765424916; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bwI27Qotcd/3gSdH3Q5W4KZfmIl1mrQxgI8NNrXL2tY=;
	b=CiKNCl6HiNRiGMgs51XMeqmBivZe+juhguUdznN/5bqDPA2aXktK64SDqq+wz8Buy9BS5ypkfSyqNRygYb+ef6/k8wN6NZPCvOZebDtyIU5xF0tS0G40ACLviY0Ul5Uq649GpYyHFdPtmWLCJfpknk73h/PwTLSZZNSpmENsjcg=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuYnsDN_1765424911 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 11:48:35 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bamvor Jian Zhang <bamv2005@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RESEND] selftests: gpio: correctly check the type of /dev/gpiochipX
Date: Thu, 11 Dec 2025 11:48:31 +0800
Message-ID: <20251211034831.62802-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/dev/gpiochipX is a character device, not a directory, so we should
use "test -c" instead of "test -d" to check for its existence;
otherwise, the current check will not work correctly when
/dev/gpiochipX is left over (e.g., as a stale device node).

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 tools/testing/selftests/gpio/gpio-aggregator.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-aggregator.sh b/tools/testing/selftests/gpio/gpio-aggregator.sh
index 9b6f80ad9f8a..13d8e1607571 100755
--- a/tools/testing/selftests/gpio/gpio-aggregator.sh
+++ b/tools/testing/selftests/gpio/gpio-aggregator.sh
@@ -351,7 +351,7 @@ test "$(agg_get_chip_num_lines _sysfs.0)" = "1" || fail "number of lines is not
 test "$(agg_get_line_name _sysfs.0 0)" = "" || fail "line name is unset"
 echo "$(agg_configfs_dev_name _sysfs.0)" > "$SYSFS_AGG_DIR/delete_device"
 test -d $CONFIGFS_AGG_DIR/_sysfs.0 && fail "_sysfs.0 unexpectedly remains"
-test -d /dev/${CHIPNAME} && fail "/dev/${CHIPNAME} unexpectedly remains"
+test -c /dev/${CHIPNAME} && fail "/dev/${CHIPNAME} unexpectedly remains"
 
 echo "1.2.2. Complex creation/deletion"
 echo "chip0bank0_0 chip1_bank1 10-11" > "$SYSFS_AGG_DIR/new_device"
@@ -365,7 +365,7 @@ test "$(agg_get_line_name _sysfs.0 1)" = "" || fail "line name is unset"
 test "$(agg_get_line_name _sysfs.0 2)" = "" || fail "line name is unset"
 echo "$(agg_configfs_dev_name _sysfs.0)" > "$SYSFS_AGG_DIR/delete_device"
 test -d $CONFIGFS_AGG_DIR/_sysfs.0 && fail "_sysfs.0 unexpectedly remains"
-test -d /dev/${CHIPNAME} && fail "/dev/${CHIPNAME} unexpectedly remains"
+test -c /dev/${CHIPNAME} && fail "/dev/${CHIPNAME} unexpectedly remains"
 
 echo "1.2.3. Asynchronous creation with deferred probe"
 sim_disable_chip  chip0
@@ -382,7 +382,7 @@ test "$(agg_get_chip_num_lines _sysfs.0)" = "1" || fail "number of lines is not
 test "$(agg_get_line_name _sysfs.0 0)" = "" || fail "line name unexpectedly set"
 echo "$(agg_configfs_dev_name _sysfs.0)" > "$SYSFS_AGG_DIR/delete_device"
 test -d $CONFIGFS_AGG_DIR/_sysfs.0 && fail "_sysfs.0 unexpectedly remains"
-test -d /dev/${CHIPNAME} && fail "/dev/${CHIPNAME} unexpectedly remains"
+test -c /dev/${CHIPNAME} && fail "/dev/${CHIPNAME} unexpectedly remains"
 
 echo "1.2.4. Can't instantiate a chip with invalid configuration"
 echo "xyz 0" > "$SYSFS_AGG_DIR/new_device"
-- 
2.43.0


