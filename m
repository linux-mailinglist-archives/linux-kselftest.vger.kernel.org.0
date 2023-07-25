Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD27761898
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 14:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjGYMpD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjGYMpC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 08:45:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7AEDA
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 05:44:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98e39784a85so1388104066b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690289098; x=1690893898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DVe5kbgnFh2Y4eGHfjCzHKbLu04TQkYMB7dsKJm3Umo=;
        b=GpcyljcjU7Qr5dRNNYfizZwrwBd4cnjkvyHTuvC/QsN3XiYBpHJim9y0Fwhwc12FfD
         aXUdwC4S44xNeyqhfcrwKMKZn14++9A7dS881Sg+Nm6Rp55TRzJuABW3jgcxoetQ82KS
         rdPHpg0b0w+Cu7zrIR6V80QMY49a17Up7GMpMri0hlbFbJ/e85dQN/8v9LUhnjzptMP2
         I1rLEsN8NAbBHL6D2Z4ZsHzrPphtmuQjq1BmY4zHbzxWwUm57J72SMevDz7P6ChP9tkh
         1bWV1k8SOuFyF7PNNO2I0iyrpY/3VczpraJ9h6dwsNUtCnP2hQGAMKzOgSjG1qKB+O+3
         SQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289098; x=1690893898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVe5kbgnFh2Y4eGHfjCzHKbLu04TQkYMB7dsKJm3Umo=;
        b=cfM/xHB7+3KPsfzoSbafF/PqDtvRKhq5YvrSuMtlexznlB4B0ZO/FlnPEb7mgFhA4b
         sdPeR8OhnV3YsRPl70Bq1xhKpOjYlSMwY0EFOWSk4ThJlrEQfn2A19nAw3oPoD8HQ08p
         C03Z7SpZydwpP4gj/Q8fdQ8D5COe7/pW6gt8x2adcf0pNzMQF4O5CBFlFdrh4ZktQNCi
         nVfi8EhN/pNcLHDyoXEocgaU4g4pb+tXhpYxDDNPIN3WtbzHEODgeU4K8i4Aks7uKiYx
         Y60kE/M/Uo4L9FM/J0ESSL5+ZJLV6J9xP6yw/pwT3lrHrVsQlHCtxC8ouGz8qqsouaVt
         i5lw==
X-Gm-Message-State: ABy/qLa/yuJHE7qbPZrLbj0sg8E5I8Lu33IEP+ZNLY5g9G/jpclAbo6g
        lkeca5dzo+7iQWO6UB8X8oghUw==
X-Google-Smtp-Source: APBJJlGRSB+oOdzfbHk1XswFZQ6sXyZlhMpraB1keFiipvJqv7JZBaK38TlZAFpu/NEWGgF+T3sqfA==
X-Received: by 2002:a17:906:5dd8:b0:99b:4d3d:c9b7 with SMTP id p24-20020a1709065dd800b0099b4d3dc9b7mr2464164ejv.31.1690289098120;
        Tue, 25 Jul 2023 05:44:58 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id qp7-20020a170907206700b00992b66e54e9sm8134209ejb.214.2023.07.25.05.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:44:57 -0700 (PDT)
Date:   Tue, 25 Jul 2023 14:44:56 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>, maz@kernel.org,
        oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v6 06/13] KVM: arm64: selftests: Split get-reg-list test
 code
Message-ID: <20230725-f5cf47c63abd8673d22b4936@orel>
References: <cover.1690273969.git.haibo1.xu@intel.com>
 <1f25f27d1316bc91e1e31cd3d50a1d20f696759a.1690273969.git.haibo1.xu@intel.com>
 <CAJve8okJ-HYpsOrqH4Zvn7OBtwXWa4JumC+ZsMfHKB-deVYd2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8okJ-HYpsOrqH4Zvn7OBtwXWa4JumC+ZsMfHKB-deVYd2A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 04:50:36PM +0800, Haibo Xu wrote:
> On Tue, Jul 25, 2023 at 4:37 PM Haibo Xu <haibo1.xu@intel.com> wrote:
> >
> > From: Andrew Jones <ajones@ventanamicro.com>
> >
> > Split the arch-neutral test code out of aarch64/get-reg-list.c into
> > get-reg-list.c. To do this we invent a new make variable
> > $(SPLIT_TESTS) which expects common parts to be in the KVM selftests
> > root and the counterparts to have the same name, but be in
> > $(ARCH_DIR).
> >
> > There's still some work to be done to de-aarch64 the common
> > get-reg-list.c, but we leave that to the next patch to avoid
> > modifying too much code while moving it.
> >
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/Makefile          |  12 +-
> >  .../selftests/kvm/aarch64/get-reg-list.c      | 367 +----------------
> >  tools/testing/selftests/kvm/get-reg-list.c    | 377 ++++++++++++++++++
> >  3 files changed, 398 insertions(+), 358 deletions(-)
> >  create mode 100644 tools/testing/selftests/kvm/get-reg-list.c
> >
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > index c692cc86e7da..95f180e711d5 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -140,7 +140,6 @@ TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
> >  TEST_GEN_PROGS_aarch64 += aarch64/aarch32_id_regs
> >  TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
> >  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
> > -TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
> >  TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
> >  TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
> >  TEST_GEN_PROGS_aarch64 += aarch64/psci_test
> > @@ -152,6 +151,7 @@ TEST_GEN_PROGS_aarch64 += access_tracking_perf_test
> >  TEST_GEN_PROGS_aarch64 += demand_paging_test
> >  TEST_GEN_PROGS_aarch64 += dirty_log_test
> >  TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
> > +TEST_GEN_PROGS_aarch64 += get-reg-list
> >  TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
> >  TEST_GEN_PROGS_aarch64 += kvm_page_table_test
> >  TEST_GEN_PROGS_aarch64 += memslot_modification_stress_test
> > @@ -181,6 +181,8 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
> >  TEST_GEN_PROGS_riscv += set_memory_region_test
> >  TEST_GEN_PROGS_riscv += kvm_binary_stats_test
> >
> > +SPLIT_TESTS += get-reg-list
> > +
> >  TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
> >  TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
> >  TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
> > @@ -228,11 +230,14 @@ LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
> >  LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
> >  LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
> >  LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
> > +SPLIT_TESTS_TARGETS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
> > +SPLIT_TESTS_OBJS := $(patsubst %, $(ARCH_DIR)/%.o, $(SPLIT_TESTS))
> >
> >  TEST_GEN_OBJ = $(patsubst %, %.o, $(TEST_GEN_PROGS))
> >  TEST_GEN_OBJ += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
> >  TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_OBJ))
> >  TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBKVM_OBJS))
> > +TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TESTS_OBJS))
> >  -include $(TEST_DEP_FILES)
> >
> >  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
> > @@ -240,7 +245,10 @@ $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
> >  $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
> >         $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> >
> > -EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) cscope.*
> > +$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
> > +       $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
> > +
> > +EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) $(SPLIT_TESTS_OBJS) cscope.*
> >
> >  x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
> >  $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c
> 
> Hi @Andrew Jones,
> 
> After rebasing to v6.5-rc3, some changes are needed to the SPLIT_TESTS
> target, or the make would fail.
> Please help have a look.
>

I took a look and then remembered why I hate looking at Makefiles... I
guess it's fine, but it's a pity we need to repeat the $(CC) line.

Thanks,
drew
