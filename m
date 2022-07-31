Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B00585E49
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Jul 2022 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiGaJZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 31 Jul 2022 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaJZq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 31 Jul 2022 05:25:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC454B873;
        Sun, 31 Jul 2022 02:25:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k15so2108032pfh.1;
        Sun, 31 Jul 2022 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fgm3Q++1bshM2vl04u7TMk9GX8r0/GgZjPpDoVpdNEw=;
        b=nOYN6MEV8djhhHocvXe+hviriAisVPDKDjgJEmXQnC7GE3aIWE9Ofw/xhg2liiM82U
         +KwO7/qekJpFxGJTcIQs6Ctl4GJ9n7x29rIcz+B4lWnbhR8/e/3AaZFRo8KHc1eoRael
         X69jxEngBuKi3ivSukSnVKMM/JaZVdbWvwTwPK3t/I9QelyFY1ZC3lUHBLd4EA29jYwp
         Db7keNveNxVLU8fBjzU7u0+K4F6xtZ+/Q8cAztfuOCffqEbLLomDQ45aApYY0HBpbPk2
         SYHx7082vuAwMVHkTaOO5s83Pk9GFsL75hDgnJ/h/ctiqjRX+ZmWGCl9ZTaTKar4Kp6G
         7KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fgm3Q++1bshM2vl04u7TMk9GX8r0/GgZjPpDoVpdNEw=;
        b=hdlrO4RmmUpZIPGFJUjH1Ha1ifA3gvyA3nVoaUIGISoI3tLQe6B2TCCJkS3j4Q6lj9
         rH1Yf/jZiLoxFA3lnyVov8u+QmL9xVKF2jUhpXgiOcN1Ki/NmdhdqUK0z+GSzfQSKqlF
         eDOly/4dovD/St4GBXM5ViH15jJtmAv6PZ/lYDn7E3IHri762h31kbFRIJomHqQI48Im
         o2PM/mtNTXj7aAvoyu1zeQqMRVmAkYyURNpQd3fcpn8XLJJw9GrpuF/KYpCF3JMLqyUF
         pThwSa7ON/kLIr/2Uwr9nOhuasDLkYc5BMfdbTf9WAF3GKz1IJ6juggDWaHcN7ytq3J7
         4itg==
X-Gm-Message-State: ACgBeo0CXPNGeM35IrskWHzi+zZX3YhuM4iPmTrkDrpRITF09ky1C45D
        nI8FfrjBGZKIXIbsppv2dAU=
X-Google-Smtp-Source: AA6agR7VU84e7l6aGVkbcFw+tkLywcnjeN6b4ZIQYsTlc3xYB3BhyXpmuUjM/Tsb71Wj1g6nvgb6AQ==
X-Received: by 2002:a63:5425:0:b0:41b:a9e0:bfc1 with SMTP id i37-20020a635425000000b0041ba9e0bfc1mr6783924pgb.206.1659259545257;
        Sun, 31 Jul 2022 02:25:45 -0700 (PDT)
Received: from biggie.. ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902e84100b0016d1b708729sm7147827plg.132.2022.07.31.02.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 02:25:44 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     keescook@chromium.org, shuah@kernel.org, brauner@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, luto@amacapital.net,
        wad@chromium.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bpf@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/seccomp: Check CAP_SYS_ADMIN capability in the test mode_filter_without_nnp
Date:   Sun, 31 Jul 2022 14:55:29 +0530
Message-Id: <20220731092529.28760-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the "mode_filter_without_nnp" test in seccomp_bpf, there is currently
a TODO which asks to check the capability CAP_SYS_ADMIN instead of euid.
This patch adds support to check if the calling process has the flag 
CAP_SYS_ADMIN, and also if this flag has CAP_EFFECTIVE set.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 136df5b76319..16b0edc520ef 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -392,6 +392,8 @@ TEST(mode_filter_without_nnp)
 		.filter = filter,
 	};
 	long ret;
+	cap_t cap = cap_get_proc();
+	cap_flag_value_t is_cap_sys_admin = 0;
 
 	ret = prctl(PR_GET_NO_NEW_PRIVS, 0, NULL, 0, 0);
 	ASSERT_LE(0, ret) {
@@ -400,8 +402,8 @@ TEST(mode_filter_without_nnp)
 	errno = 0;
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
 	/* Succeeds with CAP_SYS_ADMIN, fails without */
-	/* TODO(wad) check caps not euid */
-	if (geteuid()) {
+	cap_get_flag(cap, CAP_SYS_ADMIN, CAP_EFFECTIVE, &is_cap_sys_admin);
+	if (!is_cap_sys_admin) {
 		EXPECT_EQ(-1, ret);
 		EXPECT_EQ(EACCES, errno);
 	} else {
-- 
2.34.1

