Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9646DD242
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 07:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDKF5l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 01:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjDKF5i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 01:57:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062C52D7B;
        Mon, 10 Apr 2023 22:57:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ud9so17280677ejc.7;
        Mon, 10 Apr 2023 22:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1681192637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GUD9yijmU2vznVIxO0uguX/ETkIRPP+R6vlejm8iH3A=;
        b=jSZdo1wtv4gzEvX4J3w0SJrZ0TKscwSVtBsZijS9j6qXePnpDefEgFR/+DsCoS2XZl
         7lxW496fDD546lH25dzDrMY38jtLXcN2hVhf54Uw6Ln8Spv0ZRGnhkb+ACjEoLIsOHuR
         keAkTDZ8rUZhccLTvCHhBAXoQNwoqQjecy4H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681192637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUD9yijmU2vznVIxO0uguX/ETkIRPP+R6vlejm8iH3A=;
        b=PDNiLhrAUZ1p7FWJ5sp2s+C9qxMw7iifSPjm8iTXi5lDb1mpP1V0at46gdhZlpG+Lr
         aV0b7DsSL+HSykQ+vPObxSbKg5t8Ofkd+Qv/oGkPK/sSj7DDR33jkKndh4atx5dbzRUt
         Wf9GMLP0wW+NVS97HD6CJZ1IpZQqafH787hvU0Qij/JxpmsBz0J3VOBteRk15CifXmfe
         BULMSkaW7kHwoDbAb4ZDYVdSaLQV5rpdn2+NSXz+7n2yU/0akjpJB8WoWBDtSDIRF/ca
         C1hWjIVRJBVSgv9HRVrNlaWYfNQcKyk3VRdYESRqcDVmfJEo78nNnOH4USTp9NEvteIR
         0lhg==
X-Gm-Message-State: AAQBX9cm+UThGdubeXrxyp4f+5dWlH53Ifn/c1elzpiwXRp2HUOcPMeY
        KEC4BrHOGKL8p30i8LJAf0Cl3tLicmAnhydH4vcde6FyJOQ=
X-Google-Smtp-Source: AKy350bWIaPszbl+8ZTUlnZswNv+DDIa4V3lvErdkuyIy4DyIRrAtDIkK+ieEjR0YoCV5dlQJy9rjsxfg+2wCz4SJOU=
X-Received: by 2002:a17:907:75d9:b0:94b:28ff:9e89 with SMTP id
 jl25-20020a17090775d900b0094b28ff9e89mr1703013ejc.15.1681192636857; Mon, 10
 Apr 2023 22:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230408040020.868929-1-npiggin@gmail.com>
In-Reply-To: <20230408040020.868929-1-npiggin@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 11 Apr 2023 05:57:04 +0000
Message-ID: <CACPK8Xfw6S+pHDuWvoed=PkE7XUHme=eXoWRbLfCFKRO9w=C2w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] KVM: selftests: add powerpc support
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 8 Apr 2023 at 04:01, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> This series adds initial KVM selftests support for powerpc
> (64-bit, BookS, radix MMU).

This means the tests won't work on power8. Perhaps you could add
something like this?

--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -33,6 +33,8 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
        vm_paddr_t prtb, pgtb;
        size_t pgd_pages;

+       TEST_REQUIRE(kvm_has_cap(KVM_CAP_PPC_MMU_RADIX));
+

>
> Since v1:
> - Update MAINTAINERS KVM PPC entry to include kvm selftests.
> - Fixes and cleanups from Sean's review including new patch 1.
> - Add 4K guest page support requiring new patch 2.
>
> Thanks,
> Nick
>
> Nicholas Piggin (4):
>   KVM: selftests: Move pgd_created check into virt_pgd_alloc
>   KVM: selftests: Add aligned guest physical page allocator
>   KVM: PPC: selftests: add support for powerpc
>   KVM: PPC: selftests: add selftests sanity tests
>
>  MAINTAINERS                                   |   2 +
>  tools/testing/selftests/kvm/Makefile          |  15 +
>  .../selftests/kvm/include/kvm_util_base.h     |  27 ++
>  .../selftests/kvm/include/powerpc/hcall.h     |  21 +
>  .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
>  .../selftests/kvm/include/powerpc/processor.h |  33 ++
>  .../selftests/kvm/lib/aarch64/processor.c     |   4 -
>  tools/testing/selftests/kvm/lib/guest_modes.c |   3 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  56 ++-
>  .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
>  .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
>  .../selftests/kvm/lib/powerpc/processor.c     | 429 ++++++++++++++++++
>  .../testing/selftests/kvm/lib/powerpc/ucall.c |  30 ++
>  .../selftests/kvm/lib/riscv/processor.c       |   4 -
>  .../selftests/kvm/lib/s390x/processor.c       |   4 -
>  .../selftests/kvm/lib/x86_64/processor.c      |   7 +-
>  tools/testing/selftests/kvm/powerpc/helpers.h |  46 ++
>  .../testing/selftests/kvm/powerpc/null_test.c | 166 +++++++
>  .../selftests/kvm/powerpc/rtas_hcall.c        | 146 ++++++
>  19 files changed, 1129 insertions(+), 34 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
>  create mode 100644 tools/testing/selftests/kvm/powerpc/helpers.h
>  create mode 100644 tools/testing/selftests/kvm/powerpc/null_test.c
>  create mode 100644 tools/testing/selftests/kvm/powerpc/rtas_hcall.c
>
> --
> 2.40.0
>
