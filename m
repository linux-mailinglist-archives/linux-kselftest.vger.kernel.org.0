Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31AE52418A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 02:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349674AbiELAal (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 20:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349655AbiELAak (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 20:30:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B9A580F7
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 17:30:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f16f3a7c34so31757347b3.17
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 17:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0J8P1K+Pc+pMnOB9fJOxIgGn/5rddsTWXBmrJCDpNWM=;
        b=VFKsYXv0v7lf3Bb8KTBlngA69IfwQBf46pJBZBZHyFkYBg+y3q9KMyOSSHXd/CbiNd
         r2f3orVJWoJb72ZMl9iUABXlzMcOGk6Qwx1+QmuEMKHbv5BT/XcyJcsyPjvSUR91cCJP
         HLh5wA6uTAYDieGWE99apmQW09fkPrUr4qnvOEocpi2MYPfkPgT/0NY4LmOaU4seiU2U
         69sEvRRuP6TBiXVypVMdj4ISTEB/vuoMKu69EMQdx6lhMf4P93GUSmuwCvYX6cTUCY9b
         w2b0Ev3hj4hE3Yoqqw6LXnfOcK2IwtsRdxmDk6L0yvYwPbvGDaSphXmEDfaiv3KgxZp7
         J8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0J8P1K+Pc+pMnOB9fJOxIgGn/5rddsTWXBmrJCDpNWM=;
        b=c5sZ6FahL18GWbe1y5foMIy6jzjUbA/T5eH/n0Se19tahsTGrE0IKREoui6xQXo6vM
         QlVgYdB6FY/J10ro5xmN0zIW4VIjzOYrLNDQnWQQYgLY7jJBcHRWK1H/3uUpX65w/wrd
         PJdw7cW0lZj+DAQVSYN57Gbn9SqR3wAln26nGlKFxM+0zeTNEwLts8mLEXIM194gLd8T
         HcuLtjRC5kxPAAVcJX//xg6rOZ6teHCvDgPwGPy5rk7AloEdNZODpdEsJzikG0VZl8xm
         Gzv7O8PZKL2KujhHbujKUlHjBasjA5st+p2G5c8hu0u2dF4DkgT3FZDS9Y8aadiu0e78
         IMNw==
X-Gm-Message-State: AOAM532bi0PRrszEIIyegnhoL73kN1TsLFl4+yXa4xCycJlUdqD/HE0F
        P/otj198XyiRoBc7mfYf5c80CtALrS/w7z0LfCkn+g==
X-Google-Smtp-Source: ABdhPJztheMq4wek6bjRE3pjaXONWrS9xUmr/9I9m7eTyIKBdd/Pf3LX+0fKpge8zSFiJoMiStN2DF6ez48eaGwGgmtFAw==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:2bac:a878:d06e:e354])
 (user=brendanhiggins job=sendgmr) by 2002:a25:2106:0:b0:64b:2295:33a9 with
 SMTP id h6-20020a252106000000b0064b229533a9mr8834429ybh.289.1652315438880;
 Wed, 11 May 2022 17:30:38 -0700 (PDT)
Date:   Wed, 11 May 2022 17:30:26 -0700
Message-Id: <20220512003026.3413497-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v1] kunit: tool: update riscv QEMU config with new serial dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The config for the serial console for riscv,
CONFIG_SERIAL_EARLYCON_RISCV_SBI, added a dependency,
CONFIG_RISCV_SBI_V01, at some point, so add that in to the base arch
config.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/qemu_configs/riscv.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
index 9e528087cd7c..a7a4ab8093b1 100644
--- a/tools/testing/kunit/qemu_configs/riscv.py
+++ b/tools/testing/kunit/qemu_configs/riscv.py
@@ -21,6 +21,7 @@ CONFIG_SOC_VIRT=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_RISCV_SBI_V01=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
 			   qemu_arch='riscv64',
 			   kernel_path='arch/riscv/boot/Image',

base-commit: feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
-- 
2.36.0.550.gb090851708-goog

