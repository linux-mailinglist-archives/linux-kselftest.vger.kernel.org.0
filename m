Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629E3728E42
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 05:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbjFIDEY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 23:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjFIDEU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 23:04:20 -0400
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9857130E6;
        Thu,  8 Jun 2023 20:04:18 -0700 (PDT)
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-653f9c7b3e4so1022842b3a.2;
        Thu, 08 Jun 2023 20:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686279858; x=1688871858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59GQ9AhyFkzfBGxyjIZEJrXmZrr4sm+i3SWD90zj3wY=;
        b=aYtf820ZP48hIQXbtw13gT8rttPjTyonTrXdmsQYyOESNUFwZf2bcDTTLxRn1Q+3lG
         pIqDx3w6LjJbgDhOGGPW48m5mnlliYC6in20y1sFUR6zSfxYue2ULHmYhQcVN7W/PbHW
         PLQKiifrXvbKfcn4e4/fXZqGleCRQYQyM7NIHqRgFj17ixUZ8QXppQiGpAEkQamyUa8q
         bI7M1qEzfGwl807EJXPZ1WLgQqARQb7FbHQ9j0TxhuZ9/0iOkPpYkSOL91nLaHkwqzRP
         h46DfyaB1z8S0TRbYIYI/K2UJucpypFieu2iRikQMaPCDNGMLtyYtt8LeRmrWjj3IXqx
         VT7A==
X-Gm-Message-State: AC+VfDyZ5NmSJsv6BDPPbXLI+DN3Cpis4Mz6s9hl/MovTIsjc/fcLNWq
        xtPH4BFJdEoRIJ+f24VjJg==
X-Google-Smtp-Source: ACHHUZ5UVxY14D1+wNQgLxZLAZyOjnBVLcigDRa21eDTvN8JUmWnyb16tYxtEjwkjggAVSdspqJGCg==
X-Received: by 2002:a05:6a00:1911:b0:663:8255:8cc3 with SMTP id y17-20020a056a00191100b0066382558cc3mr77833pfi.7.1686279857968;
        Thu, 08 Jun 2023 20:04:17 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id a16-20020a62bd10000000b0065ecdefa57fsm1713778pff.0.2023.06.08.20.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 20:04:17 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v2 0/3] tracing/user_events: Fix incorrect return value for
Date:   Fri,  9 Jun 2023 11:02:59 +0800
Message-Id: <20230609030302.1278716-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now the writing operation return the count of writes whether events are
enabled or disabled. Fix this by just return -ENOENT when events are disabled.

v1 -> v2:
- Change the returh vale from -EFAULT to -ENOENT

sunliming (3):
  tracing/user_events: Fix incorrect return value for writing operation
    when events are disabled
  selftests/user_events: Enable the event before write_fault test in
    ftrace self-test
  selftests/user_events: Add test cases when event is disabled

 kernel/trace/trace_events_user.c                  | 3 ++-
 tools/testing/selftests/user_events/ftrace_test.c | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.25.1

