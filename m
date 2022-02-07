Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B7E4AC8AC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 19:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiBGSgh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 13:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbiBGSdQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 13:33:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E4FC0401DA
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 10:33:15 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p15so44721756ejc.7
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 10:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQV3FF5mFgBVe7Tg/aDZitfy1ByGgWInZOonbxaNvNg=;
        b=l4qyatFZhyECRncPLcXL8VNkiMsmHadTVF8MBX9JntJrammN4JstK81tY9P8n6tvcL
         oGNyxh/lnCKWL1BNREH/G58qnyJ5uCKz+A19Az6Cz0BOiU6rL4qieFp6j0dME2DnFeXI
         fsaJdue9hmuH/oaqIUx4D/z+WsOVdJzhZPq0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQV3FF5mFgBVe7Tg/aDZitfy1ByGgWInZOonbxaNvNg=;
        b=5Q29GIg/dDWqrOof45R9qOylFs8ZWkXvlgP2IRd78s1+TXN57k+Wp8NH14BmvF5j6+
         /5N+hrPO29nG0AwsWdTMAI+9SmXbEVQ0r+mdVxkKgw7oaJ1WXMJzaCGEVqI2t97LxL2F
         Fd2dfmh1hbsFYrxFxyXtj9WJmrkgL0Se+dGhUi4bA04WvTyksocb7+GrEzUfxB9B3Q5j
         LvBcEek70Sh/Pw7lf8h0DKnp0bCjGshz2rBdcCZKDlds73rig2q50Imdd2NpxCoqY+ON
         pCOA7qiq8XxGlofDOsO9A6/z1dRJtRHBWcm/mY71sjx6aANGZIfQS9MvCNfbA5Aekwat
         QUkQ==
X-Gm-Message-State: AOAM530ZCE4mcY7x+q8Iqm+LiHtFmqqoVvRwpD7TgYlNiJLc92MqUQ9S
        ZTmLv6UQLqiskNkMNEu32WgF8A==
X-Google-Smtp-Source: ABdhPJzPyU4JY8Gr4F6U8ZniBFYs/FdtbhAwY6umKjMplE4ASnx4SFwbOXTYMvegEjdUmC5ceiR7dQ==
X-Received: by 2002:a17:906:5a5c:: with SMTP id my28mr775731ejc.54.1644258794460;
        Mon, 07 Feb 2022 10:33:14 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id k15sm3045173eji.64.2022.02.07.10.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 10:33:14 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 6/6] apparmor: test: Use NULL macros
Date:   Mon,  7 Feb 2022 19:33:08 +0100
Message-Id: <20220207183308.1829495-6-ribalda@chromium.org>
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

Replace the PTR_EQ NULL checks with the more idiomatic and specific NULL
macros.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 security/apparmor/policy_unpack_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 533137f45361..5c18d2f19862 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -313,7 +313,7 @@ static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
 	size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
 
 	KUNIT_EXPECT_EQ(test, size, 0);
-	KUNIT_EXPECT_PTR_EQ(test, string, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, string);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
 }
 
@@ -409,7 +409,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
 	size = unpack_u16_chunk(puf->e, &chunk);
 
 	KUNIT_EXPECT_EQ(test, size, (size_t)0);
-	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, chunk);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
 }
 
@@ -431,7 +431,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
 	size = unpack_u16_chunk(puf->e, &chunk);
 
 	KUNIT_EXPECT_EQ(test, size, (size_t)0);
-	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, chunk);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
 }
 
-- 
2.35.0.263.gb82422642f-goog

