Return-Path: <linux-kselftest+bounces-47967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C1ACDE85F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 10:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 686233006477
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B4527CCE0;
	Fri, 26 Dec 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FHtAA0Ay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9825771;
	Fri, 26 Dec 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766740380; cv=none; b=SuwzhH1pYHffVM82A/fYRTA1LO8HE1aY6qEf0HzYoJwWPNBss0Eek0W1D0/v8OcOvlcj54yws9T2Rh9Wj3GIwi7cG4Tp5DnfAplpzncNc2FJaqff6kdXrsFj3c4EidIetOPVmldKhIvpLFcqNa/JWJ8BXcBgEr0N6Y+7XPFl774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766740380; c=relaxed/simple;
	bh=AtrdlCV+YHjlWykxoRGGwakWl+iiQcP8jaoqVooxEL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fXipdWJfPMTzgZ6D/Z71AHGzfAq8ocmjAi3XXo9dlbaGlSAEXgh8F+QKbEtRLByF4eDKMbRoiYdTbCVCMC35io1Hj0VG2Bj4g4A+QcbGgQ1NcA9t7EemHVDvEDQQ1EPHve4Q4XENMMPWH72WK3Kl1EENzz22y+tVMxBlpxfe5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FHtAA0Ay; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766740366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tP79jUlxQqteTlJTZcbdsCyV2FTopmoHAhDCb8dWps8=;
	b=FHtAA0AyeDgP27abECFFsD0xufv6Uz1tCV9vAo8IJQorB1yhc6vmNBlsR1eVvDPMAnGHOZ
	wi87nDFwA2RzqGP6drknNEGYQxmeVC1xS/o8n9y7ZosrXA7wgTqu8WVk1rmV/5LwMW3rO7
	ly3jzJr4dxLEUjdINfaRPrTtXdMyw1Q=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	wangfushuai@baidu.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Fushuai Wang <fushuai.wang@linux.dev>
Subject: [PATCH] selftests/tracing: Fix test_multiple_writes stall
Date: Fri, 26 Dec 2025 17:12:17 +0800
Message-Id: <20251226091217.58992-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When /sys/kernel/tracing/buffer_size_kb is less than 12KB,
the test_multiple_writes test will stall and wait for more
input due to insufficient buffer space.

This patch check current buffer_size_kb value before the test.
If it is less than 12KB, it temporarily increase the buffer to
12KB, and restore the original value after the tests are completed.

Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 .../ftrace/test.d/00basic/trace_marker_raw.tc    | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
index 7daf7292209e..216f87d89c3f 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -58,7 +58,7 @@ test_multiple_writes() {
 	echo stop > trace_marker
 
 	# Check to make sure the number of entries is the id (rounded up by 4)
-	awk '/.*: # [0-9a-f]* / {
+	awk -v ORIG="${ORIG}" '/.*: # [0-9a-f]* / {
 			print;
 			cnt = -1;
 			for (i = 0; i < NF; i++) {
@@ -70,6 +70,7 @@ test_multiple_writes() {
 					# The number of items is always rounded up by 4
 					cnt2 = int((cnt + 3) / 4) * 4;
 					if (cnt2 != num) {
+						system("echo \""ORIG"\" > buffer_size_kb");
 						exit 1;
 					}
 					break;
@@ -89,6 +90,7 @@ test_buffer() {
 	# The id must be four bytes, test that 3 bytes fails a write
 	if echo -n abc > ./trace_marker_raw ; then
 		echo "Too small of write expected to fail but did not"
+		echo $ORIG > buffer_size_kb
 		exit_fail
 	fi
 
@@ -99,9 +101,21 @@ test_buffer() {
 
 	if write_buffer 0xdeadbeef $size ; then
 		echo "Too big of write expected to fail but did not"
+		echo $ORIG > buffer_size_kb
 		exit_fail
 	fi
 }
 
+ORIG=`cat buffer_size_kb`
+
+# test_multiple_writes test needs at least 12KB buffer
+NEW_SIZE=12
+
+if [ ${ORIG} -lt ${NEW_SIZE} ]; then
+	echo ${NEW_SIZE} > buffer_size_kb
+fi
+
 test_buffer
 test_multiple_writes
+
+echo $ORIG > buffer_size_kb
-- 
2.36.1


