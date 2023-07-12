Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A223750CC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGLPkt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 11:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjGLPks (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 11:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6BDC
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 08:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 671536187A
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 15:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CECAC4339A;
        Wed, 12 Jul 2023 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689176446;
        bh=TnBFqbbzgjL9q9pFRoc5uu6BkdcO9YJ7JVR18QHszz8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qxVEnB/5IDGeIXoXuliMt3jaDqILPk0b0m5VguRDIY3c2nl39ekD67uvMykOdHcVT
         y8RJJC0jk4f+XpzEUMBvjkUGSDmDyeyH1jbFE8GbMzkTChN45XXTJ9iQf480A8NK/A
         D9rVOLU8EhLoZl3Fx6Ixhs8Z/6nuJDPD3tMEoCfFDZTfYtkixyVwI7RyoAjbFep+Gw
         yt3MoAg+VrVAu2/Ff5sbrJtqngm6h6ZElrz4xiBPIl0ky3SA3Ze7nRzvDaJQGBlyda
         dQIAJ29dtdCYlJM+wCoEz+WdhS7sKFp6KXauloNqcoMBd7FlkC+Fe6rpvt8pS9b2Zj
         xtTwsA46mDf2Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Jul 2023 16:40:34 +0100
Subject: [PATCH 1/2] kunit: Enable ASoC in all_tests.config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-asoc-topology-kunit-enable-v1-1-b9f2da9dca23@kernel.org>
References: <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org>
In-Reply-To: <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=682; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TnBFqbbzgjL9q9pFRoc5uu6BkdcO9YJ7JVR18QHszz8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrsl27ZL9bb6Lvk7dV/yYkcl8czkbEDp6M5JF3
 fZ5YIXFOgCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK7JdgAKCRAk1otyXVSH
 0M58B/47rzu91SwUwCKWAryHgGCq69ZM0U8NuOuxuimscwow45VjLpFLJLqs1YaLwbGjz/f/s1U
 jwaqvgJ0lukYrUq7MNKR4IjHkPY5EyXtEIBHfdieUWQwkgUKUCsHTnX4Gw9MCqVskznMiNMWWYb
 FU3+yw9OVFcaezNsSdLP6bVDy16j3R8YDWyZbx7HDFTPgpJYr1dPsYNZLzPqBZUGZanPxrseV7j
 7X3rhpYwRux2Hid3xXH7JrVcjf1idI9TquKpxpMVt2Pmz/+5ACGgpqwFz+ti4kpNLFwS2Z0DN7n
 VOwIQ+uGA8vNWkX5jYY8l66imUA/4wu7AXO2A6rwVtMm8QS4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are KUnit tests for some of the ASoC utility functions which are
not enabled in the KUnit all_tests.config, do so.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/kunit/configs/all_tests.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 0393940c706a..13d15bc693fb 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -35,3 +35,7 @@ CONFIG_DAMON_DBGFS=y
 
 CONFIG_SECURITY=y
 CONFIG_SECURITY_APPARMOR=y
+
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y

-- 
2.39.2

