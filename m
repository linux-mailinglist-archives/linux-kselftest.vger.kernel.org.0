Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492BC6FD33D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 02:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjEJAKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 20:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjEJAKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 20:10:21 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC0C2D54
        for <linux-kselftest@vger.kernel.org>; Tue,  9 May 2023 17:10:19 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-44ff2f8ec9dso4067865e0c.1
        for <linux-kselftest@vger.kernel.org>; Tue, 09 May 2023 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683677419; x=1686269419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8U/kO56+ryvdgd3Zu/MG4y3wVGQ9K4RFuHgypD9NY8=;
        b=B4e5IgXnj5eYQ0nrDYPT0l/I0eEVBZqccr94/V4cXIgml1nGfa1Mou1iDiPOTcbeV5
         l3aFzN9MvGCC4SbhDRQmLv07G/H2qMk2T3Mg+U0NX2Pd+AGzjjhIUDy+4I8/dQ+trKP9
         eZd86vB/hRXjeDk7tlOagjpX8WSZjtZrmXoIlCvMsZZ6vDaVv7nGE8NXzgTKg+Et1O9l
         nGGfvxNkcU8QK9LSfd8B9V0+R7np15eFLpkWP9Pf+JI+YNnLFsrQL7SVnSGSxrhrFnlh
         JYRC0MS+Bgv29woF2nFVPISoIdbFVRIdoYU0PW8BGnGAwI/fjJzWOOMegAWd96mK7ytF
         JNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683677419; x=1686269419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8U/kO56+ryvdgd3Zu/MG4y3wVGQ9K4RFuHgypD9NY8=;
        b=V6EiKBdlgCphxhAXn2O4UrnS4IdQUOsjuyf7D6xiUgiXjK8d9A2193m4fXQ8lvscTO
         ZauLTDzP/3R0HMAo94i5Vw7pnVs1AsnUW0gfB/k/BZpBm6a1sMpFOrkKS3SguIHMzeHR
         oBJrrxF3ZvbkQD6zX+8udouY17IkWhjfoWiY6jcvcpYkrCmbWXXELQDaTWtWlAoRl4vo
         BcwLu01JvVqg1zXg9FIFuW7/fB+XdIi03E8Bx6gF0XHS2ShPV599FgWg7AKZuHydAg+o
         kxRJMJ5nyyF5Omp3FBd8VrAwkUbFvMfh5kkSSMvOhhC9UI+sXAWHNxJ1KjhP8hHijBuY
         QRdQ==
X-Gm-Message-State: AC+VfDxO8hc/iI79JAoxbLYpj8Sj+qyPO9Xd7gCcLEfvJI+OIJuo5H/6
        TKIUkcULVErvYAZYJXThTV5pqNTURU/uiLFjfq2phA==
X-Google-Smtp-Source: ACHHUZ4/yLqsxT7gr4uXUox8qdQEWI+m5ZFqDA/qsRHG0fk45lXq0QBGPNfZT+/+DidyFxUWKBZ4JFnI2TP/CWHPT1A=
X-Received: by 2002:a1f:e601:0:b0:44f:d211:2df3 with SMTP id
 d1-20020a1fe601000000b0044fd2112df3mr5054876vkh.13.1683677418877; Tue, 09 May
 2023 17:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Tue, 9 May 2023 17:10:07 -0700
Message-ID: <CAAYXXYyfDyXxHH7Rw-iKMdqT+ymSG5vdGMvQKE8Wm3OSwE9E=Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] TDX Guest Quote generation support
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
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 12, 2023 at 8:42=E2=80=AFPM Kuppuswamy Sathyanarayanan
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


Thanks Kuppuswamy for the v2 of this patch set.
I reviewed all  3 patches and it looks good for me and it covers our use ca=
ses.

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
>  arch/x86/coco/tdx/tdx.c                      | 196 +++++++++++++++++++
>  arch/x86/include/asm/tdx.h                   |   8 +
>  drivers/virt/coco/tdx-guest/tdx-guest.c      | 168 +++++++++++++++-
>  include/uapi/linux/tdx-guest.h               |  43 ++++
>  tools/testing/selftests/tdx/tdx_guest_test.c |  68 ++++++-
>  6 files changed, 487 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>
