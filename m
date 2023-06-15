Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F78732141
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 23:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjFOVCK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 17:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjFOVCK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 17:02:10 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CDE193
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jun 2023 14:02:08 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-62df53196edso1041316d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jun 2023 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686862927; x=1689454927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM071qijEG6vwQ8W2iWjOXAWrKZk2GbsTR59ysMJ+f0=;
        b=r3+18zMpdGu3FBIH/XR/CeWPIdLuk9aHwOyPzPMPD+aHBmCQpHV+CqHUcVxkyh3f56
         fQ7+hwVRMsFfVJ6+fAgFxywc9Ey5lBpqCJ1GP/M6gvUqaPeqlGn+b+LTUfV+eWSTjehP
         AttQBBokUk9dBF//9b4mMJFpP/2IYaDEkFoGTV/xU2CUd5Kss+CHXPeuI2SnlPARzQjV
         627F9+EcbOVoZxCvs6FMh/M6bErKb9BknEk6bpMOEacDUXg9U3FvnUNrB1OD8WsQ5mpN
         ftALbqUPSTzgQw4ZxwDtP2xWijGeHdmJZRHt9ceN4vbAImdo/Irw3ryRWU7EZjVnA/Lw
         osEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686862927; x=1689454927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM071qijEG6vwQ8W2iWjOXAWrKZk2GbsTR59ysMJ+f0=;
        b=X8l95qv2qwT4BFCNJ75Rz3Ts8MryxeKVrt4NaBGH4y8EQgqN1AabLvGH6eJbp2V+cB
         L7DbscXX3v4iuDRWkkU9OY5SezOQTZakUm4s0dK5Hj2o5bsDBCc05nau4uUaDeyuiTBC
         P8iXXS2LLVbgNRTa/d6wX1yc2MkIyxa0sZgiIAna5Hlbe2JuqVng3iFLMZGowALpYqaV
         k4ACCfKPj3IARxbqQFfZdcQ8KRxPP3Of3lEt57VX6ITvdsQhMaqi0RKVeAcy9nEPE3pN
         8n6W5/CRkdPkQPJHtmZfjz/9fjtECQHfy+6dl44b6g3SMceu80bVUgqbd2BA06lDCwGW
         0cOg==
X-Gm-Message-State: AC+VfDwu3lmlL2so0zRfaZaMOHsriiIWRpEIGZFzZzkrdVdTbyvsmMHB
        n8Jgm11kGZwtsfvboi/D/Appm96Ur8fXPdPQY3I+Mw==
X-Google-Smtp-Source: ACHHUZ4krPXQb/OSjDusqHVygPJ8Ls9dUMXR5x901QOHwbeTZhZdMqBueLHq0YUPgxe/cr08Jcvy1LCoC+5/N/PO2+Y=
X-Received: by 2002:ad4:5d62:0:b0:62f:f23e:14fe with SMTP id
 fn2-20020ad45d62000000b0062ff23e14femr102715qvb.20.1686862927549; Thu, 15 Jun
 2023 14:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230614-kselftest-mm-llvm-v1-1-180523f277d3@kernel.org>
In-Reply-To: <20230614-kselftest-mm-llvm-v1-1-180523f277d3@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Jun 2023 17:01:56 -0400
Message-ID: <CAKwvOdk0sPi95TSdbyEKXud68nHq_7=ccDwaCkVsyd54ArRC=A@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Fix cross compilation with LLVM
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 14, 2023 at 5:19=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> Currently the MM selftests attempt to work out the target architecture by
> using CROSS_COMPILE or otherwise querying the host machine, storing the
> target architecture in a variable called MACHINE rather than the usual AR=
CH
> though as far as I can tell (including for x86_64) the value is the same =
as
> we would use for architecture.
>
> When cross compiling with LLVM we don't need a CROSS_COMPILE as LLVM can
> support many target architectures in a single build so this logic does no=
t
> work, CROSS_COMPILE is not set and we end up selecting tests for the host
> rather than target architecture. Fix this by using the more standard ARCH
> to describe the architecture, taking it from the environment if specified=
.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Broonie,
Thanks for the patch! What's the best way to test this?

$ ARCH=3Darm64 make LLVM=3D1 -j128 -C tools/testing/selfte
sts/mm/

Is what I would have guessed, but I get errors with or without this patch.

Also, fwiw, b4 shows that you don't have a pgp key setup for
broonie@kernel.org; I don't think it matters, but maybe it's a
surprise to you if you thought you had set that up,
$ b4 shazam https://lore.kernel.org/llvm/20230614-kselftest-mm-llvm-v1-1-18=
0523f277d3@kernel.org/
...
  =E2=9C=97 No key: openpgp/broonie@kernel.org


> ---
>  tools/testing/selftests/mm/Makefile | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftest=
s/mm/Makefile
> index 23af4633f0f4..4f0c50c33ba7 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -5,12 +5,15 @@ LOCAL_HDRS +=3D $(selfdir)/mm/local_config.h $(top_srcd=
ir)/mm/gup_test.h
>
>  include local_config.mk
>
> +ifeq ($(ARCH),)
> +
>  ifeq ($(CROSS_COMPILE),)
>  uname_M :=3D $(shell uname -m 2>/dev/null || echo not)
>  else
>  uname_M :=3D $(shell echo $(CROSS_COMPILE) | grep -o '^[a-z0-9]\+')
>  endif
> -MACHINE ?=3D $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's=
/ppc64.*/ppc64/')
> +ARCH ?=3D $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/pp=
c64.*/ppc64/')
> +endif
>
>  # Without this, failed build products remain, with up-to-date timestamps=
,
>  # thus tricking Make (and you!) into believing that All Is Well, in subs=
equent
> @@ -65,7 +68,7 @@ TEST_GEN_PROGS +=3D ksm_tests
>  TEST_GEN_PROGS +=3D ksm_functional_tests
>  TEST_GEN_PROGS +=3D mdwe_test
>
> -ifeq ($(MACHINE),x86_64)
> +ifeq ($(ARCH),x86_64)
>  CAN_BUILD_I386 :=3D $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_=
32bit_program.c -m32)
>  CAN_BUILD_X86_64 :=3D $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivia=
l_64bit_program.c)
>  CAN_BUILD_WITH_NOPIE :=3D $(shell ./../x86/check_cc.sh "$(CC)" ../x86/tr=
ivial_program.c -no-pie)
> @@ -87,13 +90,13 @@ TEST_GEN_PROGS +=3D $(BINARIES_64)
>  endif
>  else
>
> -ifneq (,$(findstring $(MACHINE),ppc64))
> +ifneq (,$(findstring $(ARCH),ppc64))
>  TEST_GEN_PROGS +=3D protection_keys
>  endif
>
>  endif
>
> -ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s39=
0x sparc64 x86_64))
> +ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x =
sparc64 x86_64))
>  TEST_GEN_PROGS +=3D va_high_addr_switch
>  TEST_GEN_PROGS +=3D virtual_address_range
>  TEST_GEN_PROGS +=3D write_to_hugetlbfs
> @@ -112,7 +115,7 @@ $(TEST_GEN_PROGS): vm_util.c
>  $(OUTPUT)/uffd-stress: uffd-common.c
>  $(OUTPUT)/uffd-unit-tests: uffd-common.c
>
> -ifeq ($(MACHINE),x86_64)
> +ifeq ($(ARCH),x86_64)
>  BINARIES_32 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
>  BINARIES_64 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
>
>
> ---
> base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
> change-id: 20230614-kselftest-mm-llvm-a25a7daffa6f
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>
>


--=20
Thanks,
~Nick Desaulniers
