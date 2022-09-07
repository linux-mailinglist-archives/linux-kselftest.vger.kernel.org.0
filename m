Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493D95B1049
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 01:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiIGXVP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 19:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiIGXVO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 19:21:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D413798D26
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Sep 2022 16:21:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so503672pjp.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Sep 2022 16:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=W/5yzHduhXFdDjGaKgQPKYstDOOVGEFyDuCg/4I9JE0=;
        b=Fr1b4b794PsnmJQyW0ToUVMUOqsls9yNarn9pbknfm08jhOZdKXwlsrPv52GeSgjHd
         foH5J6Rk1E6biynw+uM69sfpaU6ByH92ZjKaLVIFrNHdMkODAgkqNCt5jXmb+jHdvfXh
         6J8aVSbScdvqJV2nB1yHSYRatt5b4+o+ZG8wPyNIjgKz3Nt7n9S6WkYXVCfSJla/QOHm
         kswJrTfih9p58YTiLMH3VypnxoBl32UjPImIkg1vOVzlO9Ay6fwURH+l5iCP0zxngDKK
         CIsYsnfODjUuNAF8O3333/KcWSXUFiVhGfIsrU5rDSYZjqN0v2ODzEvZQfXSwsFX4Rz9
         uUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=W/5yzHduhXFdDjGaKgQPKYstDOOVGEFyDuCg/4I9JE0=;
        b=IBCaMSnw5bc69xiX8iiwUQ4VAj15uSQDJ4TLUSV3/DwpRc50hTQNnx6C3xf+XYgDQO
         /dceuPdhKPmvcUxmXYIj+pnGqgTkxlSJEbxxXpmTleHMPOlAccq29O3QG4GzPznUmUqO
         sG4/csIZBTH/PL47YUO8J6vpfc93plpdHoTDscxtMrKQruD20e5EcscLpgwy9Bt90HEq
         DQ/YYMFndURt8c3M8V2/UU0+2QwDChm0NKSsClL5FGWE7xC98WJEZjeJ+pRx/AdiMTVU
         ACXYlcx1N2mt0SvtkTQURW+s/pgPUvPc2lVPt1PREvzr9UglP+qPbzmAwoXHytHY+fvU
         4wIg==
X-Gm-Message-State: ACgBeo291ZWL6HTQ96YxoezaUnO0sWWEUzq/qOzW1P0eyz/fk60srFC4
        quDZx/IAu28BGcD7naMfoZCABA==
X-Google-Smtp-Source: AA6agR6u9NRaS38/HSx2R0mjNwDLbPk9PpH7eS2AashpWHGAScNGv2MSxnhVwoHtFDGbjtU2z4LncQ==
X-Received: by 2002:a17:902:d502:b0:177:f287:269d with SMTP id b2-20020a170902d50200b00177f287269dmr571869plg.140.1662592872342;
        Wed, 07 Sep 2022 16:21:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y28-20020aa79afc000000b0053e0d6f353esm409532pfp.27.2022.09.07.16.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:21:11 -0700 (PDT)
Message-ID: <63192767.a70a0220.1747c.0d31@mx.google.com>
Date:   Wed, 07 Sep 2022 16:21:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux-kselftest-next-6.0-rc2-11-g144eeb2fc761
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (linux-kselftest-next-6.0-rc2-11-g144eeb2fc761)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (linux-kselftest-next-6.=
0-rc2-11-g144eeb2fc761)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/linux-kselftest-next-6.0-rc2-11-g144eeb2fc761/

Tree: kselftest
Branch: next
Git Describe: linux-kselftest-next-6.0-rc2-11-g144eeb2fc761
Git Commit: 144eeb2fc761f966f71ab8b4b7d2a2198ecc400f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

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
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
