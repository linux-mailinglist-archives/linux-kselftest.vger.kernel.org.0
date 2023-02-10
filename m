Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368716916A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 03:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBJCSU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 21:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBJCSS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 21:18:18 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA4870948
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Feb 2023 18:18:08 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id x31so2821072pgl.6
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Feb 2023 18:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JD0vcSluqypk3x51RCaDbN77ObAmQTKr+jqPLCF6r+0=;
        b=omLFkIm8zzRCepI0pIK7l5vjOhN16vkAW5YzWS8WdjIwoTdGBAsL8WlM995qtSeRmR
         jaCvhJiQ+1t1EG7mObGBE5Y6jPNv8UftMy1bF/lLAYFSIpuA6x8chWPvqL4UDjV0FMA3
         pIwqA0o9aMGRD4O5jMfEgiMnSJRBVoswo1A6Et0GQYnEzoxbxDyBprPqRhkF4pyWv7r9
         knsePZQgoKyiq8ilsAapdMjcKb9u1FU75QRDyxSIGYk26kHn+FYQfjDyaoHFous9ZPCx
         ouTvcmMfSLYu81NDYX2DUx+HJvZKaFXVT4a2dvGgeMCrtVO9b3nyDmuOo4x6tNwfLgXE
         cRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JD0vcSluqypk3x51RCaDbN77ObAmQTKr+jqPLCF6r+0=;
        b=DrP0BW25nOlQvsm+/zUHeM74u8XhSYAMRSypFqpjQYBGxueUqawjUbHSvvc7X1SgJf
         /UQiv5joMglF1cYlqPpDoMcgE+uTFYRs5xCkaTXnYUH9mNjtfWq82Wz9cGN6bbmMpior
         KUoRfaREDQO5t/5wvueU4A+RKbjyBvcsxZS1EqOFvpRaOX9qOXJr+j7NTA3Ouy+WPFsI
         j4pdjdXIjXcQnI9sSY92Xr8TuXb2KbZlHhX8dbYOWydd62Np0/F26BaUvbuyITtDMEI/
         F3kUFKulb2ycbmIjMtbE2LNo3FsmcoNhzPTRQ1W+l2aJAQkt612IRnxM3hVeAkNr/ufS
         lCcw==
X-Gm-Message-State: AO0yUKWd6IFfbAHrqnTnzx512NzhCzPFljhA/J3PnrkHEbi3MWoxBzHS
        1A8VsDOBvZOQsnNsd//WbVx/RWTPvyAsgufishlr/A==
X-Google-Smtp-Source: AK7set+365J2a8iMxFWYXvnk/KzZBPStRBieNNzsNWJO+gbr+T6+DOsAcShA/Dr16A1mcGfpY7WwZA==
X-Received: by 2002:a62:18c8:0:b0:5a8:4e65:80ac with SMTP id 191-20020a6218c8000000b005a84e6580acmr4902135pfy.10.1675995488249;
        Thu, 09 Feb 2023 18:18:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c10-20020aa78e0a000000b005898fcb7c1bsm2146703pfr.177.2023.02.09.18.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 18:18:07 -0800 (PST)
Message-ID: <63e5a95f.a70a0220.16815.448e@mx.google.com>
Date:   Thu, 09 Feb 2023 18:18:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-36-g4c853ca1cf79
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 2 warnings (v6.2-rc5-36-g4c853ca1cf79)
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

kselftest/next build: 7 builds: 0 failed, 7 passed, 2 warnings (v6.2-rc5-36=
-g4c853ca1cf79)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.2-rc5-36-g4c853ca1cf79/

Tree: kselftest
Branch: next
Git Describe: v6.2-rc5-36-g4c853ca1cf79
Git Commit: 4c853ca1cf798f1d74a7bd9e3a0541a3ae8ae77e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 2 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x141ef6
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xcc: relocation to =
!ENDBR: native_write_cr4+0x4

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 0 errors, 2 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x141ef6
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xcc: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
