Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7334563F94
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 13:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiGBLHw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 07:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiGBLHw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 07:07:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1017215A1F;
        Sat,  2 Jul 2022 04:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B8FFB8208C;
        Sat,  2 Jul 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04494C341CB;
        Sat,  2 Jul 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656760068;
        bh=CstmAGIFUD9KcmREj8biRqou6vWNIVEs4ask1NN3mQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AF/lHHye+fUHS+ddWCI8YAhQZTrDpvI3Gdasjfnmo40T4NMgB4Z8oNAv0HjkkcD8c
         bNpj1OWZkY/dujiI9bqdmp9d0xcXZtSejqQFCxXFO8YkcgWzmGihZax9WDJl/L8epR
         4TwIi9fjwdtEzya33PCuE8w+3ebcgwMiX42jreZJ1EqR2OWuUlRMN3pHZjIObsRsDe
         BcbpSBhzhoQ75OTOaNuQyu6TVh/uvsFCW6XG7Fg/+YuFvA0YUkwlPo79CXye3YmE3r
         /oPIDwGrXQ1JTg/Xw09CxWC3kj0M+vqEol6VYEwuiHVOJPXLOoaJEZok5S3fp+iAxB
         6davtisyi7L5g==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7ayX-007gsC-Oj;
        Sat, 02 Jul 2022 12:07:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 08/12] kunit: test.h: fix a kernel-doc markup
Date:   Sat,  2 Jul 2022 12:07:40 +0100
Message-Id: <32a67e9ee77cc6c435d08a2cb5ef12559b417fee.1656759989.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656759988.git.mchehab@kernel.org>
References: <cover.1656759988.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix this kernel-doc warning:

	Documentation/dev-tools/kunit/api/test:9: ./include/kunit/test.h:323: WARNING: Inline interpreted text or phrase reference start-string without end-string.

Functions should use func_name() on kernel-doc markups, as
documented at:
	Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/

 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8ffcd7de9607..f1c1a95df9b8 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -320,7 +320,7 @@ static inline int kunit_run_all_tests(void)
  *
  * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * This functions identically as &kunit_test_suites() except that it suppresses
+ * This functions identically as kunit_test_suites() except that it suppresses
  * modpost warnings for referencing functions marked __init or data marked
  * __initdata; this is OK because currently KUnit only runs tests upon boot
  * during the init phase or upon loading a module during the init phase.
-- 
2.36.1

