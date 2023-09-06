Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36E3793567
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 08:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjIFGgC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 02:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjIFGgB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 02:36:01 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D2CDB;
        Tue,  5 Sep 2023 23:35:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so54342661fa.2;
        Tue, 05 Sep 2023 23:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693982154; x=1694586954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWk9261dl9yT3+tRA+dP2sa8Zh3sqGeWIt1riM3bl/o=;
        b=ZYHceVU4/4S05biB78lQgYYwLmvLnFF61RzjPNMMq/f276EKmnzijM5m8KY77+eDlY
         yr/fPi2R0UJOkPVUIfa9ulVVyaDW9qT/pI3iVP5Gl1ygLvXwGQRk38qwjw95N16Gc1QY
         rh1vtT5gv2EXeiN0+Ow/BZBO6RXgA/Ba/NxiJT6fzybnZvyaVD01tmwfRoq4vZe11f8E
         E/GOjEwIXugk3hU20PywUCVb1XnXi/XURL9cdinafnGqynTipuW6bd72YpvvMPi2qpQT
         8ZkzzaDR+QImjDK+5/+zXsiGGobxszaG11n+BJ5wbUu9DD/iv/CUXxj9RaYVSPYgbh6U
         gPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693982154; x=1694586954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWk9261dl9yT3+tRA+dP2sa8Zh3sqGeWIt1riM3bl/o=;
        b=lb/Y6X19RJ8mcFUFWvxTy7gC10RX3m8JwIilgYmwvOflaaQMNYIOZlAkSfw4YBTjh2
         pg61zx8nNs+Y8i01NyCI6TMkiVeceP/V5vtM4r5mHBGeQ4njcyWbQMtnOc5qdWsMe2ER
         Fxdd18TtOsKalCdrEi2T4Gnq3VhX4IIbVG/t36T2imklzHTKd17ZwnlpxEDDbzt7ta5Y
         p25obmOL9q7yYBVR0Bsc49QmUCzR7yfd2jm3Iadx5l4ZsBQpjkY0GrLsyyWfrnKUdC+v
         LHzFuT7Nr7sN66TynlpmlwUpuF6NX8TG5kHQgnVI51a3/ZeSYRRb2I4Tfogx3t8jLX3i
         T3bw==
X-Gm-Message-State: AOJu0YxG7n9+LmEAhMbuVTexg4iYmtn1bo8Nr23KldM2L1iomRvCPdNN
        /y+PO7LIoiNZIbOwRuH0/Hnr6vmalETOBnn9UFk=
X-Google-Smtp-Source: AGHT+IH/OTSGo8oNlVEs24IU/Tp7NwIpeyY5T+E3bCZYbTrKqx8+lnJ+ckT0ttJ9AI+Kn/CI/PqrvRDUda9YZCtQ9GE=
X-Received: by 2002:a2e:954d:0:b0:2be:3ca8:bdc9 with SMTP id
 t13-20020a2e954d000000b002be3ca8bdc9mr1430213ljh.49.1693982153959; Tue, 05
 Sep 2023 23:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <8173daae52720dbdabbd88a5d412f653e6706de1.1693659382.git.haibo1.xu@intel.com>
 <20230904-06f09083d5190fd50e53b1ea@orel>
In-Reply-To: <20230904-06f09083d5190fd50e53b1ea@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 6 Sep 2023 14:35:42 +0800
Message-ID: <CAJve8on7Yi7cDuXOVznuRdTvfUhig2hZy8g72nvnHkM7omoVAw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] tools: riscv: Add header file csr.h
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
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        wchen <waylingii@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>, Like Xu <likexu@tencent.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>,
        zhang songyi <zhang.songyi@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
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

On Mon, Sep 4, 2023 at 9:33=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Sat, Sep 02, 2023 at 08:59:25PM +0800, Haibo Xu wrote:
> > Borrow the csr definitions and operations from kernel's
> > arch/riscv/include/asm/csr.h to tools/ for riscv.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/arch/riscv/include/asm/csr.h | 521 +++++++++++++++++++++++++++++
> >  1 file changed, 521 insertions(+)
> >  create mode 100644 tools/arch/riscv/include/asm/csr.h
> >
> > diff --git a/tools/arch/riscv/include/asm/csr.h b/tools/arch/riscv/incl=
ude/asm/csr.h
> > new file mode 100644
> > index 000000000000..4e86c82aacbd
> > --- /dev/null
> > +++ b/tools/arch/riscv/include/asm/csr.h
> > @@ -0,0 +1,521 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2015 Regents of the University of California
> > + */
> > +
> > +#ifndef _ASM_RISCV_CSR_H
> > +#define _ASM_RISCV_CSR_H
> > +
> > +#include <linux/bits.h>
> > +
> > +/* Status register flags */
> > +#define SR_SIE               _AC(0x00000002, UL) /* Supervisor Interru=
pt Enable */
> > +#define SR_MIE               _AC(0x00000008, UL) /* Machine Interrupt =
Enable */
> > +#define SR_SPIE              _AC(0x00000020, UL) /* Previous Superviso=
r IE */
> > +#define SR_MPIE              _AC(0x00000080, UL) /* Previous Machine I=
E */
> > +#define SR_SPP               _AC(0x00000100, UL) /* Previously Supervi=
sor */
> > +#define SR_MPP               _AC(0x00001800, UL) /* Previously Machine=
 */
> > +#define SR_SUM               _AC(0x00040000, UL) /* Supervisor User Me=
mory Access */
> > +
> > +#define SR_FS                _AC(0x00006000, UL) /* Floating-point Sta=
tus */
> > +#define SR_FS_OFF    _AC(0x00000000, UL)
> > +#define SR_FS_INITIAL        _AC(0x00002000, UL)
> > +#define SR_FS_CLEAN  _AC(0x00004000, UL)
> > +#define SR_FS_DIRTY  _AC(0x00006000, UL)
> > +
> > +#define SR_VS                _AC(0x00000600, UL) /* Vector Status */
> > +#define SR_VS_OFF    _AC(0x00000000, UL)
> > +#define SR_VS_INITIAL        _AC(0x00000200, UL)
> > +#define SR_VS_CLEAN  _AC(0x00000400, UL)
> > +#define SR_VS_DIRTY  _AC(0x00000600, UL)
> > +
> > +#define SR_XS                _AC(0x00018000, UL) /* Extension Status *=
/
> > +#define SR_XS_OFF    _AC(0x00000000, UL)
> > +#define SR_XS_INITIAL        _AC(0x00008000, UL)
> > +#define SR_XS_CLEAN  _AC(0x00010000, UL)
> > +#define SR_XS_DIRTY  _AC(0x00018000, UL)
> > +
> > +#define SR_FS_VS     (SR_FS | SR_VS) /* Vector and Floating-Point Unit=
 */
> > +
> > +#ifndef CONFIG_64BIT
>
> How do we ensure CONFIG_64BIT is set?
>

Currently, no explicit checking for this.
Shall we add a gatekeeper in this file to ensure it is set?

#ifndef CONFIG_64BIT
#error "CONFIG_64BIT was not set"
#endif

> Thanks,
> drew
>
> > +#define SR_SD                _AC(0x80000000, UL) /* FS/VS/XS dirty */
> > +#else
> > +#define SR_SD                _AC(0x8000000000000000, UL) /* FS/VS/XS d=
irty */
> > +#endif
> > +
> > +#ifdef CONFIG_64BIT
> > +#define SR_UXL               _AC(0x300000000, UL) /* XLEN mask for U-m=
ode */
> > +#define SR_UXL_32    _AC(0x100000000, UL) /* XLEN =3D 32 for U-mode */
> > +#define SR_UXL_64    _AC(0x200000000, UL) /* XLEN =3D 64 for U-mode */
> > +#endif
> > +
> > +/* SATP flags */
> > +#ifndef CONFIG_64BIT
> > +#define SATP_PPN     _AC(0x003FFFFF, UL)
> > +#define SATP_MODE_32 _AC(0x80000000, UL)
> > +#define SATP_ASID_BITS       9
> > +#define SATP_ASID_SHIFT      22
> > +#define SATP_ASID_MASK       _AC(0x1FF, UL)
> > +#else
> > +#define SATP_PPN     _AC(0x00000FFFFFFFFFFF, UL)
> > +#define SATP_MODE_39 _AC(0x8000000000000000, UL)
> > +#define SATP_MODE_48 _AC(0x9000000000000000, UL)
> > +#define SATP_MODE_57 _AC(0xa000000000000000, UL)
> > +#define SATP_ASID_BITS       16
> > +#define SATP_ASID_SHIFT      44
> > +#define SATP_ASID_MASK       _AC(0xFFFF, UL)
> > +#endif
> > +
> > +/* Exception cause high bit - is an interrupt if set */
> > +#define CAUSE_IRQ_FLAG               (_AC(1, UL) << (__riscv_xlen - 1)=
)
> > +
> > +/* Interrupt causes (minus the high bit) */
> > +#define IRQ_S_SOFT           1
> > +#define IRQ_VS_SOFT          2
> > +#define IRQ_M_SOFT           3
> > +#define IRQ_S_TIMER          5
> > +#define IRQ_VS_TIMER         6
> > +#define IRQ_M_TIMER          7
> > +#define IRQ_S_EXT            9
> > +#define IRQ_VS_EXT           10
> > +#define IRQ_M_EXT            11
> > +#define IRQ_S_GEXT           12
> > +#define IRQ_PMU_OVF          13
> > +#define IRQ_LOCAL_MAX                (IRQ_PMU_OVF + 1)
> > +#define IRQ_LOCAL_MASK               GENMASK((IRQ_LOCAL_MAX - 1), 0)
> > +
> > +/* Exception causes */
> > +#define EXC_INST_MISALIGNED  0
> > +#define EXC_INST_ACCESS              1
> > +#define EXC_INST_ILLEGAL     2
> > +#define EXC_BREAKPOINT               3
> > +#define EXC_LOAD_MISALIGNED  4
> > +#define EXC_LOAD_ACCESS              5
> > +#define EXC_STORE_MISALIGNED 6
> > +#define EXC_STORE_ACCESS     7
> > +#define EXC_SYSCALL          8
> > +#define EXC_HYPERVISOR_SYSCALL       9
> > +#define EXC_SUPERVISOR_SYSCALL       10
> > +#define EXC_INST_PAGE_FAULT  12
> > +#define EXC_LOAD_PAGE_FAULT  13
> > +#define EXC_STORE_PAGE_FAULT 15
> > +#define EXC_INST_GUEST_PAGE_FAULT    20
> > +#define EXC_LOAD_GUEST_PAGE_FAULT    21
> > +#define EXC_VIRTUAL_INST_FAULT               22
> > +#define EXC_STORE_GUEST_PAGE_FAULT   23
> > +
> > +/* PMP configuration */
> > +#define PMP_R                        0x01
> > +#define PMP_W                        0x02
> > +#define PMP_X                        0x04
> > +#define PMP_A                        0x18
> > +#define PMP_A_TOR            0x08
> > +#define PMP_A_NA4            0x10
> > +#define PMP_A_NAPOT          0x18
> > +#define PMP_L                        0x80
> > +
> > +/* HSTATUS flags */
> > +#ifdef CONFIG_64BIT
> > +#define HSTATUS_VSXL         _AC(0x300000000, UL)
> > +#define HSTATUS_VSXL_SHIFT   32
> > +#endif
> > +#define HSTATUS_VTSR         _AC(0x00400000, UL)
> > +#define HSTATUS_VTW          _AC(0x00200000, UL)
> > +#define HSTATUS_VTVM         _AC(0x00100000, UL)
> > +#define HSTATUS_VGEIN                _AC(0x0003f000, UL)
> > +#define HSTATUS_VGEIN_SHIFT  12
> > +#define HSTATUS_HU           _AC(0x00000200, UL)
> > +#define HSTATUS_SPVP         _AC(0x00000100, UL)
> > +#define HSTATUS_SPV          _AC(0x00000080, UL)
> > +#define HSTATUS_GVA          _AC(0x00000040, UL)
> > +#define HSTATUS_VSBE         _AC(0x00000020, UL)
> > +
> > +/* HGATP flags */
> > +#define HGATP_MODE_OFF               _AC(0, UL)
> > +#define HGATP_MODE_SV32X4    _AC(1, UL)
> > +#define HGATP_MODE_SV39X4    _AC(8, UL)
> > +#define HGATP_MODE_SV48X4    _AC(9, UL)
> > +#define HGATP_MODE_SV57X4    _AC(10, UL)
> > +
> > +#define HGATP32_MODE_SHIFT   31
> > +#define HGATP32_VMID_SHIFT   22
> > +#define HGATP32_VMID         GENMASK(28, 22)
> > +#define HGATP32_PPN          GENMASK(21, 0)
> > +
> > +#define HGATP64_MODE_SHIFT   60
> > +#define HGATP64_VMID_SHIFT   44
> > +#define HGATP64_VMID         GENMASK(57, 44)
> > +#define HGATP64_PPN          GENMASK(43, 0)
> > +
> > +#define HGATP_PAGE_SHIFT     12
> > +
> > +#ifdef CONFIG_64BIT
> > +#define HGATP_PPN            HGATP64_PPN
> > +#define HGATP_VMID_SHIFT     HGATP64_VMID_SHIFT
> > +#define HGATP_VMID           HGATP64_VMID
> > +#define HGATP_MODE_SHIFT     HGATP64_MODE_SHIFT
> > +#else
> > +#define HGATP_PPN            HGATP32_PPN
> > +#define HGATP_VMID_SHIFT     HGATP32_VMID_SHIFT
> > +#define HGATP_VMID           HGATP32_VMID
> > +#define HGATP_MODE_SHIFT     HGATP32_MODE_SHIFT
> > +#endif
> > +
> > +/* VSIP & HVIP relation */
> > +#define VSIP_TO_HVIP_SHIFT   (IRQ_VS_SOFT - IRQ_S_SOFT)
> > +#define VSIP_VALID_MASK              ((_AC(1, UL) << IRQ_S_SOFT) | \
> > +                              (_AC(1, UL) << IRQ_S_TIMER) | \
> > +                              (_AC(1, UL) << IRQ_S_EXT))
> > +
> > +/* AIA CSR bits */
> > +#define TOPI_IID_SHIFT               16
> > +#define TOPI_IID_MASK                GENMASK(11, 0)
> > +#define TOPI_IPRIO_MASK              GENMASK(7, 0)
> > +#define TOPI_IPRIO_BITS              8
> > +
> > +#define TOPEI_ID_SHIFT               16
> > +#define TOPEI_ID_MASK                GENMASK(10, 0)
> > +#define TOPEI_PRIO_MASK              GENMASK(10, 0)
> > +
> > +#define ISELECT_IPRIO0               0x30
> > +#define ISELECT_IPRIO15              0x3f
> > +#define ISELECT_MASK         GENMASK(8, 0)
> > +
> > +#define HVICTL_VTI           BIT(30)
> > +#define HVICTL_IID           GENMASK(27, 16)
> > +#define HVICTL_IID_SHIFT     16
> > +#define HVICTL_DPR           BIT(9)
> > +#define HVICTL_IPRIOM                BIT(8)
> > +#define HVICTL_IPRIO         GENMASK(7, 0)
> > +
> > +/* xENVCFG flags */
> > +#define ENVCFG_STCE                  (_AC(1, ULL) << 63)
> > +#define ENVCFG_PBMTE                 (_AC(1, ULL) << 62)
> > +#define ENVCFG_CBZE                  (_AC(1, UL) << 7)
> > +#define ENVCFG_CBCFE                 (_AC(1, UL) << 6)
> > +#define ENVCFG_CBIE_SHIFT            4
> > +#define ENVCFG_CBIE                  (_AC(0x3, UL) << ENVCFG_CBIE_SHIF=
T)
> > +#define ENVCFG_CBIE_ILL                      _AC(0x0, UL)
> > +#define ENVCFG_CBIE_FLUSH            _AC(0x1, UL)
> > +#define ENVCFG_CBIE_INV                      _AC(0x3, UL)
> > +#define ENVCFG_FIOM                  _AC(0x1, UL)
> > +
> > +/* symbolic CSR names: */
> > +#define CSR_CYCLE            0xc00
> > +#define CSR_TIME             0xc01
> > +#define CSR_INSTRET          0xc02
> > +#define CSR_HPMCOUNTER3              0xc03
> > +#define CSR_HPMCOUNTER4              0xc04
> > +#define CSR_HPMCOUNTER5              0xc05
> > +#define CSR_HPMCOUNTER6              0xc06
> > +#define CSR_HPMCOUNTER7              0xc07
> > +#define CSR_HPMCOUNTER8              0xc08
> > +#define CSR_HPMCOUNTER9              0xc09
> > +#define CSR_HPMCOUNTER10     0xc0a
> > +#define CSR_HPMCOUNTER11     0xc0b
> > +#define CSR_HPMCOUNTER12     0xc0c
> > +#define CSR_HPMCOUNTER13     0xc0d
> > +#define CSR_HPMCOUNTER14     0xc0e
> > +#define CSR_HPMCOUNTER15     0xc0f
> > +#define CSR_HPMCOUNTER16     0xc10
> > +#define CSR_HPMCOUNTER17     0xc11
> > +#define CSR_HPMCOUNTER18     0xc12
> > +#define CSR_HPMCOUNTER19     0xc13
> > +#define CSR_HPMCOUNTER20     0xc14
> > +#define CSR_HPMCOUNTER21     0xc15
> > +#define CSR_HPMCOUNTER22     0xc16
> > +#define CSR_HPMCOUNTER23     0xc17
> > +#define CSR_HPMCOUNTER24     0xc18
> > +#define CSR_HPMCOUNTER25     0xc19
> > +#define CSR_HPMCOUNTER26     0xc1a
> > +#define CSR_HPMCOUNTER27     0xc1b
> > +#define CSR_HPMCOUNTER28     0xc1c
> > +#define CSR_HPMCOUNTER29     0xc1d
> > +#define CSR_HPMCOUNTER30     0xc1e
> > +#define CSR_HPMCOUNTER31     0xc1f
> > +#define CSR_CYCLEH           0xc80
> > +#define CSR_TIMEH            0xc81
> > +#define CSR_INSTRETH         0xc82
> > +#define CSR_HPMCOUNTER3H     0xc83
> > +#define CSR_HPMCOUNTER4H     0xc84
> > +#define CSR_HPMCOUNTER5H     0xc85
> > +#define CSR_HPMCOUNTER6H     0xc86
> > +#define CSR_HPMCOUNTER7H     0xc87
> > +#define CSR_HPMCOUNTER8H     0xc88
> > +#define CSR_HPMCOUNTER9H     0xc89
> > +#define CSR_HPMCOUNTER10H    0xc8a
> > +#define CSR_HPMCOUNTER11H    0xc8b
> > +#define CSR_HPMCOUNTER12H    0xc8c
> > +#define CSR_HPMCOUNTER13H    0xc8d
> > +#define CSR_HPMCOUNTER14H    0xc8e
> > +#define CSR_HPMCOUNTER15H    0xc8f
> > +#define CSR_HPMCOUNTER16H    0xc90
> > +#define CSR_HPMCOUNTER17H    0xc91
> > +#define CSR_HPMCOUNTER18H    0xc92
> > +#define CSR_HPMCOUNTER19H    0xc93
> > +#define CSR_HPMCOUNTER20H    0xc94
> > +#define CSR_HPMCOUNTER21H    0xc95
> > +#define CSR_HPMCOUNTER22H    0xc96
> > +#define CSR_HPMCOUNTER23H    0xc97
> > +#define CSR_HPMCOUNTER24H    0xc98
> > +#define CSR_HPMCOUNTER25H    0xc99
> > +#define CSR_HPMCOUNTER26H    0xc9a
> > +#define CSR_HPMCOUNTER27H    0xc9b
> > +#define CSR_HPMCOUNTER28H    0xc9c
> > +#define CSR_HPMCOUNTER29H    0xc9d
> > +#define CSR_HPMCOUNTER30H    0xc9e
> > +#define CSR_HPMCOUNTER31H    0xc9f
> > +
> > +#define CSR_SSCOUNTOVF               0xda0
> > +
> > +#define CSR_SSTATUS          0x100
> > +#define CSR_SIE                      0x104
> > +#define CSR_STVEC            0x105
> > +#define CSR_SCOUNTEREN               0x106
> > +#define CSR_SSCRATCH         0x140
> > +#define CSR_SEPC             0x141
> > +#define CSR_SCAUSE           0x142
> > +#define CSR_STVAL            0x143
> > +#define CSR_SIP                      0x144
> > +#define CSR_SATP             0x180
> > +
> > +#define CSR_STIMECMP         0x14D
> > +#define CSR_STIMECMPH                0x15D
> > +
> > +/* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
> > +#define CSR_SISELECT         0x150
> > +#define CSR_SIREG            0x151
> > +
> > +/* Supervisor-Level Interrupts (AIA) */
> > +#define CSR_STOPEI           0x15c
> > +#define CSR_STOPI            0xdb0
> > +
> > +/* Supervisor-Level High-Half CSRs (AIA) */
> > +#define CSR_SIEH             0x114
> > +#define CSR_SIPH             0x154
> > +
> > +#define CSR_VSSTATUS         0x200
> > +#define CSR_VSIE             0x204
> > +#define CSR_VSTVEC           0x205
> > +#define CSR_VSSCRATCH                0x240
> > +#define CSR_VSEPC            0x241
> > +#define CSR_VSCAUSE          0x242
> > +#define CSR_VSTVAL           0x243
> > +#define CSR_VSIP             0x244
> > +#define CSR_VSATP            0x280
> > +#define CSR_VSTIMECMP                0x24D
> > +#define CSR_VSTIMECMPH               0x25D
> > +
> > +#define CSR_HSTATUS          0x600
> > +#define CSR_HEDELEG          0x602
> > +#define CSR_HIDELEG          0x603
> > +#define CSR_HIE                      0x604
> > +#define CSR_HTIMEDELTA               0x605
> > +#define CSR_HCOUNTEREN               0x606
> > +#define CSR_HGEIE            0x607
> > +#define CSR_HENVCFG          0x60a
> > +#define CSR_HTIMEDELTAH              0x615
> > +#define CSR_HENVCFGH         0x61a
> > +#define CSR_HTVAL            0x643
> > +#define CSR_HIP                      0x644
> > +#define CSR_HVIP             0x645
> > +#define CSR_HTINST           0x64a
> > +#define CSR_HGATP            0x680
> > +#define CSR_HGEIP            0xe12
> > +
> > +/* Virtual Interrupts and Interrupt Priorities (H-extension with AIA) =
*/
> > +#define CSR_HVIEN            0x608
> > +#define CSR_HVICTL           0x609
> > +#define CSR_HVIPRIO1         0x646
> > +#define CSR_HVIPRIO2         0x647
> > +
> > +/* VS-Level Window to Indirectly Accessed Registers (H-extension with =
AIA) */
> > +#define CSR_VSISELECT                0x250
> > +#define CSR_VSIREG           0x251
> > +
> > +/* VS-Level Interrupts (H-extension with AIA) */
> > +#define CSR_VSTOPEI          0x25c
> > +#define CSR_VSTOPI           0xeb0
> > +
> > +/* Hypervisor and VS-Level High-Half CSRs (H-extension with AIA) */
> > +#define CSR_HIDELEGH         0x613
> > +#define CSR_HVIENH           0x618
> > +#define CSR_HVIPH            0x655
> > +#define CSR_HVIPRIO1H                0x656
> > +#define CSR_HVIPRIO2H                0x657
> > +#define CSR_VSIEH            0x214
> > +#define CSR_VSIPH            0x254
> > +
> > +#define CSR_MSTATUS          0x300
> > +#define CSR_MISA             0x301
> > +#define CSR_MIDELEG          0x303
> > +#define CSR_MIE                      0x304
> > +#define CSR_MTVEC            0x305
> > +#define CSR_MENVCFG          0x30a
> > +#define CSR_MENVCFGH         0x31a
> > +#define CSR_MSCRATCH         0x340
> > +#define CSR_MEPC             0x341
> > +#define CSR_MCAUSE           0x342
> > +#define CSR_MTVAL            0x343
> > +#define CSR_MIP                      0x344
> > +#define CSR_PMPCFG0          0x3a0
> > +#define CSR_PMPADDR0         0x3b0
> > +#define CSR_MVENDORID                0xf11
> > +#define CSR_MARCHID          0xf12
> > +#define CSR_MIMPID           0xf13
> > +#define CSR_MHARTID          0xf14
> > +
> > +/* Machine-Level Window to Indirectly Accessed Registers (AIA) */
> > +#define CSR_MISELECT         0x350
> > +#define CSR_MIREG            0x351
> > +
> > +/* Machine-Level Interrupts (AIA) */
> > +#define CSR_MTOPEI           0x35c
> > +#define CSR_MTOPI            0xfb0
> > +
> > +/* Virtual Interrupts for Supervisor Level (AIA) */
> > +#define CSR_MVIEN            0x308
> > +#define CSR_MVIP             0x309
> > +
> > +/* Machine-Level High-Half CSRs (AIA) */
> > +#define CSR_MIDELEGH         0x313
> > +#define CSR_MIEH             0x314
> > +#define CSR_MVIENH           0x318
> > +#define CSR_MVIPH            0x319
> > +#define CSR_MIPH             0x354
> > +
> > +#define CSR_VSTART           0x8
> > +#define CSR_VCSR             0xf
> > +#define CSR_VL                       0xc20
> > +#define CSR_VTYPE            0xc21
> > +#define CSR_VLENB            0xc22
> > +
> > +#ifdef CONFIG_RISCV_M_MODE
> > +# define CSR_STATUS  CSR_MSTATUS
> > +# define CSR_IE              CSR_MIE
> > +# define CSR_TVEC    CSR_MTVEC
> > +# define CSR_SCRATCH CSR_MSCRATCH
> > +# define CSR_EPC     CSR_MEPC
> > +# define CSR_CAUSE   CSR_MCAUSE
> > +# define CSR_TVAL    CSR_MTVAL
> > +# define CSR_IP              CSR_MIP
> > +
> > +# define CSR_IEH             CSR_MIEH
> > +# define CSR_ISELECT CSR_MISELECT
> > +# define CSR_IREG    CSR_MIREG
> > +# define CSR_IPH             CSR_MIPH
> > +# define CSR_TOPEI   CSR_MTOPEI
> > +# define CSR_TOPI    CSR_MTOPI
> > +
> > +# define SR_IE               SR_MIE
> > +# define SR_PIE              SR_MPIE
> > +# define SR_PP               SR_MPP
> > +
> > +# define RV_IRQ_SOFT         IRQ_M_SOFT
> > +# define RV_IRQ_TIMER        IRQ_M_TIMER
> > +# define RV_IRQ_EXT          IRQ_M_EXT
> > +#else /* CONFIG_RISCV_M_MODE */
> > +# define CSR_STATUS  CSR_SSTATUS
> > +# define CSR_IE              CSR_SIE
> > +# define CSR_TVEC    CSR_STVEC
> > +# define CSR_SCRATCH CSR_SSCRATCH
> > +# define CSR_EPC     CSR_SEPC
> > +# define CSR_CAUSE   CSR_SCAUSE
> > +# define CSR_TVAL    CSR_STVAL
> > +# define CSR_IP              CSR_SIP
> > +
> > +# define CSR_IEH             CSR_SIEH
> > +# define CSR_ISELECT CSR_SISELECT
> > +# define CSR_IREG    CSR_SIREG
> > +# define CSR_IPH             CSR_SIPH
> > +# define CSR_TOPEI   CSR_STOPEI
> > +# define CSR_TOPI    CSR_STOPI
> > +
> > +# define SR_IE               SR_SIE
> > +# define SR_PIE              SR_SPIE
> > +# define SR_PP               SR_SPP
> > +
> > +# define RV_IRQ_SOFT         IRQ_S_SOFT
> > +# define RV_IRQ_TIMER        IRQ_S_TIMER
> > +# define RV_IRQ_EXT          IRQ_S_EXT
> > +# define RV_IRQ_PMU  IRQ_PMU_OVF
> > +# define SIP_LCOFIP     (_AC(0x1, UL) << IRQ_PMU_OVF)
> > +
> > +#endif /* !CONFIG_RISCV_M_MODE */
> > +
> > +/* IE/IP (Supervisor/Machine Interrupt Enable/Pending) flags */
> > +#define IE_SIE               (_AC(0x1, UL) << RV_IRQ_SOFT)
> > +#define IE_TIE               (_AC(0x1, UL) << RV_IRQ_TIMER)
> > +#define IE_EIE               (_AC(0x1, UL) << RV_IRQ_EXT)
> > +
> > +#ifdef __ASSEMBLY__
> > +#define __ASM_STR(x)    x
> > +#else
> > +#define __ASM_STR(x)    #x
> > +#endif
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +#define csr_swap(csr, val)                                   \
> > +({                                                           \
> > +     unsigned long __v =3D (unsigned long)(val);               \
> > +     __asm__ __volatile__ ("csrrw %0, " __ASM_STR(csr) ", %1"\
> > +                           : "=3Dr" (__v) : "rK" (__v)         \
> > +                           : "memory");                      \
> > +     __v;                                                    \
> > +})
> > +
> > +#define csr_read(csr)                                                \
> > +({                                                           \
> > +     register unsigned long __v;                             \
> > +     __asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)        \
> > +                           : "=3Dr" (__v) :                    \
> > +                           : "memory");                      \
> > +     __v;                                                    \
> > +})
> > +
> > +#define csr_write(csr, val)                                  \
> > +({                                                           \
> > +     unsigned long __v =3D (unsigned long)(val);               \
> > +     __asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"     \
> > +                           : : "rK" (__v)                    \
> > +                           : "memory");                      \
> > +})
> > +
> > +#define csr_read_set(csr, val)                                       \
> > +({                                                           \
> > +     unsigned long __v =3D (unsigned long)(val);               \
> > +     __asm__ __volatile__ ("csrrs %0, " __ASM_STR(csr) ", %1"\
> > +                           : "=3Dr" (__v) : "rK" (__v)         \
> > +                           : "memory");                      \
> > +     __v;                                                    \
> > +})
> > +
> > +#define csr_set(csr, val)                                    \
> > +({                                                           \
> > +     unsigned long __v =3D (unsigned long)(val);               \
> > +     __asm__ __volatile__ ("csrs " __ASM_STR(csr) ", %0"     \
> > +                           : : "rK" (__v)                    \
> > +                           : "memory");                      \
> > +})
> > +
> > +#define csr_read_clear(csr, val)                             \
> > +({                                                           \
> > +     unsigned long __v =3D (unsigned long)(val);               \
> > +     __asm__ __volatile__ ("csrrc %0, " __ASM_STR(csr) ", %1"\
> > +                           : "=3Dr" (__v) : "rK" (__v)         \
> > +                           : "memory");                      \
> > +     __v;                                                    \
> > +})
> > +
> > +#define csr_clear(csr, val)                                  \
> > +({                                                           \
> > +     unsigned long __v =3D (unsigned long)(val);               \
> > +     __asm__ __volatile__ ("csrc " __ASM_STR(csr) ", %0"     \
> > +                           : : "rK" (__v)                    \
> > +                           : "memory");                      \
> > +})
> > +
> > +#endif /* __ASSEMBLY__ */
> > +
> > +#endif /* _ASM_RISCV_CSR_H */
> > --
> > 2.34.1
> >
