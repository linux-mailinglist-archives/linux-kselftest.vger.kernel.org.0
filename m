Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1DB7AC91B
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Sep 2023 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjIXNZa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Sep 2023 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjIXNYU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Sep 2023 09:24:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF904EFE;
        Sun, 24 Sep 2023 06:20:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEBAC433C9;
        Sun, 24 Sep 2023 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561628;
        bh=Fly4wWpTO5IDypLkx4t6fiAgcBDlsgiBtf87rD/WXAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/svroqnyCohMFM5MIrDUILAXWXFRY1gkbDcLze2uItwS5roMp6LR/Dl7yeyS/Twd
         zXnxF4+KPJ1TTjVpB8EI2hcU7TKqbnoC/5I0etR/751sascPDiyubveOBSFpQ64XgF
         jL9eCRjFQiFFJoTImgOU1k9vCkhIqMWgJMdfzm/qCGiuzTLohlA29qjw0LbMHS0pMk
         YSl+SqV7CrwwIkLtb/iuDHrlxtWgccpI6JGai+HBCD3nNPMXNbiSyMHBysZ9MOWFL2
         ediL/STUZZFz7OzPh7O2W0S5D8CGq1DlOZXIzFkCIqHbqnqEOJM+sk1zdAfcR1FyEH
         kx2Q1Y4uXiaQg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Yejian <zhengyejian1@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/7] selftests/ftrace: Correctly enable event in instance-event.tc
Date:   Sun, 24 Sep 2023 09:20:12 -0400
Message-Id: <20230924132015.1276811-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924132015.1276811-1-sashal@kernel.org>
References: <20230924132015.1276811-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.257
Content-Transfer-Encoding: 8bit
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

