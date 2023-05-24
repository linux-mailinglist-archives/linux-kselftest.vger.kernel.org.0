Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A264C71000F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 23:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjEXVeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 17:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjEXVeN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 17:34:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F614123
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 14:34:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f6e83e12fso211703666b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684964049; x=1687556049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1P02ygObyIDE9xEYpmdTLdG1kQ58BidHyF2QEKFct0=;
        b=JuFJLCYCw0ii3MUii5D+NNmk1WX+e0euXi7WDZJOtCSW6/rNpBWaDaCiRozFN0XujG
         4NGy5ThwKE8FetHv9BTiQSHNJaUll2SEL5rtOH+lcH3GBaB/9Dl2KRUqF2ovEXxGuY0B
         mbKPbIrvpA9Imc9gXSLjNVQv0dZdYlz8ANoSYIEa3wWczxG51gcdoKe5FXoDrYA49CnV
         hE6KZrDVVgZB3doREz6t+Yz0wrjn2ynUjQKeHojnC2szV2SJ9pTJ+D/hH+O9RBC4QhPP
         GhDoEgxUS8NTJCF6WalNtsR1ked57ynl1S8tz+i1475j6BzxaExIg5NQqj6HohUW3jDs
         XxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684964049; x=1687556049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1P02ygObyIDE9xEYpmdTLdG1kQ58BidHyF2QEKFct0=;
        b=XCwIzGAH28AgJjv/NOv6VIAJswwXsYTPS/dvL72djqnFglQw2SYh9gSW6DAWVUJ0i+
         N8cdPiEXZQ4FcRyaM4kfxcwvIaZNxcGLipMDyckS9Ill7u7y222SinlWnFlyl52embSn
         fKT4IFVK8FwShp5+P/Qi6DHksyZJHcRxSBPCwku5VQmAwsKlG+BbQXpp+HUgCvWBcKv3
         jdGRGITQP3N/WY0R9s07AIRQnYa72U6J1YhdDTrSOvOMrCYN9ZIMS0Gcs8OqwndQDQ1G
         DGWvDxXzfYT6rR5aycw9NHWqcvD91zjCIhRwdQwa7xio4NiClHs8cfA4gdya4j32xQZ8
         J9Ww==
X-Gm-Message-State: AC+VfDxcqH3zoMin+lehb4EI3SfktemUlvEeB0rCOFDkE3vf8cEukkhP
        peD+evV9tOZgIvCXc68HJl9rTTmoDXozS2g6Xki/FA==
X-Google-Smtp-Source: ACHHUZ71UsaaryHaS10+63H01EwtKQi2VgeR246vudtO41ywuCQPuFlCiXRf1cZ8HGm+wPGJLnzNe07n72787A7bzOw=
X-Received: by 2002:a17:907:3e26:b0:967:2abb:2cec with SMTP id
 hp38-20020a1709073e2600b009672abb2cecmr18102161ejc.64.1684964049241; Wed, 24
 May 2023 14:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Chong Cai <chongc@google.com>
Date:   Wed, 24 May 2023 14:33:58 -0700
Message-ID: <CALRH0CjSko=j9w1U6OY6NaZ-jav1t7adxdK40=FV5gbF2yX1PQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] TDX Guest Quote generation support
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
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

Tested-by: Qinkun Bao <qinkun@google.com>

Thanks Sathyanarayanan for the new patch! This patch is critical for
our use case.
We built a guest image with the patch, and verified it works for us,
when using a host kernel built with https://github.com/intel/tdx repo.

On Sun, May 14, 2023 at 12:24=E2=80=AFAM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi All,
>
> In TDX guest, the attestation process is used to verify the TDX guest
> trustworthiness to other entities before provisioning secrets to the
> guest.
>
> The TDX guest attestation process consists of two steps:
>
> 1. TDREPORT generation
> 2. Quote generation.
>
> The First step (TDREPORT generation) involves getting the TDX guest
> measurement data in the format of TDREPORT which is further used to
> validate the authenticity of the TDX guest. The second step involves
> sending the TDREPORT to a Quoting Enclave (QE) server to generate a
> remotely verifiable Quote. TDREPORT by design can only be verified on
> the local platform. To support remote verification of the TDREPORT,
> TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
> locally and convert it to a remotely verifiable Quote. Although
> attestation software can use communication methods like TCP/IP or
> vsock to send the TDREPORT to QE, not all platforms support these
> communication models. So TDX GHCI specification [1] defines a method
> for Quote generation via hypercalls. Please check the discussion from
> Google [2] and Alibaba [3] which clarifies the need for hypercall based
> Quote generation support. This patch set adds this support.
>
> Support for TDREPORT generation already exists in the TDX guest driver.
> This patchset extends the same driver to add the Quote generation
> support.
>
> Following are the details of the patch set:
>
> Patch 1/3 -> Adds event notification IRQ support.
> Patch 2/3 -> Adds Quote generation support.
> Patch 3/3 -> Adds selftest support for Quote generation feature.
>
> [1] https://cdrdv2.intel.com/v1/dl/getContent/726790, section titled "TDG=
.VP.VMCALL<GetQuote>".
> [2] https://lore.kernel.org/lkml/CAAYXXYxxs2zy_978GJDwKfX5Hud503gPc8=3D1k=
Q-+JwG_kA79mg@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/a69faebb-11e8-b386-d591-dbd08330b008@lin=
ux.alibaba.com/
>
> Kuppuswamy Sathyanarayanan (3):
>   x86/tdx: Add TDX Guest event notify interrupt support
>   virt: tdx-guest: Add Quote generation support
>   selftests/tdx: Test GetQuote TDX attestation feature
>
>  Documentation/virt/coco/tdx-guest.rst        |  11 ++
>  arch/x86/coco/tdx/tdx.c                      | 194 +++++++++++++++++++
>  arch/x86/include/asm/tdx.h                   |   8 +
>  drivers/virt/coco/tdx-guest/tdx-guest.c      | 175 ++++++++++++++++-
>  include/uapi/linux/tdx-guest.h               |  44 +++++
>  tools/testing/selftests/tdx/tdx_guest_test.c |  65 ++++++-
>  6 files changed, 490 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>
