Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F1D74B88E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 23:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGGVKU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 17:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjGGVKP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 17:10:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4554126AD
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 14:10:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c5a479bc2d4so2377524276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688764206; x=1691356206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvImKJCnpIBlsXhTAJ5caOzinogK+Nn3xCDMVw248HA=;
        b=IjuYQHNxzDetS1bFh3oTNA99NoYKBnvi1iDS+FsNxK7dlEGVkehUUzIrqTKMW8vFWQ
         pAe5SaRChZa/wkNbxuAyr2PQDTwSATtkICGZp0IacWufQ8rDsoNJMypaSVRkS10jDRCh
         Bcv362LHJNfHGk/R/U5sK3pv+XxhDGxRuGMKzHG4AhbwcGZPgLAt/NCXtn14YcrWcA+q
         osYuH6Qt4rUVaKNa2RqqsO6jK+5Gh/dTZL658vNtTLPJRdFMg9IBUZxXSkvIH6OQ5Kdw
         xe8cvPsdKWo78euGlZaFZgcDc5QC9VsZMhYlieP83NH8Pye4/F/nNR5SCAJ5glVwUJ5j
         E06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764206; x=1691356206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvImKJCnpIBlsXhTAJ5caOzinogK+Nn3xCDMVw248HA=;
        b=U7Q/9RwKR24jT3FFusaNK+MM57+YVeLk1jfiFWjFU17RkoW4kftYF8hI9iLBDnWHQP
         A6jFV4128T+Q7UeCBxg7ddlvVMxGsykwHJvbSNws/JFUcIz6JmWiakpWtba8owjkw/yP
         WWhRvhPuTpVNrhTkYW8ORHcXtxI9FMDJ0de3zkuKP1cxGnPQepugk1I6rwkSzmgXZ0z2
         pMw45Gx2ggtNSNj+RCAYWV3dOKtVUWAYu18EvgOv8y88kMX2QvppeMHEc6yiJbMe4SVS
         3wHNVl97PrrssCPuGjkS5Dote8zuiWPXdsOyaQtht0RT34KXJZSha2bnjpc1HOX2Wq47
         zujw==
X-Gm-Message-State: ABy/qLYQrGDG7Grd8TzgR4IlL0zpbdc+bvOVEzlWl1mg4YDB92jHGGrb
        B5+A/FMYDt7bjnX7d47sN3qeTOSmZg==
X-Google-Smtp-Source: APBJJlF6eWs2PeWhgSRDTLOlm+VIZ9ZeO6Lz2EMl8aKQVzPxzF0JX9ZbRsytW7yLxleuHaiKqvySyIUXKw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:905:0:b0:c4c:f97e:421a with SMTP id
 a5-20020a5b0905000000b00c4cf97e421amr59714ybq.4.1688764206117; Fri, 07 Jul
 2023 14:10:06 -0700 (PDT)
Date:   Fri,  7 Jul 2023 21:09:45 +0000
In-Reply-To: <20230707210947.1208717-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707210947.1208717-8-rmoar@google.com>
Subject: [RFC v2 7/9] kunit: time: Mark test as slow using test attributes
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
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
2.41.0.255.g8b1d071c50-goog

