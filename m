Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7615E7BA044
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjJEOex (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 10:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjJEOdV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:33:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AD66183
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Oct 2023 23:06:01 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27751ac0653so424587a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Oct 2023 23:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1696485960; x=1697090760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+OzM9WN1Dh21ubOEAVeEY0lIe+PfmIXwuMmmkct6SM=;
        b=3epmckszdy4PjWzn5YVDphkhm9OrhQM7y7LAUm4eew3ZWJ6bwKrZlEq+Umbmmz5raV
         vQm8MSbe6MN5MA4J4DVh5+RVZp+a4R5+/kLoMdCJVRupOLMQI4sxF65IdguQAMN/+ubT
         BbonGFbERKH/jLvTjtE0H+chxQRxMlYOremQIcjTNpU56P0tNbIyZyLlYrDWMB+xvcT9
         pioobganbB3Ey9jmXZRFQlnj3K3WZzE6PKBgdJYbHqTgHsB6R+GjNEh1NKaK8ohq77x0
         saCP6CEtk4x5f6BIWhgmGAnbJtOwe4mFIGW7ayR1mZ165u7hQQdUzViADIkKXqcP1Eyj
         uOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696485960; x=1697090760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+OzM9WN1Dh21ubOEAVeEY0lIe+PfmIXwuMmmkct6SM=;
        b=aG4VrzBFwA9EL7FnmjLm3oKlpDjVlQZAw/E8PT6BQI3UjKa/79JJrd0HGjkqrj4aJs
         85YuTn6LivdJpF+3zC/zlrIEqQBM0p+alGw/MuLC8tVh06yCYeiOSqyGflv3UnSasArG
         v7VGnJcDIpl7G74Hku3lnLVEXtpP5yFSU33t5hPy38tVBvKinqDCztwEphE7ed8EgcWQ
         tlp2UQ42sifsw2NW3B7ud1nLpnydY8l4ldXzbm4iUKoTfQqVYILsKVRkvy/DdXPofFRA
         a3BBWy5dR4r2hThb/8e1FMk3LLIvpqY3J2K6F1mgbDAsma1ESXErOTdWydO1YTG+0j1J
         pzhA==
X-Gm-Message-State: AOJu0YzitFJSRB0pPAaXNbd/SILRmFPyZbM6o3SruCnjS4AgvvFgl45g
        JjanhMf+psEej1zbCX21qybcQ0RJdchtg1DMk6Yj+A==
X-Google-Smtp-Source: AGHT+IG1fxwb2v6SLkh4Fkaz8cqMSdUWu3blXiCEco3U0En8uebQJpE7wswsbpc3LD+Oi31mdQhRZwbY+N7+m1uQ3rk=
X-Received: by 2002:a17:90b:84:b0:268:15dd:c5c7 with SMTP id
 bb4-20020a17090b008400b0026815ddc5c7mr3855515pjb.40.1696485960557; Wed, 04
 Oct 2023 23:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231003035226.1945725-1-apatel@ventanamicro.com>
In-Reply-To: <20231003035226.1945725-1-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 5 Oct 2023 11:35:50 +0530
Message-ID: <CAAhSdy0P=5WiFfFyMHjkd63JKCcjsTsvhLTNgUB+LOCd8A9iOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] KVM RISC-V Conditional Operations
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 3, 2023 at 9:22=E2=80=AFAM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> This series extends KVM RISC-V to allow Guest/VM discover and use
> conditional operations related ISA extensions (namely XVentanaCondOps
> and Zicond).
>
> To try these patches, use KVMTOOL from riscv_zbx_zicntr_smstateen_condops=
_v1
> branch at: https://github.com/avpatel/kvmtool.git
>
> These patches are based upon the latest riscv_kvm_queue and can also be
> found in the riscv_kvm_condops_v3 branch at:
> https://github.com/avpatel/linux.git
>
> Changes since v2:
>  - Dropped patch1, patch2, and patch5 since these patches don't meet
>    the requirements of patch acceptance policy.
>
> Changes since v1:
>  - Rebased the series on riscv_kvm_queue
>  - Split PATCH1 and PATCH2 of v1 series into two patches
>  - Added separate test configs for XVentanaCondOps and Zicond in PATCH7
>    of v1 series.
>
> Anup Patel (6):
>   dt-bindings: riscv: Add Zicond extension entry
>   RISC-V: Detect Zicond from ISA string
>   RISC-V: KVM: Allow Zicond extension for Guest/VM
>   KVM: riscv: selftests: Add senvcfg register to get-reg-list test
>   KVM: riscv: selftests: Add smstateen registers to get-reg-list test
>   KVM: riscv: selftests: Add condops extensions to get-reg-list test

Queued this series for Linux-6.7

Thanks,
Anup

>
>  .../devicetree/bindings/riscv/extensions.yaml |  6 +++
>  arch/riscv/include/asm/hwcap.h                |  1 +
>  arch/riscv/include/uapi/asm/kvm.h             |  1 +
>  arch/riscv/kernel/cpufeature.c                |  1 +
>  arch/riscv/kvm/vcpu_onereg.c                  |  2 +
>  .../selftests/kvm/riscv/get-reg-list.c        | 54 +++++++++++++++++++
>  6 files changed, 65 insertions(+)
>
> --
> 2.34.1
>
