Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39574575786
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 00:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiGNWTi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 18:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbiGNWTg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 18:19:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5C22AE14
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 15:19:35 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e16so3071748pfm.11
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nJz+F6rvuv2n3Te6qVs9cbDfmB2O9jvR2BSRIB++EzI=;
        b=NB7TULY2VBz0KmzIO3mgTfMao+Y+KbxTkJvR3FuRTs6qNqtpDHudHJgZez14w60HFQ
         8MHMlBeLbK9ldvjmszR3i6SBBHTM80+ySbjQhacCqFPsqZ9b7SOIjfiUG5NCXSI/bWUf
         7XPkgbX73uNxm+AU/bXu+AuJNFyNFKyeIPSVzaubudqEM+USspmRz3XSvIGNrzssoUoX
         t3PYDQ1AWCg8WIpu2FKQsy88dyXelxsjms7iMMxeEg2RQl+WT9LHzOkZkZNZTL4woZbI
         wYcSlWvsUIox0+5eqD9gzZNUWZLWHhNT6+qfoQxkulymS0/+aiavCElCaPj49prQMZ7s
         Fd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nJz+F6rvuv2n3Te6qVs9cbDfmB2O9jvR2BSRIB++EzI=;
        b=W6LgCd645fDqeKbczBKDd6HPfzYMcduH9bdPDp3yNqLoqFqX3Q9vgvt2o05sAv7kDL
         atvucKczGNzUQdSKpfxDU0XuKqP7nmFJAPBkMqiQaQWqwz4ssZ3GyZRfxDI4N848O48+
         D5s7mzz3RnXAPxptVDOXZp2r8v0AqnWTlXP16TLHjum/RFV3vs1H5TwGnRV8oRkCUUdo
         BUgoraxUCR8BYH6jfIHrf1ok7uxN7RcEUKdyUvhfRkpdzD7d1s25u9nCLVReQc5xr+ME
         U/F+tNJEaybVyAarRq2WiZTWIq1e8hnUE48RppXP3s6AK9NXmfBAkpHSj/D5yS8FyXzc
         cdJw==
X-Gm-Message-State: AJIora+aKlIJ5ecJGSEnWgId3k2Z6ahbBGNyDAFwU8J78u4/7naKKq7d
        WJ1n85wBYm4Co5Fvu+vdXsPXRw==
X-Google-Smtp-Source: AGRyM1voA9lBz4UTKPiXlUBUfZoG6by3eLbJqiwDnYsAso4CiQgdrXeCai+of3+nPt48sLBj+X+O/A==
X-Received: by 2002:a63:84c8:0:b0:415:b761:efa1 with SMTP id k191-20020a6384c8000000b00415b761efa1mr9222622pgd.89.1657837174852;
        Thu, 14 Jul 2022 15:19:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w63-20020a623042000000b0052ab8646500sm2223948pfw.56.2022.07.14.15.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 15:19:34 -0700 (PDT)
Message-ID: <62d09676.1c69fb81.33f0b.3ae4@mx.google.com>
Date:   Thu, 14 Jul 2022 15:19:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc4-23-ga917dd94b832
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v5.19-rc4-23-ga917dd94b832)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v5.19-rc4-23-ga917dd94b=
832)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.19-rc4-23-ga917dd94b832/

Tree: kselftest
Branch: next
Git Describe: v5.19-rc4-23-ga917dd94b832
Git Commit: a917dd94b832c8f4ad458d0ca2bd1007466c5643
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

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
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
