Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC71682243
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 03:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjAaCgs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 21:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjAaCgq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 21:36:46 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B431027D68
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 18:36:13 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id e11-20020a17090a77cb00b0022925dd66d3so8819841pjs.4
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 18:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rzt0/3jsMFJUfIhPaBwoOkey3oh79UDiXKh2IWsZmn0=;
        b=K3+uNVeLsYBpdR+StkpRilWPuzp9BhVJMT5HHjDPiG9zQRr6DXc3CuLxN2CN73sFMR
         4hBMbgSFoXabaZ1YKjHzyqBF5LhtffZ4MeT9PDfae0Tf4kgjZ4fj5QO6aOTu5EmjR5b8
         vsE+0MWch+sS5XN1LW+AoBKrrFnvC+TziOlFZBZa5hdHjLlcrNmNRl04rznpa6uYmeYq
         3bFmYqU15coJDy6fwDDGEbyBWiEaaFos3z5Mg027kMAGidIfvPNFWVthu9NGw7TO9T6y
         tKjBTDF05Yxnf/eWFbJkm7yfrl7S7RtG+0b+wqQaM+Fkfr8fZfsbW2FRFWfD7yJhL6Qk
         tKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzt0/3jsMFJUfIhPaBwoOkey3oh79UDiXKh2IWsZmn0=;
        b=2N/5xG3wmRotqRpCLihvT6HlcwIv0BflqOaPl6vREQdeUVUXk4wb8cLOQ4sIGjCP/i
         q8QTHmD9B2Qf6TDnZebOnp6dQfE88e1Ud+XPMtxCKUw+mhx13qTVfYDFAulDxmEODQBC
         j9yHcWCL7/YqRCigr2NuK71027Oa/PdjvjHXE8sSbAcrs1FFQGesQsVn4A0XosP9QCCn
         2mcufS5emyoR8qd88dj7IHjBe/9nP8OumTzsR4ybg2X4P6bX4sapOLCGApzeThptTEx6
         nFifbDbb0S+UO/IaMdJTU9BPU88vio8W84GNzjqBtQJR7Yf6aqovF0zF14Duj/tnZIMz
         KOlA==
X-Gm-Message-State: AFqh2krUTapeu0QHogMOHt3YUrlyJYLVTckQgKaKwbi44zXwqiBJrvWR
        RMlqy/M3/sq0jfkCapfDmW/9yFMhK/ZSQA==
X-Google-Smtp-Source: AMrXdXu9Jp65RUI63xyyhAsw+D0hWv/DjieVAkRwci9M/liREghVAwWDGEbKiqyKZJdLjojUR35XPRu8VTNP2g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a63:2001:0:b0:4be:74f7:d3f7 with SMTP id
 g1-20020a632001000000b004be74f7d3f7mr5746281pgg.124.1675132571123; Mon, 30
 Jan 2023 18:36:11 -0800 (PST)
Date:   Tue, 31 Jan 2023 10:35:03 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131023503.1629871-1-davidgow@google.com>
Subject: [PATCH] kunit: fix kunit_test_init_section_suites(...)
From:   David Gow <davidgow@google.com>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Rae Moar <rmoar@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Brendan Higgins <brendan.higgins@linux.dev>

Looks like kunit_test_init_section_suites(...) was messed up in a merge
conflict. This fixes it.

kunit_test_init_section_suites(...) was not updated to avoid the extra
level of indirection when .kunit_test_suites was flattened. Given no-one
was actively using it, this went unnoticed for a long period of time.

Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
Signed-off-by: Brendan Higgins <brendan.higgins@linux.dev>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 87ea90576b50..716deaeef3dd 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -303,7 +303,6 @@ static inline int kunit_run_all_tests(void)
  */
 #define kunit_test_init_section_suites(__suites...)			\
 	__kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),	\
-			    CONCATENATE(__UNIQUE_ID(suites), _probe),	\
 			    ##__suites)
 
 #define kunit_test_init_section_suite(suite)	\
-- 
2.39.1.456.gfc5497dd1b-goog

