Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA532640B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 10:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgIJI5C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 04:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730259AbgIJIzl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 04:55:41 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26CF420770;
        Thu, 10 Sep 2020 08:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599728140;
        bh=RUqvnNc5wOwqapqqse5XrNvDpPCq89bLAr/r7gI4jU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awgxyXjHGtxa4cfVDOa6QyO85fpqiltWylBoV8S/1Fl0vfU77sMSwBI2sJgnZsV0s
         glkbrnmhLQwKnFS4U2Y7oMjvs2UghCWBFkYj5Yz43zNyb67i/C5zZjT+dVUOMVZ/Vy
         FvrUUreYm3jYBACOdXJ7HpG8jIuZ5IgNLw0fTbwY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 4/8] tracing/kprobes: Support perf-style return probe
Date:   Thu, 10 Sep 2020 17:55:35 +0900
Message-Id: <159972813535.428528.4437029657208468954.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159972809455.428528.4737752126800169128.stgit@devnote2>
References: <159972809455.428528.4737752126800169128.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support perf-style return probe ("SYMBOL%return") for kprobe events.
This will allow boot-time tracing user to define a return probe event.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Update README so that user can notice the kernel supports this feature.
  - Add a new error message.
---
 kernel/trace/trace.c        |    2 +-
 kernel/trace/trace_kprobe.c |   18 +++++++++++++++++-
 kernel/trace/trace_probe.h  |    1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f40d850ebabc..2c8c8f7ddef7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5122,7 +5122,7 @@ static const char readme_msg[] =
 	"\t           -:[<group>/]<event>\n"
 #ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
-  "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
+  "place (kretprobe): [<module>:]<symbol>[+<offset>]%return|<memaddr>\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
   "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index aefb6065b508..e33690a12255 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -717,6 +717,9 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	 *      p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
 	 *  - Add kretprobe:
 	 *      r[MAXACTIVE][:[GRP/]EVENT] [MOD:]KSYM[+0] [FETCHARGS]
+	 *    Or
+	 *      p:[GRP/]EVENT] [MOD:]KSYM[+0]%return [FETCHARGS]
+	 *
 	 * Fetch args:
 	 *  $retval	: fetch return value
 	 *  $stack	: fetch stack address
@@ -746,7 +749,6 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	switch (argv[0][0]) {
 	case 'r':
 		is_return = true;
-		flags |= TPARG_FL_RETURN;
 		break;
 	case 'p':
 		break;
@@ -804,12 +806,26 @@ static int trace_kprobe_create(int argc, const char *argv[])
 		symbol = kstrdup(argv[1], GFP_KERNEL);
 		if (!symbol)
 			return -ENOMEM;
+
+		tmp = strchr(symbol, '%');
+		if (tmp) {
+			if (!strcmp(tmp, "%return")) {
+				*tmp = '\0';
+				is_return = true;
+			} else {
+				trace_probe_log_err(tmp - symbol, BAD_ADDR_SUFFIX);
+				goto parse_error;
+			}
+		}
+
 		/* TODO: support .init module functions */
 		ret = traceprobe_split_symbol_offset(symbol, &offset);
 		if (ret || offset < 0 || offset > UINT_MAX) {
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
 			goto parse_error;
 		}
+		if (is_return)
+			flags |= TPARG_FL_RETURN;
 		if (kprobe_on_func_entry(NULL, symbol, offset))
 			flags |= TPARG_FL_FENTRY;
 		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index a22b62813f8c..04d00987da69 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -404,6 +404,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
+	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(GROUP_TOO_LONG,	"Group name is too long"),		\
 	C(BAD_GROUP_NAME,	"Group name must follow the same rules as C identifiers"), \

