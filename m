Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8523E57CACB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 14:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiGUMm6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiGUMm5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 08:42:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762A31360;
        Thu, 21 Jul 2022 05:42:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so769325wmo.0;
        Thu, 21 Jul 2022 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRTXV8cFbW+efzv2SDGshel6YzEMdaNUonQxjNrbvZU=;
        b=T6ob61YTom7vlfUnFmhWrjAqhdPz0vmm68x0CCl5LtFfTPXLKgDDNDEzh4hkd4I4jf
         PsfPpeapUSi8Ltp8VpZrBMdbVSqCtzD9zZakVr4xA1Mrbih2AODK83SEHUv9VXDQvJMN
         jOn5JANek/7KPEfkYrXhENw/kOcJ48lTem7YnXgzACp/Bc4B5Y18Dm+47jWbMwFrQ7Ul
         2Bd2Zosp2b2eWW8kaij0N8UYOf+pDmxbnd12GqU7VzSkiHzAT8SV4SdWj4gqEClb7h0q
         /uh10sHc8x230wPG2yFxjEuFt0dOV6C8IplGhzqk7naZDg1gvCf3INGGuQ8fzfPNWG4X
         KPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRTXV8cFbW+efzv2SDGshel6YzEMdaNUonQxjNrbvZU=;
        b=fXi5LsN+xZS7NyDYKXZ3+V5ssInmkc28a3T7ncTiDQaXajzC/5RJtz3ik1V/NQVVDx
         mA7Mv11gt5+mIdaZjKjNZenIOBbcqPTEV9raPPkUPjXs5a1aSgxncgiFJIfmFCNYLATn
         LzlVSl4E8MXhKyv+Re8WEoThecIjSvVNXCXWEwz2tyac/7KmZbn8l0zwlZrQbz7BXC4O
         eKNVy4a+ir7rHRwSDU8BO4TAqb1qx2Oj11bE0zWK2hk20mGbh6I7Vdbd2Yy+fTPqa97M
         4vwY59ABMjT52rXJeeofIc0Wr1uGEI/4CKMEZILBshH9cS/o+aIF5TOGs+1r6dIVe0Pq
         eDkg==
X-Gm-Message-State: AJIora8gCSmpD7i3GK2Z9w8FVEC+M2IMsvlBGxEyugwrz5WGE+cfES+g
        qYiIhRLKErFwjvst1YK2b43vJazvyc4yByBl
X-Google-Smtp-Source: AGRyM1tJwSY/A09DmSchBJIT4wiX1XFryLNpHwfK/rwkOCkLDE4DgCI032Bqj20lXmJuqcr/5rmddg==
X-Received: by 2002:a1c:3541:0:b0:3a2:e2e2:d80e with SMTP id c62-20020a1c3541000000b003a2e2e2d80emr8186393wma.184.1658407375060;
        Thu, 21 Jul 2022 05:42:55 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b003a3199c243bsm8170348wmq.0.2022.07.21.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:42:54 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: selftests: Fix spelling mistake "mismtach" -> "mismatch"
Date:   Thu, 21 Jul 2022 13:42:53 +0100
Message-Id: <20220721124253.20823-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in an assert message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/x86_64/cpuid_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
index a6aeee2e62e4..c85113d1aeb2 100644
--- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
@@ -93,7 +93,7 @@ static void compare_cpuids(const struct kvm_cpuid2 *cpuid1,
 
 		TEST_ASSERT(e1->function == e2->function &&
 			    e1->index == e2->index && e1->flags == e2->flags,
-			    "CPUID entries[%d] mismtach: 0x%x.%d.%x vs. 0x%x.%d.%x\n",
+			    "CPUID entries[%d] mismatch: 0x%x.%d.%x vs. 0x%x.%d.%x\n",
 			    i, e1->function, e1->index, e1->flags,
 			    e2->function, e2->index, e2->flags);
 
-- 
2.35.3

