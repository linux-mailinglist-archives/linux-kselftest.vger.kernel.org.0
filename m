Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073106956A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 03:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBNCZV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 21:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBNCZU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 21:25:20 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C29510413
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 18:25:19 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso614247pju.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 18:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/+X5NTbtfbmmH2fYcKG4IHCT+tOwshtz2LfJLSPSpM8=;
        b=DDCm4/DTjf5IbE7QSuahb2ZWUt9T7iyIyJdfGGFbjVnFv+ETV2rLTNQr7XJ+fChmPF
         d13ruXMX3ymWmvVAZe3ATNrijvn9KynOYEAYsiPrSewTILZ+D4erYrSVv1P5shFjns32
         RpeDZVrRkUWTOv6wpsQcuKGX9rMTAbiWA/a6nquNCQKauP1y2cOEAeqmRMnF+1qh5aHs
         xN4QAyZh6ajJZI+6aVqQgdo4N0Ja1etmY0oP9P2n0Ql2oky2dI7DKAN6LpaybuiybBT5
         T9anvwQ4Pfn2nZDXJkMq8yeFUM9EB66ZWRZ1roI6N/BWqnMCIuFrGY8uBRLqM5o5wg9b
         Kcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+X5NTbtfbmmH2fYcKG4IHCT+tOwshtz2LfJLSPSpM8=;
        b=i7UdY95rRS5+19kKBc4aGn8tzcd4q6Q6byAxQ4bV7ZjKdD3iuegjbdddHAJ/fS36um
         Z4CA174MBm6TtbdCKMDja04/fxiJN+xOpKqAr+hSG99jJl5oGThlLb86d/xJxXuvOXSm
         25uicCR4lnVh/3JjHcTZD4gDuPImbpff+3RvmBsji/HFzS4pR/TGRRgz+EvPIdehrqiA
         6oXs2cnLfHNivx2TtYeK7eiv0/AvyAQTqveqnTyF41E9rY0tuvG7KdgQT8+3S4ONZW87
         9OtgWYiPYQHijZfLww9seoC/hMNwNRTkXsotg8eRPmP2crDqQFcVAKTR2s7AlQrJTLpC
         CYfA==
X-Gm-Message-State: AO0yUKX9MTn9zIB/HvP1vsUdeTVgfbZfQAwQrjiU3mWuGUy4Yqik1M9b
        1o/Uh70uVf1awGn6pwViGmT46Q==
X-Google-Smtp-Source: AK7set/siOAlhFOsHzSD22ShAUHdfBcfJ/SH8sDU1dsxO5u3t6zlp+WKDVfJNJkvknbiz6QAeaPGnw==
X-Received: by 2002:a05:6a20:8e22:b0:be:da1c:df65 with SMTP id y34-20020a056a208e2200b000beda1cdf65mr826370pzj.28.1676341518883;
        Mon, 13 Feb 2023 18:25:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y9-20020a63b509000000b004fb11a7f2d4sm7845737pge.57.2023.02.13.18.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 18:25:18 -0800 (PST)
Message-ID: <63eaf10e.630a0220.dafa9.dec6@mx.google.com>
Date:   Mon, 13 Feb 2023 18:25:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-39-gaca5a0944c30
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 3 warnings (v6.2-rc5-39-gaca5a0944c30)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 6 builds: 0 failed, 6 passed, 3 warnings (v6.2-rc5-39=
-gaca5a0944c30)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.2-rc5-39-gaca5a0944c30/

Tree: kselftest
Branch: next
Git Describe: v6.2-rc5-39-gaca5a0944c30
Git Commit: aca5a0944c309c56267b0c1d001aa999ddb2fb1e
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

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x144456
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x1445cb
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to =
!ENDBR: native_write_cr4+0x4

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x1445cb
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x144456
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
