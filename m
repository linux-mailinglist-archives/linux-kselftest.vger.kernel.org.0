Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9B86B5817
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 04:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCKDjD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 22:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCKDjC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 22:39:02 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FB9FAD61
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 19:39:01 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h8so7633788plf.10
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 19:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678505941;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WPAMCZG4usrcfr6ltJzFZQPjQFxnHXk9Ap9tawhTYCY=;
        b=a5mEdbytwgQXGNweG/oBzJYHxTpqn/6X5dODX09aU2enlCMJO5aBGqArzE7EBMoi7m
         1rq9MqzGzYUQQEwNr+lBILMWe9r0tzvuWD1SBEN/jfuGbM+lSH7rXq0ffpqMg9oTKc8h
         cZV79SIZi9Q0fqlKPK27YITkI9irWe8MwvIUOMpLk4j0oPH5SHHVc0RnIT8Plj50VoDW
         Qil1bME0yXvwAhF6tjGx6RPIZF0Nq5gMcs+ypkdq/j2ro+VVXxVrTXklDWPWHjt+diSE
         HydnbJoZVn7oq0xWdzXYXKZ93SZyDckVTLO8H0tPFX/kMSmfnKbEWQehqlYkqfSOmDEH
         VzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678505941;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPAMCZG4usrcfr6ltJzFZQPjQFxnHXk9Ap9tawhTYCY=;
        b=AlBvW12k0MrhJjMjJEODImb4sFbYXZi1i/NvQ/ZYV5dW6oEFsztc9hSjv3i7RbRkka
         r1TPzpF7RklMhLl5Dl8eZTtcg1Ldb7VuYw31r3JCj26nx12D8xmhZV1zdgZ0khCch9mw
         bv7z3VVITk1FYkQuwn/wIsfQ/OA9Iehv4APIyBy+bZjOFvsQt3QI7OVGXlu4+2PKls/p
         jRXdEHHe/6CcvlHJZvdckVgz9lgFGPpdIBKmcC5PHb8pl3jxxa5l3M/KMgPUAGQlLE1v
         c0cF7QSXmiDVwEKf+r6MlQtNvVQGY7gYtpJqM45u+EJxxcb8sAqcl6IKY1ulnr5Ev4dZ
         I7Zw==
X-Gm-Message-State: AO0yUKV5OC9Rabit/QbLTG3V6km5J3Ff0XBfMRpbCCpqcxedzIShMowy
        eMZBMsQHcQ4qVpU293BCR2eAzdAQOhplvwYJTow4+EUU
X-Google-Smtp-Source: AK7set+veBZGloVP0DvOEXWYnvIO9/s55r5dZQD/1bcRdBTibnQTRlwUxCPgTrmWa1G19n08HZo0HA==
X-Received: by 2002:a05:6a20:7d8b:b0:cc:9b29:f621 with SMTP id v11-20020a056a207d8b00b000cc9b29f621mr35362524pzj.42.1678505940929;
        Fri, 10 Mar 2023 19:39:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 14-20020aa7914e000000b00587fda4a260sm521091pfi.9.2023.03.10.19.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 19:39:00 -0800 (PST)
Message-ID: <640bf7d4.a70a0220.aefc0.1c87@mx.google.com>
Date:   Fri, 10 Mar 2023 19:39:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-2-g624c60f326c6e
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 7 builds: 0 failed, 7 passed,
 6 warnings (v6.3-rc1-2-g624c60f326c6e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes build: 7 builds: 0 failed, 7 passed, 6 warnings (v6.3-rc1-2=
-g624c60f326c6e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.3-rc1-2-g624c60f326c6e/

Tree: kselftest
Branch: fixes
Git Describe: v6.3-rc1-2-g624c60f326c6e
Git Commit: 624c60f326c6e5a80b008e8a5c7feffe8c27dc72
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:
    defconfig+kselftest+arm64-chromebook (clang-16): 3 warnings

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 3 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to=
 !ENDBR: .text+0x1463d6
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to=
 !ENDBR: .text+0x14654b
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to =
!ENDBR: native_write_cr4+0x4
    1    drivers/gpu/host1x/dev.c:520:6: warning: variable 'syncpt_irq' is =
uninitialized when used here [-Wuninitialized]
    1    drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'sy=
ncpt_irq' to silence this warning
    1    1 warning generated.

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
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to !END=
BR: .text+0x14654b
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to !END=
BR: .text+0x1463d6
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
