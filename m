Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14154C3EB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 08:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiBYHGk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 02:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiBYHGk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 02:06:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199AF1E1107;
        Thu, 24 Feb 2022 23:06:09 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id cp23-20020a17090afb9700b001bbfe0fbe94so4041037pjb.3;
        Thu, 24 Feb 2022 23:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q/tCaefy/zF2YcxtAir2UFA6eKeXz41CXIJzupnqKxU=;
        b=qhXpU1j94DTo8fXZmkVOFyVNMaSOfACjEYnt5+znFJFAyYrNkSBRrABkjNjwutIT5t
         cvc7hWfP7QnMocVJbkNy+dT3uUWz9R+ezvoFG33w2H1C3Zn0a4JE52DziFsqN7oxEdFI
         donDNU5ZWSlYLa4dffD8ap01WIqUEmLWwCdzNwmkWok4MPhFKy3rrmkmdeokXhGbmuBs
         2XW9jPBDxFxEHIdNdq965xCVP9vJ2NESB+eBw8FOg6NWoWq3uzWNiugvaSfIQdRDumza
         y6LQ50OU/tqhcNJhcTrDADtf0Uq3MdBbXG5pJOB/biUUQLl9GLXjzhWDMf7z3fIg2I46
         4Bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q/tCaefy/zF2YcxtAir2UFA6eKeXz41CXIJzupnqKxU=;
        b=IEM0xADZRIavfafTbWZi5pEiq0/JU8TNiYE7jTOGZY1eFTxb4sbMGyMCjlUvY2bsYy
         qzlY0OL4Gm6noilR/6/KmcMJ6HPYJt46cgn95uFI9CpO/qnNHzaDizvZnVDvDb1FgvxN
         E2P4x7KNgU19syenVGgqTZzPaV6H7mvBok00DULKB9p4j4J38UzgfDMuwM8BTJjQiGa+
         ZY54SfF8vc5HAxbTeUC2wbT2cxrjLMmhN/mTrIBFMzpyWsDpG8X2Kqi6sI5i8scT5dDe
         0cAIAl0IHirA/qnA/hQVXER85vTq8BoCnU58To/2Bda/uk/WqAvnOaWTyiX9rL3MTxOA
         E2qw==
X-Gm-Message-State: AOAM531IoUpAQESHnc0SKjxY+aGwk2m/zb4jXJMupmwL1trtawf4UwZh
        nMhu/YeRkL2j+PbX+S5d7No=
X-Google-Smtp-Source: ABdhPJwB1i8k8yYncgvKIb1ud+vTwoPw9jzHgU7aiB5WCdFv1LaNP+W1u+1tV7Vhz7S74Dsh4NvC1w==
X-Received: by 2002:a17:90a:f505:b0:1bc:d47e:8b19 with SMTP id cs5-20020a17090af50500b001bcd47e8b19mr1862036pjb.102.1645772768569;
        Thu, 24 Feb 2022 23:06:08 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id u16-20020a056a00125000b004e1e36d4428sm1711084pfi.104.2022.02.24.23.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 23:06:08 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kvm: add hyperv_svm_test to .gitignore
Date:   Fri, 25 Feb 2022 15:05:57 +0800
Message-Id: <20220225070558.73195-1-likexu@tencent.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

From: Like Xu <likexu@tencent.com>

hyperv_svm_test's binary should be present in the .gitignore file
for the git to ignore it.

Fixes: e67bd7df28a0 ("KVM: selftests: nSVM: Add enlightened MSR-Bitmap selftest")
Signed-off-by: Like Xu <likexu@tencent.com>
---
 tools/testing/selftests/kvm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index dce7de7755e6..62f9b781545b 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -20,6 +20,7 @@
 /x86_64/hyperv_clock
 /x86_64/hyperv_cpuid
 /x86_64/hyperv_features
+/x86_64/hyperv_svm_test
 /x86_64/mmio_warning_test
 /x86_64/mmu_role_test
 /x86_64/platform_info_test
-- 
2.35.1

