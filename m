Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184E955C4C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbiF1Fqh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jun 2022 01:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbiF1Fqg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jun 2022 01:46:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D927146;
        Mon, 27 Jun 2022 22:46:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r66so11179682pgr.2;
        Mon, 27 Jun 2022 22:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHznjnB3X6pSSzGF29R7wDFX5N5Qt9JR+ltijgYS9ao=;
        b=FRRdoThfrfkXaV9KDBETEgtLkw6haOT82RIqDQ2eRxR2CIUxkq2vuZIw6DAqDA22dX
         05TBLlD8tx7KQKIUgr0ZooSdtoql1qH6mQsDDuTjpfXpE+nvtGNor33yQoHKWKQQ4JBG
         AemDo+eTnDHOLa6/K54Vb7wlBn4eeQ4yEtArCYzW16DYuCb/6r2m/1uxCiwIbaQS4fDT
         xfV8lI3fmJpFf3iBx9Th1lfLKDi1F2EMgDSvF32hrZbeWvI+TDFAltsGlEM//TEkb7+s
         Rz71UD4sp0JR80rzgcnGJ1R4Ch8p4ElL93oftR7uktIpNQlCGN1cn/1BJGl2WLdk+0fJ
         fuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHznjnB3X6pSSzGF29R7wDFX5N5Qt9JR+ltijgYS9ao=;
        b=ZArGBV3GILdaRHf5hSjyQZ2lrgsV+ru6nfAcKnFib898PY62ARWg3xLgAMQdJ+/Kjr
         aEZfF/kXFJZmoE1p0XthR2dq69MqIqLqtQtswnfRuscdfJGzZqFPTudAnkwF9X144NZu
         Tb/RMZVcQvK9hYF59L6cuoRZPobiJUz6VBCuwsyggWd9FUN45sy3dSnumwWWxXmB/1bX
         T44WG5CxbxMFXq7jjudivYZGNWmpUrzEHP8424VvW9pMTrEw3uDpYwDYIITfsUGkZWT8
         h0J7hsOHsKPcBmA8kkv28aOkIvVxaGIbDzmyOaQd2mpR8vUNSQutQOidCGSWlpOAENsy
         uPMQ==
X-Gm-Message-State: AJIora/6srgmQYbkDaHJqpwM6gzcwt8KLQ0OR0jbPB++LhF2KiJPgwDu
        rkI7z/kDPaEIuJuRk8P8XuM=
X-Google-Smtp-Source: AGRyM1sa/E5y4Eo5PRGtC0bm2I9DTSmOmtfPSivl0aZgtiDsPOkc733Ft6YCLXDEmYc+wbDXwGBpMw==
X-Received: by 2002:a63:6e44:0:b0:40c:73a7:b6c9 with SMTP id j65-20020a636e44000000b0040c73a7b6c9mr15831082pgc.285.1656395181226;
        Mon, 27 Jun 2022 22:46:21 -0700 (PDT)
Received: from fedora.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm8656228pff.148.2022.06.27.22.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 22:46:20 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     shuah@kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/drivers/gpu: Add error messages to drm_mm.sh
Date:   Tue, 28 Jun 2022 11:16:03 +0530
Message-Id: <20220628054603.157310-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Add error messages when the module test-drm_mm is not found or could 
not be removed to make tests output more readable.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 tools/testing/selftests/drivers/gpu/drm_mm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/gpu/drm_mm.sh b/tools/testing/selftests/drivers/gpu/drm_mm.sh
index b789dc8257e6..09c76cd7661d 100755
--- a/tools/testing/selftests/drivers/gpu/drm_mm.sh
+++ b/tools/testing/selftests/drivers/gpu/drm_mm.sh
@@ -3,7 +3,7 @@
 # Runs API tests for struct drm_mm (DRM range manager)
 
 if ! /sbin/modprobe -n -q test-drm_mm; then
-       echo "drivers/gpu/drm_mm: [skip]"
+       echo "drivers/gpu/drm_mm: module test-drm_mm is not found in /lib/modules/`uname -r` [skip]"
        exit 77
 fi
 
@@ -11,6 +11,6 @@ if /sbin/modprobe -q test-drm_mm; then
        /sbin/modprobe -q -r test-drm_mm
        echo "drivers/gpu/drm_mm: ok"
 else
-       echo "drivers/gpu/drm_mm: [FAIL]"
+       echo "drivers/gpu/drm_mm: module test-drm_mm could not be removed [FAIL]"
        exit 1
 fi
-- 
2.36.1

