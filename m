Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9D5269DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383543AbiEMTHm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 15:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355664AbiEMTHm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 15:07:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE799808A;
        Fri, 13 May 2022 12:07:39 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q76so8303394pgq.10;
        Fri, 13 May 2022 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=No82ZcPd8bPIRjiv0fKVf5bXwhD1DhzT0wx4PcYwh8Y=;
        b=bcud6UIoINbuQL/wumd22CQTOHS5IUxskSYa8n4SJ9Wjq5D4F5vC705PAvjtVWPgPe
         L5CFlCv4LsnTwfODoTOrWS9nbRwbTAEraEw3D6MRc47+IALO5qCikBJrrkKPAz93KIzp
         jn33R9nlyCH0lsnmXgQ+gdm5KOrVkWhuryO0iOsQ/oR43LvJdG1MfZDal3LSWpznhK7w
         PZUUSo45BQOJOEZp3wtSZjMyknbntb0pUmqcMgh1xdCOmviMqOLKGU2fF5fvMae0oFJB
         rtrW/PIXg4+Uo/0SkyqwMzkWh1CxvKW94480jq/tEfXNKwFMeMMH4moMNf2Fz3ALNsst
         C4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=No82ZcPd8bPIRjiv0fKVf5bXwhD1DhzT0wx4PcYwh8Y=;
        b=zGJ4gTwVh57MACvvX4GIaXINgwLn9jiJzhmZQe0knkZsKJ+f0dc6ivx0pAs+HZJUOT
         QvzEfScJc0x2GJN6glkiD6SpJn1sJzfPJCDRQkF5l5/uKzCdBgFuDgt2WvpS/L6vZ8MR
         zwrn7oYLCnh4WIVslu+gKnuohPqvfNmOB6q9loC0QD2ah04CAmkoLc+Vrk1meZVKq9J0
         5bpNlS7yrUiYTLrffQWNqACcGLiihv2+tTM3CrZiNqscEfxdulUS1hxEYuXw6nOlHsU8
         EM9ucpRb9Fqn7j2ASv1vb1e/MdcO9sRi8vD6BYueEfNonR3ZQdoAQLH0qL9S5aSZzxKk
         gGFg==
X-Gm-Message-State: AOAM5305g04RzemE6vJPD5Ka9vTBKUjvLTPrthDrD8Iu789g765wgaf4
        qWdkhr00S+96+oPUtFbqrRHV84y9jIJzbOCP
X-Google-Smtp-Source: ABdhPJxb61NHQsaqFg7QwFsrgYz1Ul1N5nwtb7vryMxqbNAbp94hBxMqb39PQtFBJrLC+fFHxHs6NQ==
X-Received: by 2002:a63:814a:0:b0:3db:3cba:323b with SMTP id t71-20020a63814a000000b003db3cba323bmr5117163pgd.142.1652468859273;
        Fri, 13 May 2022 12:07:39 -0700 (PDT)
Received: from localhost.localdomain ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902a38c00b0015e8d4eb1d2sm2213649pla.28.2022.05.13.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 12:07:38 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kselftests/ir : Improve readability of modprobe error message
Date:   Sat, 14 May 2022 00:37:20 +0530
Message-Id: <20220513190721.16482-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Improve the readability of error message which says module not found. 
The new behaviour is consistent with the modprobe command.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 tools/testing/selftests/ir/ir_loopback.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ir/ir_loopback.sh b/tools/testing/selftests/ir/ir_loopback.sh
index b90dc9939f45..aff9299c9416 100755
--- a/tools/testing/selftests/ir/ir_loopback.sh
+++ b/tools/testing/selftests/ir/ir_loopback.sh
@@ -10,7 +10,7 @@ if [ $UID != 0 ]; then
 fi
 
 if ! /sbin/modprobe -q -n rc-loopback; then
-        echo "ir_loopback: module rc-loopback is not found [SKIP]"
+        echo "ir_loopback: module rc-loopback is not found in /lib/modules/`uname -r` [SKIP]"
         exit $ksft_skip
 fi
 
-- 
2.25.1

