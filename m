Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC66BE501
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 10:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCQJKM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 05:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjCQJKH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 05:10:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1DB30FC;
        Fri, 17 Mar 2023 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679044205; x=1710580205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/mA9juw6Wk0h1jZipjb8f6HQJ6J3W6r/nV9wFA+39w=;
  b=It4JmmxAA71WbjHhbiKnSBbk+Rjm6VQrHM2tUlK1kpAniGR0x+o0XJUZ
   UVdmB2+jMRKFzjPHSdtofXuR4aNlpGXLRCHwk4c8RqTYZtPwzLir+quUU
   8/GkC+KsCKLhUxO75NtIcRuLuTEb5wCwiq0GO+iFE87/NsvevqINxngZi
   gsKykButcfouXsKZaKxSjjURX2Nl4w9b3Ub+B8BUIRuY0dqDN6UJciiIS
   1OcEJhMROC7MpRPnbFP7nFu/sSWJxST4bmK+/oG41fa8i8VBXHQmDRQ+y
   v/jbBsvCf2oallEBTKBpojGhVDyD+SxOhn7Tow8WhFOhkLTef2PVeVL5L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="340581205"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="340581205"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 02:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="710428979"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="710428979"
Received: from xliu2-mobl1.ccr.corp.intel.com (HELO localhost) ([10.255.29.180])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 02:09:58 -0700
Date:   Fri, 17 Mar 2023 17:09:53 +0800
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>, pbonzini@redhat.com,
        shuah@kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftest: Add dependency rules in makefile for C
 source code
Message-ID: <20230317090953.qkduwduutcam4ho2@linux.intel.com>
References: <20230127133601.1165472-1-yu.c.zhang@linux.intel.com>
 <ZBJMc24vyL3X9RHa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBJMc24vyL3X9RHa@google.com>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Do we actually need to omit -MD here?  IIUC, it just means that the .d file will
> get redundantly generated when building the final executable.  I would much prefer
> to build everything with the same options unless there's a good reason not to,
> e.g. this patch doesn't feed -MD into the LIBKVM_STRING_OBJ target, which seems
> wrong.

No, we don't. I added "-MD" in EXTRA_CFLAGS, so that only .o files would
be impacted when generating dependency files. But it is unnecessary.

As to the LIBKVM_STRING_OBJ target, it is my negligence. :)

I tried your suggested fix, and it works fine. Will send out v2(based on
selftests branch of github.com/kvm-x86/linux). Thanks!

B.R.
Yu
> 
> I.e. why not simply
> 
> ---
>  tools/testing/selftests/kvm/Makefile | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 152c1a988e42..faaf65aa7621 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -182,6 +182,8 @@ TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
>  TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
>  LIBKVM += $(LIBKVM_$(ARCH_DIR))
>  
> +OVERRIDE_TARGETS = 1
> +
>  # lib.mak defines $(OUTPUT), prepends $(OUTPUT)/ to $(TEST_GEN_PROGS), and most
>  # importantly defines, i.e. overwrites, $(CC) (unless `make -e` or `make CC=`,
>  # which causes the environment variable to override the makefile).
> @@ -196,7 +198,7 @@ else
>  LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
>  endif
>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
> -	-Wno-gnu-variable-sized-type-not-at-end \
> +	-Wno-gnu-variable-sized-type-not-at-end -MD \
>  	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
>  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>  	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
> @@ -223,7 +225,18 @@ LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
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
> +$(TEST_GEN_OBJ): %.o: %.c
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> +
> +EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) cscope.*
>  
>  x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
>  $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c
> 
> base-commit: 95b9779c1758f03cf494e8550d6249a40089ed1c
> -- 
> 
