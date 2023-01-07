Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0152660F1A
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jan 2023 14:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjAGNcf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Jan 2023 08:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjAGNc0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Jan 2023 08:32:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6315E0A5;
        Sat,  7 Jan 2023 05:32:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D962B810AA;
        Sat,  7 Jan 2023 13:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC7AC433EF;
        Sat,  7 Jan 2023 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673098342;
        bh=HGJHlcKefwA/vKHzLOsju9wxMYeQUgD1tHvIeGZhwP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNrzDEV/aOPxQaA9ne4EU1emyfiqMkOkcV/hymisgM67DzCy+jw+H10Yk0C2JmRYy
         aw1l9jmWeMlBEBn6wfTSI9E5WrJNaohNhPM+WMZDdDLXadkoWTfQyBXyUsmCwCsXZf
         rjrJS6uZ1PBqfXcDDfCY1AnsS4Kad4vhnags7NvDnmq3v5HBDsVmWU3ZmdysSDeT1X
         USleihtE+VMLLWG4yLVDSwuSCXsvqLAfe7+WNkaP/v/FMc+I9IezXffJ1Yi6DyWocZ
         E8/rGGNtzQ2LCwW8vxulw+ytnxPFFKOE9kEoZtZJQpKQC6pMYsQnA3sRWqKA+rHsPP
         FbMVepdiY9JcA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 1/3] tracing/eprobe: Fix to add filter on eprobe description in README file
Date:   Sat,  7 Jan 2023 22:32:17 +0900
Message-Id: <167309833728.640500.12232259238201433587.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <167309832823.640500.13244630381161014364.stgit@devnote3>
References: <167309832823.640500.13244630381161014364.stgit@devnote3>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to add a description of the filter on eprobe in README file. This
is required to identify the kernel supports the filter on eprobe or not.

Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a555a861b978..d0c22766dc26 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5598,7 +5598,7 @@ static const char readme_msg[] =
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t           s:[synthetic/]<event> <field> [<field>]\n"
 #endif
-	"\t           e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]\n"
+	"\t           e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>] [if <filter>]\n"
 	"\t           -:[<group>/][<event>]\n"
 #ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"

