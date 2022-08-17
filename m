Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456BE5978EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 23:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbiHQVct (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 17:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbiHQVcs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 17:32:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72470A8CE1;
        Wed, 17 Aug 2022 14:32:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bu15so9105722wrb.7;
        Wed, 17 Aug 2022 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cL70TvnaPfbrnYSXL9vjl4iww1REMOrIoq/dv3e3TcY=;
        b=YEeJ9soDolxKR+ZHOjZVYmAlkqw1K2yVq7ThasfGOhMvW7U7OLERhOj6FJ1ZUOBYAV
         6gb6pP/Lg9gQsBGQ4mhlEcJk8Nh6jqoS7D+KCh2TX9kl84Lyl4N5cKf0XhtFKrtNkyjE
         ZmXWU4sum0rkPhdtot85YUMqxz5B57HEtpevyWs+nJfE+/SFh1osDlRpI4rLkx0vHBrp
         5UtN9mk2jw8EcJMPemIs9cBh7/Tx2YsuCLGIYm8yiehyAF6MF224rgXBbbmh3DWee4Wo
         ydzQMJSvbDVrs23rMSzBow+0VmcjGGZulM7bM3FbRYMnkkQWZI6Nx8RE5Z1+19K31N7v
         z8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cL70TvnaPfbrnYSXL9vjl4iww1REMOrIoq/dv3e3TcY=;
        b=vsPO3nxzIayaLLX8/MhsUwKW5H7UCQgpCPUGiIxjq8WGMD5wysXeYiIcR2xuweQTu/
         pFpAVtLHa37YJdg5kFqcsqXO39n2cTL6ljMWeInofn2A2o7h8XRPcdGEHTBsOd4C9rRk
         I7yLjoMPusTEbK8zdeB+pRVYv37soB7fktzuWUkqWhqnvxJdrYzVsqkWMMmtbpZoYb7i
         Ch8bvUYrgbagySD/8DiDehzBpxnJaEpw81h2LeTGRiq7DFFBMDmiuxpfH0htepGN1g3v
         d6OPLcA+6aTr2/pJhk/eUjgQu8HW5tjiS/5Qxgl2cvL645Mf4z3Z6dReySYDBlATQgI6
         F+PA==
X-Gm-Message-State: ACgBeo0ezguqtK/EB6iC8VkZtYmvTWyDaJxkKaHKYS5r4DUXu34vh1Lc
        2Frv0W6+Makb4KTxWdmiMHo=
X-Google-Smtp-Source: AA6agR6qS6ZVDuEnJKMtHXZM4wNDGT5ZMnPAaW+jXSXHVgn0D3gPsE/CXh1pvH/fAI+zP0shUPLahw==
X-Received: by 2002:a5d:6da1:0:b0:220:b328:e4d4 with SMTP id u1-20020a5d6da1000000b00220b328e4d4mr13179wrs.14.1660771963622;
        Wed, 17 Aug 2022 14:32:43 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c47c500b003a3561d4f3fsm3043954wmo.43.2022.08.17.14.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 14:32:43 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] selftests/bpf: Fix spelling mistake "succesful" (kfunc_call.c)
Date:   Wed, 17 Aug 2022 22:32:42 +0100
Message-Id: <20220817213242.101277-1-colin.i.king@gmail.com>
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
V2: change subject line as per Mykola Lysenko's recommendation
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

