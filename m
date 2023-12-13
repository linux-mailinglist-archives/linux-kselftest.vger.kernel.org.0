Return-Path: <linux-kselftest+bounces-1768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7593381066D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6EC1C2092E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1C396;
	Wed, 13 Dec 2023 00:22:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63188631;
	Wed, 13 Dec 2023 00:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D0FC433C7;
	Wed, 13 Dec 2023 00:22:34 +0000 (UTC)
Date: Tue, 12 Dec 2023 19:23:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v3] tracing/selftests: Add test to test the trace_marker
Message-ID: <20231212192317.0fb6b101@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a test that writes longs strings, some over the size of the sub buffer
and make sure that the entire content is there.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/linux-trace-kernel/20231212151632.25c9b67d@gandalf.local.home

- Realized with the upcoming change of the dynamic subbuffer sizes, that
  this test will fail if the subbuffer is bigger than what the trace_seq
  can hold. Now the trace_marker does not always utilize the full subbuffer
  but the size of the trace_seq instead. As that size isn't available to
  user space, we can only just make sure all content is there.

 .../ftrace/test.d/00basic/trace_marker.tc     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
new file mode 100755
index 000000000000..b24aff5807df
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
@@ -0,0 +1,82 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Basic tests on writing to trace_marker
+# requires: trace_marker
+# flags: instance
+
+get_buffer_data_size() {
+	sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page
+}
+
+get_buffer_data_offset() {
+	sed -ne 's/^.*data.*offset:\([0-9][0-9]*\).*/\1/p' events/header_page
+}
+
+get_event_header_size() {
+	type_len=`sed -ne 's/^.*type_len.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`
+	time_len=`sed -ne 's/^.*time_delta.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`
+	array_len=`sed -ne 's/^.*array.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`
+	total_bits=$((type_len+time_len+array_len))
+	total_bits=$((total_bits+7))
+	echo $((total_bits/8))
+}
+
+get_print_event_buf_offset() {
+	sed -ne 's/^.*buf.*offset:\([0-9][0-9]*\).*/\1/p' events/ftrace/print/format
+}
+
+event_header_size=`get_event_header_size`
+print_header_size=`get_print_event_buf_offset`
+
+data_offset=`get_buffer_data_offset`
+
+marker_meta=$((event_header_size+print_header_size))
+
+make_str() {
+        cnt=$1
+	# subtract two for \n\0 as marker adds these
+	cnt=$((cnt-2))
+	printf -- 'X%.0s' $(seq $cnt)
+}
+
+write_buffer() {
+	size=$1
+
+	str=`make_str $size`
+
+	# clear the buffer
+	echo > trace
+
+	# write the string into the marker
+	echo -n $str > trace_marker
+
+	echo $str
+}
+
+test_buffer() {
+
+	size=`get_buffer_data_size`
+	oneline_size=$((size-marker_meta))
+	echo size = $size
+	echo meta size = $marker_meta
+
+	# Now add a little more the meta data overhead will overflow
+
+	str=`write_buffer $size`
+
+	# Make sure the line was broken
+	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: /,"");printf "%s", $0; exit}' trace`
+
+	if [ "$new_str" = "$str" ]; then
+		exit fail;
+	fi
+
+	# Make sure the entire line can be found
+	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: */,"");printf "%s", $0; }' trace`
+
+	if [ "$new_str" != "$str" ]; then
+		exit fail;
+	fi
+}
+
+test_buffer
-- 
2.42.0


