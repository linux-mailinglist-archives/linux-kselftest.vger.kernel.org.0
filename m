Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4572377E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 08:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjFFGVO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 02:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjFFGVB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 02:21:01 -0400
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED55C10D3;
        Mon,  5 Jun 2023 23:20:45 -0700 (PDT)
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-75d13719304so491449885a.3;
        Mon, 05 Jun 2023 23:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032445; x=1688624445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21KuDm7E1j2X3eQMy2+wyemXDR46+T1mk758fuRtSIk=;
        b=eEiDpA+aM5BgbrQyI0563Fqpmkrstb19/uSdDQEMcTq9Q4gkspABlAbRvziBypRR2Z
         8oYj74dPPHUIfSQtaP0iebxD+c67OZtVgQfhQfy2NpQ5hx15ZG8xQR1KuDx5vqNielHy
         QZ1Raa42lT16hlDfTE48yNzg8YOlhsUFqss3kLdy9tnUrTeSxKclrdca1zM6weIXqJQp
         ULdm2aNpqhH1WQAMbfNF8LcKObh8BGJ2A9h7XYIRjplZZyLMD2x9HQK5dflBt8JGJvXN
         MGAKZXv7A53IL/i/zvsMLyz+XsQzIs9OAE780gi2T6MSqxQMq0e+OBDGfy4OaoOwF4Ht
         dq3Q==
X-Gm-Message-State: AC+VfDzNsRtHD2DYQR/MyWe70wHTjBZJpymP92V6OmJNZX3ZO0nBBUMX
        DvV07zqZ5HHBBeEp5nr75b3sONeDNXett8Mqsw==
X-Google-Smtp-Source: ACHHUZ7sV7mYt96+zd7ZHFso7k5JxEMoWC4puU+K6E95zXwv4zI5VpW9i41m8Pvto3ceWZEfuv4ZKw==
X-Received: by 2002:a05:620a:6502:b0:75b:23a1:411 with SMTP id qb2-20020a05620a650200b0075b23a10411mr990861qkn.39.1686032444981;
        Mon, 05 Jun 2023 23:20:44 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id w7-20020a634907000000b0052c3f0ae381sm4960841pga.78.2023.06.05.23.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 23:20:44 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v3 1/4] tracing/user_events: Fix the incorrect trace record for empty arguments events
Date:   Tue,  6 Jun 2023 14:20:24 +0800
Message-Id: <20230606062027.1008398-2-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606062027.1008398-1-sunliming@kylinos.cn>
References: <20230606062027.1008398-1-sunliming@kylinos.cn>
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

The user_events support events that has empty arguments. But the trace event
is discarded and not really committed when the arguments is empty. Fix this
by not attempting to copy in zero-length data.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 0d91dac206ff..698703a3d234 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1399,7 +1399,7 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
 	if (unlikely(!entry))
 		return;
 
-	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
+	if (unlikely(i->count != 0 && !copy_nofault(entry + 1, i->count, i)))
 		goto discard;
 
 	if (!list_empty(&user->validators) &&
@@ -1440,7 +1440,7 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
 
 		perf_fetch_caller_regs(regs);
 
-		if (unlikely(!copy_nofault(perf_entry + 1, i->count, i)))
+		if (unlikely(i->count != 0 && !copy_nofault(perf_entry + 1, i->count, i)))
 			goto discard;
 
 		if (!list_empty(&user->validators) &&
-- 
2.25.1

