Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C11660F1E
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jan 2023 14:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjAGNdI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Jan 2023 08:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjAGNcl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Jan 2023 08:32:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1305E0B7;
        Sat,  7 Jan 2023 05:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1E960C08;
        Sat,  7 Jan 2023 13:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7D7C433EF;
        Sat,  7 Jan 2023 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673098360;
        bh=QQjmgf5W/T/Kzs3A2mqRoW9fGZAadyb1nwhZ/JNs3Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5v0ZpD7GrnovovNTeycO7D8G9AusoUDyOmMLdWFRQXW2hGZat6+XCcMYZlvUIkcr
         3Si5qSbWy8UEMjnx2xg7tuPr4jsi2uaBf67bpkW0xmc+kGAUUDNVQ7xpGCayNWXlFj
         7fV2ib8aRBgK1Ke1cZZFM0N8y1sMS89yuTJKvRZMMCbMynFiAuZjCi4vjoEPyRP0lI
         pkwq2Jpme+73ahSaxONYJ7Wbi9aRRhYrCgshZxV/39CTOqBQ+9ZivZ3yzD7hWqI5Vc
         mKR908XXakWA0rznLWnDbW+DrZ0nghg7Wr6JPBqAyRmn5+OZxVKFByLJkaryo9D/DC
         vGOoyXIfw6NCQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests/ftrace: Fix probepoint testcase to ignore __pfx_* symbols
Date:   Sat,  7 Jan 2023 22:32:36 +0900
Message-Id: <167309835609.640500.9664678940260305746.stgit@devnote3>
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

Fix kprobe probepoint testcase to ignore __pfx_* prefix symbols. Those are
introduced by commit b341b20d648b ("x86: Add prefix symbols for function
padding") for identifying PADDING_BYTES of NOPs. Since kprobe events can
not probe these prefix symbols, this testcase has to skip those symbols.

Fixes: b341b20d648b ("x86: Add prefix symbols for function padding")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
index 624269c8d534..68425987a5dd 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
@@ -21,7 +21,7 @@ set_offs() { # prev target next
 
 # We have to decode symbol addresses to get correct offsets.
 # If the offset is not an instruction boundary, it cause -EILSEQ.
-set_offs `grep -A1 -B1 ${TARGET_FUNC} /proc/kallsyms | cut -f 1 -d " " | xargs`
+set_offs `grep -v __pfx_ /proc/kallsyms | grep -A1 -B1 ${TARGET_FUNC} | cut -f 1 -d " " | xargs`
 
 UINT_TEST=no
 # printf "%x" -1 returns (unsigned long)-1.

