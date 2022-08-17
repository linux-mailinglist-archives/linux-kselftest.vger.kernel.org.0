Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23519596B69
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 10:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiHQIeW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 04:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiHQIeW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 04:34:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696AA4D274;
        Wed, 17 Aug 2022 01:34:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r16so6147749wrm.6;
        Wed, 17 Aug 2022 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=P8ZUO6V2KNOkYdxLtrlQAlfU03xMErqXxjLAC+qSY1k=;
        b=LvGtIr23u6IOczpxEdJkuDvtZWJFg2EiyPw2Kof+Vk7jDEXAozxeSlH9UW/3DEsFRQ
         sKmtO1ZRSuTBvQvCZn/gFM1V2A+MXWJoE5rCuMwdyxCcOm/6yGQUtdxr2nlVyY1L/nnO
         Hc1mfcDDIWK3qHs/Fp9ojMc03Os1A0WM2/HbXVMmrBsCDTCFv9ZH8uaCHTPCt4kVd44e
         6nzibmRRLnW/NPzaoOikOv2qYFig9IXiSoz4FCzAb3Ov6ciCrqLKrUcCyz2biI/dJpg0
         WQMp3iYlVqr5JCD0UbwrnCuyyO0VAunwttotVQ5Yr2T7bIWhjg6PhvqEhril9Z7eGcwl
         7azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=P8ZUO6V2KNOkYdxLtrlQAlfU03xMErqXxjLAC+qSY1k=;
        b=cYM9pXrI8YlodbWgZAALQk+kENHUSdm9YYSzl5zVZXRQQw0UP7yKuY0hVcwjjdnqqZ
         UcDskh/8FGBHBFA10nSCLndM/KPiZVH5TTMw1HWXbG9GoyRrgpV+s7fVRHqzGV0nbRrg
         hIGisp0a9YLIlskXnDloeHl/eAPXlvzIf6SipA6w9/FK35fczrp/xOMiqcx6TFKRizXc
         xSruhseAgncjz70osqMLYe0HJDM079cQwYsljrnxhl/zPTKZ4XnuKWmuZSTRCGMkbkgI
         GYGhtKj8RjwC+xWD3E/8PkvfeRComK/biEMbFL70CQGW+8VfZC4L8ELelM40DB1+xxkh
         QfrA==
X-Gm-Message-State: ACgBeo3uXkHB9PYPL4r+wYsOEKo7dV+z+GsUSzSigo0s7cb4OmF4fa3T
        79DFCbskggM3wXh+GPyPlHw=
X-Google-Smtp-Source: AA6agR6hZ9mpFa3dqJCDYX3Y0+uFAo+ADFuKqcLC3sOqv47exRzKdQm7lXD0AiRDV6YyCBSMHc1SRg==
X-Received: by 2002:adf:f905:0:b0:224:f876:c001 with SMTP id b5-20020adff905000000b00224f876c001mr8961785wrr.201.1660725258966;
        Wed, 17 Aug 2022 01:34:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id ay39-20020a05600c1e2700b003a5fcae64d4sm1487241wmb.29.2022.08.17.01.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 01:34:18 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/bpf: Fix spelling mistake "succesful" -> "successful"
Date:   Wed, 17 Aug 2022 09:34:17 +0100
Message-Id: <20220817083417.50884-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There is a spelling mistake in an ASSERT_OK literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 351fafa006fb..eede7c304f86 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -109,7 +109,7 @@ static void test_destructive(void)
 {
 	__u64 save_caps = 0;
 
-	ASSERT_OK(test_destructive_open_and_load(), "succesful_load");
+	ASSERT_OK(test_destructive_open_and_load(), "successful_load");
 
 	if (!ASSERT_OK(cap_disable_effective(1ULL << CAP_SYS_BOOT, &save_caps), "drop_caps"))
 		return;
-- 
2.37.1

