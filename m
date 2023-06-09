Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F23E728E46
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 05:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbjFIDEp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 23:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbjFIDEk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 23:04:40 -0400
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042AA3585;
        Thu,  8 Jun 2023 20:04:29 -0700 (PDT)
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-652a6bf4e6aso1078029b3a.2;
        Thu, 08 Jun 2023 20:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686279868; x=1688871868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwLBYM4w/H7KoFqtcB4hQtAsyswAe46iM2ztf4QLeWA=;
        b=lROOdt4xdms5cZbvzHzFnZkxK6pVtpJOXC4vWbX4c7myvkCGJlA+QPFHi59nkES2X2
         Wuej1GPd9SAJv0szFXo2I11+BhdzoON5OciEEvv09hECo67sslsHkZOP47BnL0++JXCp
         HEYIUR/hzUYwsXBYLprdQkScF1+EUn2cNLR6Z0I1yJkK1h5tpXrToxt5tWDkmGfHWyfZ
         qsqiLK5aCbSJiqV/f4EqwVF5fNv5gtMLzbcYYoFrZdgXHy77+b5fd9FuGmOYLZlXuuc/
         IZjpIQub6S790/FH+s9JqGVS/q2gpJ8CHBZ7ugq6KhYyjH4nmoip0Dc44+Wvj6Dl+Sqe
         f3SQ==
X-Gm-Message-State: AC+VfDxylAOKg8KNhQj2Xemlhpip4kmZlCzIATCCWHSQTP/GnfUAAOBj
        GURT6BGgqjhlvF0lcIG8hQ==
X-Google-Smtp-Source: ACHHUZ58KmGXkdf1adlVag7X48yeMliPeQiXzcRHoS75t00s7Sq/540FCowE+rKzWZ7O/UJciP7DMg==
X-Received: by 2002:a05:6a00:1254:b0:663:83ad:4809 with SMTP id u20-20020a056a00125400b0066383ad4809mr24615pfi.27.1686279868257;
        Thu, 08 Jun 2023 20:04:28 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id a16-20020a62bd10000000b0065ecdefa57fsm1713778pff.0.2023.06.08.20.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 20:04:27 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v2 2/3] selftests/user_events: Enable the event before write_fault test in ftrace self-test
Date:   Fri,  9 Jun 2023 11:03:01 +0800
Message-Id: <20230609030302.1278716-3-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609030302.1278716-1-sunliming@kylinos.cn>
References: <20230609030302.1278716-1-sunliming@kylinos.cn>
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

The user_event has not be enabled in write_fault test in ftrace
self-test, Just enable it.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 tools/testing/selftests/user_events/ftrace_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index abfb49558a26..d33bd31425db 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -373,6 +373,10 @@ TEST_F(user, write_fault) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Enable event */
+	self->enable_fd = open(enable_file, O_RDWR);
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+
 	/* Write should work normally */
 	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
 
-- 
2.25.1

