Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF05752B31
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 21:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjGMTt6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 15:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjGMTt5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 15:49:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65134272B
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 12:49:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6726d5d92afso1509884b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689277796; x=1691869796;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ewGK/wVHv/K3eVnaAYLQL2cJArGVouZfFmObjZRxc+0=;
        b=nZnzVcxu6OWQwbUepQxuFKMl7OrQmNVCZ2dbud7o31Ozrq3KbhO6rYylItPTrdfvB1
         J4ksMhLPz1jRE5v8P69YzQtyYPnoMuRm9kL01XXdD80Z7PnNEXH5i4rL2Sup+wJhJrlX
         yCg3pFvVNNV5g54rwZOkhSpbG+rLSKmsJHKhy0uSZE/jQ5B7V9vlgjJycW8rLlmerf/f
         a59oWY556Q4mE4RFDX30pvMpNF76Kz1XfHpAZHKRtLur8P66ihTQnXjPEO9IZ5LiJoLt
         2PnzyKR15XyGn/pyRjsZdncotV9dxjMtwQm+Nno3EZkatxa2UQQPW3qT4eDBinec18gB
         S96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689277796; x=1691869796;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewGK/wVHv/K3eVnaAYLQL2cJArGVouZfFmObjZRxc+0=;
        b=BsdzfPi5l1ahd+yjinlxxr8dFtr54Sn1xoVOQfe3pTJ3S80DDnn8pd76BMqaYD+/ss
         Cxrf9Zxa7OBGdBPFCAlNwx0Q265b8oGWh6O0jzd5V5UCYQHd7OaKBlbTd8MK9j2Wzwz2
         jmGxyZ0iOGzFfPkLjTyjKKenJ73eAPxVX+LkRx5hkeWiezP1snzNsFsCdexIOM9YKA01
         zzjhBsWLsxPEmeOkkUstByZwnwpDjCNg9AytPX7FZxBTgG3TQBGyrOj1RJuDuVbxsfzu
         sre+xirfe7Nj3DXh0U4JCTptf6YoahVz9v1R/78x6JtTCrFfaX8fa8Ef0QpvIsZL7nUR
         M3XQ==
X-Gm-Message-State: ABy/qLb26rnwn4nhW4mFTfg/MxcgMQyAO7jhueS/ER0cnCZ/6Z4jVXNY
        LuAx/+rpoLBSx+k6n/f9FEirNaqVLh0QeeGnpOf/cQ==
X-Google-Smtp-Source: APBJJlGUYzQkUoPiqQBkBOhlU5xobP+q3wJY9pMJ5YWApDsu+3sFs0U6efpGdOsA4g/j8GLMU0qnEA==
X-Received: by 2002:a17:902:dac2:b0:1b6:a37a:65b7 with SMTP id q2-20020a170902dac200b001b6a37a65b7mr774950plx.23.1689277795790;
        Thu, 13 Jul 2023 12:49:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170903054d00b001b9da8b4eb7sm6259052plb.35.2023.07.13.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 12:49:55 -0700 (PDT)
Message-ID: <64b05563.170a0220.52c9d.df8a@mx.google.com>
Date:   Thu, 13 Jul 2023 12:49:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: v6.5-rc1-1-gb33b8731566d
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 5 builds: 0 failed, 5 passed,
 4 warnings (v6.5-rc1-1-gb33b8731566d)
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

kselftest/fixes build: 5 builds: 0 failed, 5 passed, 4 warnings (v6.5-rc1-1=
-gb33b8731566d)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.5-rc1-1-gb33b8731566d/

Tree: kselftest
Branch: fixes
Git Describe: v6.5-rc1-1-gb33b8731566d
Git Commit: b33b8731566d50aae6e11bd02921452cf3a7e0e7
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning
    x86_64_defconfig+kselftest (gcc-10): 3 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: relocate_range+0xbb
    1    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1e: redunda=
nt UACCESS disable

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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: relocate_range+0xbb

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1e: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---
For more info write to <info@kernelci.org>
