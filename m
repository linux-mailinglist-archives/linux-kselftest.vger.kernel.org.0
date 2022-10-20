Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785EC606603
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJTQku (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 12:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJTQks (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 12:40:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C80714D1DC
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 09:40:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g28so62469pfk.8
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xdKaJMBvUmIKbh2Lyw8nNzTOqBu53UG/4bKZ2w88isY=;
        b=l3w7IWMHdn1iyTILtJzSlPN/LZnMKHyF08VZPE1MVD0m2DYUagGPvbcinoitbkcB0y
         2tFRZg/+a6wTQ/n2Q+lM7ABLDIERQ+Ok1hYYn7VCvlJxQSIoausq5qtKaNn64uiDEwlP
         O0FVGyWmLfdPGfgmz8QXxIj7/br9z9JSSBOfF345QzjFUfYraJL1yfsAisIrH0jPs2v5
         bEG99aMnpbiz5TCqdhxlce2YstXiqa2LGctEGsuyolXdHyfMnyb9EypYyDh6hgLOV1VM
         aFCMvq1SirwekOxPnVyhtIELHksbltPvwnxAYU/r/a1tUrldfLkpP1EHfC0vllYzXu8r
         DKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdKaJMBvUmIKbh2Lyw8nNzTOqBu53UG/4bKZ2w88isY=;
        b=BiBDuN5yqNYmoByCy1tWbt9bVixp23rQMzNK/I9nhe8bTgVH1sqSkfkLJKZMObvkqS
         PU2PHzdyPo9MaQNlQZa5Ck8Ugj6ZVvrjSuo8mc1GVqrTueggW2N7HkZyNas4CWk0gRo/
         799YUbTeDAYjmEZA020GY6SRxS67mB5srvChnHObOYh+A6lszpWowxm92zeKpIEDZc1h
         4DOfblPvWlRvCC5k3GXPUQLxw1HepungplaCgXNffk20XwQuZwANUMud3nCsnH8q1B1g
         y6vWB4t6+t7O2cGdwxQ5TIoCob7pZAzRRSj8qvt0TRtVE38fhH70VdodPbySpi7sG+1/
         axTw==
X-Gm-Message-State: ACrzQf1KBdicgvJDW86EIxzlTio5Ab6bvWC/+IMtAQdkDzyJBSRU76tR
        wT2zScDbDUyUuMtqja8YDIO2Z7I1g9ycVZCZ
X-Google-Smtp-Source: AMsMyM6IIQ6siCsWyCYpwE9ueUGafmtbP3BMogBh6S73GHoxG4yTCe4zeSdx2t9TjH2gdLeVckHIRA==
X-Received: by 2002:a63:1521:0:b0:43c:9566:7a6a with SMTP id v33-20020a631521000000b0043c95667a6amr12452173pgl.339.1666284045981;
        Thu, 20 Oct 2022 09:40:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b00176ca74c58bsm12959415plb.245.2022.10.20.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:40:45 -0700 (PDT)
Message-ID: <63517a0d.170a0220.1a6d4.8cf0@mx.google.com>
Date:   Thu, 20 Oct 2022 09:40:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc1-1-gde3ee3f63400a
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 2 errors (v6.1-rc1-1-gde3ee3f63400a)
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

kselftest/next build: 7 builds: 0 failed, 7 passed, 2 errors (v6.1-rc1-1-gd=
e3ee3f63400a)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-1-gde3ee3f63400a/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-1-gde3ee3f63400a
Git Commit: de3ee3f63400a23954e7c1ad1cb8c20f29ab6fe3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:
    defconfig+kselftest+arm64-chromebook (clang-15): 1 error

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    2    error: write on a pipe with no reader


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
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 1 er=
ror, 0 warnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 1 error, 0 wa=
rnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

---
For more info write to <info@kernelci.org>
