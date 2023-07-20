Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC875AD4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGTLrk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjGTLrh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:47:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783FAE4C;
        Thu, 20 Jul 2023 04:47:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6862842a028so422414b3a.0;
        Thu, 20 Jul 2023 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689853656; x=1690458456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSF6S+UOyj9oNfC0MJh489ttKCJmHxLthvR3b7uPlOk=;
        b=aQmt55SMNkO7Bt5Ze+Zhr09RbdVTYlRZgISvQULiN8aQkyWghnSHznynuNoKz6gsn8
         NFXsrzwUEXz8iNO6lTMVl+jVTsDosgM2irByooN1uSPKfEo1t4tXkUDGv6qQIgvzXGCo
         9kTxXoT1+9wGu9GFzQEBcKPBYeZej0gCBI7d3a7z23jHMyvJ53v2OACETyRbYO+vIXkB
         dCw4Z1/+63CHbYVr77K0QDX8e9hiDCk0GEvgWHHsIimMrvxis5rsau4OXdJCQoNXW+JJ
         542sH6Df4CLUSbh/H+DRRr5xAFvIVeCHkRlgNEpznK9KDHYPiXgOIheyyeCN6W5atKm9
         IoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689853656; x=1690458456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSF6S+UOyj9oNfC0MJh489ttKCJmHxLthvR3b7uPlOk=;
        b=IWKwcEd77pWBlevyTSbxMOZZ04Lpy+AQ80Ez9BdX/Q1K4qx84mKSd/zFXjcd7zrWJD
         vnQfor4ilNm4K7Owtbljb+4fnLVLiQdH80qbjB4ip6CcBbVzb2Nlf4OBnvA7yfmjWJE7
         G0n6NmX6maxGMumkaCqv5cRnkMbmMYd5PSClJhWhvk7cBjpJ3H4yR5iHNxyPc0fZiStX
         NnPd0ygGPOKgrFR/1lzsGOFNFSxMPtzkNbAzTOEw7nNxjTgPdncwZouCD6Fls86lmBoy
         WEcs497fGInRT5SoZeUfnNlozYlaUPft3Dxvs8AN6zRWBIBEavlieBFGmx1LAc80R8cR
         9DtQ==
X-Gm-Message-State: ABy/qLY6BYno3qK7JhCCUoWwGfLqkP62QvUHNwYJ43vdzTnpLgwdBrVr
        Gtk+gwzG2TCKXZX6Ki528TY=
X-Google-Smtp-Source: APBJJlE1vwO7JvaQF1kaLXRw7jO2jBt4xswxJcRk0MoZuDLuYD0Hc/MpW0zKIT02aiix4OXl6jDtzQ==
X-Received: by 2002:a05:6a20:4308:b0:122:ff52:7331 with SMTP id h8-20020a056a20430800b00122ff527331mr5455249pzk.52.1689853655870;
        Thu, 20 Jul 2023 04:47:35 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id u22-20020a170902a61600b001b2069072ccsm1164007plq.18.2023.07.20.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:47:35 -0700 (PDT)
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
Subject: [PATCH v5 1/6] KVM: selftests: Add x86 properties for Intel PMU in processor.h
Date:   Thu, 20 Jul 2023 19:47:09 +0800
Message-Id: <20230720114714.34079-2-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720114714.34079-1-cloudliang@tencent.com>
References: <20230720114714.34079-1-cloudliang@tencent.com>
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

Add x86 properties for Intel PMU so that tests don't have to manually
retrieve the correct CPUID leaf+register, and so that the resulting code
is self-documenting.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index aa434c8f19c5..5cb7df74d0b1 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -239,7 +239,12 @@ struct kvm_x86_cpu_property {
 #define X86_PROPERTY_MAX_BASIC_LEAF		KVM_X86_CPU_PROPERTY(0, 0, EAX, 0, 31)
 #define X86_PROPERTY_PMU_VERSION		KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 0, 7)
 #define X86_PROPERTY_PMU_NR_GP_COUNTERS		KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 8, 15)
+#define X86_PROPERTY_PMU_GP_COUNTERS_BIT_WIDTH	KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 23, 16)
 #define X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH	KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 24, 31)
+#define X86_PROPERTY_PMU_EVENTS_MASK		KVM_X86_CPU_PROPERTY(0xa, 0, EBX, 0, 7)
+#define X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK	KVM_X86_CPU_PROPERTY(0xa, 0, ECX, 0, 31)
+#define X86_PROPERTY_PMU_NR_FIXED_COUNTERS	KVM_X86_CPU_PROPERTY(0xa, 0, EDX, 0, 4)
+#define X86_PROPERTY_PMU_FIXED_COUNTERS_BIT_WIDTH	KVM_X86_CPU_PROPERTY(0xa, 0, EDX, 0, 4)
 
 #define X86_PROPERTY_SUPPORTED_XCR0_LO		KVM_X86_CPU_PROPERTY(0xd,  0, EAX,  0, 31)
 #define X86_PROPERTY_XSTATE_MAX_SIZE_XCR0	KVM_X86_CPU_PROPERTY(0xd,  0, EBX,  0, 31)
-- 
2.39.3

