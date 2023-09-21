Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8D7A9632
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 19:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjIURAZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIURAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 13:00:21 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF1E73
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 09:59:18 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4121130e7afso7416911cf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695315557; x=1695920357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9nCvb9CrO2GaZq009DzYQ8CxVOSv0DQu3f44RpIAl4=;
        b=cQ9/egk3+iGU+nnFDE3GfLYKcXMSG/eXqyR2G8uPWYZaM3SGteyTCf5hN04FHGhtI/
         vZ8pPAorCK8cDuH1W9GAG4VrkegH+6QkFaK9zFtYI+x6buiH8lTU6pQ7sfEbW86qyWhL
         NxJwO7NMH8gF6K2ojBV6lZeUchRe1JfQ0YXqFqeVzZAEIujNLdk9muv/fh9+L4t8ZAqw
         mZ0UasVPig0HULVpBHqoWFrCgyysJIVjuk3Ee349vMH1YjDq55DFGiwL3v7Cn/w1rLjQ
         7GqnZOURKjyY1loV1EtyXfdxtQk2JSAj6wmC50agHQ4vnkggWhVWNGNfgFvJrZQtO/gX
         Z5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315557; x=1695920357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9nCvb9CrO2GaZq009DzYQ8CxVOSv0DQu3f44RpIAl4=;
        b=FXLV4UuTIxLicnKTzxPl+BKLMkC/WS7rsIa632Dd3oviXjZC9RbCOxMn7WY7zZCUjS
         JRlS8x35WQD5wxXt81e5WZ1ZhuRcmyVTExs1dK1BVaLxYSnRgBECDQokxoDEfUesNk/N
         Bp4smRn4WCjVD2Y+Hy99BoqAMcC0uxLov+wVknjr19KY7Q0cC2kPvZHCuq0ELmZgpvwi
         BUiZ8Q3VpvzBdNNbvZ4u+UnhXLI8KteEYnYvfDvvp/2BGiZEzMJOJS7gOHPPzwfZhLzU
         wbmFInuAKqFD57Iyx78hw4o9tz2FqdKpX2R1rISov9hbIk7NFEM54ibPS2XZOqEH6eSc
         PPvA==
X-Gm-Message-State: AOJu0YytpZ5XDmrfNV6TmKsrLd+V59MbwQOQ0e8YSSfUHQEKaAwG9mBz
        oaiu4TtVEODcnLhFvY0uPgJQD7SVrC30416LGXdvBWW+GCcgGKtoo+o=
X-Google-Smtp-Source: AGHT+IHVPuhFW+sGrMGW2iY7pMa14QvaelEddHySWV/HAgZhZpuV4DDEx4xNG/hsPPFcqiqQeUvbDngd1S9ogJ2JCoI=
X-Received: by 2002:a17:90a:c08a:b0:268:553f:1938 with SMTP id
 o10-20020a17090ac08a00b00268553f1938mr4569172pjs.4.1695273761830; Wed, 20 Sep
 2023 22:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230920154608.1447057-1-apatel@ventanamicro.com>
In-Reply-To: <20230920154608.1447057-1-apatel@ventanamicro.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 21 Sep 2023 10:52:29 +0530
Message-ID: <CAK9=C2WXtRLTFA5JeWbkyKt+1qyTat0nw7v3-b6oQ-YO_37tdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] KVM RISC-V fixes for ONE_REG interface
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 9:16=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This series includes few assorted fixes for KVM RISC-V ONE_REG interface
> and KVM_GET_REG_LIST API.
>
> These patches can also be found in riscv_kvm_onereg_fixes_v2 branch at:
> https://github.com/avpatel/linux.git
>
> Changes since v1:
>  - Addressed Drew's comments in PATCH4
>
> Anup Patel (4):
>   RISC-V: KVM: Fix KVM_GET_REG_LIST API for ISA_EXT registers
>   RISC-V: KVM: Fix riscv_vcpu_get_isa_ext_single() for missing
>     extensions
>   KVM: riscv: selftests: Fix ISA_EXT register handling in get-reg-list
>   KVM: riscv: selftests: Selectively filter-out AIA registers

Queued this series for 6.6-rcX fixes

Thanks,
Anup

>
>  arch/riscv/kvm/vcpu_onereg.c                  |  7 ++-
>  .../selftests/kvm/riscv/get-reg-list.c        | 58 ++++++++++++++-----
>  2 files changed, 47 insertions(+), 18 deletions(-)
>
> --
> 2.34.1
>
