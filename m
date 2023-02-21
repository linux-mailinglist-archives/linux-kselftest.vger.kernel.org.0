Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB269E4C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjBUQh3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjBUQhW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:22 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749E02CC48
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:21 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u15-20020a17090341cf00b0019af23e69dcso2386879ple.19
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CDOmnOlE8Y16AZivwv4VrFjTYze8Lvbli++k4cFr8iw=;
        b=PAhlZ3TH/qi87Rr35Iq03hgqMaNyTkBefespOAIKOR/aUKjLdJ5kjRUHll7B1SOPRP
         caqMqqEaoONZstLTVWne2rgdF7JqpXohyWkg8KiM6ga+4pg31UD/3Cy1IV4e153IF8O4
         CTbMT7hYH07pc+exh90qXksXCE7KWlUOajHS6W/SoG+BtS0ENgjnEFBKI8GM2EdZ/uai
         2nkqhBr70racrzPMN0lpvzrhC6P7WB50lH5b8H2C53mPkX3xwEBdoCMPyHV1JWUM5FSV
         sHoE4/Zem+o5Bb4PpV672rHwIQ7Ggdn1D+8Qorn7Dfozq/9s3VP+OVk4vc93j+4aUypw
         kTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDOmnOlE8Y16AZivwv4VrFjTYze8Lvbli++k4cFr8iw=;
        b=OrCoiFcC4vhfLRSiFtHa3YDVnY/1JqRMLCkaG/SYa5d401lrJ80mwdY3XzItNeSITn
         aLPeiQouEMSc6aeDWmX/0pSRWkZ0iwFj9Fdm5LItvrqY6xWLz8QkNxXCEQDNr/Ju0Lbo
         fKgBBHOBXxV/w2S0aGpXloiwJQDvfZhVLy731/EnHFoN2rxdWN23eL7FxBPBaQknoFXy
         x5tyCJjI6r4kpJpXsJn2IKSn4DRdijdKUuGe7Qg9+YpIqLYJwYcbF28tSFppG0bpawxc
         YP9PEGeIzdIPl2LwJVu6Rp84Gr02UHD1Sh6zj6NuYzMczW4E8zTBFZpl9HTBFoy5Z+MZ
         t6RQ==
X-Gm-Message-State: AO0yUKUV1qeA8n56zMLvr//bJ+DRP+ojzncemkwZW+QqU69M2lpmDX/y
        2mOt6FmJ/4iM7+VW9P+nvnKHUfGVaint
X-Google-Smtp-Source: AK7set9AbFU6MwOpGnqsU4KVjGfpEIXXqS1rDAeVKZ15ImsolzbD3XEA4itgbEXg6SUnKjup0K78dciNs0gt
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:903:2651:b0:19b:8cbb:30fe with SMTP id
 je17-20020a170903265100b0019b8cbb30femr708174plb.13.1676997440971; Tue, 21
 Feb 2023 08:37:20 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:44 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-3-mizhang@google.com>
Subject: [PATCH v3 02/13] KVM: selftests: x86: Add a working xstate data structure
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

Add a working xstate data structure for the usage of AMX and potential
future usage on other xstate components. AMX selftest requires checking
both the xstate_bv and xcomp_bv. Existing code relies on pointer
arithmetics to fetch xstate_bv and does not support xcomp_bv.

So, add a working xstate data structure into processor.h for x86.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 12 +++++++
 tools/testing/selftests/kvm/x86_64/amx_test.c | 36 ++++++-------------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index b1a31de7108a..5cfd7ef40d78 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -45,6 +45,18 @@
 #define X86_CR4_SMAP		(1ul << 21)
 #define X86_CR4_PKE		(1ul << 22)
 
+struct xstate_header {
+	u64				xstate_bv;
+	u64				xcomp_bv;
+	u64				reserved[6];
+} __attribute__((packed));
+
+struct xstate {
+	u8				i387[512];
+	struct xstate_header		header;
+	u8				extended_state_area[0];
+} __attribute__ ((packed, aligned (64)));
+
 /* Note, these are ordered alphabetically to match kvm_cpuid_entry2.  Eww. */
 enum cpuid_output_regs {
 	KVM_CPUID_EAX,
diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index bd72c6eb3b67..bb9dc0008f43 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -41,10 +41,6 @@
 
 #define XSAVE_HDR_OFFSET		512
 
-struct xsave_data {
-	u8 area[XSAVE_SIZE];
-} __aligned(64);
-
 struct tile_config {
 	u8  palette_id;
 	u8  start_row;
@@ -103,13 +99,13 @@ static inline void __tilerelease(void)
 	asm volatile(".byte 0xc4, 0xe2, 0x78, 0x49, 0xc0" ::);
 }
 
-static inline void __xsavec(struct xsave_data *data, uint64_t rfbm)
+static inline void __xsavec(struct xstate *xstate, uint64_t rfbm)
 {
 	uint32_t rfbm_lo = rfbm;
 	uint32_t rfbm_hi = rfbm >> 32;
 
 	asm volatile("xsavec (%%rdi)"
-		     : : "D" (data), "a" (rfbm_lo), "d" (rfbm_hi)
+		     : : "D" (xstate), "a" (rfbm_lo), "d" (rfbm_hi)
 		     : "memory");
 }
 
@@ -158,16 +154,6 @@ static void set_tilecfg(struct tile_config *cfg)
 	}
 }
 
-static void set_xstatebv(void *data, uint64_t bv)
-{
-	*(uint64_t *)(data + XSAVE_HDR_OFFSET) = bv;
-}
-
-static u64 get_xstatebv(void *data)
-{
-	return *(u64 *)(data + XSAVE_HDR_OFFSET);
-}
-
 static void init_regs(void)
 {
 	uint64_t cr4, xcr0;
@@ -184,7 +170,7 @@ static void init_regs(void)
 
 static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 						    struct tile_data *tiledata,
-						    struct xsave_data *xsave_data)
+						    struct xstate *xstate)
 {
 	init_regs();
 	check_cpuid_xsave();
@@ -205,9 +191,9 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 	__tilerelease();
 	GUEST_SYNC(5);
 	/* bit 18 not in the XCOMP_BV after xsavec() */
-	set_xstatebv(xsave_data, XFEATURE_MASK_XTILEDATA);
-	__xsavec(xsave_data, XFEATURE_MASK_XTILEDATA);
-	GUEST_ASSERT((get_xstatebv(xsave_data) & XFEATURE_MASK_XTILEDATA) == 0);
+	xstate->header.xstate_bv = XFEATURE_MASK_XTILEDATA;
+	__xsavec(xstate, XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILEDATA));
 
 	/* xfd=0x40000, disable amx tiledata */
 	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILEDATA);
@@ -244,7 +230,7 @@ int main(int argc, char *argv[])
 	struct kvm_run *run;
 	struct kvm_x86_state *state;
 	int xsave_restore_size;
-	vm_vaddr_t amx_cfg, tiledata, xsavedata;
+	vm_vaddr_t amx_cfg, tiledata, xstate;
 	struct ucall uc;
 	u32 amx_offset;
 	int stage, ret;
@@ -284,10 +270,10 @@ int main(int argc, char *argv[])
 	tiledata = vm_vaddr_alloc_pages(vm, 2);
 	memset(addr_gva2hva(vm, tiledata), rand() | 1, 2 * getpagesize());
 
-	/* xsave data for guest_code */
-	xsavedata = vm_vaddr_alloc_pages(vm, 3);
-	memset(addr_gva2hva(vm, xsavedata), 0, 3 * getpagesize());
-	vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xsavedata);
+	/* XSAVE state for guest_code */
+	xstate = vm_vaddr_alloc_pages(vm, DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));
+	memset(addr_gva2hva(vm, xstate), 0, PAGE_SIZE * DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));
+	vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xstate);
 
 	for (stage = 1; ; stage++) {
 		vcpu_run(vcpu);
-- 
2.39.2.637.g21b0678d19-goog

