Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267AD4B3253
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Feb 2022 02:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbiBLBKA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 20:10:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiBLBKA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 20:10:00 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776BD5C
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 17:09:57 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i30so19106071pfk.8
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 17:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=JHu4eDHgWX+rqIL8cDnAMKv2T4Koe7Z+xBB7PNRPIPw=;
        b=0mNPaEREieCxRVNlGF+qLorOKl/t+p1aZCpgqxgcb4mbnJ7ZVwaDZdTQGxvmM5Z3sl
         7AkLP4FXqhlj9A0bqEU36NeCcrYKn9y/2fh7JE94/y9bEJtEfOeNbvZtqF0OS7E2RYq3
         Tpql2t4KCMxCFlz3DPCNodCoZfV6E/TBsYemFEznAl8cKN7ZveVlAieDVNJgoiWQEVqa
         I2o+FECOn+MP0dzoUChHL93DffzHQzXsnxx69oQjAUfU9l6lkzq9qUO+nFnfwvpqglMT
         YB6qXXj/SXYjfFkZ9T7dm0kNVsswGfSluOID9KAKPZDICgq2w8AopEEWPIU9CVyJ39r7
         wJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=JHu4eDHgWX+rqIL8cDnAMKv2T4Koe7Z+xBB7PNRPIPw=;
        b=AGEGzrJjSAPvZxkBBhn+v++EbCUpXK4xNQJxlMdA141Sds8R9tS5cD3XSG1ju8PFGq
         NIh8cnEY7kDKTEy34zhwsb5BhfMxs/KFQe7V1zGzmFIW0P/t6GOYwvEIttTLPzEhMaJ2
         DCTvU6mOTn8kyXD4V4TekTcz2W2PGkEC1pAOkehZlKmTZTZIbhRZY+RavEmEbhT89N5q
         SMCEUCS/SgeXpLvg6DJjGiJjn6vRITCu3Q8Fx26DwOFo4sIoOlh6u5vgRfm28hiFMu2C
         Eogdbr0MyFPPb7bTnVQp0Wjv8XfaVMUSoWGLc3qDsH0RqO4D56PVkr/5YocXpwuKSYC6
         sbaA==
X-Gm-Message-State: AOAM530QPwmBf250joPU0kK5mLD/luirpy/kHQZmf44u/joh0B52UfPr
        7pUdNrjnapiMwnl0xajLSp4wS+b5ivC8Uu5K
X-Google-Smtp-Source: ABdhPJwyGZQzj+VMLEoHapNIt+ohSIqniK50rV28lFqrZv18et9HCTpN0M618rDnfTYZCp/MODF4QA==
X-Received: by 2002:a63:ec56:: with SMTP id r22mr3478243pgj.229.1644628196747;
        Fri, 11 Feb 2022 17:09:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ob12sm6298982pjb.47.2022.02.11.17.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 17:09:56 -0800 (PST)
Message-ID: <620708e4.1c69fb81.5134.fb41@mx.google.com>
Date:   Fri, 11 Feb 2022 17:09:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-5.17-rc4-1-ga7e793a867ae
Subject: kselftest/fixes build: 8 builds: 0 failed, 8 passed,
 1 warning (linux-kselftest-fixes-5.17-rc4-1-ga7e793a867ae)
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

kselftest/fixes build: 8 builds: 0 failed, 8 passed, 1 warning (linux-kself=
test-fixes-5.17-rc4-1-ga7e793a867ae)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-5.17-rc4-1-ga7e793a867ae/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-5.17-rc4-1-ga7e793a867ae
Git Commit: a7e793a867ae312cecdeb6f06cceff98263e75dd
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

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
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable inst=
ruction

---
For more info write to <info@kernelci.org>
