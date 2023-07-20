Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4475A710
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 08:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGTG71 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 02:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGTG71 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 02:59:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC60132
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 23:59:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31441bc0092so337374f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 23:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689836364; x=1690441164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT1DoIojr0lvslKOunqTR4YXj4PFl+5LQJAMXq3nC5E=;
        b=ZDbx6qAcN8P+a9zusWZTkSl9rouTQF/iSqEtve1lkFjxsrKdWPD6dMC2Umr3gK0sIm
         nkzMw50TbmJwgcQIx++d1ggHjzr6+sA6GAKvbxlNWECwqbhFRvboEMDbjSOMt6CFznjJ
         O36ADGX1UaNkxZWfL7VJnxC+Cw3dNijMi+5cHTLgKK8SiFsVriuYykuE2k1SMWR22XY6
         5WxT4DDw/UrHFcXUA/TDL5yUwwgAoniALRtBlkd8RbObdZKNO0W+L2Z2Ac61fVFTAtPL
         YHLVKQefTrzGZrXQCVxFRHfphf2SXdfAdIWaHdz9BRl6fVTzOf00WkysK5x98InR9zeP
         FHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836364; x=1690441164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pT1DoIojr0lvslKOunqTR4YXj4PFl+5LQJAMXq3nC5E=;
        b=UmKlyZMdEzZ4sSo4uYcB0gbTHHckaIyi135MZkCf8+ZAq1Wj2yA+vqgUWwKe8Z0UeY
         Xx9Y7ssynC0e/EKD1VPgxS5IEHnjtlig8COf1B8mISyvXG3YtUpBhuHnff96n7LQ9dVR
         U4wldsHNVYqHfpEYmIPFsR55i9UuewUxtJFn2/vYp5fZB2lCPkY0CMfpYyjpuhB6m1Gt
         1z0zQbl38WqxoCbctoWWsQaJ7gdmu9eYhIVxxLaJiOuCeUVfLUpJEnrHOFzXylsuQD+G
         cc9wrKK+QVySoJYLzrlUVJ9Nqr8PvfhO9Y7U6NySQxpPg/MWy4huKSxbfnwZod3Rc/oB
         Ixbg==
X-Gm-Message-State: ABy/qLYAQSvWfRqEwHHjkLQ7HlvtnIImjVtPl1UMsqC97IiOtOHGowKE
        VmbJSoDaj57No4lmSI7GM054b1+Tc+CIkOxU2qCQzg==
X-Google-Smtp-Source: APBJJlG41skPij9fp8nZyKeEoH9myLamnBgBOCZf3SxF3pb6Xp13yIhuN0hjhRkJju4WSDs1jm0RLUedZXc7rvYty9A=
X-Received: by 2002:a05:6000:1c2:b0:30f:b7b4:3e55 with SMTP id
 t2-20020a05600001c200b0030fb7b43e55mr1436688wrx.19.1689836363671; Wed, 19 Jul
 2023 23:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230714165508.94561-1-charlie@rivosinc.com> <20230714165508.94561-5-charlie@rivosinc.com>
In-Reply-To: <20230714165508.94561-5-charlie@rivosinc.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 20 Jul 2023 08:59:12 +0200
Message-ID: <CAHVXubgSLhsMdS3aFbSuPNf2d_FXhztnFtRnbjsMstH5coCHWA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] RISC-V: mm: Document mmap changes
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 14, 2023 at 6:56=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> The behavior of mmap is modified with this patch series, so explain the
> changes to the mmap hint address behavior.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/riscv/vm-layout.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-l=
ayout.rst
> index 5462c84f4723..892412b91300 100644
> --- a/Documentation/riscv/vm-layout.rst
> +++ b/Documentation/riscv/vm-layout.rst
> @@ -133,3 +133,25 @@ RISC-V Linux Kernel SV57
>     ffffffff00000000 |  -4     GB | ffffffff7fffffff |    2 GB | modules,=
 BPF
>     ffffffff80000000 |  -2     GB | ffffffffffffffff |    2 GB | kernel
>    __________________|____________|__________________|_________|_________=
___________________________________________________
> +
> +
> +Userspace VAs
> +--------------------
> +To maintain compatibility with software that relies on the VA space with=
 a
> +maximum of 48 bits the kernel will, by default, return virtual addresses=
 to
> +userspace from a 48-bit range (sv48). This default behavior is achieved =
by
> +passing 0 into the hint address parameter of mmap. On CPUs with an addre=
ss space
> +smaller than sv48, the CPU maximum supported address space will be the d=
efault.
> +
> +Software can "opt-in" to receiving VAs from another VA space by providin=
g
> +a hint address to mmap. A call to mmap is guaranteed to return an addres=
s
> +that will not override the unset left-aligned bits in the hint address,
> +unless there is no space left in the address space. If there is no space
> +available in the requested address space, an address in the next smalles=
t
> +available address space will be returned.
> +
> +For example, in order to obtain 48-bit VA space, a hint address greater =
than
> +:code:`1 << 38` must be provided.

Is this correct? Shouldn't the hint be strictly greater than the
address space it targets? In patch 1, you state that "A hint address
passed to mmap will cause the largest address space that fits entirely
into the hint to be used", it seems contradictory to me.

> Note that this is 38 due to sv39 userspace
> +ending at :code:`1 << 38` and the addresses beyond this are reserved for=
 the
> +kernel. Similarly, to obtain 57-bit VA space addresses, a hint address g=
reater
> +than or equal to :code:`1 << 47` must be provided.
> --
> 2.41.0
>
