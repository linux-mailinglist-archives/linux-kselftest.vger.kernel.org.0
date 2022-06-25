Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97D555A815
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 10:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiFYIfd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 04:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFYIfc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 04:35:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61621823;
        Sat, 25 Jun 2022 01:35:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d14so4783431pjs.3;
        Sat, 25 Jun 2022 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfI+U63NZLKVZ09V6Z9oBSRXc7vElcpXav+bJvvH+hE=;
        b=NK1Y3X8cC4gG+cYt/V1M/IQ1qELujDa/yKcLRCQm1XvRN/dDddHXQnB9Q38Z6eagL7
         jsEqP/2Yl/2b0u3vGXxRPbKF2XcgQj2bBjd+q13wc2YsFG69UPlcqJv6KyMNz79X0tS3
         pcIutKsNc/MjEgLHMS1kku48nABf9N9woifiuVGJAm83gO2LZg8HVIC0LviDUby/onai
         LqCOsdxDbkpAdWJVaH+ej+lO4OLHJCI75qoagYOoZ2AzzfCJoowoCZSGoPTb0uUCNpwn
         quH9XA0vtcpXV/tdfzmKuaaa7lMQBdMfXKlfvqsu4MipPIik4qDHb43cxyyt4p2tgHv8
         mygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfI+U63NZLKVZ09V6Z9oBSRXc7vElcpXav+bJvvH+hE=;
        b=mQfu38E9EWKBnOtfhObh9q7XARINhX06Bf/wY+DSE5lwn487dYbdbned4N/wrLj0JN
         CzPsjsqsh1YGAX/t3kDDqa6Wt954wO3W6Gs3/3ffzj7FqxlZWeXEEMe8hy9gJSqAbN1j
         4KKyc+VwDZtNnuZ8VPNJSivgozvXWGfBd7MddB6n9xdZm6k13kBHbY2Qs1h/4pENp7L7
         aZ81tU/TpQURTB3qhEZ8iHZCgpCpUc6EARnme7gHGDRFuA8wIS5WM/NYwxj0o10xMdwB
         C35RrNig9WttmU0sB7OS/dhVve+aNtSO3UK4FH+gPl3AZ6MAzlKY8J3ZI4N61BCzL0Fa
         8CLg==
X-Gm-Message-State: AJIora9CskT33QUtK8+9LuNTR61VGSvdbmj9oTqtl5VQbM0USTwKwPc/
        41MFX0wg+RQsXWFCRpm7FvafWM5VHXkD/Fia
X-Google-Smtp-Source: AGRyM1s6dsMdYLtWyDA+S3DshJ8D6SZ4TR0+mhVzPUOJgCXEItyndBuPt55lKfMWW+v5UhGxAyTlbQ==
X-Received: by 2002:a17:902:f685:b0:16a:3c40:e3b5 with SMTP id l5-20020a170902f68500b0016a3c40e3b5mr3343349plg.106.1656146131072;
        Sat, 25 Jun 2022 01:35:31 -0700 (PDT)
Received: from fedora.. ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709027c0a00b0016a6caacaefsm2628345pll.103.2022.06.25.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 01:35:30 -0700 (PDT)
From:   Gautam <gautammenghani201@gmail.com>
To:     sj@kernel.org, shuah@kernel.org
Cc:     Gautam <gautammenghani201@gmail.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] kselftests/damon: add support for cases where debugfs cannot be read
Date:   Sat, 25 Jun 2022 14:05:13 +0530
Message-Id: <20220625083513.19761-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625055608.12812-1-gautammenghani201@gmail.com>
References: <20220625055608.12812-1-gautammenghani201@gmail.com>
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

Changes in v3:
1. Change the name of variable holding the error message.

 tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/damon/_chk_dependency.sh

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
old mode 100644
new mode 100755
index 0189db81550b..0328ac0b5a5e
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -26,3 +26,13 @@ do
 		exit 1
 	fi
 done
+
+permission_error="Operation not permitted"
+for f in attrs target_ids monitor_on
+do
+	status=$( cat "$DBGFS/$f" 2>&1 )
+	if [ "${status#*$permission_error}" != "$status" ]; then
+		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
+		exit $ksft_skip
+	fi
+done
-- 
2.36.1

