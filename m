Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0B04CB118
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 22:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiCBVQl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 16:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiCBVQl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 16:16:41 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505F2110D
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 13:15:57 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2dbd97f9bfcso33379517b3.9
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Mar 2022 13:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=g6S7KTHpZij+RGyRnvZ8nkfXBf0HsFi8cLuypoMiBsc=;
        b=Po0Ah5KgYGXPXt+xj6i2L/fWOJ79wDdt3yHPYnemARHcnitocRIUqJCIfcxzNd5YSC
         snQrxe+RLdw0NGC/l4Luuu6VphbZsaYytB6COm1GMxri+SlYHubZCPv6B2KIz1kIv4ut
         L7b1zvuEM2nf2tzlBWYuMStmy1vMTHZzxY4xHSqIgAHkvegdRv5KM+9+VomZenzmTezz
         nHFjIXlWWPd1DWGVlTDLqWawx2mRl6F4Wk+Ag0Eor9NOCsM+AfXmUUhzVvxxK4kVpq4j
         pqaG88cqK6lFiQ+WV+capV6KJVr1c/ET4bJoHMZDl/kCv1luhhHxXnSVE+/NRZ88wEDH
         J33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=g6S7KTHpZij+RGyRnvZ8nkfXBf0HsFi8cLuypoMiBsc=;
        b=g1OWVv1fn/5+w6AbjUlRgvQRPzbGQjul+eXIElXlWfYX0hPG55X+9GXvsITNWybJgf
         WJCxgxix+9yg9oXkjC7XEvoa23Wzh8QEvkCaC/fxGpHBOrToRy5ma8MMlDbxUkBpeuKN
         7v499CLWFTLCAn4LuXhz/V2k+Nzjy8ZRc9fP5Jai4qGpAcwyFVDiDTVuYUae5Ov54yYD
         Qvws2GMVvEVO9wK00ZdYVrtqf1ezIwyzsr2DMjPZE+C0KRfVoAnhxdBhFluTHiPX2rtX
         5B41K+pHh7a6i/RAwzLKWDOaAknp0lNnY6C8YISD43viwJz/YDI6v3mZ+SqY1qQTB6Cl
         LFWA==
X-Gm-Message-State: AOAM532mxXzX5gHZOL6cxS2JcC45U7MbwjlTIUi3kwftJeE1iMViNYm4
        mhRk41Vz06Aex5PoFj4SD4veBqHnCUFIYNJ0PZ1N8w==
X-Google-Smtp-Source: ABdhPJx83W/3wuFBK5MLadFsQL8B8MUMe9388xotYcgI6A1IybhSNFqphijnutgdst4Fs72DhVbMkGDOUROcKs6MLNA=
X-Received: by 2002:a81:2f12:0:b0:2d7:d366:164a with SMTP id
 v18-20020a812f12000000b002d7d366164amr32617735ywv.265.1646255755010; Wed, 02
 Mar 2022 13:15:55 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 3 Mar 2022 02:45:43 +0530
Message-ID: <CA+G9fYuX3nM5y_VD_0menGTF0AqDOZ85=ptmQ_3XoPAAxYMWyQ@mail.gmail.com>
Subject: [next] Internal error: aarch64 BRK: f20003e8 at pc : has_cpuid_feature
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Freescale Mailman List <freescale@lists.linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Will Deacon <will@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[Please ignore this email if it is already reported]

Linux next-20220228..next-20220302 running on Freescale Layerscape 2088A RDB
board the following kernel crash reported [1].

This kernel crash is only seen with kselftest-merge configs.

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 6705cd745adbbeac6b13002c7a30060f7b2568a5
  git_describe: next-20220228..next-20220302
  kernel-config: https://builds.tuxbuild.com/25kHVbzi7zV3Pzb1i4scZwtXzeA/config
  device: Freescale Layerscape 2088A RDB Board

Kernel crash:
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] Internal error: aarch64 BRK: f20003e8 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
5.17.0-rc6-next-20220228 #1
[    0.000000] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
[    0.000000] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : has_cpuid_feature+0x104/0x10c
[    0.000000] lr : has_cpuid_feature+0x58/0x10c
[    0.000000] sp : ffffb7b2bf6b3d00
[    0.000000] x29: ffffb7b2bf6b3d00 x28: ffffb7b2be085690 x27: 0000000000000018
[    0.000000] x26: ffffb7b2be874e48 x25: ffffb7b2be874e70 x24: ffffb7b2beabc238
[    0.000000] x23: 0000000000000005 x22: ffffb7b2bfc05be0 x21: ffffb7b2bfc05728
[    0.000000] x20: 0000000000000020 x19: ffffb7b2be084950 x18: 0000000000000000
[    0.000000] x17: 6666666666663733 x16: 000000000001f000 x15: 0126000040000000
[    0.000000] x14: 1020110500000000 x13: 0000000002102211 x12: 0126000040000000
[    0.000000] x11: 0000000000000000 x10: 0000000000000043 x9 : 1211111110110222
[    0.000000] x8 : 0000000010011011 x7 : 0000013100000000 x6 : 0000000002102211
[    0.000000] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[    0.000000] x2 : 0000000000000028 x1 : 0000000000000040 x0 : 0022220000000000
[    0.000000] Call trace:
[    0.000000]  has_cpuid_feature+0x104/0x10c
[    0.000000]  has_useable_gicv3_cpuif+0x24/0x94
[    0.000000]  update_cpu_capabilities+0x90/0x144
[    0.000000]  init_cpu_features+0x28c/0x2b4
[    0.000000]  cpuinfo_store_boot_cpu+0x58/0x68
[    0.000000]  smp_prepare_boot_cpu+0x4c/0x60
[    0.000000]  start_kernel+0x20c/0x77c
[    0.000000]  __primary_switched+0xc0/0xc8
[    0.000000] Code: b9402260 17ffffd7 d2800000 17ffffd6 (d4207d00)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
[1] https://lavalab.nxp.com/scheduler/job/851695#L565
[2] https://lavalab.nxp.com/scheduler/job/853258#L695
