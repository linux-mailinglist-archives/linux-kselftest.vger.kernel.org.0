Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EEF2F501B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 17:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbhAMQgN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 11:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbhAMQgM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 11:36:12 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D65C0617A3
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:55 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e18so3917809ejt.12
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ortZEFtRxUHru0nbidQWEmOXybckovOr5wRf4WEJjFM=;
        b=a8++npUHoFCwDIM5u6xxezEiajVUXj9kNbUL7gaHw8elD+3ybFg/9Fp2aDjy6UsXnu
         qo1mWCj7GY0ddbZyrWDHtUOpPrldMvEMxFGKIw55sZk93tnLSyCrwnTn+JJ8Bs8NilUc
         9n7R5GK1UQCF2f+BlMJX4KnA8U9biEqOaTAoNjbOeWjQQDnjJRorUu3El+/PB/rLDYre
         V06JGLLOiym+BF4912W6EVw12y1LaEz2LcPZ04yGXUjfW9fxBhEv0lW8OBQHcjZ06aCn
         lgqSW1xrQsvR7VxUXQ/RgAgGfbaAE01ieNKdIzJDwgnq03JrYOYzey8S0ypxpUpRBRBL
         tYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ortZEFtRxUHru0nbidQWEmOXybckovOr5wRf4WEJjFM=;
        b=Mj2oxHfChByzryCT6ss2mJKkv1wvYZAPo91Jo2YyM8Mq0fLYAlxZO92c/1989pA8Qf
         SIzgj0Hsv7JHoNCMN7FNcuOVaAe25456VuZX50hGBBUe7RtOPJd28G6ZSwocYCWozKuR
         S01dXphiLRBIXBuf0Uu3E4UkTBTG/JbtxOxq+w5Sr8iRkR2vqodDuvIgEAP+9morAHCy
         W912wjf3MU/zulGECTvvzNT9whAWTdIqqCf76UCzd5W2ywJT67DHDHxBjoX6S7H9djpO
         BP1SkuIOelcPkWXke0IgkVUMeKwMylxZGFrz6CmqSudooa5cdvzJut952/8PxLq/5mgN
         FIPw==
X-Gm-Message-State: AOAM530QyJoyugVoNyHLmGCnsg853dfjihbIussZ35Hkv0NKR8Nn95B5
        NUZQWYZVdfgGoF0zb6w+yn5fQg==
X-Google-Smtp-Source: ABdhPJwbHL5+zAlZGGQxHuywH889qbeJnoolUcK2Rkj5UHFlOgiSCITdApr8ZZqV51Qn0RUa0v/3JA==
X-Received: by 2002:a17:906:3553:: with SMTP id s19mr2112447eja.95.1610555694454;
        Wed, 13 Jan 2021 08:34:54 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g25sm923943ejf.15.2021.01.13.08.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:34:53 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: Move generated test files to $(TEST_GEN_FILES)
Date:   Wed, 13 Jan 2021 17:33:18 +0100
Message-Id: <20210113163319.1516382-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113163319.1516382-1-jean-philippe@linaro.org>
References: <20210113163319.1516382-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

During an out-of-tree build, attempting to install the $(TEST_FILES)
into the $(OUTPUT) directory fails, because the objects were already
generated into $(OUTPUT):

rsync: [sender] link_stat "tools/testing/selftests/bpf/test_lwt_ip_encap.o" failed: No such file or directory (2)
rsync: [sender] link_stat "tools/testing/selftests/bpf/test_tc_edt.o" failed: No such file or directory (2)

Use $(TEST_GEN_FILES) instead.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 92888eed89f3..67cdf858f01f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -44,10 +44,9 @@ ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS += test_progs-bpf_gcc
 endif
 
-TEST_GEN_FILES =
-TEST_FILES = test_lwt_ip_encap.o \
-	test_tc_edt.o \
-	xsk_prereqs.sh
+TEST_GEN_FILES = test_lwt_ip_encap.o \
+	test_tc_edt.o
+TEST_FILES = xsk_prereqs.sh
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-- 
2.30.0

