Return-Path: <linux-kselftest+bounces-37766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98370B0C9E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 19:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CD45421C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 17:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E4C2E0B5F;
	Mon, 21 Jul 2025 17:42:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B661F8690;
	Mon, 21 Jul 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119746; cv=none; b=b3k/anDW13Q+xvPNIRZVE1Bfs9LhJUjI0ZB2Fl/I/Fy1RSfLRoUx2ePUYakO4+LdzqtMNxfra2Nn1kpDd6wW8IOJXeJjSuGgWh7ehFoqG2uRqhJgRCHVjDSNd3/tnD7OApgQYHa81/9SmCWd5fv4LESfCg2E+/BZxm/pgfvkyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119746; c=relaxed/simple;
	bh=w/2j9ClBxq0pV31rPFeVzo+iLovp//XDRhOvxyXxZRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WMojLRW6nmVBBCQmLxxcWNh4YzMvMEiVIsHGdL3C+eJxFTFCqw+NNZocMZjjAcNpLcdSPLSg9dhhJXfn2XrQ+ZSwwaboi7aaoZqIgg3evq1Hj74uenGTu2CW8eHyoWlW8xcYoW7ouE8yoR95FIIic54mexGsVwr3eqeX459paIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 98F7512C62A;
	Mon, 21 Jul 2025 17:42:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id B3EE720026;
	Mon, 21 Jul 2025 17:42:13 +0000 (UTC)
Date: Mon, 21 Jul 2025 13:42:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuahkhan@gmail.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH] selftests/tracing: Fix false failure of subsystem event
 test
Message-ID: <20250721134212.53c3e140@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3izyokdfko365m1434hke7w4gc1khgow
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B3EE720026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+8Ghli5wRqbA0bgMbeMKMIikC8MX5Gc0A=
X-HE-Tag: 1753119733-523282
X-HE-Meta: U2FsdGVkX1/AvunrBznBj7dzqK3kyYT1D73eWM3WQ09tue0xVMFXytS+JsyVXTKfk+php50gA3v3XMUfF5MMhykePKQlRvqB1ZB7ajCQpM20XjM3BjYqn+42zV+F54DSc+1K8bR4Hr1NaSBpHFqrLxQyDW+NMKuBvKc3GkN0z9MKP/vahcq9zecZ8nnj+h9tBYjp0KdGX/7x4LdEY3DNkcA4rJBYdHYBWmsX7YD98Eg3xLOB7SdBhjbKShPfLrzrJX3amHsl1n4z2hb8H9oP2Ro9QYX/nhpi04NcPV1+OeWKHHD4kE5btHS57K9oRvElX9vt+TSJvLtGPDkyTNTFRJOTdQGfFfK1+/TpI3kzAOlWsN4/IPbgFUOnZ8y0wMHlgIbppJgptvYEnDo3kQORuqucKK8c25YsQP6s/bGx5Vw=

From: Steven Rostedt <rostedt@goodmis.org>

The subsystem event test enables all "sched" events and makes sure there's
at least 3 different events in the output. It used to cat the entire trace
file to | wc -l, but on slow machines, that could last a very long time.
To solve that, it was changed to just read the first 100 lines of the
trace file. This can cause false failures as some events repeat so often,
that the 100 lines that are examined could possibly be of only one event.

Instead, create an awk script that looks for 3 different events and will
exit out after it finds them. This will find the 3 events the test looks
for (eventually if it works), and still exit out after the test is
satisfied and not cause slower machines to run forever.

Reported-by: Tengda Wu <wutengda@huaweicloud.com>
Closes: https://lore.kernel.org/all/20250710130134.591066-1-wutengda@huaweicloud.com/
Fixes: 1a4ea83a6e67 ("selftests/ftrace: Limit length in subsystem-enable tests")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/event/subsystem-enable.tc   | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index b7c8f29c09a9..65916bb55dfb 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -14,11 +14,35 @@ fail() { #msg
     exit_fail
 }
 
+# As reading trace can last forever, simply look for 3 different
+# events then exit out of reading the file. If there's not 3 different
+# events, then the test has failed.
+check_unique() {
+    cat trace | grep -v '^#' | awk '
+	BEGIN { cnt = 0; }
+	{
+	    for (i = 0; i < cnt; i++) {
+		if (event[i] == $5) {
+		    break;
+		}
+	    }
+	    if (i == cnt) {
+		event[cnt++] = $5;
+		if (cnt > 2) {
+		    exit;
+		}
+	    }
+	}
+	END {
+	    printf "%d", cnt;
+	}'
+}
+
 echo 'sched:*' > set_event
 
 yield
 
-count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`check_unique`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -29,7 +53,7 @@ echo 1 > events/sched/enable
 
 yield
 
-count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`check_unique`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
-- 
2.47.2


