Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6877D6A9FFD
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 20:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjCCTVE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 14:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjCCTVE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 14:21:04 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5B7559E8
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Mar 2023 11:21:03 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v16so3352492wrn.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Mar 2023 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677871261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9ZZuv5MtZprL8HR8bDjuGADsur3LZJXi9dnz/mZ8tk=;
        b=bPygZgsgJ/zfuY2F35GQXTzCzXigU0Gz8EZtxrejcBORT1QYCwBpvi90lCwdUVaKH6
         3ufMmvPDjQTtyvtiQWrJnakF0Kp1JsVPHw4hfm3/etg/hXQnbAjDYCCviJHOsvlT4G9T
         Bh7vY4H5mi5p7UpVsCZ1vu+u8WvMTXIZ6MiOiv7xiXh0KAsY6wYR3sawtAqaacKznAM0
         1J/SdB32JzLOV6KM9mV44s4Yz1XXt9Rw+qI//Bl7a+45lu0kJBYJzIH+0+X1HntQwl0D
         dCSDno2vpi5n5bkyeV2+DJWyVoplH05p8wgy46aQv22a2Z6S+gk7H/6IJeyB/9Jdgxnx
         6dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677871261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9ZZuv5MtZprL8HR8bDjuGADsur3LZJXi9dnz/mZ8tk=;
        b=4uiYWGu2vyVbWy4NWue+CYLhiOXLdD1L0sWBsyoAF8GG4VqWDFHCkHKkR/vu24gtif
         6Lww/g1YPhvwvzu0239I+XVQS+9ENCMl53g28QJg4QFQuO5l8gLbY4Bg+bbIGmORW+BE
         hYDSgCNlmsizasfjqGxZPB15fEKHkWuYh0y4xgV/Ltq3q0JPytjSWVyF5yzUFPKJPpT/
         mW+fG/EBXCDWVbL6jX6RgZqsbDRS8LcAIyBnz5BzvBbCaecuddINRWt8EwSfWFtPrltO
         2/q79xN7bdjuYHwzunNkKyOelRwIqjtNlfEWwAeSDywBuJoDFWFUgKd4VmwLPuqSFoZl
         SxtA==
X-Gm-Message-State: AO0yUKUg4lHm2gzHPPlea+y7F44FAM5RvT8X0MjPrYbkj5zRw5+GbhCI
        31zUtpk7dLiUGex6PE0CSayQ3mkhy78=
X-Google-Smtp-Source: AK7set/HF+wL+GQOyCK5EKNdcgmXKmLhYpZ3mJcWcMkBilLrJlyDjQdbDi7Dr67sMHGIvoPq08651g==
X-Received: by 2002:a05:6000:118a:b0:2c7:be8:4873 with SMTP id g10-20020a056000118a00b002c70be84873mr1984584wrx.58.1677871261465;
        Fri, 03 Mar 2023 11:21:01 -0800 (PST)
Received: from kos-moceratops.home ([2a01:cb1d:8ddc:f000:36ae:1bf1:281b:95d9])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d4581000000b002c55551e6e9sm2948341wrq.108.2023.03.03.11.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 11:21:01 -0800 (PST)
From:   Patrice Duroux <patrice.duroux@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Patrice Duroux <patrice.duroux@gmail.com>
Subject: [PATCH 2/2] replace 2&>1 by 2>&1
Date:   Fri,  3 Mar 2023 20:20:56 +0100
Message-Id: <20230303192056.18732-1-patrice.duroux@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAGKjw9KHDnVgRz5bstJYkq4t0-bT5fvkuQZbEB48d-8jo4Q00g@mail.gmail.com>
References: <CAGKjw9KHDnVgRz5bstJYkq4t0-bT5fvkuQZbEB48d-8jo4Q00g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Patrice Duroux <patrice.duroux@gmail.com>
---
 .../testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh b/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
index a1f269ee84da..92acab83fbe2 100755
--- a/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
+++ b/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
@@ -31,7 +31,7 @@ trap 'cleanup' EXIT
 
 eth=${NETIFS[p1]}
 
-ip link del br0 2&>1 >/dev/null || :
+ip link del br0 2>&1 >/dev/null || :
 ip link add br0 type bridge && ip link set $eth master br0
 
 (while :; do
-- 
2.39.2

