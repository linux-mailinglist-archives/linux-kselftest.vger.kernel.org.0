Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AF85393B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 May 2022 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbiEaPNw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbiEaPNv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 11:13:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9784994DC
        for <linux-kselftest@vger.kernel.org>; Tue, 31 May 2022 08:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F486B811B1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 May 2022 15:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AFCC385A9;
        Tue, 31 May 2022 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654010027;
        bh=RmwCycR3WFlIwfKXA5dP2eyhQAV6Zi3YQ1p6a5oR4A4=;
        h=From:To:Cc:Subject:Date:From;
        b=X3PA433joT0XoLzFfVKPaRF8uiK6lH7oPvAiWsVJSbUkaJ338U46HfNfa6wvPSBoc
         9BFJ8wv5W6TuiXYJ0ZOx94kdXyuHp36rpenrEj3vsXZR9FKZJaDoUOqa9UD+EjCYZn
         E8agMwIgYf1kMsyIIiQ5e8NqsOzhmXSxzLUwOHzxkzkXq/bU+g9ccEyd/JnRMJhYLe
         zxFq/gW1GLU4/W+KbTqVNT/38VapH1Ira3EqMtx4WKXEqmS5B3xt0MqjXWsq0OfH6b
         mI6HyScAbgqeHkKTY4TzPd7QzlcjHcOCsI8HpoTYiEndNVuqjz60k7S/ETsTNOn/74
         ryT/wtvNVP0qw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] selftests: alsa: Handle pkg-config failure more gracefully
Date:   Tue, 31 May 2022 17:13:37 +0200
Message-Id: <20220531151337.2933810-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; h=from:subject; bh=RmwCycR3WFlIwfKXA5dP2eyhQAV6Zi3YQ1p6a5oR4A4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiljBBCCHKDUduv/2nquVo28cAVN51XaTXqgU+Tu7q X2OsG86JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYpYwQQAKCRAk1otyXVSH0CpYB/ 9QBZ+2ZEym7LVf16fGuCDWbOBtahBrHoM+mSrEzpsYPimoy6iMkBxy/QJFqhxCb2xGWP45mEHieKBc enOaemDT17QIJDWAvqZIBr+zIKviE5ongTuvxqacPnR8MdUCdTEl0ZSKo98GGLR2ExVI+6p9iXdf5N cIrkK5CmajuEYHxkq2qlG9bWC/FzXTB5n3tp4E4tqyzrVMfRkPyDfj88I1LWtM9R6L+OgexgCgscse 9h+eJ/PQBjaHLKCf7RkF3IMAwZq/lF03RsolwPbWGsHtND94ZzHLRgt2HfWtFmCG2z2t0FErL4tKpr jJ69pgWBSi8QzAqFwVR5QDADPmIeOt
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Follow the pattern used by other selftests like memfd and fall back on the
standard toolchain options to build with a system installed alsa-lib if
we don't get anything from pkg-config. This reduces our build dependencies
a bit in the common case while still allowing use of pkg-config in case
there is a need for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index f64d9090426d..fd8ddce2b1a6 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -3,6 +3,9 @@
 
 CFLAGS += $(shell pkg-config --cflags alsa)
 LDLIBS += $(shell pkg-config --libs alsa)
+ifeq ($(LDLIBS),)
+LDLIBS += -lasound
+endif
 
 TEST_GEN_PROGS := mixer-test
 
-- 
2.30.2

