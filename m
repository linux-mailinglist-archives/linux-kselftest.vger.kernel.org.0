Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DF07AC9A2
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Sep 2023 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjIXNga (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Sep 2023 09:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjIXNYR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Sep 2023 09:24:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F4219AF;
        Sun, 24 Sep 2023 06:20:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27003C433B6;
        Sun, 24 Sep 2023 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561646;
        bh=Fly4wWpTO5IDypLkx4t6fiAgcBDlsgiBtf87rD/WXAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJIVFvTzI6IQdDNCPKmdNqrqMDIqBPgNC8VWTWymu+U+pP5JbeljJs/RBymQFGQZq
         MAuyYt/nYPZIIW4mi/EOyACKOUFPvGSIx//35yie84zHdMj90k7bbuGObr/Nj54sO/
         WuY3Q5/hMVzVgqkOMESdK9noilRbJJN1PN80iuPCCUa0/JrVJ+3/O7bvUsddd5ptEa
         bLGkT6ofjCGMdFbTjjvO36A1C8uklAnTCYTZnIaPJS1uftBf2+JEUSHeUb52viTsDr
         xoMMuataI1wif0RgtW2KEKBg/f40J92RXQi4VvybZeYcj4cOkxCjK9h1A1iF9Hywbx
         nmCKuEW0XRKjQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Yejian <zhengyejian1@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/7] selftests/ftrace: Correctly enable event in instance-event.tc
Date:   Sun, 24 Sep 2023 09:20:29 -0400
Message-Id: <20230924132033.1276920-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924132033.1276920-1-sashal@kernel.org>
References: <20230924132033.1276920-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.295
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit f4e4ada586995b17f828c6d147d1800eb1471450 ]

Function instance_set() expects to enable event 'sched_switch', so we
should set 1 to its 'enable' file.

Testcase passed after this patch:
  # ./ftracetest test.d/instances/instance-event.tc
  === Ftrace unit tests ===
  [1] Test creation and deletion of trace instances while setting an event
  [PASS]

  # of passed:  1
  # of failed:  0
  # of unresolved:  0
  # of untested:  0
  # of unsupported:  0
  # of xfailed:  0
  # of undefined(test bug):  0

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/ftrace/test.d/instances/instance-event.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
index 4fa0f79144f4a..9473934a573a1 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -43,7 +43,7 @@ instance_read() {
 
 instance_set() {
         while :; do
-                echo 1 > foo/events/sched/sched_switch
+                echo 1 > foo/events/sched/sched_switch/enable
         done 2> /dev/null
 }
 
-- 
2.40.1

