Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6272377C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 08:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjFFGVD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 02:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFFGUv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 02:20:51 -0400
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464CCE5C;
        Mon,  5 Jun 2023 23:20:34 -0700 (PDT)
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-33b1da9a8acso27489975ab.3;
        Mon, 05 Jun 2023 23:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032433; x=1688624433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Qt0TZdpZFts0TaM3xOskSanCMvu3uxtIMS0vk4fZs4=;
        b=Vqkqx+sPUmhcCTxuMJTEKjgVZ63gd95xTE70vE4vGJyLJjl6u2u6+1IoNEuw0YyQlb
         CjBW78mZ4YADhLChdeS87s4wNWvJgye1j4uIOFUO+lH4es0EIIN0Bw5IiYPxGbYPnLx5
         5i6+v1ru81ljppViNzJ9YRizaX/wxRwcA+pM1Qnit1KR7soQ06vRPoA28MfkpoBCJ+ki
         y7LexDrEQexaHsAAgtuu39GAfAF6z1BanuAejKOZKfHhfpooDTJVIQXLgFai2NZlQXZc
         BCcoq5d3U2C4BqeiXWLfOM+kqB6NaCwcPrLflr613jTo2uvWh3KPJOkcbd/9Z5Id317W
         b02A==
X-Gm-Message-State: AC+VfDwFoKallIgeG+xNTpAV/eAxwUxyMYM8Gl+1FDe9nzMD23mrrufV
        9xEVLi7PoEVsanmjzcdzog==
X-Google-Smtp-Source: ACHHUZ6xNkFciwwaRIuqEw1lf4XuDHonXqDVaCQK2K5088245x20eei0bMvul3JDj9mzmYCjEfNM2w==
X-Received: by 2002:a92:c505:0:b0:338:f770:ccc3 with SMTP id r5-20020a92c505000000b00338f770ccc3mr1743804ilg.21.1686032433406;
        Mon, 05 Jun 2023 23:20:33 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id w7-20020a634907000000b0052c3f0ae381sm4960841pga.78.2023.06.05.23.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 23:20:32 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v3 0/4] tracing/user_events: Add empty arguments events
Date:   Tue,  6 Jun 2023 14:20:23 +0800
Message-Id: <20230606062027.1008398-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series patches fix the incorrect trace record for empty arguments
events and add correspondent selftests.

V3:
  Improve modification descriptions to maintain consistent formatting

v2:
  Change "i->count" to "i->count !=0 " to prevent compiler optimization
  Add correspondent selftests

sunliming (4):
  tracing/user_events: Fix the incorrect trace record for empty
    arguments events
  selftests/user_events: Add ftrace self-test for empty arguments events
  selftests/user_events: Clear the events after perf self-test
  selftests/user_events: Add perf self-test for empty arguments events

 kernel/trace/trace_events_user.c              |  4 +-
 .../selftests/user_events/ftrace_test.c       | 33 ++++++++
 .../testing/selftests/user_events/perf_test.c | 82 +++++++++++++++++++
 3 files changed, 117 insertions(+), 2 deletions(-)

-- 
2.25.1

