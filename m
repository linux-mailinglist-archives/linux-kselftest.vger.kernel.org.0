Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ADA6DE720
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 00:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDKWSb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 18:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDKWSa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 18:18:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3276340C6
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 15:18:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j8so7867721pjy.4
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681251508; x=1683843508;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=45KH6O5cj3RnPv+AOERyco+kop0/CnU8ZDIN7l/NC+M=;
        b=FFdNzO/L7iElsum/R6mZcDIU8W6SlnWMu8DiZsfNqusK33w68xIqe8+ibOHbfY1Y1o
         /5OPwKORw4kYwVenXO6Jp8umAQikl+dXAlsVeHulkROKiR12/sjzLZix74hnQ/SM8QA+
         4A0EE5JhQAmi27xbpLJvVgW0sYMf8PYGCG8a/GEgbhCxpbh21x5V76rHc9fgXwHnlDwu
         wHrwGU73A12+BgUDOI8aXkcCGwsqy3sbOPwb6Zx5Cd1Ft2BHxgcxxt6lwJ+DHYQfRkI0
         7Q0UrM5p55WCoO+D4nMJca8usK8mRtQoleHHHHCxnS80RyKFGZn2OfvqLeu7kEu7RpY6
         JQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681251508; x=1683843508;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45KH6O5cj3RnPv+AOERyco+kop0/CnU8ZDIN7l/NC+M=;
        b=EFwPbfYQ/sjvFsq9+IFXGdgdJUI5R8vzJ525FWqL6wT03TE69TNLzow565yaIStNTA
         LKjI2q+gbBnOujMEFYuxRdUJQlZYLRMUahfFEdYRJS/YsM7lLtq6BW9erc4LItKE7FtU
         Holhv2QFpD7+e14kKN8JYtrjxjUYXzpkT2Vl5IXTH1vD2Fk+pIpmbpIoaQJ3JmcOfrT5
         WIDKRGNPz6KpygKKS5PaI4IZzB0ZQNcJDJprY5f4pur++kCQbccQGUPr73LLBKb62bTj
         NnuKy9zhhcBdhoGx+nuC2LImLAWWMZCw/rB9NSuxbn9MWV40zHvEUBwq5idWsbYij7j0
         Cr/A==
X-Gm-Message-State: AAQBX9f9TYhhPU7aw4ccwisZPH4b4T2p8V2iJ83ka0GUsipBNxuRaznO
        sO+6YohvVteMCgiYEsSXjQrO1UHOP+AKjXdAx344zw==
X-Google-Smtp-Source: AKy350amRjVIm/EOeW/TqFPitTpzaMFw53yaOGbpEvytlr5xuOnqzsBoMeXsdZEZVvNjEZ9XJy02mw==
X-Received: by 2002:a05:6a20:8b25:b0:e8:d3db:f172 with SMTP id l37-20020a056a208b2500b000e8d3dbf172mr14258790pzh.44.1681251508614;
        Tue, 11 Apr 2023 15:18:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7880d000000b00637709a2417sm4688446pfo.52.2023.04.11.15.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:18:28 -0700 (PDT)
Message-ID: <6435dcb4.a70a0220.625ae.9ee6@mx.google.com>
Date:   Tue, 11 Apr 2023 15:18:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-17-g266679ffd867
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 9 warnings (v6.3-rc1-17-g266679ffd867)
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

kselftest/next build: 8 builds: 0 failed, 8 passed, 9 warnings (v6.3-rc1-17=
-g266679ffd867)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.3-rc1-17-g266679ffd867/

Tree: kselftest
Branch: next
Git Describe: v6.3-rc1-17-g266679ffd867
Git Commit: 266679ffd867cb247c36717ea4d7998e9304823b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:
    defconfig+kselftest (clang-16): 3 warnings
    defconfig+kselftest+arm64-chromebook (clang-16): 3 warnings

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 3 warnings


Warnings summary:

    2    drivers/gpu/host1x/dev.c:520:6: warning: variable 'syncpt_irq' is =
uninitialized when used here [-Wuninitialized]
    2    drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'sy=
ncpt_irq' to silence this warning
    2    1 warning generated.
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to=
 !ENDBR: .text+0x1463d6
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to=
 !ENDBR: .text+0x14654b
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to =
!ENDBR: native_write_cr4+0x4

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
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 3 warnings,=
 0 section mismatches

Warnings:
    drivers/gpu/host1x/dev.c:520:6: warning: variable 'syncpt_irq' is unini=
tialized when used here [-Wuninitialized]
    drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'syncpt_=
irq' to silence this warning
    1 warning generated.

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 PASS, 0 er=
rors, 3 warnings, 0 section mismatches

Warnings:
    drivers/gpu/host1x/dev.c:520:6: warning: variable 'syncpt_irq' is unini=
tialized when used here [-Wuninitialized]
    drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'syncpt_=
irq' to silence this warning
    1 warning generated.

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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to !END=
BR: .text+0x14654b
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to !END=
BR: .text+0x1463d6
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to !ENDB=
R: native_write_cr4+0x4

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
