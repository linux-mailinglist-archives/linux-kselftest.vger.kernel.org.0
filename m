Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A77571814
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 13:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiGLLJ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 07:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiGLLJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 07:09:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA8B1862
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 04:09:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so7615739pjf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0cbmkpfsK3M25V0fzoF7BYCcEqV/KodaPNWw4ag/TF0=;
        b=ZQe+FIV0Ln+1NiHSApkgG67uzW3JDGy4UCWl7PLIjsBIchm7WR4fRdLgl72PcGl9GX
         nK9JHKO3chEEmRRMfBv6hRF+3VEJIYCDGyR3z0XEGHJy/3CLvpyIVKHEV5QocojxRZjK
         3S69ozFZfk6AP0aJYP6PBJpv9o42s7qX2jSWo2l1N76GCcyHdJAseK7/1QImXmlNwtIg
         UNvi1htZVhE9IrAWZUd9b1PecuSJb8lXViKqeT9dU+2pItNtisN7gywFCVIE6jicIHxw
         jJYZLg707XTbwrJl2/DZR71wBipPXY1cwR1soV0UaS/5PqkUrgkR4qqnhcCcIPshoPjg
         bbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0cbmkpfsK3M25V0fzoF7BYCcEqV/KodaPNWw4ag/TF0=;
        b=qYzvDoNIz0ckE4u/DY3GB9olYdihcSvHdF+tGqeh9cyfURjVyG4hPhQrcakMD/LvAH
         HC656b95OuvLKH7Pu1apXsK9sPSf8u8fI3FEwHn5yRhkqubeV3h1LXRv6jFBxpfoqyo1
         eF6ZWcuQglghiBpKOLT/msFNhAb0ZGYF7mPrsXdvCit9Xe6DFSksLCpiDT1OB5jR1aF8
         ZJjfwO6VDFh1KbRLmJMYl10CM253dqsB4DFQHN1sm4tV4izvRlOkEzNb87Ezc1RuZjl0
         O06URdJnSBb05PRQApU9XS93DrqYQA87JvCQDF5BiBcQYRHAkLO3/lRGLqH3C3QFLOhn
         S4Qg==
X-Gm-Message-State: AJIora+JrV54WTlgcdhQiaFbaLFo5JYaEWVTKpiRz/+dZJ+0SuaAr4ko
        FMaVv6K06HtmiCHY4R2On2dN1Z2OjTppEb4L
X-Google-Smtp-Source: AGRyM1tj/s0I7Rhu1iIr22SFoe88HrnTUJtLxe8qmoPJ/OBs5gc3ryfU3QkqpR3BJ8VJ9lyCNO4UEw==
X-Received: by 2002:a17:902:e542:b0:16b:fcbe:7b90 with SMTP id n2-20020a170902e54200b0016bfcbe7b90mr23578085plf.90.1657624185813;
        Tue, 12 Jul 2022 04:09:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p64-20020a62d043000000b0052a297324cbsm6562162pfg.41.2022.07.12.04.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:09:45 -0700 (PDT)
Message-ID: <62cd5679.1c69fb81.1d51.95a9@mx.google.com>
Date:   Tue, 12 Jul 2022 04:09:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc4-13-g67bd292cd281
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 5 builds: 0 failed,
 5 passed (v5.19-rc4-13-g67bd292cd281)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 5 builds: 0 failed, 5 passed (v5.19-rc4-13-g67bd292cd=
281)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.19-rc4-13-g67bd292cd281/

Tree: kselftest
Branch: next
Git Describe: v5.19-rc4-13-g67bd292cd281
Git Commit: 67bd292cd281be2216cd269c161be31cd3ccf196
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 2 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, clang-14) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-14) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
