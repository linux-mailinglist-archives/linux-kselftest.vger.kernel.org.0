Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0856C567
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 02:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGHXjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 19:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGHXjr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 19:39:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF9684A15
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 16:39:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so3362945pjl.5
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Q2TV6aZYvYqUeP4xh9RCoVsbO8UvU6HXxHeVaR91HWk=;
        b=tfFCqvv69xksbZ6uQIhCAHa1+IguPnJGtMyNqGFgqfAOWGlCLp/zpwC+ErqCMEXsgH
         EGADKYlJod/VdLe7Y4Sq6ttjhp3lminlY87EIzsYHtxr6AVfk7in6t7Xbz33dRJzr0Ap
         WtUMUlGaXW3lXdU8WwTUN0qmeGseGfOdOWVW8qJPYDbk533hlg+IRTrCzSUROi3OfM2a
         mvwUicYXxKMGB3juDilPdBM3ExwDCOT27VMGB/PReDsP3WWZHt2dOewA/s8jdmVwMBsz
         ROvp9W2n2KNz0Ttm780WmlFJICEuCdN8ZzlG2AVmBk2dDNsR8l4z+rEJDWQprY0fkmMr
         reWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Q2TV6aZYvYqUeP4xh9RCoVsbO8UvU6HXxHeVaR91HWk=;
        b=akzKvbM651IGVV7kGf7cKhx1qxyiglWw0RIgfx91c3zt1y2txvmghCQRLTurYcXKSm
         wt8xngH3gVTLMLkd6F2MYgiHJOmGt3m5Mi+8Wxz2mX/8bkNy/V0+zJSCWUR9uT43C2Os
         JnQv7iCmnfVxEpy3hO5YTL0zvpsZciWVWhuPFWFJjgtp8WzA9Qb0Sv2vhTC+J1uk2/0n
         WhOqWrRmTn5DaY8MeE3Uc+UAq84rcJnvyrrTpGPUw+J6bZL/tAf8TK9hqWnN8Eu3iKLd
         B9Tb3+aVqYHOaEYnfx1uGCge3Yzc557tjg5gR2UXXtahHcjENvkgHVR7QPYUw8OL8woE
         nrXw==
X-Gm-Message-State: AJIora9gh3J/j9LsxVPzXW1+6UszC+C9cOUZzPTNAebqunlsmyv10koR
        JL4epHPljgpGSUtVPfu6fNsBc+44WBKc26vV
X-Google-Smtp-Source: AGRyM1tEFStSQHOJ+wxGNT0Df73VzOp0vikws8ENtIQ3K9iF2bVEsFtPZCLuTSZSJBr1PpK3fqhqxw==
X-Received: by 2002:a17:90b:17d1:b0:1f0:6f1:90d1 with SMTP id me17-20020a17090b17d100b001f006f190d1mr1445436pjb.221.1657323585835;
        Fri, 08 Jul 2022 16:39:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902f68b00b0016372486febsm56453plg.297.2022.07.08.16.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 16:39:45 -0700 (PDT)
Message-ID: <62c8c041.1c69fb81.63dc3.01e6@mx.google.com>
Date:   Fri, 08 Jul 2022 16:39:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc4-9-gdbeb23272687
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v5.19-rc4-9-gdbeb23272687)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v5.19-rc4-9-gdbeb232726=
87)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.19-rc4-9-gdbeb23272687/

Tree: kselftest
Branch: next
Git Describe: v5.19-rc4-9-gdbeb23272687
Git Commit: dbeb232726871352fc3e688ff5b02897f8cb0dc7
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
