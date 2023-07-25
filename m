Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E689760DA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjGYIxl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjGYIwp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:52:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C728127;
        Tue, 25 Jul 2023 01:50:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b7441bfa9eso66814571fa.0;
        Tue, 25 Jul 2023 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690275048; x=1690879848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9E3/WWnB3oqCCKicWHSv17L65rJSzN/sd8dp6vx1FQ=;
        b=YLNBowiTU69Ja/HCaBea3FPTx+ls86SNtFC7ONC0KOg1J7cu8IZFnZLwwk4n2zDxjI
         XcekrqM13pSQl1pAaXQNtLR6GwEWBCVKYp+eWbbv63yKHgnMaptHCzfDRz9bt6v7u/9M
         gDLGiBuH3dKnyH5ENURz+/XYHBCcShB5X7tICrtdjKdBrGStkjmgtVg05s7GKhG4rPwh
         CZTU62ahmVHuQRO2FlyKtsdFUKXxwTy4ZHKMsgmx3hHO8ezOMuRNWqyTNBtA19xQvwKS
         sDWM93WmkQ7KG7S045C7WLtYgGtDJ0fb0ixTPKfHbyOsrhBClBQgrBqntgbAZeC3Z8oK
         oImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275048; x=1690879848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9E3/WWnB3oqCCKicWHSv17L65rJSzN/sd8dp6vx1FQ=;
        b=RMt7w1H2nRBzx2KWiVopWU5wkZoPIpzMYlHGwo+C1Rl5wKAtby4VR2CyhNr0gnQqff
         vOcrNPSmvIRHzYfHQMtoWJ/lXjc14XB+ZWh8Bd0mDD5VTJniqz7CXWS/sTbE/mbX4btc
         Lz841/8RgK/97amTXeY86YvT9F1LYYDkjC1L2Xlc+bqKJ41cTOn7flB3sPdW9n8U/aZb
         2eYCELH1FUXBRC6tFGYbyo2dysckw1Ya2jWWC+/+9xtx8A7TYzKPtGZ/3T9rAVgO+Tjt
         aGHxGz7W5FWg9Xt37KTvfRbKuMGcvFEvqrtnDpW71VF3prtJQaiScFnh5xD2DftOCLUy
         jStQ==
X-Gm-Message-State: ABy/qLaRz4M/wlZj4O4w7O4dJdQgkrkz6i6kAFYuGZcTNF+OLnyUFDT9
        kEqzdJ2jH6I0nKMcexo0DhnxhRC/er+pdYekaus=
X-Google-Smtp-Source: APBJJlGBlJjhXA317NVJI8YZATKyklEw0tkXtLszo383gTFM/xNrJUX6GWwD9HJEgK2Q2+0j7hQmt2LxipqVhYinjTg=
X-Received: by 2002:a2e:8e31:0:b0:2b6:a0c8:fde3 with SMTP id
 r17-20020a2e8e31000000b002b6a0c8fde3mr748982ljk.6.1690275048115; Tue, 25 Jul
 2023 01:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690273969.git.haibo1.xu@intel.com> <1f25f27d1316bc91e1e31cd3d50a1d20f696759a.1690273969.git.haibo1.xu@intel.com>
In-Reply-To: <1f25f27d1316bc91e1e31cd3d50a1d20f696759a.1690273969.git.haibo1.xu@intel.com>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Tue, 25 Jul 2023 16:50:36 +0800
Message-ID: <CAJve8okJ-HYpsOrqH4Zvn7OBtwXWa4JumC+ZsMfHKB-deVYd2A@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] KVM: arm64: selftests: Split get-reg-list test code
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     ajones@ventanamicro.com, maz@kernel.org, oliver.upton@linux.dev,
        seanjc@google.com, Paolo Bonzini <pbonzini@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 4:37=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> From: Andrew Jones <ajones@ventanamicro.com>
>
> Split the arch-neutral test code out of aarch64/get-reg-list.c into
> get-reg-list.c. To do this we invent a new make variable
> $(SPLIT_TESTS) which expects common parts to be in the KVM selftests
> root and the counterparts to have the same name, but be in
> $(ARCH_DIR).
>
> There's still some work to be done to de-aarch64 the common
> get-reg-list.c, but we leave that to the next patch to avoid
> modifying too much code while moving it.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |  12 +-
>  .../selftests/kvm/aarch64/get-reg-list.c      | 367 +----------------
>  tools/testing/selftests/kvm/get-reg-list.c    | 377 ++++++++++++++++++
>  3 files changed, 398 insertions(+), 358 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/get-reg-list.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index c692cc86e7da..95f180e711d5 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -140,7 +140,6 @@ TEST_GEN_PROGS_EXTENDED_x86_64 +=3D x86_64/nx_huge_pa=
ges_test
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/aarch32_id_regs
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/arch_timer
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/debug-exceptions
> -TEST_GEN_PROGS_aarch64 +=3D aarch64/get-reg-list
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/hypercalls
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/page_fault_test
>  TEST_GEN_PROGS_aarch64 +=3D aarch64/psci_test
> @@ -152,6 +151,7 @@ TEST_GEN_PROGS_aarch64 +=3D access_tracking_perf_test
>  TEST_GEN_PROGS_aarch64 +=3D demand_paging_test
>  TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
>  TEST_GEN_PROGS_aarch64 +=3D dirty_log_perf_test
> +TEST_GEN_PROGS_aarch64 +=3D get-reg-list
>  TEST_GEN_PROGS_aarch64 +=3D kvm_create_max_vcpus
>  TEST_GEN_PROGS_aarch64 +=3D kvm_page_table_test
>  TEST_GEN_PROGS_aarch64 +=3D memslot_modification_stress_test
> @@ -181,6 +181,8 @@ TEST_GEN_PROGS_riscv +=3D kvm_page_table_test
>  TEST_GEN_PROGS_riscv +=3D set_memory_region_test
>  TEST_GEN_PROGS_riscv +=3D kvm_binary_stats_test
>
> +SPLIT_TESTS +=3D get-reg-list
> +
>  TEST_PROGS +=3D $(TEST_PROGS_$(ARCH_DIR))
>  TEST_GEN_PROGS +=3D $(TEST_GEN_PROGS_$(ARCH_DIR))
>  TEST_GEN_PROGS_EXTENDED +=3D $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
> @@ -228,11 +230,14 @@ LIBKVM_C_OBJ :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(=
LIBKVM_C))
>  LIBKVM_S_OBJ :=3D $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
>  LIBKVM_STRING_OBJ :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
>  LIBKVM_OBJS =3D $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
> +SPLIT_TESTS_TARGETS :=3D $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
> +SPLIT_TESTS_OBJS :=3D $(patsubst %, $(ARCH_DIR)/%.o, $(SPLIT_TESTS))
>
>  TEST_GEN_OBJ =3D $(patsubst %, %.o, $(TEST_GEN_PROGS))
>  TEST_GEN_OBJ +=3D $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
>  TEST_DEP_FILES =3D $(patsubst %.o, %.d, $(TEST_GEN_OBJ))
>  TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(LIBKVM_OBJS))
> +TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(SPLIT_TESTS_OBJS))
>  -include $(TEST_DEP_FILES)
>
>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
> @@ -240,7 +245,10 @@ $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
>  $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
>         $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>
> -EXTRA_CLEAN +=3D $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) cscope=
.*
> +$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
> +       $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS=
) -o $@
> +
> +EXTRA_CLEAN +=3D $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) $(SPLI=
T_TESTS_OBJS) cscope.*
>
>  x :=3D $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
>  $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c

Hi @Andrew Jones,

After rebasing to v6.5-rc3, some changes are needed to the SPLIT_TESTS
target, or the make would fail.
Please help have a look.

Regards,
Haibo
