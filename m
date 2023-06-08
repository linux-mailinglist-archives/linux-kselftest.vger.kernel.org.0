Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1AF727407
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 03:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjFHBQK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 21:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjFHBQK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 21:16:10 -0400
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDB2269F;
        Wed,  7 Jun 2023 18:16:08 -0700 (PDT)
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-19f675022d8so70619fac.0;
        Wed, 07 Jun 2023 18:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686186968; x=1688778968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueYNpwpPQw4FdttuUeyvSQxlAk/WNLmJ1r90VUlwt2o=;
        b=N1g0H3NqtWF1GWQ7VhG/qgs2XfUiHlEzd8w37/ftHoU6oWJL8yk606QhWwELkYKPq7
         4J7kwsOSBmtn0E3FG4Bu06Lk6z5WXhRA5eF2gffcV8ymY0AlDSPnnUjG4OXnT2p4A3ax
         UPyIIu4sH3+HICtFYeADSpREirehim/V5GGMhTn1Po7ewrQ/KoV2FqHscmmJqQwEs8IG
         /U7g+XjJVnq3g2glbbO/o99X1HUujruXvqTFTPOxJZNl+s9Og5r0eatltsAPLljLO0Ym
         ce/jmJub1mMYMPGiibxUf4+LOMBsRyu2a4rUOKonVtJRGhyr4JQDi5n4W4FD7Fc8U/p7
         xx7Q==
X-Gm-Message-State: AC+VfDxBZkBUPWresA+TAco5Hz0UDs0mcWc6gCQqWhqFqlDnOqVxj/Mg
        mordz47uHjfsBzS9WRqX5g==
X-Google-Smtp-Source: ACHHUZ5yAlJTEqzE7X+xjo9wvbXWM8Gk3iZbjXjA4RVOAqphuLGPY6TerfW3Gfx6Y6pBJGYcKEe5Cw==
X-Received: by 2002:a05:6870:8581:b0:19e:efe5:dfc8 with SMTP id f1-20020a056870858100b0019eefe5dfc8mr4108299oal.44.1686186967877;
        Wed, 07 Jun 2023 18:16:07 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a128b00b00250334d97dasm1906691pja.31.2023.06.07.18.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 18:16:07 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH 0/3] tracing/user_events: Fix incorrect return value for
Date:   Thu,  8 Jun 2023 09:15:51 +0800
Message-Id: <20230608011554.1181097-1-sunliming@kylinos.cn>
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

Now the  writing operation return the count of writes whether events are
enabled or disabled. Fix this by just return -EFAULT when events are disabled.

sunliming (3):
  tracing/user_events: Fix incorrect return value for writing operation
    when events are disabled
  selftests/user_events: Enable the event before write_fault test in
    ftrace self-test
  selftests/user_events: Add test cases when event is disabled

 kernel/trace/trace_events_user.c                  | 3 ++-
 tools/testing/selftests/user_events/ftrace_test.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.25.1

