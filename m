Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7221C7481CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjGEKOm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGEKOl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 06:14:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1328FE57;
        Wed,  5 Jul 2023 03:14:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso46211685e9.0;
        Wed, 05 Jul 2023 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688552077; x=1691144077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlDTGxKAa9u+MMfrqxFnjprJCty9LTNk5K6Uo9s9JGE=;
        b=FMqifX2a0syOcCH/4H/HWrk26qkao7Gk6vgpVmIKL9hFDe6xc/jtngBFhuXHVaXQRD
         q2xMVdrHmZe+W54XWO8cNQ3oqjreEPSNFlAoM372QI5DNvShq1arjPSmF0XxSzhTw6Lg
         uc5/iDik2rXx7xs9oB9jfA2tRHNU6/+ane5lw6nwIvfvmOb0I6ZR1RW5QhBcGRkOWCik
         2zxB5DEVfkNdcl+Pt/hlcKSS3257cvANVWdJONC06ylqTx5yKLTpLR9mbVpWB68YIhA+
         BoE17WuaJIaHYpy6QVvk++zohLl5stBmZPcFX97v6uPbBA42ogccTDc1PKSvtLNnlkW4
         hCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552077; x=1691144077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlDTGxKAa9u+MMfrqxFnjprJCty9LTNk5K6Uo9s9JGE=;
        b=VkOfdmvCSaP7KAIw8m1sK5A/zv/s3nLxkQiI6o+nHQlIpL8wAu9CAw20uCAp142ffV
         2aVXnFhnhiWM7eF4oLvC5rBQA9OoJIlp1tGZ/v+as+yyDup2l+sm+V84Rs81fXNvC70A
         c8Kwwm6DlL3iIlLEAC+LPjcbVObg0jxFtfcHaoO0k3B6Qg8Md3GrErkcSIUkfLRVOKLE
         H7tUooNHGAwF0BCGQwksUd1S68zRz7rEGVVseg5ng3TJNAg+8gh4AphG2AX1VEWtVmIU
         wVmEoEeoJG6/83rKbwPVQxwEUG5ffIg7yjw7XluGVd1ExenfmH2raHkcydqcJVRiVdZm
         rNpA==
X-Gm-Message-State: AC+VfDxXhuF5NHiNL+G/jigLFWvn9AL9/xJDeXW3ijfjBige8nkfVwpc
        ySxH+4ELJ45TEtz3GGql9Lo=
X-Google-Smtp-Source: ACHHUZ7K5EfFMNSC4PLTQGysSNBsmGFHkS+8k8ibS7sZA5Nzf+ZclnTrpg63X8YXOsKfj2XY0LGojA==
X-Received: by 2002:a05:600c:2201:b0:3fa:91d2:55b6 with SMTP id z1-20020a05600c220100b003fa91d255b6mr13704823wml.9.1688552077291;
        Wed, 05 Jul 2023 03:14:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i5-20020a05600c290500b003fbab76165asm1672277wmd.48.2023.07.05.03.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:14:36 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Chiu <andy.chiu@sifive.com>,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: Fix spelling mistake "regesters" -> "registers"
Date:   Wed,  5 Jul 2023 11:14:35 +0100
Message-Id: <20230705101435.1995171-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are spelling mistakes in ksft_test_result_fail messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
index 66764edb0d52..62d8884a1a0d 100644
--- a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
@@ -49,14 +49,14 @@ int main(void)
 	ksft_print_msg("vl = %lu\n", vl);
 
 	if (datap[0] != 0x00 && datap[0] != 0xff) {
-		ksft_test_result_fail("v-regesters are not properly initialized\n");
+		ksft_test_result_fail("v-registers are not properly initialized\n");
 		dump(datap, vl * 4);
 		exit(-1);
 	}
 
 	for (i = 1; i < vl * 4; i++) {
 		if (datap[i] != datap[0]) {
-			ksft_test_result_fail("detect stale values on v-regesters\n");
+			ksft_test_result_fail("detect stale values on v-registers\n");
 			dump(datap, vl * 4);
 			exit(-2);
 		}
-- 
2.39.2

