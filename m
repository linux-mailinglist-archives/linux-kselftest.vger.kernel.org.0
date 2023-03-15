Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6211F6BC034
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 23:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjCOWyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 18:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjCOWyR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 18:54:17 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0456040C
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 15:53:41 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m1-20020a17090a668100b00237d84de790so1589779pjj.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678920821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5IjZBzmYfOxuUAk9Wp5OhIFThytGtbjuPg10gNWTiKg=;
        b=X710boA9PzUplR36EbJVYxlgU9RIibRuaPj4iN/Wb8gbsQ1YhtJrm3VwiSCCojuXeY
         vGOMq9qQPnCcPFPOKX78tRTAMsBjLOqOiE6s5CkZqOB1+aEGy2QN4TFABssKFl3W/p1m
         mxwNLqYid90p/PlEkCPASmIXyqGQpYBYZbNCQ4tPu8YnQS5AnZq+ljOtzqmNhASgFmTC
         tcigX5oluffGxEV5WwrpY5QONuhzkJN8atG5CxsqlPpyzRRmBwIq6U4kKUA5M+KD11tm
         Vsd2lvyyBw1cSQnJBa5gY3+Z+tIIqHuNenKDQ954bJ4tWEZgN9OMFdzwITGoeZI6LAG4
         V2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678920821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IjZBzmYfOxuUAk9Wp5OhIFThytGtbjuPg10gNWTiKg=;
        b=ugHYq8DPBEBPFNl/l+xzWyRSjWxVutBOkVqoG7U+N087wpc7ZvGpD6HFj8gzAQ/CAJ
         YoolZy/hZAQVSRSnHH6IgxnVel4Th4cuj/Dz2Yp5R/W+EUw9bvvge+NP8blnWVKaiBj/
         ns1ItlseSLOaLSASzGQ6N5pr5nHKDyN1gS49O8QtLNzUO1h7KEXssy4y/sVfJeDwzM5s
         2hf98PStDSil4zvFB/nmP1xQNkvZNQKzdMbiYkkuBh+NunwEux4kDKN5n11dKf3Cppn2
         1Ay3rRZYGXyUfrndI521rrDF9gVNDyPNzqCfHSovGbFoqpGjYHaC7lxDUe/EWO8ta6xL
         cSPw==
X-Gm-Message-State: AO0yUKVQ/fOWyzf+sJSEwu7zMhZDBVU3vOgeQCo3vNdkCOJIECkmi5Zi
        nmdHZcpnPLfR658jnvkHbUO7yyc6fWw=
X-Google-Smtp-Source: AK7set8tX2kO0D/KT+tsILppg4BLvkxjQlZpG+8xkPe1JsJ5viaTykbZT3C8Woss1pFF9vrbc5j0C1x/1nc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:eb08:b0:23b:4e6e:aed9 with SMTP id
 j8-20020a17090aeb0800b0023b4e6eaed9mr472733pjz.9.1678920820723; Wed, 15 Mar
 2023 15:53:40 -0700 (PDT)
Date:   Wed, 15 Mar 2023 15:53:39 -0700
In-Reply-To: <20230127133601.1165472-1-yu.c.zhang@linux.intel.com>
Mime-Version: 1.0
References: <20230127133601.1165472-1-yu.c.zhang@linux.intel.com>
Message-ID: <ZBJMc24vyL3X9RHa@google.com>
Subject: Re: [PATCH] KVM: selftest: Add dependency rules in makefile for C
 source code
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 27, 2023, Yu Zhang wrote:
> Currently, KVM selftests have to run "make clean && make" to rebuild the
> entire test suite each time a header file is modified. Define "-MD" as
> an EXTRA_CFLAGS, so we can generate the dependency rules for each target
> object, whose prerequisites contains the source file and the included header
> files as well. And including those dependency files in KVM selftests' makefile
> will release us from such annoyance.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 1750f91dd936..b329e0d1a460 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -180,6 +180,8 @@ TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
>  TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
>  LIBKVM += $(LIBKVM_$(ARCH_DIR))
>  
> +OVERRIDE_TARGETS = 1
> +
>  # lib.mak defines $(OUTPUT), prepends $(OUTPUT)/ to $(TEST_GEN_PROGS), and most
>  # importantly defines, i.e. overwrites, $(CC) (unless `make -e` or `make CC=`,
>  # which causes the environment variable to override the makefile).
> @@ -198,9 +200,11 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>  	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
>  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>  	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
> -	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
> +	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. \
>  	$(KHDR_INCLUDES)
>  
> +EXTRA_CFLAGS += -MD
> +
>  no-pie-option := $(call try-run, echo 'int main(void) { return 0; }' | \
>          $(CC) -Werror $(CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
>  
> @@ -218,11 +222,22 @@ LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
>  LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
>  LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
>  
> -EXTRA_CLEAN += $(LIBKVM_OBJS) cscope.*
> +TEST_GEN_OBJ = $(patsubst %, %.o, $(TEST_GEN_PROGS))
> +TEST_GEN_OBJ += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
> +TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_OBJ))
> +TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBKVM_OBJS))
> +-include $(TEST_DEP_FILES)
> +
> +$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM_OBJS) $(LDLIBS) -o $@

Do we actually need to omit -MD here?  IIUC, it just means that the .d file will
get redundantly generated when building the final executable.  I would much prefer
to build everything with the same options unless there's a good reason not to,
e.g. this patch doesn't feed -MD into the LIBKVM_STRING_OBJ target, which seems
wrong.

I.e. why not simply

---
 tools/testing/selftests/kvm/Makefile | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 152c1a988e42..faaf65aa7621 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -182,6 +182,8 @@ TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
 LIBKVM += $(LIBKVM_$(ARCH_DIR))
 
+OVERRIDE_TARGETS = 1
+
 # lib.mak defines $(OUTPUT), prepends $(OUTPUT)/ to $(TEST_GEN_PROGS), and most
 # importantly defines, i.e. overwrites, $(CC) (unless `make -e` or `make CC=`,
 # which causes the environment variable to override the makefile).
@@ -196,7 +198,7 @@ else
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
-	-Wno-gnu-variable-sized-type-not-at-end \
+	-Wno-gnu-variable-sized-type-not-at-end -MD \
 	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
@@ -223,7 +225,18 @@ LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
 LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
 
-EXTRA_CLEAN += $(LIBKVM_OBJS) cscope.*
+TEST_GEN_OBJ = $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TEST_GEN_OBJ += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_OBJ))
+TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBKVM_OBJS))
+-include $(TEST_DEP_FILES)
+
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM_OBJS) $(LDLIBS) -o $@
+$(TEST_GEN_OBJ): %.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) cscope.*
 
 x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
 $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c

base-commit: 95b9779c1758f03cf494e8550d6249a40089ed1c
-- 

