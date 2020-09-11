Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566F0265625
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 02:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgIKArW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 20:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgIKArU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 20:47:20 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB4C214F1;
        Fri, 11 Sep 2020 00:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599785240;
        bh=q0yRMguvY/GwKYtuU8Ll/cQ/jEQ6NkxZAQwfNy/ELnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z+OHEKnKofX2I8Mld+PKlQyw8MRioNkf+sARuiTD7xqN8J44F//PInHKIn4RUFRcc
         iFPL+GVWmz+CUgdO5AzzcEbkKERTTpBlfYOJvJHGArMsuYgPElS+jYL+DOo9MDDwIX
         +/I7SpmizLNvn2gwlUnHIT2Es7qvXPwGhDGSpF6U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kselftest@vger.kernel.org, Tim.Bird@sony.com
Subject: [PATCH v3.1 3/8] Documentation: tracing: Add tracing_on option to boot-time tracer
Date:   Fri, 11 Sep 2020 09:47:15 +0900
Message-Id: <159978523520.485820.9250337223076929279.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911074110.fa9d19c152f3c35947199360@kernel.org>
References: <20200911074110.fa9d19c152f3c35947199360@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tracing_on option description to the boot-time tracer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3.1:
   - Fix "on boot" to "on starting boot-time tracing".
---
 Documentation/trace/boottime-trace.rst |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index dcb390075ca1..9bc8aceb8c0a 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -61,6 +61,10 @@ These options can be used for each instance including global ftrace node.
 ftrace.[instance.INSTANCE.]options = OPT1[, OPT2[...]]
    Enable given ftrace options.
 
+ftrace.[instance.INSTANCE.]tracing_on = 0|1
+   Enable/Disable tracing on this instance when starting boot-time tracing.
+   (you can enable it by the "traceon" event trigger action)
+
 ftrace.[instance.INSTANCE.]trace_clock = CLOCK
    Set given CLOCK to ftrace's trace_clock.
 

