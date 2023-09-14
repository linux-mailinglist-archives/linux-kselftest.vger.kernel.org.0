Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117CF79FEB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 10:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbjINIql (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 04:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbjINIqh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 04:46:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF998
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 01:46:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so7686215e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694681191; x=1695285991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQEPjdH4Gli9KAKRohOP4WFvJ7BvjQDzxENQGkakYUo=;
        b=akqB3OZmyrYPrr/2AkSGvD93rHAXS+FRk5BVzmf8wBaG6o33cIZAeJVxQAJ4aOgLgC
         ODJLzw/M7HRGg+Bc5/Rxu/z35r0SJ3t2/MyBM9/hWRI6ONHlRkT0Z8gEd7ufyj0yB88U
         u2FnVScOUwu9REAnC0s5ZS5LMRzY53Xuq2TjWlWb1dUDm+aY2Xot+A+81SbbO0GXYaM3
         gFXysm9D1b/J/0DqOvOCYOP2xlGPi2SbsUUoAem3z8z6tJ+uwcs6xzUYydHF9nqSXkjO
         IAXfgKVaAYzmOYVFtb73AISpAyf2VGV6xT4hNJqe3+zRdUg99BnLMZCND8iFNJsMNvLY
         pNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681191; x=1695285991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQEPjdH4Gli9KAKRohOP4WFvJ7BvjQDzxENQGkakYUo=;
        b=Dl2U0aitCptLkmaFOhVD4sXOSMqoWGu/wunoll+6xL3EtOw4sntZQ669uYVCD7e90C
         l6AWPNk24wyH+BgGm3PiyHWzsKQkxkksB8RCNwBOy+pg8bUruJXDNVnOntUWutnRRQfF
         q41mj7r6ULXM+0wpPekPqs6xwBsIlx1VT6aLKlozB/eaietRm8UgkVBhMPeyAXLCuDQv
         Rn6hSmojiMTlGfngqSvRtc2qpdiIUOY0iotNnRZe+SVnmS94TxuF6ta6p1ITtkx+0ZAe
         YlAcvjABSx/P2yXXKzb93s8vloyeOsQu/1iyTKGGfnL96v5/llmMaMzqeC7qNC2mKiCR
         JgNQ==
X-Gm-Message-State: AOJu0YxZeSbDo3FVSMxYwDGgjk5ZZyr1a9U7xWleKUP7ziFITwOTyiIq
        YWxO84Or0CscajRg2d625yVpOQ==
X-Google-Smtp-Source: AGHT+IEirTjVMIzTLjC7sB1QXwQuxnOxm1+1fH/gEKNI6n9l8wkInADFzO37/+IpdsjO1bWWulPatg==
X-Received: by 2002:a5d:6105:0:b0:319:8427:d221 with SMTP id v5-20020a5d6105000000b003198427d221mr4297904wrt.62.1694681191504;
        Thu, 14 Sep 2023 01:46:31 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b003176eab8868sm1157269wrs.82.2023.09.14.01.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:46:31 -0700 (PDT)
Date:   Thu, 14 Sep 2023 10:46:30 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/9] KVM: selftests: Unify the makefile rule for split
 targets
Message-ID: <20230914-393dcb077c664af16c4830e4@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <cda6cc71c9bdde87fe87f6c2dec4f03ca249dd62.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda6cc71c9bdde87fe87f6c2dec4f03ca249dd62.1694421911.git.haibo1.xu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 09:36:56AM +0800, Haibo Xu wrote:
> A separate makefile rule was used for split targets which was added
> in patch(KVM: arm64: selftests: Split get-reg-list test code). This
> could be avoided by minor changes to the recipes of current rule.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index a3bb36fb3cfc..7972269e8c5f 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -249,13 +249,10 @@ TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TESTS_OBJS))
>  -include $(TEST_DEP_FILES)
>  
>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
> -	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM_OBJS) $(LDLIBS) -o $@
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
>  $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>  
> -$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
> -	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
> -
>  EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) $(SPLIT_TESTS_OBJS) cscope.*
>  
>  x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
> @@ -274,6 +271,7 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>  x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
>  $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>  $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
> +$(SPLIT_TESTS_TARGETS): $(OUTPUT)/%: $(ARCH_DIR)/%.o
>  
>  cscope: include_paths = $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include lib ..
>  cscope:
> -- 
> 2.34.1
>

Nice.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
