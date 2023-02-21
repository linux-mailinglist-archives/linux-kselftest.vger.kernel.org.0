Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0744069E4E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjBUQiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjBUQiD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:38:03 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533E92CFD2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:40 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id cl18-20020a17090af69200b0023470d96ae6so1952553pjb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V/DDoXnf2opyFk/JIknDREbRoogTSxKXRqdxFHEiFI8=;
        b=azZPMaZPqkrP+aRIze5KyWBJigIWuhR7vtvT2AIX7QbIONV/SEZfaTC3RTMNBJ/gmU
         WYfczP8dXkhdM244WOARnjbjac48VMe8eRTwD7rTm6azex04IDUSY5aK7pYJUH5Q9fSQ
         cAuHVy840VC+14rudyO4RSecU0L00tAeBdKtH7NcPLH8GxDkvp1xvPKlLwmrkMt57oNf
         sBPRwczKUdtLW4cbVPp72zxUCHV+SKGOro4n/9T6lq8U5i6fhwmfhXtLw29/sNy2c/G6
         ful7j4FyU0Ce4ymO3+jQVgWQIIwUy0pocwJ+mztGJ2ZXd0XKM3AY0LmeezohXhHHMwUK
         vnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/DDoXnf2opyFk/JIknDREbRoogTSxKXRqdxFHEiFI8=;
        b=2bXw2VvZdwyQWEbJeKXgpA8J3bXf9G+5ciQXbkRK+CEI2DQC4nSNKbsrnFQakWcSf1
         GQEbLGHqzLw/15+ahnzWW9elI6T1z+jhpaVQMe4QNrrIwiJ+aiATx7mwIURwYw4CcnDO
         kZxjUcbRN+BhQEdGz9jTnqMCQDiqFae+whKXNEwza7Imioac5VZ3Sa6AAegbvM0LIbcv
         OawK2bUjwRcKpfWv0VEvlKhxtO49x0WEbRxh3+MK8Pmmegn3pmRdfKrs7Y7V/18jJk84
         Ih0+vHJoBJFkRjtG9TGYNkpvcg48PQ3t5ntecOeb5VeaD7wbb/YaIRwYY9ksjdZQWAGy
         Cm4Q==
X-Gm-Message-State: AO0yUKVckk+cnuiIJI5MKVu881DUpHu0JWUt3Y078dzdR0SgOky/Ca8b
        QzfpB29DW+VytcVle4S7H+qPy5jB1bFE
X-Google-Smtp-Source: AK7set+uCt7SuZB25GG76skCLbvVlwbw3NDGyd+ph4vafj6zCKa42RtEONl+cA12mbmKCbURNFSBFoNJic7t
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a63:77c1:0:b0:4fc:27da:54a5 with SMTP id
 s184-20020a6377c1000000b004fc27da54a5mr681202pgc.1.1676997459042; Tue, 21 Feb
 2023 08:37:39 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:54 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-13-mizhang@google.com>
Subject: [PATCH v3 12/13] KVM: selftests: x86: Check that the palette table
 exists before using it
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Aaron Lewis <aaronlewis@google.com>

Check that the palette table exists before using it. The maximum number of
AMX palette tables is enumerated by CPUID.1DH:EAX. Assert that the palette
used in amx_test, CPUID.1DH.1H, does not exceed that maximum.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 1 +
 tools/testing/selftests/kvm/x86_64/amx_test.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 5cfd7ef40d78..a6a86c41ed75 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -223,6 +223,7 @@ struct kvm_x86_cpu_property {
 #define X86_PROPERTY_XSTATE_MAX_SIZE		KVM_X86_CPU_PROPERTY(0xd,  0, ECX,  0, 31)
 #define X86_PROPERTY_XSTATE_TILE_SIZE		KVM_X86_CPU_PROPERTY(0xd, 18, EAX,  0, 31)
 #define X86_PROPERTY_XSTATE_TILE_OFFSET		KVM_X86_CPU_PROPERTY(0xd, 18, EBX,  0, 31)
+#define X86_PROPERTY_AMX_MAX_PALETTE_TABLES	KVM_X86_CPU_PROPERTY(0x1d, 0, EAX,  0, 31)
 #define X86_PROPERTY_AMX_TOTAL_TILE_BYTES	KVM_X86_CPU_PROPERTY(0x1d, 1, EAX,  0, 15)
 #define X86_PROPERTY_AMX_BYTES_PER_TILE		KVM_X86_CPU_PROPERTY(0x1d, 1, EAX, 16, 31)
 #define X86_PROPERTY_AMX_BYTES_PER_ROW		KVM_X86_CPU_PROPERTY(0x1d, 1, EBX, 0,  15)
diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index deacd21cf744..2fd6a8a928d9 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -30,6 +30,7 @@
 #define XSAVE_SIZE			((NUM_TILES * TILE_SIZE) + PAGE_SIZE)
 
 /* Tile configuration associated: */
+#define PALETTE_TABLE_INDEX		1
 #define MAX_TILES			16
 #define RESERVED_BYTES			14
 
@@ -120,6 +121,10 @@ static void check_xtile_info(void)
 	GUEST_ASSERT(xtile.xsave_size == 8192);
 	GUEST_ASSERT(sizeof(struct tile_data) >= xtile.xsave_size);
 
+	GUEST_ASSERT(this_cpu_has_p(X86_PROPERTY_AMX_MAX_PALETTE_TABLES));
+	GUEST_ASSERT(this_cpu_property(X86_PROPERTY_AMX_MAX_PALETTE_TABLES) >=
+		     PALETTE_TABLE_INDEX);
+
 	GUEST_ASSERT(this_cpu_has_p(X86_PROPERTY_AMX_NR_TILE_REGS));
 	xtile.max_names = this_cpu_property(X86_PROPERTY_AMX_NR_TILE_REGS);
 	GUEST_ASSERT(xtile.max_names == 8);
-- 
2.39.2.637.g21b0678d19-goog

