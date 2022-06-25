Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BFC55A76C
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 08:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiFYF4l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 01:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFYF4l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 01:56:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9FA3CFE8;
        Fri, 24 Jun 2022 22:56:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r66so4269117pgr.2;
        Fri, 24 Jun 2022 22:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vI5/9tMSai6sEiMDgKYG4Cvt0bVWGX78NMg6buGrxMs=;
        b=Cys8IzXQH2MsSDgOyFJyh/9lRs7A21k6srYNuYr+moHfExJYKc4YcjSS/HGLsodV/X
         S1FA/sgVFnsOOsM0u0eI3sjcC6S8oEc+kmNqh7d5IAp4k5IrsZA1kYWt51VD9dP/vDsK
         gqk6YJI06Nm9hW8YH7Sf9aQUzZ7VwtH5RJ4RMentQgNzpLnEjUkvdJg8IOzVO1DtocvG
         AHgK2mTkIhtLlcZKBAa/58Yz1B7ULNX64b8279Kz08273WgKauMGIMXwWBkyHaZALXtM
         oCUbOHIDA8UPQniqAdH6zBRf5aXRLg23/PJyL5+dQJ5X3foUJ6/ja7AigwNVJP3YqiAU
         0m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vI5/9tMSai6sEiMDgKYG4Cvt0bVWGX78NMg6buGrxMs=;
        b=TanUy0+rY3mLW2aNlDZLF096j6YS6M3mEeWJp1Y5gRTVMff8mtWljmZ/Zxw6COvTlr
         /1FoTHDRgZ+nbgIokBFK3Tum9kGdZjGo2kzJh71YnTJI4wQrqjI4SzXieZTSlRqd/bo5
         w38DqLSQ3c6FYpiefdd/UgwY0Y9j3SEnA32PhctYyI961TAu8sJ5uT+pb8GT0u5wEE3j
         +K7s3ZCregrSOTEmXACU6QTYBpxKKT6l5ElMUWgyEl5A/7+jnm2Fl/CWQQN//NF28rBk
         TpS18fHpWxzYh1ESyQWRGvEkgJlGvB6t/tTsmfa6m6iGf7J/r9uykQSDEdIa6bcVo+wp
         kZJA==
X-Gm-Message-State: AJIora+f/PD6IuU8hdIP51obY3DSJ3XQzV3HgksXnAVMJa4kzOoM0E2c
        Boldw4JCZqZ5yLJC6Y/9aS4=
X-Google-Smtp-Source: AGRyM1tKbanRfe8gCWw87yykbSIujh994LuikAhfSQmYN3gdd9dkDRc5leilpUgWiJlPqP+hGlrqlQ==
X-Received: by 2002:a63:a70d:0:b0:40c:a1e3:23c2 with SMTP id d13-20020a63a70d000000b0040ca1e323c2mr2301813pgf.84.1656136599769;
        Fri, 24 Jun 2022 22:56:39 -0700 (PDT)
Received: from fedora.. ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79574000000b0050dc7628183sm2819997pfq.93.2022.06.24.22.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 22:56:39 -0700 (PDT)
From:   Gautam <gautammenghani201@gmail.com>
To:     sj@kernel.org, shuah@kernel.org
Cc:     Gautam <gautammenghani201@gmail.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kselftests/damon: add support for cases where debugfs cannot be read
Date:   Sat, 25 Jun 2022 11:26:08 +0530
Message-Id: <20220625055608.12812-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624202921.80867-1-sj@kernel.org>
References: <20220624202921.80867-1-sj@kernel.org>
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

The kernel is in lockdown mode when secureboot is enabled and hence
debugfs cannot be used. Add support for this and other general cases 
where debugfs cannot be read and communicate the same to the user before
running tests.

Signed-off-by: Gautam <gautammenghani201@gmail.com>
---
Changes in v2:
1. Modify the error message to account for general cases.
2. Change the return code so that the test is skipped.

 tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/damon/_chk_dependency.sh

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
old mode 100644
new mode 100755
index 0189db81550b..aae7ff8c2080
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -26,3 +26,13 @@ do
 		exit 1
 	fi
 done
+
+secureboot_error="Operation not permitted"
+for f in attrs target_ids monitor_on
+do
+	status=$( cat "$DBGFS/$f" 2>&1 )
+	if [ "${status#*$secureboot_error}" != "$status" ]; then
+		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
+		exit $ksft_skip
+	fi
+done
-- 
2.36.1

