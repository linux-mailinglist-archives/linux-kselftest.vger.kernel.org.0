Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E53755B75
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 08:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjGQGYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 02:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjGQGYH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 02:24:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE510CC;
        Sun, 16 Jul 2023 23:24:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso2452516b3a.3;
        Sun, 16 Jul 2023 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689575041; x=1692167041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stqHzkq7kigcMhRBDly6DL6DHAf258g1j0/ov6PXdGE=;
        b=SfpdvFolwH0JYP/J1qiauZHPhImaAXaGzYP/cc2qCXNmM+m4zuGijaCDU1/NWddsDD
         olUr7TqXnrHTaLPmkJ+bUFz+Y1A4WTPIr35BjuOpjxdVoxtOtiH6Blr2d+vUIjGYV9/L
         b1smx1lrM3jPyGvV3epCQwNIae50lE5rc+pxLsD6lS3i7lx746p3oAyJRy0iZAlfmSo6
         uEXtVRepsdtaHm0C/FKIVIRmI48/q4laoJXriJO4xE14gL1g/QOAs3XhkbZVgmbSs9ii
         iB8rXVn/PArb9UAw0xNwhK5Qb/pKlEE6D8m+aAbdeUmCnTvhyaKM+EOHZe5VO+IwJPNz
         UJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689575041; x=1692167041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stqHzkq7kigcMhRBDly6DL6DHAf258g1j0/ov6PXdGE=;
        b=kFCu7nAArgTaLcy5qeqYaUh0hSea+6zH9iHSHygfdQ/1l7r1OZeCVkX/WfYV0Pfzpn
         WC5veYvrNJv2bXrzqK7C/tE588cUDQ+y5NEymnm4G7H/pJqA5HiCiYkB/eXX3A7lbZEi
         CUqDNQKh3THhzyg3+3AC4INgseX5Rg2gLlJgMF59+ozIOrLRKPiVmdUahNivYRL0DsxB
         FbiXplWsyXpsrd9VSCGhKUxK37aZjDhWrstYAOCCcB6LSi6RCquQ1yk+JtGUTm2pw5eZ
         yk2OXk1SADzRSoIwKAp3dPppRl9ZSb560CUiRbgxtseHc3DZX5LrfgcmsdoUHt9exgEE
         4RmA==
X-Gm-Message-State: ABy/qLbPlrdqBzsxfX/lztflJfEWKuk62fzfS2zTXf+H6XxbJr0alE/v
        HrU4PzdaIrZ+XwqQwHec7Vg=
X-Google-Smtp-Source: APBJJlF+X1lFnaQ0WkL3Hs3J6Jxd1SirmIbzJTagavxfJ8ocpuO8hVifSG+IDepGloqy6Ee4FojYWg==
X-Received: by 2002:a05:6a20:841a:b0:12c:f124:5b72 with SMTP id c26-20020a056a20841a00b0012cf1245b72mr10556237pzd.43.1689575041559;
        Sun, 16 Jul 2023 23:24:01 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b9ff5aa2e7sm9555716plt.239.2023.07.16.23.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:24:01 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] KVM: selftests: Add macros for fixed counters in processor.h
Date:   Mon, 17 Jul 2023 14:23:38 +0800
Message-Id: <20230717062343.3743-2-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717062343.3743-1-cloudliang@tencent.com>
References: <20230717062343.3743-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add x86 properties for the number of PMU fixed counters and the bitmask
that allows for "discontiguous" fixed counters so that tests don't have
to manually retrieve the correct CPUID leaf+register, and so that the
resulting code is self-documenting.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index aa434c8f19c5..15331abf063b 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -240,6 +240,8 @@ struct kvm_x86_cpu_property {
 #define X86_PROPERTY_PMU_VERSION		KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 0, 7)
 #define X86_PROPERTY_PMU_NR_GP_COUNTERS		KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 8, 15)
 #define X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH	KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 24, 31)
+#define X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK	KVM_X86_CPU_PROPERTY(0xa, 0, ECX, 0, 31)
+#define X86_PROPERTY_PMU_NR_FIXED_COUNTERS	KVM_X86_CPU_PROPERTY(0xa, 0, EDX, 0, 4)
 
 #define X86_PROPERTY_SUPPORTED_XCR0_LO		KVM_X86_CPU_PROPERTY(0xd,  0, EAX,  0, 31)
 #define X86_PROPERTY_XSTATE_MAX_SIZE_XCR0	KVM_X86_CPU_PROPERTY(0xd,  0, EBX,  0, 31)
-- 
2.39.3

