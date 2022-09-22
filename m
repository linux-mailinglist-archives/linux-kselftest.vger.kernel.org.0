Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35BE5E5D95
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 10:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiIVIgb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 04:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiIVIga (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 04:36:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCADA61D1;
        Thu, 22 Sep 2022 01:36:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id c7so8432201pgt.11;
        Thu, 22 Sep 2022 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MhRarJ6HsClW27b7vtuGGO9+1qjL4ewcJiYtQp85NVs=;
        b=PupQ1VxaalBQAbhKNzbtAp0aIhcecxHqTumsawCvdkP4elLO+RYGH0ybVsanFd5sIX
         mmEqUFLUXcybEAKVaOPAr+KdXlORbLX4DOCGO0/siKbxw4UgzygAAV73hGyXt6UGRvoD
         qWqmI0K3gGelI+TD3fxNbdhas53GDkJNvA9Qiq2HfmXLy5jy+Fo92DvQyEAx/y+E0mYy
         opg2pA8aNRd+OHsrxx8EoqHD0P6uwxXgFwSqtpyuGeiFZBA+ni1zn0VJsDlmgCoxmE88
         Om8rh1QFhLnDtSIs8eQM3gbl6ualXSf52fKJZQAspuSeLz02nyy18bA6YHWRifMcYzbi
         9tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MhRarJ6HsClW27b7vtuGGO9+1qjL4ewcJiYtQp85NVs=;
        b=lVQR1nUwp0EXcavXNPr9K9jZGoBXUIGA+sqDBPAn9ptU1A/N//XS24uF484ffYeqOl
         1eWbKDreBeiniSMTCxRpeSbJbuwVuAPJXpzj/bHqaKbtNESY0ScNqDhmhGWoKwInREzb
         ddrnUOvibyNfZ8riuTDG0BfrsFGDif914IV1gMObt5WzrJmidQIAYkOjz3IS29hdaLt0
         ioPl4r8djEYpd+c18lWZkmzsYrwYGUvm2xoQr1jTkFhUAZwHg+eQTRbpd1b0rMazXiI+
         MwozDXBwr3r1CfXXSuIDGJUk6LBk/dixzSRoj52skdi02q40sRJXCw0tuqc6xrzH76vb
         yjdg==
X-Gm-Message-State: ACrzQf0FFBcfTedKklJ9ozFtSS4GdBDqQjGraAeTUohent0mrzeZFe4q
        HiuJVUEeDScaG/J7YN3jPTE=
X-Google-Smtp-Source: AMsMyM6mk+Yf7RFgk2KXxVPzP22QjA+djcokpAoyZFs5lc3NU+vZL0sr3+rtx+PSS7EDWQBPGRebZQ==
X-Received: by 2002:a63:a501:0:b0:434:ff77:1fda with SMTP id n1-20020a63a501000000b00434ff771fdamr2131551pgf.310.1663835788995;
        Thu, 22 Sep 2022 01:36:28 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b00543a098a6ffsm3631338pfk.212.2022.09.22.01.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:36:28 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     brendan.higgins@linux.dev
Cc:     davidgow@google.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, skhan@linuxfoundation.org,
        dlatypov@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] kunit: tool: use absolute path for wget
Date:   Thu, 22 Sep 2022 08:36:11 +0000
Message-Id: <20220922083610.235936-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Xu Panda <xu.panda@zte.com.cn>

Not using absolute path when invoking wget can lead to serious
security issues.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 tools/testing/kunit/qemu_configs/riscv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
index 6207be146d26..c3dcd654ca15 100644
--- a/tools/testing/kunit/qemu_configs/riscv.py
+++ b/tools/testing/kunit/qemu_configs/riscv.py
@@ -11,7 +11,7 @@ if not os.path.isfile(OPENSBI_FILE):
              'Would you like me to download it for you from:\n' + GITHUB_OPENSBI_URL + ' ?\n')
        response = input('yes/[no]: ')
        if response.strip() == 'yes':
-               os.system('wget ' + GITHUB_OPENSBI_URL)
+               os.system('/usr/bin/wget ' + GITHUB_OPENSBI_URL)
        else:
                sys.exit()

-- 
2.15.2
