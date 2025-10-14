Return-Path: <linux-kselftest+bounces-43137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25088BDAF99
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 20:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DD818A787B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2194A29ACF7;
	Tue, 14 Oct 2025 18:51:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304327979A;
	Tue, 14 Oct 2025 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760467916; cv=none; b=Q6z6qZQhhXmzpOCY6ewGnd5KNyZUV9Sd5Ve7YMuaY8jnXQbxg9dVQe2l5eLkwsLynOPE2UpI1QYhxIWZAq775QOnv2Irvh+9FLyJ8ASB4Q+f5kXgmzGb5m7Khu+W9uFKbht3mdRdI++DOBQlt4jTD0QUwPL8R/+qKQwJGDKlF7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760467916; c=relaxed/simple;
	bh=QPziPp2Y/4S3ux1cLbRCxq0EGdLI32mUmWMci0N66Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bSJjBd59Zyd/j/34PQ5mu0KCE3T8baqjPVINWWLyTEfVZLRnbHX5r/0EDtg/ABp9Z4ilbB5ukB+VGkuX7tAneSr+gFL3ERtr8/+WLTbehgDO0GfAPXXsW5VksOhSxAoMJsbKAKPzfREEXr1YoPjsWIdNYbVmtL4O+eTcByLRH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 10CFE1A0A0E;
	Tue, 14 Oct 2025 18:51:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 4472F1D;
	Tue, 14 Oct 2025 18:51:44 +0000 (UTC)
Date: Tue, 14 Oct 2025 14:51:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] selftests/tracing: Add basic test for trace_marker_raw file
Message-ID: <20251014145149.3e3c1033@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pi796r5gp5a9dyokoteerb7q33mg895o
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 4472F1D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188w3gjNYMIg9igDGwdo5voCscms+OlKYU=
X-HE-Tag: 1760467904-669601
X-HE-Meta: U2FsdGVkX1948sCl9BJdloqdJfA/6qYieyXUsiZ7JKyudSU7UQLD+/aRHiDdijP3AHy8vWjDDsx6kc5XTnQ/c7xBfKvHbog83HoVoWjq8Z1n4CTxFDF2zMP+4M6OtJi97032hQP4Puu4rJFzMuErSbVhn0Re4uncC7MP1Zxyi9VHMxelgbdK9L8KjHkj7ivtoOj7kVW7KAnPIWlbC9+2v1kPkghiKe8W3JGeo1Vr8ztdEWztVuSdokwToXR4qQ7FiTMQSiZ6/0lqqkpYufcIYT+lnrB6smDGgtWdDc4yhQRaaWXlAR8dEba/g5MMzLusI4zl9ZeBmCU9EmwizA3a5amzCDZGm0vB/1MLff2/9koYwhTT3ovHBURSmJo3Z8+lMTyh4M926Fmr8lg471A0JKCUWnxzps68

From: Steven Rostedt <rostedt@goodmis.org>

Commit 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read
user space") made an update that fixed both trace_marker and
trace_marker_raw. But the small difference made to trace_marker_raw had a
blatant bug in it that any basic testing would have uncovered.
Unfortunately, the self tests have tests for trace_marker but nothing for
trace_marker_raw which allowed the bug to get upstream.

Add basic selftests to test trace_marker_raw so that this doesn't happen
again.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/00basic/trace_marker_raw.tc | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
new file mode 100644
index 000000000000..7daf7292209e
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -0,0 +1,107 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Basic tests on writing to trace_marker_raw
+# requires: trace_marker_raw
+# flags: instance
+
+is_little_endian() {
+	if lscpu | grep -q 'Little Endian'; then
+		echo 1;
+	else
+		echo 0;
+	fi
+}
+
+little=`is_little_endian`
+
+make_str() {
+	id=$1
+	cnt=$2
+
+	if [ $little -eq 1 ]; then
+		val=`printf "\\%03o\\%03o\\%03o\\%03o" \
+			$(($id & 0xff)) \
+			$((($id >> 8) & 0xff)) \
+			$((($id >> 16) & 0xff)) \
+			$((($id >> 24) & 0xff))`
+	else
+		val=`printf "\\%03o\\%03o\\%03o\\%03o" \
+			$((($id >> 24) & 0xff)) \
+			$((($id >> 16) & 0xff)) \
+			$((($id >> 8) & 0xff)) \
+			$(($id & 0xff))`
+	fi
+
+	data=`printf -- 'X%.0s' $(seq $cnt)`
+
+	printf "${val}${data}"
+}
+
+write_buffer() {
+	id=$1
+	size=$2
+
+	# write the string into the raw marker
+	make_str $id $size > trace_marker_raw
+}
+
+
+test_multiple_writes() {
+
+	# Write a bunch of data where the id is the count of
+	# data to write
+	for i in `seq 1 10` `seq 101 110` `seq 1001 1010`; do
+		write_buffer $i $i
+	done
+
+	# add a little buffer
+	echo stop > trace_marker
+
+	# Check to make sure the number of entries is the id (rounded up by 4)
+	awk '/.*: # [0-9a-f]* / {
+			print;
+			cnt = -1;
+			for (i = 0; i < NF; i++) {
+				# The counter is after the "#" marker
+				if ( $i == "#" ) {
+					i++;
+					cnt = strtonum("0x" $i);
+					num = NF - (i + 1);
+					# The number of items is always rounded up by 4
+					cnt2 = int((cnt + 3) / 4) * 4;
+					if (cnt2 != num) {
+						exit 1;
+					}
+					break;
+				}
+			}
+		}
+	// { if (NR > 30) { exit 0; } } ' trace_pipe;
+}
+
+
+get_buffer_data_size() {
+	sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page
+}
+
+test_buffer() {
+
+	# The id must be four bytes, test that 3 bytes fails a write
+	if echo -n abc > ./trace_marker_raw ; then
+		echo "Too small of write expected to fail but did not"
+		exit_fail
+	fi
+
+	size=`get_buffer_data_size`
+	echo size = $size
+
+	# Now add a little more than what it can handle
+
+	if write_buffer 0xdeadbeef $size ; then
+		echo "Too big of write expected to fail but did not"
+		exit_fail
+	fi
+}
+
+test_buffer
+test_multiple_writes
-- 
2.51.0


