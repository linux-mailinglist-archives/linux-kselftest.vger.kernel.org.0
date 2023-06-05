Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF9721F89
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 09:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjFEHa7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjFEHag (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 03:30:36 -0400
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A967AD;
        Mon,  5 Jun 2023 00:30:35 -0700 (PDT)
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6532671ccc7so3281078b3a.2;
        Mon, 05 Jun 2023 00:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950235; x=1688542235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21KuDm7E1j2X3eQMy2+wyemXDR46+T1mk758fuRtSIk=;
        b=A+Pm9AHqWhyveo120GfD7atXQovD87STrmE+NDVi+DsK5MlM139SVxs53py0xS8OXo
         oNZ1QCe//0aKE+sz3DP+igig8MP2buKRah2lWfIwOS+3Cgc5PkGF0zHY04jZdt7mqCCE
         6Sx8ajnAROBO2M2tKUfPz1KXiJQBPLVCeLlk55P1bmW69TER7C0Hu9uYAJAajum3y+NG
         cMZ1cg9OQM6oMeRcVPtqLA1m/itvmhQCGCrKtzQ1ELZY8OxkOZFp5a65RgrisT8Ibvz5
         0Cf6DovTmOdQ3aXijEhHeH/EvIZpnDY+uFaPiWUM+iTU7C9DS5ypv2F9iykPKYczfPyL
         OKnw==
X-Gm-Message-State: AC+VfDyVlEe4ze0rSP/l9pdNPdxasQ7T3q184ulov/QMjmkAwpsFRvXC
        wSYTu/StxdHEZxh5/8GQuw==
X-Google-Smtp-Source: ACHHUZ7ChMAQp+vzlxKyflCK6VPC2O6GMjChXE7QQC6hkM9zpe9c3D4YQmRAdK98Dmpmd4xpLk9ZBw==
X-Received: by 2002:a05:6a20:8e19:b0:116:e916:4b5b with SMTP id y25-20020a056a208e1900b00116e9164b5bmr1229383pzj.25.1685950234884;
        Mon, 05 Jun 2023 00:30:34 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 128-20020a630786000000b0053ba104c113sm5200419pgh.72.2023.06.05.00.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:30:34 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH V2 1/4] tracing/user_events: Fix the incorrect trace record for empty arguments events
Date:   Mon,  5 Jun 2023 15:30:20 +0800
Message-Id: <20230605073023.923316-1-sunliming@kylinos.cn>
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

