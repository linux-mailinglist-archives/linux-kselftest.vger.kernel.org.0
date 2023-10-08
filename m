Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF077BCBC8
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Oct 2023 04:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjJHC7N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 22:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjJHC7M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 22:59:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F8EBC;
        Sat,  7 Oct 2023 19:59:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50433d8385cso4576979e87.0;
        Sat, 07 Oct 2023 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696733949; x=1697338749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScEsw5kRuBSyCrQaTmCBYUka5dQTvwb6RwilZml22rc=;
        b=hVVbDEWLLxEn0JCbIiru9h3H94b7ftOGKPB4SA/lFZcxADytR2YlVdOwCs5qRQ+qHS
         LLHHf6XKzMeHIxuW35mielGI2OzqBYirS3nIZvTkrnnFia5gMxG+xxSV/5PvCMARl6N5
         IGegdjwnd1Q2oQ0J8D1tbwH/QsALrSoFU4YQ/jOAUFgdM+pcgEm2IuTkmIMKNjSAWqDn
         TYd3l8eOHaD5UKxBgaOHDqUeolzjonvbfl7cA6UshfULvZOZ5SE4OXKBAiGgypRmbJVo
         khyfus8VKzusezhY9lctlRu7VsJXEURO1nfPi4NtTAxxdqv8B/8i50IIM751mUyVRJ2L
         1rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696733949; x=1697338749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScEsw5kRuBSyCrQaTmCBYUka5dQTvwb6RwilZml22rc=;
        b=MnZvIkjwONI0yUy4cIGOzv92xwv0zof9A3bZLnTtfXJr0O0PB1G89opAm0MS870OOH
         wTI5UkUCpJienes0sRzj2Aqgl5lsDwY+YKzoBkLqoLtCOSPI/ek3Ceb8OgDpX9JQBB5z
         PorDqQH9lUkcoNUHSZ60lMou7/R83Vb09k42Ay14iNdiEVe9c01d60W3ZWiFCkMy9l76
         Dp6gUJqHleK4SlWODHmizb4tQS3dQfwKU25Re/JG77oTn5SkMZDExW7IG1JtYBfYQVYd
         fOp+HYidOvyLcAE6njqG3CuZryTYoop48B5632Z20AOe7n/BayXaYfDvZhsUaxaB+q6D
         WdnQ==
X-Gm-Message-State: AOJu0Yyzf44wFoMr3WtG9fO4bMW6/QidFLD8tUDMMJ0vRQMsj8MefL+r
        4QNhHX7tg4yrpJz4ueZHQOh39XZTwrJbegd3GKE=
X-Google-Smtp-Source: AGHT+IEpb2yeFTzMhQ8mODQ9bJzzgKP4xcGT3Fdr1mnHynSEwgLk6lyxwCFHJcwsd6qGQGzx5r8I8XmeCKBxhv85QXI=
X-Received: by 2002:a05:6512:1154:b0:501:bd43:3b9c with SMTP id
 m20-20020a056512115400b00501bd433b9cmr11192604lfg.23.1696733948681; Sat, 07
 Oct 2023 19:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694421911.git.haibo1.xu@intel.com> <cda6cc71c9bdde87fe87f6c2dec4f03ca249dd62.1694421911.git.haibo1.xu@intel.com>
 <20231003-d44206f71d0b22e539833697@orel>
In-Reply-To: <20231003-d44206f71d0b22e539833697@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Sun, 8 Oct 2023 10:58:57 +0800
Message-ID: <CAJve8o=Q74U0Z3PayrzY7heNc0qeTw5VYS+tdkpm=aJdefQEbQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] KVM: selftests: Unify the makefile rule for split targets
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 3, 2023 at 6:28=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Thu, Sep 14, 2023 at 09:36:56AM +0800, Haibo Xu wrote:
> > A separate makefile rule was used for split targets which was added
> > in patch(KVM: arm64: selftests: Split get-reg-list test code). This
> > could be avoided by minor changes to the recipes of current rule.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/Makefile | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> > index a3bb36fb3cfc..7972269e8c5f 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -249,13 +249,10 @@ TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(SPLIT_=
TESTS_OBJS))
> >  -include $(TEST_DEP_FILES)
> >
> >  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
> > -     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM=
_OBJS) $(LDLIBS) -o $@
> > +     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS=
) -o $@
> >  $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
> >       $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> >
> > -$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
> > -     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS=
) -o $@
> > -
> >  EXTRA_CLEAN +=3D $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) $(SP=
LIT_TESTS_OBJS) cscope.*
> >
> >  x :=3D $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ)))=
)
> > @@ -274,6 +271,7 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
> >  x :=3D $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> >  $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
> >  $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
> > +$(SPLIT_TESTS_TARGETS): $(OUTPUT)/%: $(ARCH_DIR)/%.o
> >
> >  cscope: include_paths =3D $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) incl=
ude lib ..
> >  cscope:
> > --
> > 2.34.1
> >
>
> I just noticed that with and without this patch we're building the
> arch-specific part in tools/testing/selftests/kvm/riscv even when we have
> an $(OUTPUT) directory (e.g. O=3Dbuild). Those build artifacts should be =
in
> build/kselftest/kvm/riscv instead.
>

Thanks for pointing it out. I will have a look in next week!

> Thanks,
> drew
