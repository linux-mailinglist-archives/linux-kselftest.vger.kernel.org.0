Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC097656630
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 01:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiL0AHC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 19:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiL0AHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 19:07:01 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E510A8
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 16:07:00 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d15so11805949pls.6
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 16:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mOvBkBpHjxUR/Nc2d7l03rAEyP0ibNwENN9DHytp2+k=;
        b=ikxCBIa/IIFOniS2yBgptOucDODTK6Zh65aq2ljfwGEdECq/JJjosTXqk+IOiHaFB4
         xTJSsI2VS8TC5Or0kYgPxVc4UNZleUdFPwT0T1vJERq3ArbeI7/jvDE+9ZGJiMKqXjna
         BkKtnCiqPdmyjkIFTiBOcOCrEmKNpIuC9STDReNVZsvXa/TV14KpnJ6n0xNwrunyCIFK
         MOWtnXSZFajXcxfrVxwSAvv7i0km2/pbHZFjG6kxiNLbnylTMlM0qBbLW1Xa+Yw9KqiF
         U4bqmd88p23phKq0rJggPRhebIHS62+dm+SPunnn0Rz08NjU/gJq1fVcjadU/k4i7WoJ
         SAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOvBkBpHjxUR/Nc2d7l03rAEyP0ibNwENN9DHytp2+k=;
        b=IYOgIrdWfqUTTJ72XBmLk2ILu/LqrrOJbAtqebJvNsho6rT/b9ibYO3xqjRNOkjVrV
         QUhd2g0wUgUP3d/Kj0GG69m2RNikZVM7M/ZHqUlcxlFte5LZ4lyOIITT/2vNgDGmP/lR
         ueMN0+HDzO6XLM3TQBT/qPrBMDnTzMVb8z8R+9DFGyDbuNZBH+P75zlng5ejCaWc1NAu
         4sI46jXrkn06K+54h4QB+tj3dO4Frhv6ZThD8ZUPwertnZrAnHqHhQCXMGfigcwmKzcL
         ymskwcol1sDXKQ0QrfQOqXWn6IdpDMkhkAr9WZpRgcXZJslvaLgqlzr8ESbrz7KGKNNI
         iXWA==
X-Gm-Message-State: AFqh2kpOfljY7vZipL8R9NZc1JyeK7ZhhHBzhLVhE1tvcnybi1ZtP1/N
        p8+CR8oTzqE1eGDEW3SyfMsx1JK6p3BEhrKSSn4=
X-Google-Smtp-Source: AMrXdXvxf4GlpP5DlR96E+FccCqIxsp1+cLujRcUpNPrxuqPVbPBSgi5NS8lzYsL+oMkML75L+VaFA==
X-Received: by 2002:a17:902:f145:b0:192:48cb:3429 with SMTP id d5-20020a170902f14500b0019248cb3429mr19741155plb.67.1672099620073;
        Mon, 26 Dec 2022 16:07:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jd15-20020a170903260f00b00186b69157ecsm7631900plb.202.2022.12.26.16.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 16:06:59 -0800 (PST)
Message-ID: <63aa3723.170a0220.17b8e.dad8@mx.google.com>
Date:   Mon, 26 Dec 2022 16:06:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 3 warnings (v6.2-rc1)
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

kselftest/next build: 8 builds: 0 failed, 8 passed, 3 warnings (v6.2-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.2-rc1/

Tree: kselftest
Branch: next
Git Describe: v6.2-rc1
Git Commit: 1b929c02afd37871d5afb9d498426f83432e71c2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 3 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x141c96
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x141e0b
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xcc: relocation to =
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
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 0 er=
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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x141e0b
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x141c96
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xcc: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
