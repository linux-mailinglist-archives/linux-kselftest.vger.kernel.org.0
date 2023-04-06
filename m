Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA86D9117
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 10:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjDFIDB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 04:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbjDFICj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 04:02:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D736E86B1;
        Thu,  6 Apr 2023 01:02:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l12so38583663wrm.10;
        Thu, 06 Apr 2023 01:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680768149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aV1ZnUUJLqxOvx3H0XRFtDasoGMKHSB5Y7fc9UvZtzk=;
        b=YgAI2RKmmfNtFPE/EL3tY0mL4x4CM1XeV17+kFv+MwARKdbfDenoKaze/zdW1ShSez
         4n9nQmcyv9Wm8Om/THcxFYGjdNVr8TQ63gFwBT3zhS1V+YvR7C4TWRsSv5hDmiesos1r
         vHJ6Yk6rr+3LhneR3H2GCBqoRiJlvGn32SrrRhsWei72mN48CrOH766Ty2ApW+7FRSQg
         X3VGA7dS47sideSdlPoLAXNoN5lEDQ9KKc+06Iky+TgJPQyBSdjNC8TJsxT4y+r2jIQT
         RhN1SqAZlfj4CSG+T/XMW0CDZG/vL96vm09vw0FNrS5+kiGdvRWeOfDONaQgB6meiOWM
         Jy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aV1ZnUUJLqxOvx3H0XRFtDasoGMKHSB5Y7fc9UvZtzk=;
        b=Nmj3wDTV2Eyjl3GRJ1TFKrm8+NtElUdXZ/ljak0VCU+UgAf7b2x/EGn+LRUA5K6uEz
         c5r407WVlu3iEVU2IF984ESgMyrQlCPaA/012OxqxHCyEndcZlifyn7F38xPokeWYz2U
         yfiaVh+AXqTuo+dS0VVtWkgh3/EsKZmQNWH6mXYE8fhIMgJoOTxw63lCfOSFgnr/6dOf
         moy2tk+wct/LT5p80Xf3jv3GeW2wavhLKhSJg6SfrJ42BfX7ZxNaH8l/bbCOxQsMTFS/
         bcTz53C/3MlCPFtojjLKw+ybTOlJIjIz7wkzWGPaDz+y7whgb9Ea3u4J6VJhmssBFIew
         fAsw==
X-Gm-Message-State: AAQBX9eOw1r5DBOtpbsD5GfGxSaiDL1GvLKuS3Ec6yeycl8gkyuUSUgF
        i8OoEU691SthZrIapxVmPKM=
X-Google-Smtp-Source: AKy350b9h7ZEL2DRsB2Pm+8XOYlemA64X3N8kveF+ecbq572GltkKa28E4U1bJN1sMSfw1pXKqN7ug==
X-Received: by 2002:a5d:4950:0:b0:2ce:fd37:9392 with SMTP id r16-20020a5d4950000000b002cefd379392mr5485266wrs.45.1680768148950;
        Thu, 06 Apr 2023 01:02:28 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b14-20020adfde0e000000b002d1bfe3269esm1008601wrm.59.2023.04.06.01.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:02:28 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: selftests: Fix spelling mistake "KVM_HYPERCAL_EXIT_SMC" -> "KVM_HYPERCALL_EXIT_SMC"
Date:   Thu,  6 Apr 2023 09:02:26 +0100
Message-Id: <20230406080226.122955-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in a test assert message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/aarch64/smccc_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/smccc_filter.c b/tools/testing/selftests/kvm/aarch64/smccc_filter.c
index 0f9db0641847..82650313451a 100644
--- a/tools/testing/selftests/kvm/aarch64/smccc_filter.c
+++ b/tools/testing/selftests/kvm/aarch64/smccc_filter.c
@@ -211,7 +211,7 @@ static void expect_call_fwd_to_user(struct kvm_vcpu *vcpu, uint32_t func_id,
 			    "KVM_HYPERCALL_EXIT_SMC is not set");
 	else
 		TEST_ASSERT(!(run->hypercall.flags & KVM_HYPERCALL_EXIT_SMC),
-			    "KVM_HYPERCAL_EXIT_SMC is set");
+			    "KVM_HYPERCALL_EXIT_SMC is set");
 }
 
 /* SMCCC calls forwarded to userspace cause KVM_EXIT_HYPERCALL exits */
-- 
2.30.2

