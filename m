Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB27372740B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 03:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjFHBQV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 21:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjFHBQU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 21:16:20 -0400
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3020426AE;
        Wed,  7 Jun 2023 18:16:19 -0700 (PDT)
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-6b15e510630so9185a34.3;
        Wed, 07 Jun 2023 18:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686186978; x=1688778978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwLBYM4w/H7KoFqtcB4hQtAsyswAe46iM2ztf4QLeWA=;
        b=SVoi7ONSm0KEOIywoGdSt60Fu+adCINiQYTPpjolgTvrBdR5fRuj/rFbDhSQ+tRdb3
         oIjW77aChg+svgMdfVOANg/nLuNNe3QQUeR2R77oDoI8WAernbgIggSVoKpqbDeArxkI
         rIRDSv2qyMCaY6ByYwJPonQL4nu4Yy2VPB07+SyhTbBW5qE/ZktNKVibElP9M++Bd0dr
         +l2mc4trt2tvmhihds9knUoVoF895fP6/sk/tlEkQDaCAwd6Wm4VzsKq736SnbKBv7N3
         fgQumcbGGCZ+6Mt0cHq5cyZmxIXv0c8ertWur0ekeuGch9itlEfR3FEQLrLhgZRje4Qj
         zFew==
X-Gm-Message-State: AC+VfDw0E063ABOrqSXBgGiEoo58ye8cj7XskffQsNqVeMgEwPNfuntU
        BGmbdb8dn5o3wB+k57ZVfCEaG0bBrfMoH1kbIQ==
X-Google-Smtp-Source: ACHHUZ63GHNTFPNP/gU4BnqOw+kQHX/Nrp1lXVFKeRXb/X1XodjnI3tOO9Nezjf3Iym9k6CGxyoinw==
X-Received: by 2002:a05:6830:1451:b0:6b2:ad27:fcae with SMTP id w17-20020a056830145100b006b2ad27fcaemr1731168otp.29.1686186978451;
        Wed, 07 Jun 2023 18:16:18 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a128b00b00250334d97dasm1906691pja.31.2023.06.07.18.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 18:16:18 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH 2/3] selftests/user_events: Enable the event before write_fault test in ftrace self-test
Date:   Thu,  8 Jun 2023 09:15:53 +0800
Message-Id: <20230608011554.1181097-3-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608011554.1181097-1-sunliming@kylinos.cn>
References: <20230608011554.1181097-1-sunliming@kylinos.cn>
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

