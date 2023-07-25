Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318FA76245A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGYV0O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjGYVZr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:25:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB6A1FD2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840614b107so26443087b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690320341; x=1690925141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iO/u2ma4F5rc1TFFHk9kuvKaOVRKNU+kB++I9CdxlGI=;
        b=xkKTkt65gZtUNFOilfKIRn9yKyfXwjSLm6qRtv/uZyV7CnWl1JKQ3ByQRR02Ft1aMJ
         vgpwGBYuba/cJSX+kxOgOUbfmB91n0vkIqvhatZhuXb9hH16mIQesZ8wQifx/8z5Sro7
         9Qa9Yv9Q5iv2w03f2E+liANoKkAnG0Vi8RzOcUP5/37qwluMmtsIxXOQnbppprw8Ccq5
         AZOlkAEqlrTClr0NSEIMY33eFJaVAwDrqEIOxS5ek7B/zTVPp44dbV5lawzYGyid459x
         g8wDO1As1SqiIlOCKHuYIy/B/mtAmxYMBh7UShG/0L5JKkdRpibZxFWYsFHEB3jfm/Pr
         RRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320341; x=1690925141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iO/u2ma4F5rc1TFFHk9kuvKaOVRKNU+kB++I9CdxlGI=;
        b=VIYAFD1/3GQtXxhx04lD7IdkG+FgplclFzrTldXqrb7XuTGscopReE9TGxyJ3It6gk
         0d3OYvwVP2FUijMNYr7Q28ybO+c+gG2MgR9bkdk1DT37MsGZJdbfhlseYMOHPxaeTd9j
         BU00ykmhoUnTeVABk1bSL3AX4+dSLnqJC8iEnociKcO/W9nzHPcdlAVeT3FGvEtpmbJE
         yNTFR+CFA3uOy9Rxhp6wkBvj4dlCq03X764/CQ1rPYvMEiRZLnZBJUjat7vnj543ZkjX
         tPmMyz3Afj9W0WyFO9k1MFogEoIpfThRzG6IiF+X4g8bQzwFX4mrfbA/mKL3k2p9+taw
         AZSg==
X-Gm-Message-State: ABy/qLbsR1jDES2rsXXwbiH7FJ2nrlvllq9HDtYwuFxl53cddZ0KwtTC
        g/a4QgTVm9LvYgxaBg9t6PGj6xHiKQ==
X-Google-Smtp-Source: APBJJlF4feLrAMojCZfRgMcZi+J1UYJUvASL9ku7rbSLt7CTEIIOkB7UL3EDEDfBxKBDV1H+5hcAoLMEqQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:b647:0:b0:576:b244:5a4e with SMTP id
 h7-20020a81b647000000b00576b2445a4emr3811ywk.10.1690320340980; Tue, 25 Jul
 2023 14:25:40 -0700 (PDT)
Date:   Tue, 25 Jul 2023 21:25:18 +0000
In-Reply-To: <20230725212522.1622716-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230725212522.1622716-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725212522.1622716-8-rmoar@google.com>
Subject: [PATCH v3 7/9] kunit: time: Mark test as slow using test attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Mark the time KUnit test, time64_to_tm_test_date_range, as slow using test
attributes.

This test ran relatively much slower than most other KUnit tests.

By marking this test as slow, the test can now be filtered using the KUnit
test attribute filtering feature. Example: --filter "speed>slow". This will
run only the tests that have speeds faster than slow. The slow attribute
will also be outputted in KTAP.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v2:
- No changes.
Changes since v1:
- No changes.
Changes since RFC v2:
- No changes.
Changes since RFC v1:
- No changes.

 kernel/time/time_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 831e8e779ace..ca058c8af6ba 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -86,7 +86,7 @@ static void time64_to_tm_test_date_range(struct kunit *test)
 }
 
 static struct kunit_case time_test_cases[] = {
-	KUNIT_CASE(time64_to_tm_test_date_range),
+	KUNIT_CASE_SLOW(time64_to_tm_test_date_range),
 	{}
 };
 
-- 
2.41.0.487.g6d72f3e995-goog

