Return-Path: <linux-kselftest+bounces-46620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDDCC8D69E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 09:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DCE934D108
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F7320CC0;
	Thu, 27 Nov 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p4b9h8mU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894BE523A;
	Thu, 27 Nov 2025 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764233752; cv=none; b=ENBvTR5N/nG20PF+BEgXLnhvZERoAinbEiKg42idrZBSxm5QEZ0LXek4SJKKRJlbNVRWVGtwYweONFb8yqS3lrE/x5XhrRGfqYsWQfi2FYQk17qc6wLgzz01eJ7z99lpeN6atlCejHJZa5EPa9WdImmzvjT2lfO7jChLPHRtXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764233752; c=relaxed/simple;
	bh=P/mRXhxojwzAaDBRdCIqSNqvcH8X9/vWjmUzYUbeX7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJGM5EXu2Qt6pKvZsDh1nJ8cwQril3x3GtJI7Apfm7PtJ1MyKjHjTce0ncAVQMAl6FwtTEdwCXlNhaWi9XwQJFe5DSWdhAnKM42wiIW3HPjVbd+I2bFHB9vcBQF3S731h41X/il+xRwQ0kJg32eH2Qs1uqZQsNtroUNbgEmTiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p4b9h8mU; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764233745; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bwI27Qotcd/3gSdH3Q5W4KZfmIl1mrQxgI8NNrXL2tY=;
	b=p4b9h8mUVGACnTmdT+x0sv/6ZqUcLyj+N4ZX0LazszKYokJv+GMiowFdSaUQNbcpD6mgM85JFqyqoZl5iVeDHbnDLwORYTX2qzUo6lZweRZoLQzt5Bq1RYCY6KuqvJ9wT4F+VsekS9zEwvPr1rN/RtteSvvVCtubNKaR/41Cxr8=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WtWbWI4_1764233740 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 16:55:44 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bamvor Jian Zhang <bamv2005@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: gpio: correctly check the type of /dev/gpiochipX
Date: Thu, 27 Nov 2025 16:55:40 +0800
Message-ID: <20251127085540.21142-1-kanie@linux.alibaba.com>
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


