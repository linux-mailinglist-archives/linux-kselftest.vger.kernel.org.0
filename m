Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC54A6CCDB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 00:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjC1Wyq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 18:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjC1Wym (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 18:54:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B5F2134
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 15:54:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o20so11291469ljp.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 15:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680044079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQYGlpoRo1xAwVZPEjjkyX2GN+AkTkrmM4VsIqlC63Q=;
        b=hEDALw7vFU3va/s2tPcKbQO9CLwqO9q5v5uWuTq2vrfjEek2ZVqY0WYm5we6BTZEIl
         1agBVKGbeWNEETZHhj05FgIedv7+iusFiVTkHSUHaujrImhB9ViRVSASouqDwy+IsuZR
         0NPdygmgdleGaozVT4yfMj2G25oqFbxEv8FJohz7LOq8GIwpsYbMHcCiOERaRD3hiRp/
         VgMUoAqoieYWDxwaU0wzWiWVqNosIqmfgxxZldKhotidSP4I324OqFeByF5viJnKz2ym
         XGXUmMZoDKzYIwPYqMoNTvgjaoCC5916l5n2N/ZeXdi5S4HSNm+8dnTTfpzhxrSpaOvA
         7HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680044079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQYGlpoRo1xAwVZPEjjkyX2GN+AkTkrmM4VsIqlC63Q=;
        b=4QZ27KIcJT07TQ6/VB8U1PSp4yWrOrvWH0LI8sXBSXHZn65UBMFYkX52Mg3qVIpGWT
         FMCEE+R/jpVjd2I+q0uKA5pqFZ291ypq478mTOHFKzi/rdqge5eu64i6kHcQ23UC28wW
         jGifB09L07wSv8zGMu4bjbzoak4bXAQx6FZHHy3ClIwkiemGr6YjolWnR/SNXsd04HvV
         pt0iJzbjOvIxiVvnTLQWb/4HwhmjBfMzHG9y+guweVFeDmxBPYRfAq89Ctn8is6ThowP
         RIcdL3ELxHKjq8RQv0tA1ZcLaNmQG9Eay3c9AMyvrvOd6m/UnwdCHi49xTD4/NbkDwBB
         J5gg==
X-Gm-Message-State: AAQBX9f66YVRRUhcd36rrAylGCWg35hxO8r7vErI+j8zXe87cEnnSCgR
        BM+BSRaBkoCmpFYtqXw3+M+Xrm5vlSnnQdQc2JKRXg==
X-Google-Smtp-Source: AKy350Y5TFzrIJsXARd1vQbyj0sEWRDRlKxH3oCr7ze3JctueqdMfYeUkP6IeAd3Df0QKFBZ10sfWV0EEU6xl+gW+I4=
X-Received: by 2002:a2e:6a17:0:b0:298:b375:ace9 with SMTP id
 f23-20020a2e6a17000000b00298b375ace9mr5186560ljc.9.1680044079673; Tue, 28 Mar
 2023 15:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230327163203.2918455-1-evan@rivosinc.com> <d47020f9-e5a8-4ef3-94bc-6aa6f6b2465c@spud>
In-Reply-To: <d47020f9-e5a8-4ef3-94bc-6aa6f6b2465c@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 28 Mar 2023 15:54:03 -0700
Message-ID: <CALs-HsvvKSCKzPZ8e9xst=vKOZHuByDHm5WHaE8mz66_WFMKkQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] RISC-V Hardware Probing User Interface
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        vineetg@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Xu <peterx@redhat.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Shuah Khan <shuah@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 27, 2023 at 11:34=E2=80=AFPM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> On Mon, Mar 27, 2023 at 09:31:57AM -0700, Evan Green wrote:
>
> Hey Evan,
>
> Patchwork has a rake of complaints about the series unfortunately:
> https://patchwork.kernel.org/project/linux-riscv/list/?series=3D734234
>
> Some of the checkpatch whinging may be spurious, but there's some
> definitely valid stuff in there!
>
> > Evan Green (6):
> >   RISC-V: Move struct riscv_cpuinfo to new header
> >   RISC-V: Add a syscall for HW probing
> >   RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
> >   RISC-V: hwprobe: Support probing of misaligned access performance
> >   selftests: Test the new RISC-V hwprobe interface
>
> >   RISC-V: Add hwprobe vDSO function and data
>
> And this one breaks the build for !MMU kernels unfortunately.

Drat! Ok, thanks for the heads up. I'll go track these down.
-Evan
