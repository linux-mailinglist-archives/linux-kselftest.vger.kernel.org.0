Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59BB616987
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 17:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKBQo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 12:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiKBQom (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 12:44:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A6C10AE
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 09:40:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so16678702ybr.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpyV4sjuN6nTtNbz4mfvOqF+6FZYm3YsT8sqkJTRsbo=;
        b=tYOdkg3vf+59PIaLFlt3AchFCjbgSfE5+sKR/Ibm9yt6tvf4L9pmL54S+KOmiWse82
         LH5y2tsuRIQlIw6+jxyiY+OBIrhZ59fPZKJj9ay1usM6BRCSTyP5B7d0hybfCT3bG7K6
         bVKYaq4DI4E+j1yO6LoRWzS8Ie91OLuCW982zwz/Es9Xl1EedNUp/WcVIGO40vJ/nQIs
         vG9QINdWWcmb7eFn7AQS0fAe0OTQ0OCKgaoQj9O7tEZ4GjxlXFkLmRGvj9MN+JhMwkj2
         4S3KK+LP8iupGAOh/1/c2ii1SS7tBoc2Pt/u4ZQZ0dHrHcfX7i8Lb9NNDlY+L7q2bMea
         gDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpyV4sjuN6nTtNbz4mfvOqF+6FZYm3YsT8sqkJTRsbo=;
        b=CzveOEvBlUDePb7fxgQM8QykCwqZTwk7SaMvS9QGPFEdfh5j27j4Du9UkntyJcGqb4
         u7r5Zh1LzZ96jQMe6r5o6jggc/7jaifM2OqKjNP7iOeFbGREdYq785lwdBfKQLczOEcd
         ChwuPhi9fnWvPNwOdtAsNAFJO+416CFqrR5Y0BvCG/oARTXmw2IRHD6O+3f2BdeJVJ7G
         p/ZnzjjYRAYbHlxlqNUjKXlC9HVU4piB0l/3kz97dW9I5wLyl1tRplIm7UnUSbXDhG/m
         is5+Qli0nEvHWFqb1Bi1lwhmlMfoKX2cvIl2wUFmaiHwkIRp1WxB2k0Xyz7AEh7zLwRP
         ghqQ==
X-Gm-Message-State: ACrzQf2lKnmtlh9+e8hzgq0LodkSdCfWs66pJ8rWW8byQ596dA5WAW+k
        ylCMF68O+KDQqNTcvdZZ6y6v6H8/zNw2Tw==
X-Google-Smtp-Source: AMsMyM6r3wwMHH1GQ3q0cp+5dQlmVo9cwzuc3IxzUtlriNpj4R6ZlD1q/C4MgEsEqTbg+/80TR2+m7HA8Rnxkw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a81:1e10:0:b0:36b:532a:52be with SMTP id
 e16-20020a811e10000000b0036b532a52bemr23987758ywe.54.1667407244828; Wed, 02
 Nov 2022 09:40:44 -0700 (PDT)
Date:   Wed,  2 Nov 2022 09:40:05 -0700
In-Reply-To: <20221102164005.2516646-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221102164005.2516646-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102164005.2516646-3-dlatypov@google.com>
Subject: [PATCH 3/3] kunit: tool: remove redundant file.close() call in unit test
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We're using a `with` block above, so the file object is already closed.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0063773c0fc4..c41567eaf3c3 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -239,8 +239,6 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(
 			"example",
 			result.subtests[1].name)
-		file.close()
-
 
 	def test_ignores_prefix_printk_time(self):
 		prefix_log = test_data_path('test_config_printk_time.log')
-- 
2.38.1.273.g43a17bfeac-goog

