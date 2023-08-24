Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B663A7864F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 03:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbjHXB5S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 21:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbjHXB4v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 21:56:51 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE73F12C
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 18:56:49 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-570db728a48so1998845eaf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 18:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692842209; x=1693447009;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AaJRRqb0C71AVj+PiV+kr/YD3StDccUNdemu3Wyt7Os=;
        b=ErR2AUQkzTJim7a4ELiujW/ikBCGwOy0trBOwh+sf9izhScQLaDjHDbwx/I4AEkTqU
         t/t45baiVLdydevFPv0f5phWA11stwETqX0aVE/dUd9/UftEpAmj2BfR6vwaHMdnUER4
         mB+tjLwiO+rmLKanlEX0Pb+Mqg87lRk4D2xFUxvsbqPDZ/KRpD3IXqSlqRhZG4nhWvh4
         rqflKg0oCxwY/t0LWABmKeX5y6RC4dmHNYS04qIUF6q+Gcx94I0gQzzke2Bj12KuGS6O
         c/a8seaV5PSZE7qgN/HxofrfNxmgEOtkSRCmk+gxyibstIEUKAYcr9AD8GodwThhseXS
         br2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692842209; x=1693447009;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaJRRqb0C71AVj+PiV+kr/YD3StDccUNdemu3Wyt7Os=;
        b=G7NyacPpnzPjtGRol3l7pw5CBZZvDKcroEUk78MDu1BAxeEmgacrSgHS6NMEXAHXp2
         WmiUfaBZCP+taxeP0jBTFPXEkQlZ8O7kWMVjR556cJR7LJ1W/I69MB2TxCt93TkBLpzk
         /35xZmmw97iBnMOG6Iif8on+/v2Kj3RqAvro6uGHSJstiuuW6NGqTC5kiGREZTed+PLk
         sxgc14Nvygg3tXuUebGoaaOb4iumWP7BRevR2bXByRA/fp4krv3tqZbr3EdYCXtXXvkr
         PH0scuXUkeBAsWfMX12a8lE2XlbAdYWsnvJkqasm0elRe3s+NSJbnyFywAY0x15+qAml
         6cDw==
X-Gm-Message-State: AOJu0YyqQkrK/DJ4yUuFDZjGmFi2NzubjLci2nFLHkAONwqMYlSHC+jg
        bLHCu2cG328Wuhz5VeFzz3ZxV66FN6k1B77yWOE=
X-Google-Smtp-Source: AGHT+IGKd4RJvR7s0i5VznOraARSbhtM4hXxUKxIO940cIJRne3YXj49BxW3MNGXkKXoP+utkMJlAQ==
X-Received: by 2002:a05:6870:968c:b0:1b0:2686:5b23 with SMTP id o12-20020a056870968c00b001b026865b23mr15834155oaq.51.1692842209022;
        Wed, 23 Aug 2023 18:56:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090a628a00b0026940eb686bsm383919pjj.20.2023.08.23.18.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 18:56:48 -0700 (PDT)
Message-ID: <64e6b8e0.170a0220.2bd37.18d0@mx.google.com>
Date:   Wed, 23 Aug 2023 18:56:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc3-32-g9b1db732866b
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 1 warning (v6.5-rc3-32-g9b1db732866b)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 8 builds: 0 failed, 8 passed, 1 warning (v6.5-rc3-32-=
g9b1db732866b)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.5-rc3-32-g9b1db732866b/

Tree: kselftest
Branch: next
Git Describe: v6.5-rc3-32-g9b1db732866b
Git Commit: 9b1db732866bee060b9bca9493e5ebf5e8874c48
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    2    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x13df86

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
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 PASS, 0 er=
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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x13df86

---
For more info write to <info@kernelci.org>
