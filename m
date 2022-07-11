Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE40E570849
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiGKQ1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiGKQ1V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 12:27:21 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE13F7A51A
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 09:27:19 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id e21-20020aa78c55000000b00528c6cca624so1165716pfd.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AI9VSSKfUAJq0F0wpBlSk+XMmmCJHlZ66YlR5SdU9/E=;
        b=XJOCF2hjgEIcyyljemwSCUCMLBCUcdXfpNhAGEaRJo4ZkAyIVFf/3TmKTSjcaSXMok
         /7FQb3FItAL26+kPYU57KJI9K3JSENx6e3ZEJW5u1Xqfyu0cuh4xyB08qXcDxmugdRam
         Igto/4zjQPVWFynrSOICpblUhiSxo1O32ZoyZd8F0sg6pm/NSHjMwKtH7DNlVptQT+xQ
         UP6dg8fGoQr/5u4FK9I4OBeZaTWr8M6hG0dldMhS7s7VrPWjX0Rolspmvh/KF1I86aVU
         j21VKFmEaTf2O94gvBl3Be0w73GLkfS/+aAd/hd1J19oJGK0Fwwutq1hdIQiDGXW6cI5
         dF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AI9VSSKfUAJq0F0wpBlSk+XMmmCJHlZ66YlR5SdU9/E=;
        b=n6lEzWOsPEwV2umRra/u9TeQHYcEeKiFReB2yx8mOKe0wXSYt3G8iDo7I0/LXSJHUD
         u8v1wEPY3ze8GkXx24KRxPYPM3FHBc6F5khmii2rJPqfTDeEITKF7akLmaSLvuMj4yFA
         CNBQbbefW9dZvG/3FhFHrGO4ndW2DYJeb4YaWnW+9knTPMGYho0RvIC4I+4+BE59xYQO
         fvSoFx82D1gdk6Gvc8sTVmXwSztIE2bGOVbWptpky1aTtK2icBt10aza2lRSkxPmuxYh
         jUaPDw/9UMS+sWlvRr/KDDRFsd1BtJ+CLM68Rtvyoletl6WLCdRFpuYUNdbohW7cVjxF
         IazA==
X-Gm-Message-State: AJIora9PlqblYaoAleuPOFkxyph3Ca5C/kSxvFQ50JojNEMXtfw9LX+Y
        RaqHBjoebOBBTpO8u6ajeMCihGdO6ONlHQ==
X-Google-Smtp-Source: AGRyM1tD/j9WRxYgHSoH/KZQ2O2qiduJtYWHUlyPQqPUyiNDItqwNNw9mPuBMggDC3CUfbX0jWbh5rwoHyUIUA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a63:710c:0:b0:40c:adcf:ce72 with SMTP id
 m12-20020a63710c000000b0040cadcfce72mr17092957pgc.310.1657556839298; Mon, 11
 Jul 2022 09:27:19 -0700 (PDT)
Date:   Mon, 11 Jul 2022 16:27:13 +0000
Message-Id: <20220711162713.2467476-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] clk: explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in .kunitconfig
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        Maxime Ripard <maxime@cerno.tech>
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

CONFIG_UML_PCI_OVER_VIRTIO=y is needed to enable CONFIG_PCI=y on UML.
However, this causes test failures when running the clk tests, i.e.
$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/clk

A snippet of the particular error is:
>     ok 1 - clk_gate_test_parent_rate
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0

This is triggered by this cast in the test:
   143          ctx->fake_mem = (void __force __iomem *)&ctx->fake_reg;
this seems to work except when logic iomem is enabled, i.e.
CONFIG_INDIRECT_IOMEM=y.

As a short-term fix, explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in
drivers/clk/.kunitconfig so we can enable it for everyone else by
default in kunit.py.

The long-term fix probably requires something more complicated, like
  #ifdef CONFIG_INDIRECT_IOMEM
    logic_iomem_add_region(...);
  #endif

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reported-by: Maxime Ripard <maxime@cerno.tech>
Tested-by: Maxime Ripard <maxime@cerno.tech>
---
Note: this targeting the -kselftest kunit branch.
There's a commit that triggers this by enabling logic iomem by default
[1] and there's also a commit that lets disable it via kunitconfig file
[2], which this fix relies on.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=6fc3a8636a7b0f7dbd6d0a4e450e765dc17518d4
[2] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=8a7c6f859a20ca36a9e3ce71662de697898c9ef5
---
 drivers/clk/.kunitconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
index cdbc7d7deba9..2fbeb71316f8 100644
--- a/drivers/clk/.kunitconfig
+++ b/drivers/clk/.kunitconfig
@@ -2,3 +2,4 @@ CONFIG_KUNIT=y
 CONFIG_COMMON_CLK=y
 CONFIG_CLK_KUNIT_TEST=y
 CONFIG_CLK_GATE_KUNIT_TEST=y
+CONFIG_UML_PCI_OVER_VIRTIO=n

base-commit: 7635778bac7e46458392c1261e3916e8e9e86860
-- 
2.37.0.rc0.161.g10f37bed90-goog

