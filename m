Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB06C2DBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 10:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjCUJU5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCUJU5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 05:20:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8D812594
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 02:20:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so19530085pjt.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 02:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679390455;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t5Z67uZsyl/BsAt0oeK422Bk1itxBKJHdeJ8kmGmx6g=;
        b=g0uXymeIlt7w92q7c4Y65fWB5YcFbw0QTLmaDH9MxqNbhiJIQWyjTXkleaDrLvBUB5
         NgJSr/QPy27dyk2LdxWCcFqPkdnRxFaVxpqWKq48/9vsrM9+yjeZ2GNNWSPoe5BibmhC
         FxhhnSjKN4D1PW53Sav76GvxYHq2QWDimEn0qlifreR01RGFi0tqgb1vdXCLLRy2eD8h
         hxJ7qjme0CuHyrUM32VXsdsDYIomqSGVq1SEp4+ArAI/EcH8/irRi2RRegzzWfbhYOPo
         z+hLPi18rXvY+OzTLOkBv6pG6YZzwAzzUz0GMDnodFirH31OEJ1OCNd6RfsOwVB3q0fG
         TleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679390455;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5Z67uZsyl/BsAt0oeK422Bk1itxBKJHdeJ8kmGmx6g=;
        b=e7APRHPhrpG/0rWvewA2/yKdf3kV1cnKyEmO4q1+QJqM/P0LAJaX0SgNv7ez2J8zE3
         9u8rkox5gra9uk5Fj5HX4vW85pRWoScKRr/YZIwGhkoLzHWK4HhEF2CMSDChr8xTagKp
         4zyoglbeLMYkLgaTZsqnQTzhGQa3chlrc6Jg1bqSen0CvDyZoOLOnBDDalE4kSVtIDqT
         HE6Nku0ZLI3RnewY9gXnsFxgwb6yrUO+dRe1h5K+FtXJz52cUkq82fCjbYX+mo4t32WT
         as/0hQ2j4A+npElLrSsrWhlDcyJ0KJ5GD9w++MIK8G8IcK99GaLYsdIFfveqafBta1N1
         Yodw==
X-Gm-Message-State: AO0yUKX0zX8gelhbd3qxS9vRt5cNeAw8b/2w4kfsHepjZMk9leTnLBYy
        bFR1vz/65J//B//zpxE3I/PRYDeCGHNeW2i4gVYhRQ==
X-Google-Smtp-Source: AK7set/DD6fbohFjMBPOxWmsZVjmCKjOWMRsdznMNq6CsP6Qc8noZVByIGtqF8VE/hxSlAmC8PU5jQ==
X-Received: by 2002:a17:902:ca83:b0:1a1:db10:7ba3 with SMTP id v3-20020a170902ca8300b001a1db107ba3mr1406807pld.2.1679390455185;
        Tue, 21 Mar 2023 02:20:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b0019f9fd10f62sm8274416plj.70.2023.03.21.02.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 02:20:54 -0700 (PDT)
Message-ID: <641976f6.170a0220.f8919.e318@mx.google.com>
Date:   Tue, 21 Mar 2023 02:20:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
Subject: kselftest/fixes build: 5 builds: 0 failed, 5 passed,
 3 warnings (linux-kselftest-fixes-6.3-rc3-1-g05107edc91013)
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

kselftest/fixes build: 5 builds: 0 failed, 5 passed, 3 warnings (linux-ksel=
ftest-fixes-6.3-rc3-1-g05107edc91013)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-6.3-rc3-1-g05107edc91013/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-6.3-rc3-1-g05107edc91013
Git Commit: 05107edc910135d27fe557267dc45be9630bf3dd
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
