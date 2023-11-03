Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB25D7E0AF4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 23:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjKCWJ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 18:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjKCWJ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 18:09:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE3E1BF
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Nov 2023 15:09:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-509109104e2so3194298e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Nov 2023 15:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699049363; x=1699654163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBuN7gYl2f9j4m13qRB4taTG381QaiJck5wqiJSvm24=;
        b=Kl18rAdFdNLsVWkmO4CE+2DJxLKEZO3W9ip3AWB1iI/8o/S9zZetNzjLA8NQFzWeyI
         5u4MZob6E3jrCN06YvF4CcIX39eI+q/ztbs+goAjfn2SX8NdUc5w1wG5X0XrLqg7uocL
         TYkVknq3xFszyevjYiGL78ILbUkqxX7DdJdHq4Ki6jR9REa2GGNmUKhaHhcDRieNL2ft
         M81ytNCiLUKC+It/Rv+dQD8AoFbp4dawsFjgU0spB5qE91x7ajRHAcFR272zxGkoSOOt
         4TswZhJxyF92Qvso3gWOKwc4zrgWL3FCgtfab0z8azuLB104TYjg3cKjKbAkYNVBdROF
         7IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049363; x=1699654163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBuN7gYl2f9j4m13qRB4taTG381QaiJck5wqiJSvm24=;
        b=mp9blevRO/W0Np7dh+LotZo1wcomkNXBEEO/2eU7ySjSRRfVktiUenN9GKt8yKORZ6
         tqRUsMcw6WG8JL3kJcx5hKNS718XA7u+eAfX4KQ3sJmbMX/uLYohwJhEKfHkqCpc0rnX
         Q0H5H9DHPDsWWwEZ1x5tDbGKoP5RFOXOLCeOwlT/yDc3dZeodlQR06blrELm8XDmGgJj
         mdxXJYkClrsQkQOoM0s8l/Nt3ptILH2/h2szxLFfr4fvbCnGOV5hfPnEVqkrFO03RxVK
         TBb6iHn5Vo7q+mYuD3d5RVMf7dFoUt5iNsknYKlrmS+BoPeWrtcij91SGjjcdmuONh2L
         14Nw==
X-Gm-Message-State: AOJu0YwXVQUGgHp0Y3LCHoS/S3O9Xb7JdeMWU10kCZ609XbGp+yL8hYp
        l3HXx1UIYGm7gSTfNrWMiU1TwA==
X-Google-Smtp-Source: AGHT+IEr6GbDZ4s+E8RGXMnC70xlRgNiPkcHdcJp3VSEFy36sZoLWuW438sdEFKZIJ2wEB7kwesPVg==
X-Received: by 2002:ac2:5925:0:b0:507:9fc1:ca7a with SMTP id v5-20020ac25925000000b005079fc1ca7amr16708313lfi.9.1699049362665;
        Fri, 03 Nov 2023 15:09:22 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id m11-20020ac24acb000000b00507cf5fa20esm327760lfp.97.2023.11.03.15.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 15:09:22 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     mykolal@fb.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: config.aarch64: disable CONFIG_DEBUG_INFO_REDUCED
Date:   Fri,  3 Nov 2023 23:09:12 +0100
Message-ID: <20231103220912.333930-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Building an arm64 kernel and seftests/bpf with defconfig +
selftests/bpf/config and selftests/bpf/config.aarch64 the fragment
CONFIG_DEBUG_INFO_REDUCED is enabled in arm64's defconfig, it should be
disabled in file sefltests/bpf/config.aarch64 since if its not disabled
CONFIG_DEBUG_INFO_BTF wont be enabled.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/config.aarch64 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
index 253821494884..7b6e1d48c309 100644
--- a/tools/testing/selftests/bpf/config.aarch64
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -37,6 +37,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_DEBUG_INFO_REDUCED=n
 CONFIG_DEBUG_LIST=y
 CONFIG_DEBUG_LOCKDEP=y
 CONFIG_DEBUG_NOTIFIERS=y
-- 
2.42.0

