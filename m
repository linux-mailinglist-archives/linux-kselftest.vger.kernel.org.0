Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B1B660F16
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jan 2023 14:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjAGNcI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Jan 2023 08:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGNcI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Jan 2023 08:32:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D17C5B17E;
        Sat,  7 Jan 2023 05:32:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7ED1B810AC;
        Sat,  7 Jan 2023 13:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0A3C433EF;
        Sat,  7 Jan 2023 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673098323;
        bh=/hMzieqMHtR6JL4OjdNz+jKYqIqXve8DlL6+sdK1Zp8=;
        h=From:To:Cc:Subject:Date:From;
        b=nYTcphcFaaiv8O0/i/lFw29bgNkIjCxdNE2l2Uita+0docZBafbt2ajhEYjybEXsZ
         vMzXUVj+ZBLxy0M99RXAYemqMMmnJZdV3JoNMuvqs+A+HgOXYJOW3g2TIqyOkbsH1D
         NHb/RK+wRJ34usc5cczOwszVxqzOgYtRK3OkW81Y/7H9OW82mcC7cjcGMVRcRs24f5
         R1YKqwjCRlul+Ae5lbTUvNftEtsAgM7psqjieiEAOBLTzfojKZICcmdUCOdsGPt74N
         9U3Jl3AyyQs9fjGOihNo3f4VM8G2d5UHkLHpIadyWogvVYpd35U/gcy8sP+uSR2tnw
         5EDsXAV4qvZFg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/3] selftests/tracing: Fix some testcases for recent change
Date:   Sat,  7 Jan 2023 22:31:59 +0900
Message-Id: <167309831957.640391.3123812522556713267.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
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

This includes some patches to fix 2 issues on ftrace selftests.

- eprobe filter and eprobe syntax test case were introduced but it
  doesn't check whether the kernel supports eprobe filter. Thus the
  new test case fails on the kernel which has eprobe but not support
  eprobe filter. To solve this issue, add a filter description to
  README file [1/3] and run the filter syntax error test only if the
  description is found in the README file [2/3].

- Recently objtool adds prefix symbols for the function padding nops,
  and the probepoint test case fails because this probepoint test case
  tests whether the kprobe event can probe the target function and the
  functions next to the target function. But the prefix symbols can not
  be probed. Thus these prefix symbols must be skipped [3/3].

Thank you,

---

Masami Hiramatsu (Google) (3):
      tracing/eprobe: Fix to add filter on eprobe description in README file
      selftests/ftrace: Fix eprobe syntax test case to check filter support
      selftests/ftrace: Fix probepoint testcase to ignore __pfx_* symbols


 kernel/trace/trace.c                               |    2 +-
 .../test.d/dynevent/eprobes_syntax_errors.tc       |    4 +++-
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
