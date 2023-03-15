Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371976BC1A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjCOXmA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjCOXlq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:41:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA221A676E;
        Wed, 15 Mar 2023 16:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D74A5B81E92;
        Wed, 15 Mar 2023 23:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55682C433EF;
        Wed, 15 Mar 2023 23:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923566;
        bh=HF+8Bo+oSK76QvKqEQTGyvfPu3BTSjpOqnEATCDSp/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=NrocMtD9jzHuAP+2J9aGrwleB7geFU/qV2gLjCIKktagruw7OlFwfFHUlHpYFL1Fi
         jDFiMKKXu1ZzupdZq9jZuozJUwTGg3Z5lOB2FRuwe5PDtKMKv9r1C/47NFej5Q6vqA
         R7qcGdo0dkJ+Iz4iwQYvtO/YVD54tfQkxo952+oNGlcDUR67FlboqPtCdc8f1N1QvF
         F0b2OqzRAmU7EVt9DMB7xZMKhfqOGZ7K+Ryibwt3XX4I0cEnq5zQgTJuAtjYN+9IIr
         B8r48SwasDul4ZOVn4xiUMdEI9bC55AEcJABZ5rtXCSU/HM++iR+ea9lbt2HGTnA2u
         y3weP7k5EaB2g==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: [PATCH] kunit: Use gfp in kunit_alloc_resource() kernel-doc
Date:   Wed, 15 Mar 2023 16:39:25 -0700
Message-Id: <20230315233925.2416516-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Copy/pasting the code from the kernel-doc here doesn't compile because
kunit_alloc_resource() takes a gfp flags argument. Pass the gfp
argument from the caller to complete the example.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/resource.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index cf6fb8f2ac1b..c0d88b318e90 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -72,7 +72,7 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
  *		params.gfp = gfp;
  *
  *		return kunit_alloc_resource(test, kunit_kmalloc_init,
- *			kunit_kmalloc_free, &params);
+ *			kunit_kmalloc_free, gfp, &params);
  *	}
  *
  * Resources can also be named, with lookup/removal done on a name

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

