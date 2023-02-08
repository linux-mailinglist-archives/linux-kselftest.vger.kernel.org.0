Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF268E588
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 02:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjBHBna (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 20:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHBna (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 20:43:30 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837D3CE31
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Feb 2023 17:43:28 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v23so17672365plo.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Feb 2023 17:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIXFPcUNLXRZ+eEyCPAJs8wbGFoCpT3DMuUbChLN/VQ=;
        b=EPG8wmcv6TvcanM5ZmHQOth63duzN2CHMKlM1ugVNoVDFrlOX8tmKWxW7D4hXqPI33
         9knNrej2Kwyr9VYxX/Zf3wVHCL6Td8DyttvnJDpLIjE4uAveWjgV3cT81ZtuP+qvmf6J
         +cH63HuegLfvVh/d2Qj629GABy+Mwou4W27NWafgLDCZoF9UTlt70unF5l67RiuanR3R
         Q/asYJCUCouJPFGRIsX9MnpZ3XP/AEdruVUlaVejJoNg3KFsWB5+KMx/nO6mw9sac4U4
         qZW7nYbiPDHY/ca+h4GkobIK8oz/vcFwPMUum+dKpQXLshrjQrsnAF2AfctU1Fr81hyQ
         oYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIXFPcUNLXRZ+eEyCPAJs8wbGFoCpT3DMuUbChLN/VQ=;
        b=TpG4Um3VUGrSeLP0TkY11u85uHXpbZoA1gIPkBVBtGA1sbdLszh9do6v/hlqqs+eWn
         UxwwZf/0Xrt59B6IfRd+91ENjf4D/IdYu0XwOVJa6DWi8RklWVAHRkPQLpwzYtOjq+1Q
         JsUYweaVBWa8DE/1IJskCiCHV5z97LHk37Q751RF96LACXMPnVnoh0hytPmuOjt1r2+5
         T0T9izGQj7Ozee90CTHTAfc+p6l3oR3DDgsOMf0vRI9qk52zlD/GOhMhzgxI4bnCRCQS
         XBxj1MU3bPySPvN4K4uUejWc24sd/ddfGMvkkrQRycxjYkOjK0VpmFih0hdTCTWZ/exK
         QE/A==
X-Gm-Message-State: AO0yUKWfF3jar2qBU2Dy0PvlestpNEsVnkr+PLU+b7cxYcOoBdEsovFV
        n6J4hkNGm5H6OLz9SqtP8PKKkw==
X-Google-Smtp-Source: AK7set9kjHeQRQoO+UwhGiyX/Y7MUIaddLJUUp6CMdTNlcxT73QQ4Hju12xQPoqtkesC0PylQidHDQ==
X-Received: by 2002:a17:902:d502:b0:198:af50:e4de with SMTP id b2-20020a170902d50200b00198af50e4demr113972plg.4.1675820607819;
        Tue, 07 Feb 2023 17:43:27 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j22-20020a62b616000000b00594235980e4sm9792156pff.181.2023.02.07.17.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 17:43:27 -0800 (PST)
Date:   Wed, 8 Feb 2023 01:43:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH 3/4] KVM: selftests: x86: Enable checking on xcomp_bv in
 amx_test
Message-ID: <Y+L+O/TphoIQLcA7@google.com>
References: <20230110185823.1856951-1-mizhang@google.com>
 <20230110185823.1856951-4-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110185823.1856951-4-mizhang@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 10, 2023, Mingwei Zhang wrote:
> After tilerelease instruction, AMX tiles are in INIT state. According to
> Intel SDM vol 1. 13.10: "If RFBM[i] = 1, XSTATE_BV[i] is set to the
> value of XINUSE[i].", XSTATE_BV[18] should be cleared after xsavec.
> 
> On the other hand, according to Intel SDM vol 1. 13.4.3: "If XCOMP_BV[i] =
> 1, state component i is located at a byte offset locationI from the base
> address of the XSAVE area". Since at the time of xsavec, XCR0[18] is set
> indicating AMX tile data component is still enabled, xcomp_bv[18] should be
> set.
> 
> Complete the checks by adding the assert to xcomp_bv[18] after xsavec.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/amx_test.c | 30 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index b2369f956fea..18203e399e9d 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -41,6 +41,12 @@
>  
>  #define XSAVE_HDR_OFFSET		512
>  
> +struct xstate_header {
> +	u64	xfeatures;
> +	u64	xcomp_bv;
> +	u64	reserved[6];
> +} __packed;

I definitely like the idea of using a struct, but let's go all the way, i.e. add
a mostly-functional "struct xstate" too so that we don't to do pointer arithmetic.
I don't think it makes sense to copy+paste from the kernel since I highly doubt
anyone is going to write an x87 test, so maybe this?

struct xstate_header {
	u64				xstate_bv;
	u64				xcomp_bv;
	u64				reserved[6];
} __attribute__((packed));

struct xstate {
	u8				i387[512];
	struct xstate_header		header;
	u8				extended_state_area[0];
} __attribute__ ((packed, aligned (64)));


>  struct xsave_data {
>  	u8 area[XSAVE_SIZE];

Ewww.  Not your code.  The existing code declares XSAVE_SIZE bytes, but allocates
3 4KiB pages.  It took me a bit of starting to realize TILE_SIZE is 1KiB, not 4KiB.
Can you tack on a patch do something like:

@@ -244,7 +230,7 @@ int main(int argc, char *argv[])
        struct kvm_run *run;
        struct kvm_x86_state *state;
        int xsave_restore_size;
-       vm_vaddr_t amx_cfg, tiledata, xsavedata;
+       vm_vaddr_t amx_cfg, tiledata, xstate;
        struct ucall uc;
        u32 amx_offset;
        int stage, ret;
@@ -284,10 +270,10 @@ int main(int argc, char *argv[])
        tiledata = vm_vaddr_alloc_pages(vm, 2);
        memset(addr_gva2hva(vm, tiledata), rand() | 1, 2 * getpagesize());
 
-       /* xsave data for guest_code */
-       xsavedata = vm_vaddr_alloc_pages(vm, 3);
-       memset(addr_gva2hva(vm, xsavedata), 0, 3 * getpagesize());
-       vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xsavedata);
+       /* XSAVE state for guest_code */
+       xstate = vm_vaddr_alloc_pages(vm, DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));
+       memset(addr_gva2hva(vm, xstate), 0, DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));
+       vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xstate);
 
        for (stage = 1; ; stage++) {
                vcpu_run(vcpu);

>  } __aligned(64);
> @@ -160,12 +166,26 @@ static void set_tilecfg(struct tile_config *cfg)
>  
>  static void set_xstatebv(void *data, uint64_t bv)
>  {
> -	*(uint64_t *)(data + XSAVE_HDR_OFFSET) = bv;
> +	struct xstate_header *header =
> +		(struct xstate_header *)(data + XSAVE_HDR_OFFSET);
> +
> +	header->xfeatures = bv;
>  }
>  
>  static u64 get_xstatebv(void *data)
>  {
> -	return *(u64 *)(data + XSAVE_HDR_OFFSET);
> +	struct xstate_header *header =
> +		(struct xstate_header *)(data + XSAVE_HDR_OFFSET);
> +
> +	return header->xfeatures;
> +}
> +
> +static u64 get_xcompbv(void *data)
> +{
> +	struct xstate_header *header =
> +		(struct xstate_header *)(data + XSAVE_HDR_OFFSET);
> +
> +	return header->xcomp_bv;
>  }

If we add a "full" struct, these ugly wrappers go away, e.g. as untested patches
that you can claim as your own if you test 'em and write changelogs :-)

---
 .../selftests/kvm/include/x86_64/processor.h  | 12 +++++++
 tools/testing/selftests/kvm/x86_64/amx_test.c | 36 ++++++-------------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 53ffa43c90db..a7ce1fe8d70f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -48,6 +48,18 @@ extern bool host_cpu_is_amd;
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
index bd72c6eb3b67..d506821a5a26 100644
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
+	memset(addr_gva2hva(vm, xstate), 0, DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));
+	vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xstate);
 
 	for (stage = 1; ; stage++) {
 		vcpu_run(vcpu);

base-commit: 78332517a5dab54514ae719805eec218715de1fc
-- 

