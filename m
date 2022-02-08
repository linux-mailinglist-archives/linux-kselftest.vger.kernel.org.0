Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F5D4ADC3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 16:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351562AbiBHPR5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 10:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbiBHPR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 10:17:56 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A92C061576
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 07:17:55 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y5so18456901pfe.4
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 07:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yrBmGJhTaqayR1aEtrikdHuO+CJmz+DpCSKKFmgPyUg=;
        b=XGsBNS2SdQc9WOc3IgSz/7CwhWuPi08Gg9MqWjFk7mA3RpHUnHr3ScD50tcj4tGs3l
         YWYrtE3xdriK7gP2nDjuKA4pX2Z0dacYBqmXozKrGtHNe4TmozLgHhGwVcB9h3C1jaQM
         wpuUn8Meyx/ZyPk0JkAdSuipF4ZRZQxSa/DecMzZfTLEcV2DuRfsoprk3aVLXXYUlYWi
         MYbS0NF9J/dgxAh9CtgqhwJVL1zzKGtbbYgEJyFPMbrt2cLif0p3nKz+64YiSVRE0Msi
         BRqaoGPOelGsS80v3j2RpIT4enwORmV6nwVmhXwAOhm0GIgRy4YdM3pzJrC6Pus/MqbI
         Jx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yrBmGJhTaqayR1aEtrikdHuO+CJmz+DpCSKKFmgPyUg=;
        b=KGkZ5Rg8FVE7DljK+qRv5FAOnn9hqHJ2+G4Rxyy2dfvoLwaJNhEldnlDtzJMhqDTsn
         l/4Ks7CG0yq62vlurIIfbDGZY/NnkZcNnUwzwRJQyaxQ6pslLN8xAICxSUoaSXTLH1kI
         /R08uEeDS6ieMRSOhF0fr30Nd5SN6qZsp9inxEfTJWTQRJ1VR2VC8Mt4dk16stkibgc6
         NHHSctVDqAYivhXHLvSf6HjLy9rUKYIH6xM+nv14YqokuX+/WZY7Z61HAQVdljyt8m8i
         v4pZrkBL9plo2ZICotZK5kRAfQVX+rr5pUGGatQiWDgeOQwTUo4pNhhBy2aYobYnS/Og
         K7Qw==
X-Gm-Message-State: AOAM532XrCnj5IAzEOIqd2SZIXYFuhG8PZ/4kCk/tLo+3HELXEbOiTBn
        hQ0aK0/zOK8VrMeTSByq/OpmgQ==
X-Google-Smtp-Source: ABdhPJzrkCEhyInGyxdSadkG8W1FRkHNrHGgOs+eZUrYlZGnOSZtqhm+/2fOOT57KxZbq8NFZjaLGQ==
X-Received: by 2002:a63:6786:: with SMTP id b128mr37446pgc.278.1644333475215;
        Tue, 08 Feb 2022 07:17:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ml19sm3409101pjb.52.2022.02.08.07.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 07:17:54 -0800 (PST)
Message-ID: <620289a2.1c69fb81.35dec.875a@mx.google.com>
Date:   Tue, 08 Feb 2022 07:17:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.17-rc1-2-g6d468898d774
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc1-2-g6d468898d774)
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

kselftest/next build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc1-2-=
g6d468898d774)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.17-rc1-2-g6d468898d774/

Tree: kselftest
Branch: next
Git Describe: v5.17-rc1-2-g6d468898d774
Git Commit: 6d468898d7744564ea9cb59d8de8f74660421599
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm64:

arm:

x86_64:
    x86_64_defconfig+kselftest (clang-14): 1 warning


Warnings summary:

    1    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable=
 instruction

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
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable inst=
ruction

---
For more info write to <info@kernelci.org>
