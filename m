Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE5F3B145C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 09:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFWHGy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 03:06:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49225 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFWHGx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 03:06:53 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvww7-0000ep-AI
        for linux-kselftest@vger.kernel.org; Wed, 23 Jun 2021 07:04:35 +0000
Received: by mail-wm1-f71.google.com with SMTP id l9-20020a05600c1d09b02901dc060832e2so222705wms.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 00:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AH2QL7P4i7gFaUF/ZBeQ7+HlAe6BdfHUYWj4tEHBDgw=;
        b=f0vgS2vnORWpMdIWe189JZkHHOY6bk8YIvCX13QLfKXHYlhj8F9eKgtWpVKHzgrIuy
         j+zBjgsZacEJXAo0DSut5mDMLP4i5BvTbScF0OogrmQ/bhabGFGdyiTiP9+Aq5lgF7qt
         SC0PG9w+Q9VsX2QkOrUMx7J8HH+Fcgj2yQ5Mr5YDFEv4GGXeNlSJb6xeSGerC+gOiq3m
         HNvYGX2cew3fvek2cAOaE0dh3gycNyXIVBIQSZUBLtsP0LStODkE5I34TyPG/LxlVHmD
         cT8ircj5rWXWdgQHfGDlg2Bun1wZZ8dDVYopj4kQZYiBaHyiHKFFbP8E24a9RtsxLlgs
         dH5A==
X-Gm-Message-State: AOAM5307YFas8ZgdnLdwH59NxH04CnDo8AtDdu/0Tnij8BOSCzPg7Bqt
        l+wbcyf1jlUF6CFKpO/MpK6yGdMaPxls0aOKrvnfDKsZ2Nh3y9Fc9HRpkcSSfX0/qjMpMMeTpYT
        dUB04e5sQ67ndwkPdyQNrYNarkFit+nbD/+zwVuBUh5wCQA==
X-Received: by 2002:a5d:504e:: with SMTP id h14mr5042408wrt.273.1624431875015;
        Wed, 23 Jun 2021 00:04:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMQOpl/2xpkgmzgfvqKIMaW6DBY/obT/oN1U9kV+oY949g+Ewlk2Di9BxmoeJI0KvBPAIhAw==
X-Received: by 2002:a5d:504e:: with SMTP id h14mr5042389wrt.273.1624431874854;
        Wed, 23 Jun 2021 00:04:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id q19sm4529407wmc.44.2021.06.23.00.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 00:04:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ftrace: fix event-no-pid on 1-core machine
Date:   Wed, 23 Jun 2021 09:04:31 +0200
Message-Id: <20210623070431.16592-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running event-no-pid test on a small machines (e.g. cloud 1-core
instance), other events might not happen:

    + cat trace
    + cnt=0
    + [ 0 -eq 0 ]
    + fail No other events were recorded
    [15] event tracing - restricts events based on pid notrace filtering [FAIL]

Schedule a simple sleep task to be sure that some other process events
get recorder.

Fixes: ebed9628f5c2 ("selftests/ftrace: Add test to test new set_event_notrace_pid file")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../testing/selftests/ftrace/test.d/event/event-no-pid.tc  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
index e6eb78f0b954..9933ed24f901 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
@@ -57,6 +57,10 @@ enable_events() {
     echo 1 > tracing_on
 }
 
+other_task() {
+    sleep .001 || usleep 1 || sleep 1
+}
+
 echo 0 > options/event-fork
 
 do_reset
@@ -94,6 +98,9 @@ child=$!
 echo "child = $child"
 wait $child
 
+# Be sure some other events will happen for small systems (e.g. 1 core)
+other_task
+
 echo 0 > tracing_on
 
 cnt=`count_pid $mypid`
-- 
2.27.0

