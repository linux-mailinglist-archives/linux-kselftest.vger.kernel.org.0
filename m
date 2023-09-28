Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875417B0FDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 02:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjI1AUK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 20:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjI1AUI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 20:20:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AD013A
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 17:20:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so18131860276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 17:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695860405; x=1696465205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4QGGNsUnXbHlm2535h1KbmRwKOI34J8NkE8WwWAmRM0=;
        b=jalgCVa0URnqS6ZdjQTQqUbxwtvLy67ddZSgc0ZR01/k9PcOmHDUgW1i5RxcyiCC/5
         qFoySJhtbebxR+RPfU32HdJQ44E4P7cSl9Rmc7WA5IHcZrHue7c/kyhy0KECBfD39i22
         5gZbIRFQLgEyZUeBY+ji2mUEZMy5bWMLCVicHWczfr2ia2TZ6EhftmlxJAOnNG/tklxP
         7FPocL34negDqydY7dMtm3PldAUB/NWY4OEEbYX/wWgiJJjKV8aRuB/IEQ8t54PE8NFA
         HNFC7sGBmJtphRY5si9fOJX+TqS4QbpdnVBq6T/8mRmlepY+jjrN/YnhbRxEOkkNl53A
         5VMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695860405; x=1696465205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QGGNsUnXbHlm2535h1KbmRwKOI34J8NkE8WwWAmRM0=;
        b=tULkGC4MasMvERw9AtLqWGtWRYfl5BZcYf2EXm8AjnbsKNNOo83Rh3lKoVN4aIO/g2
         q2QJ4xPJHmj7YaPd7TcC5y5bPiKde9RuOaU9rmPW/Zll1QQPNCWijKKOjmpXlIt518qU
         tRyiodlk7jmR4SRRNADOfVzthvNQgcD037spL5PHioXfZyRBoBnb5cbOqmtzLNRuhTs9
         oah7LGheYZZucoPTwIMlxBNBAifcTJY9IvC00JKgvzoPJ7+x/bd/aOzpEAeQrQE4IJmM
         nLYCG5Xx0jQjIayma2YSwnxMmXtXEYtaAqZThDp7YUZSSL70YVIBm3TKbuCaUdR7xL3K
         B4YA==
X-Gm-Message-State: AOJu0YxeRDBSMrgHjMXtjP4oUwFvRQDfknwhaF6kmWwooX2H06ChTZnP
        Kr650eutcZwSdNgVdPLuVOb/B7XQhVk=
X-Google-Smtp-Source: AGHT+IEBfyu8iwbl726nGZ0r1f2jWkIfXapTcl/HjZ1vtmHkcySW81vMihJO8Ki3Dn5u2RZ7E2kBPhAtGdk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1613:b0:d80:ff9:d19e with SMTP id
 bw19-20020a056902161300b00d800ff9d19emr55418ybb.9.1695860405485; Wed, 27 Sep
 2023 17:20:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Sep 2023 17:19:54 -0700
In-Reply-To: <20230928001956.924301-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230928001956.924301-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928001956.924301-4-seanjc@google.com>
Subject: [PATCH 3/5] KVM: selftests: Touch relevant XSAVE state in guest for
 state test
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Tyler Stachecki <stachecki.tyler@gmail.com>,
        Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Modify support XSAVE state in the "state test's" guest code so that saving
and loading state via KVM_{G,S}ET_XSAVE actually does something useful,
i.e. so that xstate_bv in XSAVE state isn't empty.

Punt on BNDCSR for now, it's easier to just stuff that xfeature from the
host side.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 14 ++++
 .../testing/selftests/kvm/x86_64/state_test.c | 77 +++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 4fd042112526..6f66861175ad 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -68,6 +68,12 @@ struct xstate {
 #define XFEATURE_MASK_OPMASK		BIT_ULL(5)
 #define XFEATURE_MASK_ZMM_Hi256		BIT_ULL(6)
 #define XFEATURE_MASK_Hi16_ZMM		BIT_ULL(7)
+#define XFEATURE_MASK_PT		BIT_ULL(8)
+#define XFEATURE_MASK_PKRU		BIT_ULL(9)
+#define XFEATURE_MASK_PASID		BIT_ULL(10)
+#define XFEATURE_MASK_CET_USER		BIT_ULL(11)
+#define XFEATURE_MASK_CET_KERNEL	BIT_ULL(12)
+#define XFEATURE_MASK_LBR		BIT_ULL(15)
 #define XFEATURE_MASK_XTILE_CFG		BIT_ULL(17)
 #define XFEATURE_MASK_XTILE_DATA	BIT_ULL(18)
 
@@ -147,6 +153,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_CLWB		KVM_X86_CPU_FEATURE(0x7, 0, EBX, 24)
 #define	X86_FEATURE_UMIP		KVM_X86_CPU_FEATURE(0x7, 0, ECX, 2)
 #define	X86_FEATURE_PKU			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 3)
+#define	X86_FEATURE_OSPKE		KVM_X86_CPU_FEATURE(0x7, 0, ECX, 4)
 #define	X86_FEATURE_LA57		KVM_X86_CPU_FEATURE(0x7, 0, ECX, 16)
 #define	X86_FEATURE_RDPID		KVM_X86_CPU_FEATURE(0x7, 0, ECX, 22)
 #define	X86_FEATURE_SGX_LC		KVM_X86_CPU_FEATURE(0x7, 0, ECX, 30)
@@ -553,6 +560,13 @@ static inline void xsetbv(u32 index, u64 value)
 	__asm__ __volatile__("xsetbv" :: "a" (eax), "d" (edx), "c" (index));
 }
 
+static inline void wrpkru(u32 pkru)
+{
+	/* Note, ECX and EDX are architecturally required to be '0'. */
+	asm volatile(".byte 0x0f,0x01,0xef\n\t"
+		     : : "a" (pkru), "c"(0), "d"(0));
+}
+
 static inline struct desc_ptr get_gdt(void)
 {
 	struct desc_ptr gdt;
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 4c4925a8ab45..df3e93df4343 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -139,6 +139,83 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 static void __attribute__((__flatten__)) guest_code(void *arg)
 {
 	GUEST_SYNC(1);
+
+	if (this_cpu_has(X86_FEATURE_XSAVE)) {
+		uint64_t supported_xcr0 = this_cpu_supported_xcr0();
+		uint8_t buffer[4096];
+
+		memset(buffer, 0xcc, sizeof(buffer));
+
+		set_cr4(get_cr4() | X86_CR4_OSXSAVE);
+		GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
+
+		xsetbv(0, xgetbv(0) | supported_xcr0);
+
+		/*
+		 * Modify state for all supported xfeatures to take them out of
+		 * their "init" state, i.e. to make them show up in XSTATE_BV.
+		 *
+		 * Note off-by-default features, e.g. AMX, are out of scope for
+		 * this particular testcase as they have a different ABI.
+		 */
+		GUEST_ASSERT(supported_xcr0 & XFEATURE_MASK_FP);
+		asm volatile ("fincstp");
+
+		GUEST_ASSERT(supported_xcr0 & XFEATURE_MASK_SSE);
+		asm volatile ("vmovdqu %0, %%xmm0" :: "m" (buffer));
+
+		if (supported_xcr0 & XFEATURE_MASK_YMM)
+			asm volatile ("vmovdqu %0, %%ymm0" :: "m" (buffer));
+
+		if (supported_xcr0 & XFEATURE_MASK_AVX512) {
+			asm volatile ("kmovq %0, %%k1" :: "r" (-1ull));
+			asm volatile ("vmovupd %0, %%zmm0" :: "m" (buffer));
+			asm volatile ("vmovupd %0, %%zmm16" :: "m" (buffer));
+		}
+
+		if (this_cpu_has(X86_FEATURE_MPX)) {
+			uint64_t bounds[2] = { 10, 0xffffffffull };
+			uint64_t output[2] = { };
+
+			GUEST_ASSERT(supported_xcr0 & XFEATURE_MASK_BNDREGS);
+			GUEST_ASSERT(supported_xcr0 & XFEATURE_MASK_BNDCSR);
+
+			/*
+			 * Don't bother trying to get BNDCSR into the INUSE
+			 * state.  MSR_IA32_BNDCFGS doesn't count as it isn't
+			 * managed via XSAVE/XRSTOR, and BNDCFGU can only be
+			 * modified by XRSTOR.  Stuffing XSTATE_BV in the host
+			 * is simpler than doing XRSTOR here in the guest.
+			 *
+			 * However, temporarily enable MPX in BNDCFGS so that
+			 * BNDMOV actually loads BND1.  If MPX isn't *fully*
+			 * enabled, all MPX instructions are treated as NOPs.
+			 *
+			 * Hand encode "bndmov (%rax),%bnd1" as support for MPX
+			 * mnemonics/registers has been removed from gcc and
+			 * clang (and was never fully supported by clang).
+			 */
+			wrmsr(MSR_IA32_BNDCFGS, BIT_ULL(0));
+			asm volatile (".byte 0x66,0x0f,0x1a,0x08" :: "a" (bounds));
+			/*
+			 * Hand encode "bndmov %bnd1, (%rax)" to sanity check
+			 * that BND1 actually got loaded.
+			 */
+			asm volatile (".byte 0x66,0x0f,0x1b,0x08" :: "a" (output));
+			wrmsr(MSR_IA32_BNDCFGS, 0);
+
+			GUEST_ASSERT_EQ(bounds[0], output[0]);
+			GUEST_ASSERT_EQ(bounds[1], output[1]);
+		}
+		if (this_cpu_has(X86_FEATURE_PKU)) {
+			GUEST_ASSERT(supported_xcr0 & XFEATURE_MASK_PKRU);
+			set_cr4(get_cr4() | X86_CR4_PKE);
+			GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSPKE));
+
+			wrpkru(-1u);
+		}
+	}
+
 	GUEST_SYNC(2);
 
 	if (arg) {
-- 
2.42.0.582.g8ccd20d70d-goog

