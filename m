Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20672589218
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiHCSQk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 14:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbiHCSQj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 14:16:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014AF274
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Aug 2022 11:16:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso2957814pjl.4
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Aug 2022 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=n3OqQ1qt6381kut5lhocnFM6Mud/KXG24G59RX3JKvo=;
        b=snN9dp/8Ihbn1V1jiBTonCB/uBM1Fto9bCu8+Tgl8owfsj34qe3qI9uNBoF4GZeddX
         PXVBc1ni/eW2sjioXPB39X+5QNJbo7ybnzNpjUJ+FfLOlcWnt8/+Ra9CTNN8xtufGKG7
         Py841IM3ZPPnSD+CrQnAr6GPbSOoKmi6sTmPFPRNbJU4TAxJVYNZwI5RL1Y0vTdNKzxk
         IfmAR0NUa2tT7ogz7aTrwMC1+lh6ZnrxVzMm+I+40hb7NUILUqqy7eDZa5wBt//iAQu8
         5O0CUk0HFKikNyJX4TnjvrajFdOY5vLfi1Itxq6NhD6VBN9blwi/DE2tgqbPvxOkxELc
         jOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=n3OqQ1qt6381kut5lhocnFM6Mud/KXG24G59RX3JKvo=;
        b=tRBcH7INz/ndN1xxMdXvtqXE3IKgou7JO9zo7R656ar2aV75osZuqp+mfTCdhfJ++7
         oxpzt4igkG2V9rodb2vKFocJotQaGHsWkq1xztSI6UpzgcV7Otg3bw6NNYRvogxQpiwl
         kZyI2DSY7OAtTvLbBEITzX6LEz7vZDuCgANefSjMxQGQIKQ9qRvUpS2MYEcw9zlofiFM
         LOV7ZxPG7O7o21QnkQcSGyl72W9NVKJ+ko/kq/XjcT48f15jCzhWK+ZyChtNjpQQHPAI
         HK8nsWZwNJc1Yvkewowq/zM0KnuPxYhlX58CS5bYPIG1W+cjnr03rkurIafVGw92dplO
         BeLg==
X-Gm-Message-State: ACgBeo1aMQVlMWbSX3AMkgs19O24Fd9/ePc7w1d3FmyecZ/NUM5BYJ6B
        dPPj3iyodSc0bLTzKhN4BAE8og==
X-Google-Smtp-Source: AA6agR6PVHQOlBigGLDa0E5o/cqkh079TRET5auSCAnAwCTORRGwJ2/VOSKUD0rORDTNATW1S29a8A==
X-Received: by 2002:a17:902:8e89:b0:16d:69b7:49b4 with SMTP id bg9-20020a1709028e8900b0016d69b749b4mr27149586plb.167.1659550597347;
        Wed, 03 Aug 2022 11:16:37 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b0016dbb5bbeebsm2323261plh.228.2022.08.03.11.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:16:36 -0700 (PDT)
Date:   Wed, 3 Aug 2022 18:16:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michal Luczaj <mhal@rbox.co>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 4/4] x86: Extend ASM_TRY to handle #UD
 thrown by FEP-triggered emulator
Message-ID: <Yuq7gMTpRqGlVdcW@google.com>
References: <Yum2LpZS9vtCaCBm@google.com>
 <20220803172508.1215-1-mhal@rbox.co>
 <20220803172508.1215-4-mhal@rbox.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803172508.1215-4-mhal@rbox.co>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 03, 2022, Michal Luczaj wrote:
> TRY_ASM() mishandles #UD thrown by the forced-emulation-triggered emulator.
> While the faulting address stored in the exception table points at forced
> emulation prefix, when #UD comes, RIP is 5 bytes (size of KVM_FEP) ahead
> and the exception ends up unhandled.

Ah, but that's only the behavior if FEP is allowed.  If FEP is disabled, then the
#UD will be on the prefix.

> Suggested-by: Sean Christopherson <seanjc@google.com>

Heh, I didn't really suggest this because I didn't even realize it was a problem :-)

> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> While here, I've also took the opportunity to merge both 32 and 64-bit
> versions of ASM_TRY() (.dc.a for .long and .quad), but perhaps there
> were some reasons for not using .dc.a?

This should be a separate patch, and probably as the very last patch in case dc.a
isn't viable for whatever reason.  I've never seen/used dc.a so I really have no
idea whether or not it's ok to use.

As a "safe" alternative that can be done before adding ASM_TRY_FEP(), we can steal
the kernel's __ASM_SEL() approach so that you don't have to implement two versions
of ASM_TRY_FEP().  That's worth doing because __ASM_SEL() can probably be used in
other places too.  Patch at the bottom.

>  lib/x86/desc.h | 11 +++++------
>  x86/emulator.c |  4 ++--
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/x86/desc.h b/lib/x86/desc.h
> index 2a285eb..99cc224 100644
> --- a/lib/x86/desc.h
> +++ b/lib/x86/desc.h
> @@ -80,21 +80,20 @@ typedef struct  __attribute__((packed)) {
>  	u16 iomap_base;
>  } tss64_t;
>  
> -#ifdef __x86_64
>  #define ASM_TRY(catch)			\
>  	"movl $0, %%gs:4 \n\t"		\
>  	".pushsection .data.ex \n\t"	\
> -	".quad 1111f, " catch "\n\t"	\
> +	".dc.a 1111f, " catch "\n\t"	\
>  	".popsection \n\t"		\
>  	"1111:"
> -#else
> -#define ASM_TRY(catch)			\
> +
> +#define ASM_TRY_PREFIXED(prefix, catch)	\

Rather than a generic ASM_TRY_PREFIXED, I think it makes sense to add an explicit
ASM_TRY_FEP() that takes in only the label and hardcodes the FEP prefix.  The "#UD
skips the prefix" behavior is unique to "successful" forced emulation, so this is
literally the only scenario where skipping a prefix is expected/correct.

*sigh*

That'll require moving the KVM_FEP definition, but that's a good change on its
own.  Probably throw it in lib/x86/processor.h?

>  	"movl $0, %%gs:4 \n\t"		\
>  	".pushsection .data.ex \n\t"	\
> -	".long 1111f, " catch "\n\t"	\
> +	".dc.a 1111f, " catch "\n\t"	\
>  	".popsection \n\t"		\
> +	prefix "\n\t"			\
>  	"1111:"
> -#endif
>  
>  /*
>   * selector     32-bit                        64-bit
> diff --git a/x86/emulator.c b/x86/emulator.c
> index df0bc49..d2a5302 100644
> --- a/x86/emulator.c
> +++ b/x86/emulator.c
> @@ -900,8 +900,8 @@ static void test_illegal_lea(void)
>  {
>  	unsigned int vector;
>  
> -	asm volatile (ASM_TRY("1f")
> -		      KVM_FEP ".byte 0x8d; .byte 0xc0\n\t"
> +	asm volatile (ASM_TRY_PREFIXED(KVM_FEP, "1f")
> +		      ".byte 0x8d; .byte 0xc0\n\t"

Put this patch earlier in the series, before test_illegal_lea() is introduced.
Both so that there's no unnecessary churn, and also because running the illegal
LEA testcase without this patch will fail.

>  		      "1:"
>  		      : : : "memory", "eax");

---
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 3 Aug 2022 11:09:41 -0700
Subject: [PATCH] x86: Dedup 32-bit vs. 64-bit ASM_TRY() by stealing kernel's
 __ASM_SEL()

Steal the kernel's __ASM_SEL() implementation and use it to consolidate
ASM_TRY().  The only difference between the 32-bit and 64-bit versions is
the size of the address stored in the table.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/desc.h      | 19 +++++--------------
 lib/x86/processor.h | 12 ++++++++++++
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/lib/x86/desc.h b/lib/x86/desc.h
index 2a285eb6..e670ebf2 100644
--- a/lib/x86/desc.h
+++ b/lib/x86/desc.h
@@ -80,21 +80,12 @@ typedef struct  __attribute__((packed)) {
 	u16 iomap_base;
 } tss64_t;

-#ifdef __x86_64
-#define ASM_TRY(catch)			\
-	"movl $0, %%gs:4 \n\t"		\
-	".pushsection .data.ex \n\t"	\
-	".quad 1111f, " catch "\n\t"	\
-	".popsection \n\t"		\
+#define ASM_TRY(catch)						\
+	"movl $0, %%gs:4 \n\t"					\
+	".pushsection .data.ex \n\t"				\
+	__ASM_SEL(.long, .quad) " 1111f,  " catch "\n\t"	\
+	".popsection \n\t"					\
 	"1111:"
-#else
-#define ASM_TRY(catch)			\
-	"movl $0, %%gs:4 \n\t"		\
-	".pushsection .data.ex \n\t"	\
-	".long 1111f, " catch "\n\t"	\
-	".popsection \n\t"		\
-	"1111:"
-#endif

 /*
  * selector     32-bit                        64-bit
diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index 03242206..30e2de87 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -19,6 +19,18 @@
 #  define S "4"
 #endif

+#ifdef __ASSEMBLY__
+#define __ASM_FORM(x, ...)	x,## __VA_ARGS__
+#else
+#define __ASM_FORM(x, ...)	" " xstr(x,##__VA_ARGS__) " "
+#endif
+
+#ifndef __x86_64__
+#define __ASM_SEL(a,b)		__ASM_FORM(a)
+#else
+#define __ASM_SEL(a,b)		__ASM_FORM(b)
+#endif
+
 #define DB_VECTOR 1
 #define BP_VECTOR 3
 #define UD_VECTOR 6

base-commit: a106b30d39425b7afbaa3bbd4aab16fd26d333e7
--

