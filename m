Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B4B695480
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 00:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjBMXIL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 18:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMXIL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 18:08:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A41A674
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 15:08:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so12443181pjk.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 15:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uu8t0OCWa/u8RhU8pWoV0/sbt4BXzwTAIqj5SWRF4Ek=;
        b=SwULZvGdfjMBAbGNom8I+c3XuIBeS4qMuYWPvNR9ALSf1u/7lH5jCUWoSZStH27RoV
         QwIMyj7gjs3BWwt6EVP5YYbvf1pUX/FuCSG98DbRf1fMG+ukFHU2gGKn39MKHwf2numn
         0Kkyt+VAt8vQ0Uzy+4wKyOD0KEvvyo3qg+gp5567PHdkg1UORx09KSGE/pAlwM9tnQ0C
         Rfw5uq904JuiPIm+B3L/6/mkwkeMhlzZymWjYjqmApefC/RldJOjGRPh02dh3pPT74c1
         MOF73Lt2AmuS2s3SgTNpVH5wIuaFyEZflDAJ5Lc6Jt5eG/8w6mjcWzsVa0epWJgixrEz
         ba3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uu8t0OCWa/u8RhU8pWoV0/sbt4BXzwTAIqj5SWRF4Ek=;
        b=jqDpTdyp54+OUy4E2AKaIayLZks27UufmXlgR8Qkn+I2F5E6dVvIxl44C9huV2e9Io
         b61mhifxwGvou7XYWEVICHXr6hb9dAsBVqQk14rWVmsajHa/txN6eCJa7n59cCRsK3TN
         prqO378IjOM6EXGrYq1XV7eDMM98UVF4RYDOmSPA9d3jSCziibUUWFKhSGSIcpVt1+p2
         QsErRZiRlw7qcBV4uPWZExzOYqBpMR1sK48dmUVm+hSLCdmekEQJxw6jAKzKGeM4qeX+
         6HTvVy+G29sQwJ9Vk1sfIx8qyGMlz+TpOmoY399HWKg90mlbEzUeG4sfgZGTIlVS2dc3
         uxIw==
X-Gm-Message-State: AO0yUKXns1pPJ37OvvqzHK3nl0anla0eleJmrF/BEEeYVXZ8ce3G2vbN
        4+juoEg0uP2rznnijnnqkFXpYA==
X-Google-Smtp-Source: AK7set984fjWFpZZtD2pXKVocqGsX73uSqm6zro9lfnx+wcIhS6zwHieWoEGkPj1ADmb9EwbTsp+Kw==
X-Received: by 2002:a17:903:2452:b0:199:30a6:376c with SMTP id l18-20020a170903245200b0019930a6376cmr561996pls.68.1676329689478;
        Mon, 13 Feb 2023 15:08:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902bb8d00b001990713589csm8731731pls.80.2023.02.13.15.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 15:08:09 -0800 (PST)
Message-ID: <63eac2d9.170a0220.5574d.fe4a@mx.google.com>
Date:   Mon, 13 Feb 2023 15:08:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-36-g6e81461b06b6
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 3 warnings (v6.2-rc5-36-g6e81461b06b6)
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

kselftest/next build: 7 builds: 0 failed, 7 passed, 3 warnings (v6.2-rc5-36=
-g6e81461b06b6)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.2-rc5-36-g6e81461b06b6/

Tree: kselftest
Branch: next
Git Describe: v6.2-rc5-36-g6e81461b06b6
Git Commit: 6e81461b06b6a4a24bf97fca37d9b89f72ce8126
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 3 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x144456
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x1445cb
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
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x1445cb
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x144456
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
