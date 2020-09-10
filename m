Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026F92640C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 10:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgIJI67 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 04:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbgIJIzU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 04:55:20 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AED4D208CA;
        Thu, 10 Sep 2020 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599728119;
        bh=SwrJXfeH/9hOrMi7XyK/W+RmfZgE720J1M//fWtouGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivcvhJmVM32K1an7TJ7aGnBwdi+4P5XrMo4dpwItVENXdXZEe0jr8ps4/ll8mafdo
         tuyvq0QKHHOqBgLuQMePdIOKpfPNtc9vfpqe0Xo1w5be1LWhikneUab7/zVBBDvFEE
         PaNoNhfIKZbXKF+bqpq2gfIzHmAFm6APwGxS9sQk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/8] tracing/boot: Add per-instance tracing_on option support
Date:   Thu, 10 Sep 2020 17:55:15 +0900
Message-Id: <159972811538.428528.2561315102284268611.stgit@devnote2>
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

Add per-instance tracing_on option, which will be useful with
traceon/traceoff event trigger actions. For example, if we
disable tracing_on by default and set traceon and traceoff on
a pair of events, we can trace functions between the pair of
events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index fa0fc08c6ef8..d52d441a17e8 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -40,6 +40,16 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 			pr_err("Failed to set option: %s\n", buf);
 	}
 
+	p = xbc_node_find_value(node, "tracing_on", NULL);
+	if (p && *p != '\0') {
+		if (kstrtoul(p, 10, &v))
+			pr_err("Failed to set tracing on: %s\n", p);
+		if (v)
+			tracer_tracing_on(tr);
+		else
+			tracer_tracing_off(tr);
+	}
+
 	p = xbc_node_find_value(node, "trace_clock", NULL);
 	if (p && *p != '\0') {
 		if (tracing_set_clock(tr, p) < 0)

