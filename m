Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3A69DAE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 08:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjBUHDZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 02:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjBUHDS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 02:03:18 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D95D193C9
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 23:03:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m7so4353423lfj.8
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 23:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPYFEzkWt45w45KoW6C4RDWljtvSD6NfX3uQqoyfGo0=;
        b=PiEaUTyKR+BZV1KdOYGaOo0Uih1cIbaC9Lzaa5cF1VTZPWQp523PuApZ5xP3Gr8xjl
         XEv87JwBL02FqisWBLvEd6ltv2bVAzwJPrKkVo4YABKyqaSYIvQyNWJj/vAPz5dara9M
         /flcqnOCtP7fksSbz5LD4Y3B2c9BukcHkOQw+irxTStuFYXlcS5e6G+cnALknEX8/aev
         gHrZol9o5+b0cOuWyl/zEYK7V9TJvVqGNNmc55dpxbE6wv2TTAQEkjPZayUGaEDFOTjb
         Z9Zx+mMYLz/xPeJTLpmblhvolK5bKElXYxCQshoRvR4592QaFGyYbOLnvm3N/8YuhmKk
         pG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPYFEzkWt45w45KoW6C4RDWljtvSD6NfX3uQqoyfGo0=;
        b=EhNvJab/Yjt7J7AEO08AUv7UquEOjO4b944KXBc61Y37SIIXz5Jpt171HhFwT6BaYx
         D5SkmKCpf4jZONI9igeQ6Sqac4mPrSUJPjT4ZToesYs/N48o9Kwl2i1HI8frHiLF19r7
         Rrrz2vyo47QJrIBSTyvhwuaopDV7pb6y1ZbFAiF96NQlkn5DeEHVUuvA9neADRINi20a
         la/9MCEghc/IG5d/oEnagaCgxA/K9Cx81Sv4PyhVx/EjSlGvoQnrTPdqdH1y2IkbziQB
         GiY4A7E2hp4GaOQEbRRTsj0u48lkzAQvD0KAhU09LgL+2ukOHFB1ev1HTs3TScCMJUqP
         xUfA==
X-Gm-Message-State: AO0yUKVeSVjdcfgq6+jAKQAkluPlhgX1vECYBBfrTkKv5NoTp6NR405L
        Q+UjOYnc76bW+6t/0YTlLW34Yg==
X-Google-Smtp-Source: AK7set9mpDbHCk/AdCr+GQzVcUK6fnXr6VHd1TUSH9y7g/NxXBzMWCsg3GVkxAh76WxtgoJ6TmI2xA==
X-Received: by 2002:ac2:5308:0:b0:4dc:8366:2ea0 with SMTP id c8-20020ac25308000000b004dc83662ea0mr968795lfh.5.1676962985988;
        Mon, 20 Feb 2023 23:03:05 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id q6-20020a19a406000000b004cc800b1f2csm642432lfc.238.2023.02.20.23.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 23:03:05 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] selftests: ir: add config file
Date:   Tue, 21 Feb 2023 08:03:01 +0100
Message-Id: <20230221070301.1323044-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Building and running the subsuite 'ir' of kselftest, shows the
following issues:
 ir_loopback: module rc-loopback is not found in /lib/modules/6.2.0-rc8-next-20230220 [SKIP]

By creating a config file with RC_LOOPBACK=m, LIRC=y and a few
IR_*DECODER=m in the selftests/ir/ directory the tests pass.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/ir/config | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 tools/testing/selftests/ir/config

diff --git a/tools/testing/selftests/ir/config b/tools/testing/selftests/ir/config
new file mode 100644
index 000000000000..a6031914fa3d
--- /dev/null
+++ b/tools/testing/selftests/ir/config
@@ -0,0 +1,13 @@
+CONFIG_LIRC=y
+CONFIG_IR_IMON_DECODER=m
+CONFIG_IR_JVC_DECODER=m
+CONFIG_IR_MCE_KBD_DECODER=m
+CONFIG_IR_NEC_DECODER=m
+CONFIG_IR_RC5_DECODER=m
+CONFIG_IR_RC6_DECODER=m
+CONFIG_IR_RCMM_DECODER=m
+CONFIG_IR_SANYO_DECODER=m
+CONFIG_IR_SHARP_DECODER=m
+CONFIG_IR_SONY_DECODER=m
+CONFIG_IR_XMP_DECODER=m
+CONFIG_RC_LOOPBACK=m
-- 
2.39.1

