Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA6789BFD
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 10:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjH0IAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 04:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjH0IAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 04:00:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35661EC;
        Sun, 27 Aug 2023 01:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693123218;
        bh=B1mFk8uZ/BLYTjxk1k/ejCC5jmffZ0I7FxsOqwtYDWg=;
        h=From:Subject:Date:To:Cc:From;
        b=i9A17SGInjboXUzxVgk3l3W5cu7bCJyVf9+tBOMFoRGtAM5L7HrpezSt/Ye6ssuZU
         mfswVfQk7bXo4DiQLX6nLh+g0Oyzdh2Fg9BUm3EsXdKqhcfMK5FbV2bIWjSzvtzN+F
         a4iAO/hb2kh7/A6Zua4eSATXBxm3xOSe+9/DQQIw=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] nolibc: remove reliance on system headers
Date:   Sun, 27 Aug 2023 10:00:14 +0200
Message-Id: <20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI4C62QC/x2MywqAIBAAf0X2nLCu0OtXokPpVgthoRFB+O9Jp
 2EOMy8kjsIJevVC5FuSHKGIqRS4bQora/HFgZAsttTocOwyu4J0eQlOE9oOW2PR1w2U6oy8yPM
 fhzHnD7DuN71hAAAA
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, Yuan Tan <tanyuan@tinylab.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693123217; l=747;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=B1mFk8uZ/BLYTjxk1k/ejCC5jmffZ0I7FxsOqwtYDWg=;
 b=4tkadWjyWeIpJdWSAHtHbIBxCI0veoaV6yaTRb4AjXizfbEpRH2p+Ax5dv4Ycm9T8pb91zAX9
 mkdqpMW4YaOD9BAwhwG2o3QTIGnE+jHu4dHykbseE2rQ/ggPHNR+rw1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This was prompted by the discussion about output directory support with
O=.
It seems sometimes we were pulling in system headers making testing
annoying and unreliable.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      tools/nolibc: add stdarg.h header
      selftests/nolibc: use -nostdinc for nolibc-test

 tools/include/nolibc/Makefile           |  1 +
 tools/include/nolibc/stdarg.h           | 16 ++++++++++++++++
 tools/testing/selftests/nolibc/Makefile |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)
---
base-commit: 556fb7131e03b0283672fb40f6dc2d151752aaa7
change-id: 20230827-nolibc-nostdinc-203908130d67

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

