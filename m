Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82BA507FC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 06:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiDTEKJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 00:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEKH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 00:10:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E45DF23
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 21:07:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c23so707822plo.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 21:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=24mF4Qx4ED2SYMPrT6w6TLRRthvEI8GQrpOrRXWKcMs=;
        b=oZDs/h80vNTIDmwfnAeUcF4OlH44V1P4R91Mj25vH8ADOuccJQ05NdUtN3exwfoxA4
         fZCKDcBBIg704Av/mlGxLX7+qfDRwV2NzuHMGDiFWBQ7Q+0YH8FAtMWDxHMkHWyY2Fpt
         7b50ZXWAjFCoNAbaEZNQIUA+UAxGQ5lbxYJgrSY8xXF0AX5JNIpGcHDMspKCMSoDXwjy
         PeJZ5stiI3woMJ2GksoghXMpaveM2O/01rTpuLyG/x0ol69a8xTjzA75vXoWG38HWgR8
         6wi2wWjR9vI0NPZvTR9tbka+n6lcFMGeGH/SlSLQ64K5/A0JRb/gK6rwuLp3JxT1XEQ+
         Hq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=24mF4Qx4ED2SYMPrT6w6TLRRthvEI8GQrpOrRXWKcMs=;
        b=hNyLC4dW6KTlD2+e9HfCDrKeNrU4yy9WTzOwIspBHDNdzYVndkSx+svBUAZm4CVw+6
         gvm6akTsME7rkwSYdJc6T4+TtgQxEeUiyGS3TTvJ/gcTjn1pNYOMC5Vqd4pYM11sfiLd
         RBxyF8k6RQvqT/eDQ3TpZQtDtYLkB3G/Rj4bGJHPU4NiPZZ7DzeaggCEbOGirN5w/P40
         R7T1e5Wwi+zb96+HG7sBVpYMjWGw+EWeaiSvTx8w+zY71hWhhzWLg3l6OOSxakT52BUa
         i6NjI52TszGVhMGvq+zAxNx5dTOeusvpUYs4KrfoZ4SLzCziDfw/i8XqIuvIq3ZuTeLU
         H21Q==
X-Gm-Message-State: AOAM532gg6DY3wRdpC7nSOTY/spSiqxOeUzNneVE6KkJy531hzcRIEHQ
        p4LtxbIvls2AcVc2h+e9HyaweA==
X-Google-Smtp-Source: ABdhPJyvThUwdTpN/X59+O0k6uQgXot/GP+dYzhvYeaaLSOa5KTAoMCJ+8+NQYyZ4TGdmbp3x5klmQ==
X-Received: by 2002:a17:902:e791:b0:151:dbbd:aeae with SMTP id cp17-20020a170902e79100b00151dbbdaeaemr19021886plb.171.1650427642303;
        Tue, 19 Apr 2022 21:07:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w21-20020a17090a461500b001d28f5ee454sm8390578pjg.47.2022.04.19.21.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 21:07:21 -0700 (PDT)
Message-ID: <625f86f9.1c69fb81.b1683.3c6a@mx.google.com>
Date:   Tue, 19 Apr 2022 21:07:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc3-3-gabd26d348b2a3
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v5.18-rc3-3-gabd26d348b2a3)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v5.18-rc3-3-gabd26d348b=
2a3)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.18-rc3-3-gabd26d348b2a3/

Tree: kselftest
Branch: next
Git Describe: v5.18-rc3-3-gabd26d348b2a3
Git Commit: abd26d348b2a366f8947e8c3c2ab9bc881ac9415
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
