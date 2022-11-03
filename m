Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250C761868F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 18:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiKCRsp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 13:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKCRsU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 13:48:20 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCAC1CB2D
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 10:47:51 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id c207-20020a624ed8000000b0056e3714b62cso1068219pfb.23
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8f8dJb7CmxUii0k7ReZbO/xecf8YvrxT0ueHHyma1BU=;
        b=D28rs6T8OGKqTwv+0w2tiy+Wo2uFgszomXWqOdz4bK8oHd/bxnx+ygDF11Merktoeh
         W0x/tTWAy+1K4R3PBvAmW6StBWEh4cu44wlQ5LyUHpThEqN8JyKhrY2ReJcTBvWxXctN
         c7p7B7aknkrGsUM+sQ8VoC51Ja99SE9d0zKTb0LZRMMyqsZV+Hcc3tWGzdC8Cx4BaYXj
         Q9CwKe+1CpuIX73dKrvuIkNUu0j8EPQ5Pg5VIsESR4Ixa3K6vFdcHCYbaKvgxXFV59jb
         j2jy2YJh6CyY4ElDHkYBrbjJLVuqzKlskpFuivE9C34VpXsmDwdCPXTY88fXmz/gLC1t
         qn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8f8dJb7CmxUii0k7ReZbO/xecf8YvrxT0ueHHyma1BU=;
        b=XZmUIX/QoeN6ulrmH6Qw+QJTSVn6t75x3ZsK0aBtbwF2e91s61QifqVTmmyl8Qkhpp
         eulb0f0GzTGseMRSQC5qILdVuX4gqv/O975z0h50jleTI7yfhIuIty0NGBMigaAWqAG1
         xEEhOXABYfIQuUfLLLxtOAqrk5zXOM/+FMeaiyYX6Ca0JNHZv6vVAiw8Fjkbp/nEH0+0
         XA33QYRuJssvWUtNG4iJiOlildsxuMWJlT77rjErkw2YgAdpFx3qlzv8/WayNvLCnrGL
         XNo+GVEqtgkPJ0XAuD/MrO4IDUWefGBRrmhD07Gi4MQQb8JPK4kh+xw7Mk43AkMBJvvd
         PR2Q==
X-Gm-Message-State: ACrzQf2Tss6vY2WoPpzHeHU3aeZSqjoWnAdbRRHnzLaS5VyJhSMyvNMa
        6tSILhJpTQHUIL0PsPA3QLVUR/O9flm3BA==
X-Google-Smtp-Source: AMsMyM4Ls8UcrKSslT8x5WlYpTRZIayBCz8AJvQ97WsPxMXWt4gyd0VthhQSDtdpv7NGJeGnmrzlzFFtJYNjTA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:4c8a:b0:214:2ed8:6501 with SMTP
 id my10-20020a17090b4c8a00b002142ed86501mr9877245pjb.70.1667497671335; Thu,
 03 Nov 2022 10:47:51 -0700 (PDT)
Date:   Thu,  3 Nov 2022 10:47:40 -0700
In-Reply-To: <20221103174740.3492603-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221103174740.3492603-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221103174740.3492603-3-dlatypov@google.com>
Subject: [PATCH v2 3/3] kunit: tool: remove redundant file.close() call in
 unit test
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
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: just rebased onto linux-kselftest/kunit
---
 tools/testing/kunit/kunit_tool_test.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 5e3429a1202b..90c65b072be9 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -242,8 +242,6 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(
 			"example",
 			result.subtests[1].name)
-		file.close()
-
 
 	def test_ignores_prefix_printk_time(self):
 		prefix_log = test_data_path('test_config_printk_time.log')
-- 
2.38.1.431.g37b22c650d-goog

