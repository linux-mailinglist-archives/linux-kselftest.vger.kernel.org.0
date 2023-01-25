Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205BA67BA24
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 20:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjAYTEW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 14:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAYTEV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 14:04:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311FE2D70
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 11:04:18 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jm10so18740701plb.13
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 11:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JGRiUejRicyjDJIlGPGAzerH6OF3vb4QKeOtSEGa4yU=;
        b=oQoSzUJ8t25tWGwsIUv0JmTsjWpdHmMy8/1VInPdblAiQBIxNeK3ZRE9hNUbNFnFPh
         9CsW+LECLrW9LLLch5L0T6TBo1qxPstRtno849KkS9j8wFn5bKwj+knwGLZHxyevXKIG
         YofJxQkhoTDBPnejfQmO9wc3mp72EQRb7KTNmMu9ItKhTx9KaMeW/e7zfQNJjgLB8vOx
         c3sWoWyM9FL73kmJ106rR5J6d3c9e86TOVsbkf/+FTeMQ6GSD+pe031g4yO2wFMhzEV4
         r6DVDmu8yTJ/fEF5exn+qlmDEErLBAeniGLVsum8WCAT6rlsXOPJYcNyOC4ugdNEIHdU
         hAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGRiUejRicyjDJIlGPGAzerH6OF3vb4QKeOtSEGa4yU=;
        b=JxuwCPWgI5Bx8RUnniCsnHKpggJQjpUhauvEbjaOoVzZ9VH0RMNE8e5lagdho9wlwy
         9FNV0zx1g4GPGJy3t3IA3DT/kQlKWQmQ6jJ57xpsmV4BCY6GtzaJdnjVsYPlv60b2DFx
         WIm4A0dQtEBWpJHXu0+JfkVmee4rBpTOCnhtTo7ECLBxe2rD/DgQhWNL8027cADBJtOj
         Xdu/tlLpFHYCY4qBemaHqBcAdo+EFrpzwPI6VkYIyXAMUEmp2jKOqlo5Tjfmfq5cfVz+
         0rAjWGiDO3DLPPZO1kYoZ7vgCv712Legv9sFBy+6sjsO7cEF0rb3gTURWq5phNYqSJ52
         SM+w==
X-Gm-Message-State: AFqh2kqhkrWwNBHi99u+/xBII4zEkSIpaoRU4zs9+gmDGB15QWmxMHsr
        phBtfbSM4XA0caaVhCe+SnnFLw==
X-Google-Smtp-Source: AMrXdXvU7BQEwaYJ8OcBaAaawvIa3ti3vmT5BNJtBM2zgr+u7BsTZ3oIpwJu0KnapsRkZG8jLPPO6Q==
X-Received: by 2002:a17:902:da90:b0:194:43e2:dcd9 with SMTP id j16-20020a170902da9000b0019443e2dcd9mr46608968plx.2.1674673457718;
        Wed, 25 Jan 2023 11:04:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902d64700b001929568afe9sm3959466plh.306.2023.01.25.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:04:17 -0800 (PST)
Message-ID: <63d17d31.170a0220.d9a12.8628@mx.google.com>
Date:   Wed, 25 Jan 2023 11:04:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 7 builds: 0 failed, 7 passed,
 3 warnings (linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8)
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

kselftest/fixes build: 7 builds: 0 failed, 7 passed, 3 warnings (linux-ksel=
ftest-fixes-6.2-rc5-1-ga49fb7218ed8)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
Git Commit: a49fb7218ed84a4c5e6c56b9fd933498b9730912
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 3 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x141c96
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x141e0b
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xcc: relocation to =
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
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x141e0b
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x141c96
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xcc: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
