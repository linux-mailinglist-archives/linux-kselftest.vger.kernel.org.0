Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343663B1B69
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 15:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFWNpm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 09:45:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59881 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhFWNpk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 09:45:40 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lw3A1-0007JS-PJ
        for linux-kselftest@vger.kernel.org; Wed, 23 Jun 2021 13:43:21 +0000
Received: by mail-wr1-f71.google.com with SMTP id t10-20020a5d49ca0000b029011a61d5c96bso1088960wrs.11
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 06:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yubxi2qbuY0f26nH+TCC7V2Gu19HEDSoQcEIu557Wn0=;
        b=huE2xvvxixJ1tUAWJZb2gh0oluIYyl2yFeraRFAtNO4ZkL5pITICHmtA7GkZohxCd3
         //pWk6E+JaELV00NqkCYbBQoMl3FVy72nIqoShYaQWF92B0DDJIw9iFOaHkGntNsMX7L
         WsE0KsMrrLFMmrH9Th0jY/6BxnmiWCEe7Bj8S5PfgA3AOWSuZHUMub4lTBB+Q6jlw4w+
         tJXMPBsU6LPEEw7yi8/CaxhLbd5K6qok6bUF5O08puByFbX0U3PmpHSZFme8jFhQkhWY
         JWqtnw7kAxRVMyxx0vG8XvfBmpKhK1kNzXBCv5IqqZixeiRVsHFfZ3fvLZlPfZ3DhuSK
         9zVQ==
X-Gm-Message-State: AOAM533sQ25MaOO70nR8j49z05irjt/XH1hMt9Tolsm273CboYCHpM0X
        3WQteCht2HVslT6dcj2vYKtGG68MzxvjnUzMAGr/7O0zt1QZRq4HG9m3n/JdkZgNrvI1CpK3TkV
        9w9nO+I+rZknVMx0LrW4TSQXE1XOfdNeqLBYbJaWsvy9SoA==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr10758138wmj.72.1624455801592;
        Wed, 23 Jun 2021 06:43:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNOn5MnmPCceGWkw5/wLdC+SG1xM2rIUPM/8N6mKYN/v/4zXCzfb61gwE5zQeig6N4a7DZEA==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr10758116wmj.72.1624455801401;
        Wed, 23 Jun 2021 06:43:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id w13sm94341wrc.31.2021.06.23.06.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 06:43:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/ftrace: fix event-no-pid on 1-core machine
Date:   Wed, 23 Jun 2021 15:43:15 +0200
Message-Id: <20210623134315.77472-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running event-no-pid test on small machines (e.g. cloud 1-core
instance), other events might not happen:

    + cat trace
    + cnt=0
    + [ 0 -eq 0 ]
    + fail No other events were recorded
    [15] event tracing - restricts events based on pid notrace filtering [FAIL]

Schedule a simple sleep task to be sure that some other process events
get recorded.

Fixes: ebed9628f5c2 ("selftests/ftrace: Add test to test new set_event_notrace_pid file")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

---

Changes since v1:
1. Correct spelling in commit msg.
2. Add Steven's ack.
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

