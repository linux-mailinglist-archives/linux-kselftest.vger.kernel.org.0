Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A214BB3B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 08:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiBRH6b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 02:58:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiBRH63 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 02:58:29 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABCF17BCFE
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 23:58:07 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id l6-20020a170903120600b0014f43ba55f3so3233336plh.11
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 23:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j0CZufvSyGMkqIs03zWz3SOrzF5QkxrcKJyKN+3F6DU=;
        b=DnvEEpeLGT7C5chE/iFqLg1oxG7vGRUWbZEgwmeFp5/uBfxwHZ4WKh+ARdG0TZevOn
         S8V+kTXByBAPADfiBUy8qdYWtbxpPbyjuahrqoW5Y+jx4Ka3f2ix+XYBDPLErajyCmGc
         WhsTS3GeBvKSmJU24IW3jl4Eitt4U8L46TqvxavzKDg0M7fao2jGz5UhpxjTsQKN5dwB
         3pcbMsevsoyi2PABytqDtcFfB+sDZF7+PctoUcSKimkNVz6fqrYV63g+hOOmzfycxYWD
         GeQLc8fwAtfGcxSsJO76HpBCHUOMxWvmRj95XUCGtf7GYhrl8yZF035C7XUfj6JbBWPA
         VPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j0CZufvSyGMkqIs03zWz3SOrzF5QkxrcKJyKN+3F6DU=;
        b=DY7+31nNAzA6wA3quTLlHIhUv+buxBqsiMOZKI0THRW+TatxWtPhujZfrNrlf4Btmh
         0losiTFPWss/cfZA13ZRNKcglfANp+qOMK5Yyt//Q4ontWZVLuOagrYXAdi7OoxwaoMn
         LIkpu5Aot0CQzg8qLU718XywJadg2po8OLbUydn/TvB7K6YNMMdg7Oxxkmb8PntvzY1/
         xw8sVqXkT9Q90xDR1HlVE04Fc6nlTBPYA6ieno2J4G18dxnZ7gj6RwLpCIoVEoeZLf8/
         YyL0QT+RDIBrGOvAmoI701VmE4/+debBUQdU2yG0L53JQnFJ2yID0ZXpJihNVG+d6WSK
         JCsg==
X-Gm-Message-State: AOAM532gX9QYUe2Z54JiBxHqtiiDQzvVcJCn9tyInugxsrplYdsyOEfu
        UaWLHT7Vb6afMO2FvaC047ebsPsYHjv8ig==
X-Google-Smtp-Source: ABdhPJweI7iurcA3Hbq+nFlKuGo4v8cSMtTOOIZv9Y5cBs/yQBBEnAM5KLK3GgPSvT5VxuN+hAiv//qPBNXQEg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:581:b0:1b9:b85e:94df with SMTP id
 i1-20020a17090a058100b001b9b85e94dfmr7115153pji.195.1645171087194; Thu, 17
 Feb 2022 23:58:07 -0800 (PST)
Date:   Fri, 18 Feb 2022 15:57:26 +0800
In-Reply-To: <20220218075727.2737623-1-davidgow@google.com>
Message-Id: <20220218075727.2737623-4-davidgow@google.com>
Mime-Version: 1.0
References: <20220218075727.2737623-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 3/4] IB/qib: Compile under User-Mode Linux
From:   David Gow <davidgow@google.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, x86@kernel.org, felix.kuehling@amd.com,
        linux-kernel@vger.kernel.org
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

The User-Mode-Linux architecture (with the x86_64 subarch) defines
CONFIG_X86_64, but doesn't expose the cpuinfo_x86 struct (instead
there's a cpuinfo_um struct).

In order to allow UML to build with allyesconfig, only check cpuinfo_x86
on non-UML architectures.

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/infiniband/hw/qib/qib_wc_x86_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/qib/qib_wc_x86_64.c b/drivers/infiniband/hw/qib/qib_wc_x86_64.c
index edd0ddbd4481..76fef1321c26 100644
--- a/drivers/infiniband/hw/qib/qib_wc_x86_64.c
+++ b/drivers/infiniband/hw/qib/qib_wc_x86_64.c
@@ -146,5 +146,9 @@ void qib_disable_wc(struct qib_devdata *dd)
  */
 int qib_unordered_wc(void)
 {
+#ifndef CONFIG_UML
 	return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
+#else
+	return 0;
+#endif
 }
-- 
2.35.1.265.g69c8d7142f-goog

