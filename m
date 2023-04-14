Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27436E1DDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDNIPL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 04:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNIPK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 04:15:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25532738;
        Fri, 14 Apr 2023 01:15:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so7771463wmb.3;
        Fri, 14 Apr 2023 01:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681460107; x=1684052107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+Mc35jdz5ILBLcNMehInkGDuRlm3RaMqvJWFISS8Gs=;
        b=fJ6ou34jHaiMWNLtuawX7mHBaqkK6TXuLS+mClgQDS/pCt6KBhXf50G1/KigCySkKo
         sf9RjSIdLKZDzrtaMUYG8QUUtsz7nSeHHvA0F+J2yiZWQ+E77OsbxUc/RR4ab+2Mb2A5
         QZrf9MncKZDfePc6Pg5SU3zri17h8UxPzct9b4AJ/E4GOaisshApKiqVStv9y+Y5C69e
         0bDHoyJMCFPBUis4g0zs7y8xN3g6CYIVkqJmXyohO8uoaa430a3NxlDiZ1W/cGCjlPeM
         wodSxpSb3knU5WHQsbxVwDQweKfVFUe1SFMAkwlO6Jf3ESWfZHHg/H7ZE/qi8CdyFToA
         Wyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460107; x=1684052107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+Mc35jdz5ILBLcNMehInkGDuRlm3RaMqvJWFISS8Gs=;
        b=S/caZTcN7DfV41BP34DKQkzl0xzU41RBD8yTPIHJirIw7tmbM2zu8hcCNQA8IiBVjH
         HGzpeWvTgijwQTHOt0dB/VSH+4Nz0wfEoS1nYoh+jGgz02tKhh2RYD+T6BvNscskJ7At
         eD57d03Dz9ehrG5ZI7O9gT+IKbje2d5sj1Zu+OcnTOrnwGIk5Uz2DImUwXywGj2jQpiv
         RgwzCsFv2UWB4MqPTu2+W2BZG5CZsVuh81CdX6f/NNgT7kiQHgBrt4pE20kDBZPhlJ7p
         93ShxRyjaEXBV6h2ULhVQlUwFPxsls3PLlsY8+6psZcb2qzxaN3Btz9F4DmMzmWzGjGR
         jnvQ==
X-Gm-Message-State: AAQBX9dzWKqq8pWvK3HEPWWXk3m1UD/Dtmnn9HvfNPA42HhFPKmTtXmN
        4tedUB1jlyGE2KegsxQd0K0=
X-Google-Smtp-Source: AKy350bOMdDp96BK15a3UYiXi665269oi3btXKvL7ZjK1c9ND3w1cT12/3oW2EflVwF3Ue0hqJ+6Jg==
X-Received: by 2002:a1c:4b0b:0:b0:3ef:4138:9eef with SMTP id y11-20020a1c4b0b000000b003ef41389eefmr3813109wma.36.1681460107213;
        Fri, 14 Apr 2023 01:15:07 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y1-20020a1c4b01000000b003ef5f77901dsm3678924wma.45.2023.04.14.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 01:15:06 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/mm: Fix spelling mistake "priviledge" -> "privilege"
Date:   Fri, 14 Apr 2023 09:15:06 +0100
Message-Id: <20230414081506.1678998-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in an error message string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/mm/uffd-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 61c6250adf93..54dfd92d86cf 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -311,7 +311,7 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	ret = userfaultfd_open(&features);
 	if (ret) {
 		if (errmsg)
-			*errmsg = "possible lack of priviledge";
+			*errmsg = "possible lack of privilege";
 		return ret;
 	}
 
-- 
2.30.2

