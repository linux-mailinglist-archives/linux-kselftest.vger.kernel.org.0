Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD571451A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 08:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjE2GvV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2GvU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 02:51:20 -0400
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6CC90;
        Sun, 28 May 2023 23:51:19 -0700 (PDT)
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1ae3fe67980so27110855ad.3;
        Sun, 28 May 2023 23:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685343078; x=1687935078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdVusEjK9OZyb/2gLlqZLiiYHDX2czHduX2fEeB+Rfk=;
        b=aQ5cyWPJu//ze3yjXo++2SitqSa25DE/NPJSQ5bF+Ol51Za3ak9pBNl8wiwdkTKUWB
         CzW2BYsmMsJrtwq6eOk4LjmOi51YANWk0dcGJAxCYSBw7rCt0DyZMZaEX41G8O6y/Onj
         d1il2j4F6BGe9XIRXdKxYMBSRrb3sH5uG2D98nlP9d8y7VTOFcTkPbWEels5jndezz07
         QGyL8Mnez8DcnwnhU4bPocDGL8WoDYMJmPoCEb8EzNDoYGWvQUpdEhOR+I5E8eAD4cLZ
         7RO9jlQICAYlv4eBHtC7naXNmYQmyDDBlgaFNaG5qvzkcbkwiETRYfecwPRWVa/JYu03
         uRFw==
X-Gm-Message-State: AC+VfDzkj4E4rAwlbM2zVOvHhxPyXnZFNB3bllqy0oSQi3I10okOxAJ8
        Z0ggX9I2pRLEddjBOmakI43BUKEwgPk9q4Zw1g==
X-Google-Smtp-Source: ACHHUZ7WwTLogkp4rSBSn5Aouq4jEO3wdngUvqibVBDBQ0W4EjlP47RRPzNzrCyJFYSnlDHzB9qh6Q==
X-Received: by 2002:a17:902:cec4:b0:1af:b9ed:1677 with SMTP id d4-20020a170902cec400b001afb9ed1677mr12388799plg.2.1685343078392;
        Sun, 28 May 2023 23:51:18 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090282c700b001ab2a0733aasm7318319plz.39.2023.05.28.23.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:51:17 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, beaub@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sunliming <sunliming@kylinos.cn>
Subject: [PATCH] tracing/user_events: Handle matching arguments that is null from dyn_events
Date:   Mon, 29 May 2023 14:51:10 +0800
Message-Id: <20230529065110.303440-1-sunliming@kylinos.cn>
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

When A registering user event from dyn_events has no argments, it will pass the
matching check, regardless of whether there is a user event with the same name
and arguments. Add the matching check when the arguments of registering user
event is null.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index e90161294698..0d91dac206ff 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1712,6 +1712,8 @@ static bool user_event_match(const char *system, const char *event,
 
 	if (match && argc > 0)
 		match = user_fields_match(user, argc, argv);
+	else if (match && argc == 0)
+		match = list_empty(&user->fields);
 
 	return match;
 }
-- 
2.25.1

