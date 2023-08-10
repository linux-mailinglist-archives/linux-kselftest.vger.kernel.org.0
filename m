Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9158C7773C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 11:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjHJJKI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 05:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjHJJKF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 05:10:05 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A7B2123;
        Thu, 10 Aug 2023 02:10:05 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 5614622812f47-3a6f3ef3155so542291b6e.1;
        Thu, 10 Aug 2023 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691658604; x=1692263404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fZ8QJ/lFE+KqunXBF6YeESlrgzpkDcP9LFRc/q76fs=;
        b=h1COgyNE2Fnhw6y4HlZ/rn7ahGyPVZfMFZR6aQUmA1bYLiEaIaE7afeIFZMzdoMz7d
         XKSI7JFtgkNM+T4DwM6VTy9CIdDmck2YbnbWxLau5M9G+BN62iucAiSzEtPjp3d0YfHh
         aIZBjooAfDKCeS/dsgui7eF0wY70S17wp+kvglzTypz8Kw3Y+MO0CeqkkHPvq2zTl1xx
         H1Mucy51RI9AOjQKba306oGmNud0/OP9/rJCUHsbZ9EyEcSmE2n0m3YbXlyTWyXGAMcm
         q6PkTgbh9UWjJa6LLsM3sKN9skFfKe0dFuW+PxVd8nhTUSEweS79ZywXkHO2yG7ydMqn
         W2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658604; x=1692263404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fZ8QJ/lFE+KqunXBF6YeESlrgzpkDcP9LFRc/q76fs=;
        b=eiU1B+y4W1klXxCjzsDE/JeeLAhrjJ3Jdmk0CYTiO5R2d8i4yD+3i2lq1kqfgV8L41
         WAwVmrqYgH0hXGajKIfluMdRgCr3dYBqUmL8pjqBl2+75EVyBo3GuOqFs9YgPpq0k4dm
         entYBc/6G6R2PMDec078xA1b4Mhyii/aDaiG6kjWjQ9kRacPaQv0XbfTQsdxkwpJmaw9
         oCPCB/o4neOz+94zyImkMcF14Yg17M9IR9OfupqY3E2/pGC6tBxziNS/8Qq4/M/5uC81
         iWDnS2xgCftvuDGGPk3KpX585I7OWhnKQZvgKB6DEEXu1dbuVG1SN3wM8Yf1P7suLDLf
         VUHQ==
X-Gm-Message-State: AOJu0YxrxjSk6kGl3DLNIRfvwZU4H6QvwTbm2D5Sb8jREH1MSmr7YzkP
        8DpvvE2zBhpzufTFV3Jo55w=
X-Google-Smtp-Source: AGHT+IFGOfucLHi5JdWUYTTL+vg8JOMqmJ/MAHjQv0YrxzjyW9qAB+dGucj5G470Ubz/jXCrHI1V3Q==
X-Received: by 2002:a05:6808:6395:b0:3a4:3072:e597 with SMTP id ec21-20020a056808639500b003a43072e597mr1983326oib.54.1691658604433;
        Thu, 10 Aug 2023 02:10:04 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b00263154aab24sm970704pjb.57.2023.08.10.02.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:10:04 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
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
Subject: [PATCH v6 1/6] KVM: selftests: Add x86 properties for Intel PMU in processor.h
Date:   Thu, 10 Aug 2023 17:09:40 +0800
Message-Id: <20230810090945.16053-2-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810090945.16053-1-cloudliang@tencent.com>
References: <20230810090945.16053-1-cloudliang@tencent.com>
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

From: Jinrong Liang <cloudliang@tencent.com>

Add x86 properties for Intel PMU so that tests don't have to manually
retrieve the correct CPUID leaf+register, and so that the resulting code
is self-documenting.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index aa434c8f19c5..4fd042112526 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -239,7 +239,12 @@ struct kvm_x86_cpu_property {
 #define X86_PROPERTY_MAX_BASIC_LEAF		KVM_X86_CPU_PROPERTY(0, 0, EAX, 0, 31)
 #define X86_PROPERTY_PMU_VERSION		KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 0, 7)
 #define X86_PROPERTY_PMU_NR_GP_COUNTERS		KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 8, 15)
+#define X86_PROPERTY_PMU_GP_COUNTERS_BIT_WIDTH	KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 16, 23)
 #define X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH	KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 24, 31)
+#define X86_PROPERTY_PMU_EVENTS_MASK		KVM_X86_CPU_PROPERTY(0xa, 0, EBX, 0, 7)
+#define X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK	KVM_X86_CPU_PROPERTY(0xa, 0, ECX, 0, 31)
+#define X86_PROPERTY_PMU_NR_FIXED_COUNTERS	KVM_X86_CPU_PROPERTY(0xa, 0, EDX, 0, 4)
+#define X86_PROPERTY_PMU_FIXED_COUNTERS_BIT_WIDTH	KVM_X86_CPU_PROPERTY(0xa, 0, EDX, 5, 12)
 
 #define X86_PROPERTY_SUPPORTED_XCR0_LO		KVM_X86_CPU_PROPERTY(0xd,  0, EAX,  0, 31)
 #define X86_PROPERTY_XSTATE_MAX_SIZE_XCR0	KVM_X86_CPU_PROPERTY(0xd,  0, EBX,  0, 31)
-- 
2.39.3

