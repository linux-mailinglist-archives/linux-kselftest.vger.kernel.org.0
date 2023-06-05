Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6372337B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 01:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjFEXEJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 19:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFEXEI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 19:04:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093098
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 16:04:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d44b198baso3950898b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686006247; x=1688598247;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w5sw5dhyEqvzv4Bewed8XbPoidt6CQkHNXPoJtMrzO4=;
        b=kYM0NS8H+U+sIlVtUTCHjqmey5lRVWRZHclmERs6MTJvnUgv8B9WjAVThNxORUbqo9
         JjzNDNOMGp+rAHZrbI5d136M9MRX7BhtDff8lrgXuCzz87jS3ph2Ath65tvMk52qCueZ
         Pepgzv7I6m5zQj9sdnu33Q6fbjOHb0aXLLBe2/vLJuHiX3UZPwWE4CMkW+iUQJUAHaJ+
         DWm5bmSJLvgt1VOHSGiy35quyNA02vaMwM4RN9ARcVOB3RyBKLb1iuYllCjTQG2LeM8p
         OvHbQkxENHhXUi9OEgZfJTWOAWBpAzIMkOG8venTzF7kIuU/sYlvZdzkggfxX/7LfDCi
         znEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006247; x=1688598247;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5sw5dhyEqvzv4Bewed8XbPoidt6CQkHNXPoJtMrzO4=;
        b=DJq0Dd9IqARZ2STgtHFVAm8AakE5UOwBfQfvbV/oRk/h67W9AU5zQNG8mWs/ZWQepF
         61eUB22orpThZDIsDD87npZiZzfGz/BN+eDlCdeh/XPLu1Hz10k3T3YoT49dHTiTjVeA
         fMMLfEZTPoxYtIQzrZ+hbu1QUL6u8bAz7BdzV+yIuF1KqiROfXdHQFaOnH5YAt1Nar4b
         cSRyzckiTRRPF3fLAJPeCE34a1Ox2Nux4QzEyX7Q/3cIifmdnNgsZMwKUtucWFlz3HPO
         /SV6gwCEoKgmwV+jdf9c29UiBlz0/DtQKGyU+QIjQ9bZEC6IDVSVIaDq1QqY7g4dB2CD
         U3ag==
X-Gm-Message-State: AC+VfDxzSCWe3a8sTYxm5MPLe/7u1POiAcwFkQCmDaha74m0q02bhsn7
        3LxaOuTzX2oqCEpboVUCE/s2QQ==
X-Google-Smtp-Source: ACHHUZ66N2VFtw+zu8w/njzeZz+zZncEHHKAOLjvf0EaXPKx4ZHHnTAoRQ51Yfq8gbggnAkt42MCcg==
X-Received: by 2002:a05:6a00:2d23:b0:64f:3840:3c24 with SMTP id fa35-20020a056a002d2300b0064f38403c24mr353776pfb.16.1686006247318;
        Mon, 05 Jun 2023 16:04:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0064d4d11b8bfsm5667777pfo.59.2023.06.05.16.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:04:06 -0700 (PDT)
Message-ID: <647e69e6.a70a0220.4ac56.a7e9@mx.google.com>
Date:   Mon, 05 Jun 2023 16:04:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-9-g4d1deb59f3ff
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 4 builds: 0 failed, 4 passed,
 3 warnings (v6.4-rc1-9-g4d1deb59f3ff)
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

kselftest/next build: 4 builds: 0 failed, 4 passed, 3 warnings (v6.4-rc1-9-=
g4d1deb59f3ff)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.4-rc1-9-g4d1deb59f3ff/

Tree: kselftest
Branch: next
Git Describe: v6.4-rc1-9-g4d1deb59f3ff
Git Commit: 4d1deb59f3ff643bd2d442bdd4dd5f58515a1629
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

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to=
 !ENDBR: .text+0x1423b6
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to=
 !ENDBR: .text+0x14252b
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to =
!ENDBR: native_write_cr4+0x4

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to !END=
BR: .text+0x14252b
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to !END=
BR: .text+0x1423b6
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
