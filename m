Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E6781133
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 19:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378889AbjHRRFU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 13:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378925AbjHRRFB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 13:05:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2D10C0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 10:05:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bdbf10333bso9456565ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692378300; x=1692983100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VAxptV1JcBWqpHjcFDc9kRlVMahNNng5HlBsu6aevpQ=;
        b=XjYA43dICinX60iFbjomGqku+0qhm2gmB4fqWHM72O+hPykTO1bnOLiJzBMtowNMaI
         BnInYgymxmnH4wKpYnkdKPFCwiABf3FZIO2xmmgPmO2HVcEhDyxrsZ2TuV0fjGK6koLT
         HCYL5OtAc0D8K3cWYdHbjY6ZRTKmBpKTNpr/h5qB/k/tr0zuVOm1jP5wyz8+1vf7UM+1
         f1nv81435RL7WygiCpCj8LENhRvQnx9aLBCnTY/QNPueAz17GP4IsmCCIMF2tUkpvuQI
         Iisz+G7dlXcqfyCsojiSq2Pch/LUKUCr+9r7Gv8OxW25HuhdA2nxxPNTaBoDGGBDic2G
         A6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692378300; x=1692983100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAxptV1JcBWqpHjcFDc9kRlVMahNNng5HlBsu6aevpQ=;
        b=BBfXm7zZ236tt3Rwjt4wmpfZNpY7BzA4OMy4vuOx+yu8KD6x4jkZTkSdf47OXMubCP
         pvIO1xZ3GnK2fkuCprLS9ySJNAvWhm9rhqC09JU4euHFzyfImBSXTjHuGkeTDUv6CVCB
         FoeL1BvbNy3nwRm//q7vHjJ6Nrae1hcP1UKtQvRepZFj190vEpuu83n26z9RWjaCHeIH
         p1/RuJFSDrqkpkpPCPz+D2TKm3/oD6cH/kQVwqv3xbbKAFQKCGgreGlEwlXfMVWZkYw2
         63DK14dkU/fM5jJyCu+VKP5sOeI/NaOpxYngQ6JxQKsZrnAs3/2HAkEagbe+6Fzkh7F4
         qBaA==
X-Gm-Message-State: AOJu0YxXoAzE66WSZPF2NudGsWrMa+h6qLxNFGdXLABLVh5opcpIhzK/
        ivf1GZO4+/9ULRHoIU4PMs8Myop4ujd+isluhL0=
X-Google-Smtp-Source: AGHT+IFlMHfrA0BxgDIzTEq+HtsA75YcNrDuB6eyKclIaLm8IM0ar3r4q78mqfJPPZHE3FQbT4nP0Q==
X-Received: by 2002:a17:902:bf47:b0:1be:f45c:bc38 with SMTP id u7-20020a170902bf4700b001bef45cbc38mr2967705pls.2.1692378300015;
        Fri, 18 Aug 2023 10:05:00 -0700 (PDT)
Received: from fanta-System-Product-Name.. ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b001bdc208ab82sm2006764pld.97.2023.08.18.10.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:04:59 -0700 (PDT)
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
To:     shuah@kernel.org, kirill.shutemov@linux.intel.com,
        mika.westerberg@linux.intel.com, wander@redhat.com,
        kai.huang@intel.com, mathieu.desnoyers@efficios.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     Anh Tuan Phan <tuananhlfc@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1] selftests/tdx: Add .gitignore
Date:   Sat, 19 Aug 2023 00:04:53 +0700
Message-Id: <20230818170454.19493-1-tuananhlfc@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add .gitignore to ignore tools/testing/selftests/tdx/tdx_guest_test

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
 tools/testing/selftests/tdx/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/tdx/.gitignore

diff --git a/tools/testing/selftests/tdx/.gitignore b/tools/testing/selftests/tdx/.gitignore
new file mode 100644
index 000000000000..56dd26b77c07
--- /dev/null
+++ b/tools/testing/selftests/tdx/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+tdx_guest_test
-- 
2.34.1

