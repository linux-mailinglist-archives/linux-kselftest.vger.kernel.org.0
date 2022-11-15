Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB006299F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 14:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiKONWA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 08:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKONV7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 08:21:59 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF3DEC6
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 05:21:58 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l2so13112006pld.13
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 05:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=09uMmcPZP7soiNTpqbk19B635XIHx8WmMo51M981QjI=;
        b=xiK1f9vct5+hoeoTf18NyDiBclnZmOwUCfjg9JM1fKbnPoZxqmWbTX8iaPFk+yQPqu
         A9Ouc8/ZVx4B9mHPRkyFvjjbxi1xSVehJOg5xY1gploZnx3G5YVEl26rQfq1qvsTn6HU
         uzsA2phU5/7T3kf5s10l0mDUSqeUQjdrCAvtm9qyIIqB6FMVMvHxcNHz7z04tDexfMvs
         FoqJ4G6I3sG0AEF6AKABkEwwJhVF80MlUqQ+6whSPEZZUdqcIJ3uT7rBgPEyI6VtL5ke
         iaSfyno4MJUxAFUHlKOYli3aFxAwLDk1Y7FYvD1+GPshsdE1pm0OAr6jayDJptIo5AUK
         z0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09uMmcPZP7soiNTpqbk19B635XIHx8WmMo51M981QjI=;
        b=BgM21O07CrweuxjNF5CIDqXr0n5dW9tyhMtP1Ij5KqIRxUZJxFx0sOYOUlq230L09M
         vO6WoN3VrcUhghGh/IZKkHe7Ufqyj4aWe0AiNMjSaepSmmh6os5LdKP8qfxHPLEVekIP
         LmJsmIwAkjLL6609RGj4QY7HG+7A/nEkdeGP9CLrX+ASjfS4FB6ZVnJmTj2uKAioF9NP
         pZtXTnv+O8ObecMLM+lyUzhUy1Ht/wyTHPU3THap68ju2TSpc++Hhv/ryNPA/RkxK4Kf
         uEZUw0hIXx1arbftPo/VO58lfbptX2z0HsSHO67RQok+MDbwBs7Rtw5gqxIC9gGwzLUm
         gH7A==
X-Gm-Message-State: ANoB5pmp8fD3E5vFsmNqsgQ+7GDnYSD+0IgxerKm4uJFODdkUP+tIkkU
        gGiAeady9i+sh/n6IV7VaFNOng==
X-Google-Smtp-Source: AA0mqf492ApBxwhFv0i1zcirAh4vB5EWbnLj121wMYzYbH4K59nRxciLaVfZwUuWpiBpIPF+/Ue6BA==
X-Received: by 2002:a17:90a:5991:b0:213:8126:867c with SMTP id l17-20020a17090a599100b002138126867cmr2196378pji.183.1668518517910;
        Tue, 15 Nov 2022 05:21:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 2-20020a630f42000000b004702eca61fcsm7697952pgp.36.2022.11.15.05.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:21:57 -0800 (PST)
Message-ID: <63739275.630a0220.9ceb1.ae4c@mx.google.com>
Date:   Tue, 15 Nov 2022 05:21:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc1-15-ga1d6cd88c897
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 3 errors (v6.1-rc1-15-ga1d6cd88c897)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 8 builds: 0 failed, 8 passed, 3 errors (v6.1-rc1-15-g=
a1d6cd88c897)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-15-ga1d6cd88c897/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-15-ga1d6cd88c897
Git Commit: a1d6cd88c8973cfb08ee85722488b1d6d5d16327
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:
    defconfig+kselftest (clang-15): 1 error
    defconfig+kselftest+arm64-chromebook (clang-15): 1 error

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    3    error: write on a pipe with no reader


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 1 error, 0 warnings, =
0 section mismatches

Errors:
    error: write on a pipe with no reader

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 1 er=
ror, 0 warnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 1 error, 0 wa=
rnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

---
For more info write to <info@kernelci.org>
