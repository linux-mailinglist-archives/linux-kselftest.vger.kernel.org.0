Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2610E4AC8B2
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 19:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiBGSgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 13:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbiBGSdO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 13:33:14 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12778C0401D9
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 10:33:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cn6so9361420edb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 10:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssHaNiY3LReYl3MVuJ+ePd9JHdf9OG1Dd7zZJ3nge2k=;
        b=Y04HjLPsZkYdoFCeBvut+f8CXidNVJOGkPxikLhixK501IvyPyXIzekoWjSlmrF8OX
         u03ERTnhW8DE58bhyNSXTsd2whnjJBZ4aIpR0gDNddM7XqB+9jop/3FmKpHHKtBg7Lc+
         Cf23LyG18ool9UQz6QmgP8iyLNerW26JbfoaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssHaNiY3LReYl3MVuJ+ePd9JHdf9OG1Dd7zZJ3nge2k=;
        b=Y4rAOdiGROBcs7Mpiv+hhUx+8t2CE6oqItXYCeBgO34zVBt8vAUKHSTHk+V/AsGb35
         7V69OWbgmqvJk/4TN3z+CDJY0P6wKEBGvejLqxUTTbP/aQXd5cq2ceazqM44rgau0WGm
         qO/QqVl7+eMBvZGwrhA6AaF1bKFPAb0KeDW+N+laSzBBT+6EH1KhOPcYrnwkpKBOXWk4
         4w2w/8KYvKbkXDdLS6OM+Mf9t7GKjm8Jy8ZQmI2f3a5/Lh8HhMGy9gIeq4YH+81GnuAq
         gvesAiSwmbsIgKtS2/Z7Nvx3ag9yRldj5Jp+M6ejX1pN15PWihof/YYAlfN0ZVAePzgT
         5Vhg==
X-Gm-Message-State: AOAM532U+HAL16NTGl87LjLDlvQDvWdOjOloFyfmDbtSlLKbgj7fU7LA
        3TTfhIXe0e6RWZgAjbFKQdo1Xw==
X-Google-Smtp-Source: ABdhPJwGN4VbnI4x7rDYfog/zY+635S5wcdgEYYlW6+Pp2dJwVNzXbvi5aUiiztSLaMEBlh2B8XjcQ==
X-Received: by 2002:aa7:c043:: with SMTP id k3mr790601edo.184.1644258792671;
        Mon, 07 Feb 2022 10:33:12 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id k15sm3045173eji.64.2022.02.07.10.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 10:33:12 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 3/6] kunit: use NULL macros
Date:   Mon,  7 Feb 2022 19:33:05 +0100
Message-Id: <20220207183308.1829495-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220207183308.1829495-1-ribalda@chromium.org>
References: <20220207183308.1829495-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the NULL checks with the more specific and idiomatic NULL macros.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 lib/kunit/kunit-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 555601d17f79..8e2fe083a549 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -435,7 +435,7 @@ static void kunit_log_test(struct kunit *test)
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
 				     strstr(suite.log, "along with this."));
 #else
-	KUNIT_EXPECT_PTR_EQ(test, test->log, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, test->log);
 #endif
 }
 
-- 
2.35.0.263.gb82422642f-goog

