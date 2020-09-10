Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684802640B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 10:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgIJI5w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 04:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730268AbgIJIzv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 04:55:51 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41522078B;
        Thu, 10 Sep 2020 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599728150;
        bh=Usei1xLmvGf2Y8buCZXpy+oUTxiyFNSfzZeT9ewnigs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zgr7WfK9sDVeejvY78RJ+pkCDQOwSqegfMelvnN8fNrZSf6ipnffv0ANSDHqOxXsx
         Pdz2qRQMHMOM4t3Zg5CpBQjuYTw9VUhBVy6WgtNYLSd/tsVHVU/PHmbWURNMIOmqw3
         CoYroNdbbR2ZmyBRbbnOoToIW/NjvFY2wzLaJakQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/8] tracing/uprobes: Support perf-style return probe
Date:   Thu, 10 Sep 2020 17:55:46 +0900
Message-Id: <159972814601.428528.7641183316212425445.stgit@devnote2>
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

Support perf-style return probe ("SYMBOL%return") for uprobe events
as same as kprobe events does.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c        |    2 +-
 kernel/trace/trace_uprobe.c |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2c8c8f7ddef7..faf55f5dd99d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5125,7 +5125,7 @@ static const char readme_msg[] =
   "place (kretprobe): [<module>:]<symbol>[+<offset>]%return|<memaddr>\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-  "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
+  "   place (uprobe): <path>:<offset>[%return][(ref_ctr_offset)]\n"
 #endif
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f4286c9bdeb4..fb5ec4e55484 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -528,7 +528,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 
 /*
  * Argument syntax:
- *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS]
+ *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET[%return][(REF)] [FETCHARGS]
  */
 static int trace_uprobe_create(int argc, const char **argv)
 {
@@ -617,6 +617,19 @@ static int trace_uprobe_create(int argc, const char **argv)
 		}
 	}
 
+	/* Check if there is %return suffix */
+	tmp = strchr(arg, '%');
+	if (tmp) {
+		if (!strcmp(tmp, "%return")) {
+			*tmp = '\0';
+			is_return = true;
+		} else {
+			trace_probe_log_err(tmp - filename, BAD_ADDR_SUFFIX);
+			ret = -EINVAL;
+			goto fail_address_parse;
+		}
+	}
+
 	/* Parse uprobe offset. */
 	ret = kstrtoul(arg, 0, &offset);
 	if (ret) {

