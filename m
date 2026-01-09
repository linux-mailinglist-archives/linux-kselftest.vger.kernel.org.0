Return-Path: <linux-kselftest+bounces-48583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D01ACD07024
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 04:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A3AA3019270
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 03:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0693223BD05;
	Fri,  9 Jan 2026 03:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLyR6ptv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D922309B2
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929869; cv=none; b=oFxMhmtB5OmPu0X8FN8R74GTkH79sEeTAkMvKPHhcVM+IP2cXvn1b+9cW4G8wFtAIDcArslXH8UdLglvAKOwwZFC3ymyI46X6J13loNaSS4ToKJ7KmtKCdAVt2W5yZk73wPdKMJ1ebX0Py48QbmAObU1LyXycsuUNKbVVWAVm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929869; c=relaxed/simple;
	bh=pQXuVp23KmJTwl1uNecClxnb6Bjg8ReC/eYBTC9HMh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qdjKTE/xFmZ6ufWQ+cNZ4QzrCio+KbySoovLjjMb6dmYIPHz90gBjDTRJgJ/QdDe+jQgAyZgFCeX3Xp+sDf9miWB2tFf1N3erYsaIJSyn363xyo96aVsNNGZTL8WJlWlFWjQLzJs1S7/U3O/jGDlu+uLmNwrjR5xJQMwCBxL9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLyR6ptv; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767929865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OntszklQiyhOLBA2hStKkvGHmLOPE0BPoaUp0XUIGLc=;
	b=CLyR6ptvctGbNIE22zTU8HkpTLigXRfp7jNzgncnNK9KX7itRwtRezSBSPtWOYZe/5xjHe
	1o08LAZPi4Uuhwf7cZ6porM6n+pwZqng25+q45TuXRHZMLP64UEfGh2TRhJRwQ/vQG7Uqj
	MWbPQNL4yw3K0OyQMAUoe3tMEgHp1rI=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	wangfushuai@baidu.com
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3] selftests/tracing: Fix test_multiple_writes stall
Date: Fri,  9 Jan 2026 11:36:20 +0800
Message-Id: <20260109033620.25727-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

When /sys/kernel/tracing/buffer_size_kb is less than 12KB,
the test_multiple_writes test will stall and wait for more
input due to insufficient buffer space.

Check current buffer_size_kb value before the test. If it is
less than 12KB, it temporarily increase the buffer to 12KB,
and restore the original value after the tests are completed.

Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
V2 -> V3: Make the From and SoB match.
V1 -> V2: Restore buffer_size_kb outside of awk script.

 .../ftrace/test.d/00basic/trace_marker_raw.tc  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
index 7daf7292209e..a2c42e13f614 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -89,6 +89,7 @@ test_buffer() {
 	# The id must be four bytes, test that 3 bytes fails a write
 	if echo -n abc > ./trace_marker_raw ; then
 		echo "Too small of write expected to fail but did not"
+		echo ${ORIG} > buffer_size_kb
 		exit_fail
 	fi
 
@@ -99,9 +100,24 @@ test_buffer() {
 
 	if write_buffer 0xdeadbeef $size ; then
 		echo "Too big of write expected to fail but did not"
+		echo ${ORIG} > buffer_size_kb
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
-test_multiple_writes
+if ! test_multiple_writes; then
+	echo ${ORIG} > buffer_size_kb
+	exit_fail
+fi
+
+echo ${ORIG} > buffer_size_kb
-- 
2.36.1


