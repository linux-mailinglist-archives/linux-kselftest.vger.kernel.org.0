Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE5766E413
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 17:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjAQQvI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 11:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjAQQu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 11:50:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F345227;
        Tue, 17 Jan 2023 08:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3740B81920;
        Tue, 17 Jan 2023 16:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF20C433EF;
        Tue, 17 Jan 2023 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673974244;
        bh=N5P5R/zCQGnqefTt1bmQdpEkdGXGOW6hFukbHmPYNwU=;
        h=From:To:Cc:Subject:Date:From;
        b=GCVa1Pay/ap3Md79Lb1wOPXY7OdwqujYCYHkzOMB+93efY+ljbOr0AIB+g4QWU5sh
         RCkonqIaLvgY5edr/ORkYTz31d+XnAkikRwH9Bb5c/RY9vW332u+7HwzTkLsjg+F27
         k18acNiMDYKHFHXfEnn42auvqD1BigLCOX9y+S2slcgFGQEyqtEyCjBebQn6VHsstF
         TA1XhT7o1xtdODv3PJkurMsPUWDdDgTG5ievLljPRtjAWLMeMtnbKjFtICWzNMh/7P
         mAYk+LA8jDbExvP2jU72F7lX2O3s5NfSlU8ukk+U7kz2DAlEvaegc5yXdUKNoPxnaP
         qxmpVXOMuBc+g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joe Fradley <joefradley@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: Export kunit_running()
Date:   Tue, 17 Jan 2023 17:50:26 +0100
Message-Id: <20230117165039.1871598-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Using kunit_fail_current_test() in a loadable module causes a link
error like:

ERROR: modpost: "kunit_running" [drivers/gpu/drm/vc4/vc4.ko] undefined!

Export the symbol to allow using it from modules.

Fixes: da43ff045c3f ("drm/vc4: tests: Fail the current test if we access a register")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/kunit/test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c9ebf975e56b..890ba5b3a981 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -21,6 +21,7 @@
 #include "try-catch-impl.h"
 
 DEFINE_STATIC_KEY_FALSE(kunit_running);
+EXPORT_SYMBOL_GPL(kunit_running);
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 /*
-- 
2.39.0

