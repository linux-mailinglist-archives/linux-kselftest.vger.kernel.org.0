Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD8754722
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 08:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjGOGzk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 02:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjGOGzj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 02:55:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E068711C
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 23:55:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8bbcfd89aso15658685ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 23:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689404138; x=1691996138;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/7uVj/lhBUF/5nh6ODvW462JBzyxJtGfh6hqwDyPjGE=;
        b=KDRsK/mF0Aodj6lnHsAH04P9rIoL6L7qGXs/slTk4WB21p5XCSgcIQMPzIhh9ibPi4
         Cfv8TVmaBK9PLaX+FCLlIQrBNXChQizRwGZ2WNdKojnTxgtJfzwqMg2s6AKN50u6FJJe
         A8bKe/4CqDpBoHj9gUp3sBmm25VlcdGGdECtKQzQt+4IpPfEMwYkxKAB5Bpr+MzaL8Sc
         rkotyERcp8E8DBy3h43w/J1Lt2jlrXf2XgI23nZ2ox0nCqJzl5LMenu9/N/BJlx8JskU
         0ghIMZ62nLPZnMYR3ageo4cYxFhJ1/c7y66whib5GrYvWh8SL7OwvsmZDHXUYPMsgdDk
         owsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689404138; x=1691996138;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7uVj/lhBUF/5nh6ODvW462JBzyxJtGfh6hqwDyPjGE=;
        b=dFFQxCZ1MLx01p7/3w7ZdIXWciNUNDBUdUSotUaPyaaPxAPZ5XoqrLKRM+udnyUnb8
         cG4iA+mH1CnyQ8thugbTHvHQO/uGm2/aQNXEZE8rbNcS0N/bO9q2utzeC7Pb1RufMkoq
         0WZxWY8+eNyssvdeQYiHgVIG66F/h6Owy4wnUtL98ngaGN86CyM8mj6Fb3XXaguaLIJc
         n0Jv6GQiNo80pw3zIR8JRP6bo5MJI5p7YsosmtPc+Ax1OjYXo7WDdixKqxpwgbujGjIf
         kHV16sBgIUBAbiEpzxd9n2Wte8oLrrt8GX9WATIlfHQaxtrlv8HCoJ3kLiThyv0iYHP5
         O6qw==
X-Gm-Message-State: ABy/qLZLP+Nmfgq8XjIeUEzvngTCeeBa0DjD+7EDkLDhuQSoN3hlW8x9
        vXw2wQ29xBGPwb3RFmMe/MB8CVGY1aNICpkSW+uqTw==
X-Google-Smtp-Source: APBJJlEQDvXYMSnG7+iYecUN1OdFpvzNAbqOVpaftYBvW4kPjqZRss4fvwPBtJX0TYGN4G2Lq2jseg==
X-Received: by 2002:a05:6a20:3c93:b0:131:371e:74 with SMTP id b19-20020a056a203c9300b00131371e0074mr5809919pzj.8.1689404138294;
        Fri, 14 Jul 2023 23:55:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f24-20020a170902ab9800b001b5247cac3dsm8821823plr.110.2023.07.14.23.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 23:55:37 -0700 (PDT)
Message-ID: <64b242e9.170a0220.92292.36d1@mx.google.com>
Date:   Fri, 14 Jul 2023 23:55:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.5-rc1-1-gfeac01aaf677
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 4 warnings (v6.5-rc1-1-gfeac01aaf677)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 6 builds: 0 failed, 6 passed, 4 warnings (v6.5-rc1-1-=
gfeac01aaf677)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.5-rc1-1-gfeac01aaf677/

Tree: kselftest
Branch: next
Git Describe: v6.5-rc1-1-gfeac01aaf677
Git Commit: feac01aaf677827a0b77115554e504ee444c9b7c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (gcc-10): 3 warnings
    x86_64_defconfig+kselftest (clang-16): 1 warning


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
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1e: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: relocate_range+0xbb

---
For more info write to <info@kernelci.org>
