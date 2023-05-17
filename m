Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D16707177
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjEQTGb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQTGa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 15:06:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E1A83FD
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 12:06:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae3bd3361dso2990015ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684350388; x=1686942388;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RIqPvAjJ1W8+ha9Tcac9Yslb/Nnb7WVCtGqbrlnub58=;
        b=eqSY8Dw3QarblW6oNo1abFzqF/fFBJkBoJRuKCOXsMCb3k8D+v0wfgYuquhO8byuWf
         vi0xz2prZc4wxiHntgn+PvkWpyvUcaRu4AMMBic+jm80oV0eX0NRWy/Qq+fcCZLGAvVt
         Vq67ai4YUSm88SNN0SgnCU8ayKfCUxg4xSziUnScg2HCem6p43C90/hhF/S+ixLUrxD0
         UTmRQalvBeSVFa6Iqz5hnXTcd4ad+orjBD4KVNcMO/fKKHDaThO8qVOVTOquHsC5MLLC
         iJqHIWG3qkU+0rYx+LK8w491BKkRnCKNYpPpGr5M3mC3k6tjP2AQxYaRYEmA7O/YePCv
         WxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350388; x=1686942388;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIqPvAjJ1W8+ha9Tcac9Yslb/Nnb7WVCtGqbrlnub58=;
        b=IjiWkpSCf2XUnqyUzk/vOl8u9E7DBWza225cn32NAtvvYhAYMzqqxihUutZLS4gXuI
         mHnC+qdTJ0tWrdmthMcApL+BM1B1cZTodf7kThcow8BlaAWZgvx/YmdP+EhIphroRXCE
         C5qW8DKUXEkrHFckTS23iYaKGRsPFXHJEGNMsKrynUmSR1sk+5nukHj9O6EaPwOtsvIc
         bw6LyhiOpJRoKVPJ/ySnwBRjhFnbx4OxAS1rK3FRFozfqTd/SUgtyQ15Q2uK4slfw5Ry
         aTtrTavrMqY58a1wVb8KNaCLRiEcNgw0P0N/Qp3ZovltPa4CRwEFDRzNRzpjigAD1oPw
         Uw0g==
X-Gm-Message-State: AC+VfDy0eKuh0SczOo2vB6Z7Yhw8X95jm/NqiN+zQfJ2gqbWcdSzZN16
        S7Evp73aJuof6Px5+Ck0WZwwCS8iBfX5ddroXu3i6g==
X-Google-Smtp-Source: ACHHUZ7ALxN5n/AlP41Ntuf5nrSFUNPG1md5+B0h9x0G8Dju0vg2YHANKyftawHMTEbIFe6NKOkO9w==
X-Received: by 2002:a17:902:ce82:b0:1ac:86b5:70d9 with SMTP id f2-20020a170902ce8200b001ac86b570d9mr4045439plg.32.1684350388387;
        Wed, 17 May 2023 12:06:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001a988a71617sm17918200pla.192.2023.05.17.12.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:06:27 -0700 (PDT)
Message-ID: <646525b3.170a0220.8443b.2da4@mx.google.com>
Date:   Wed, 17 May 2023 12:06:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-5-g3ecb4a459a1e
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 6 warnings (v6.4-rc1-5-g3ecb4a459a1e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 7 builds: 0 failed, 7 passed, 6 warnings (v6.4-rc1-5-=
g3ecb4a459a1e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.4-rc1-5-g3ecb4a459a1e/

Tree: kselftest
Branch: next
Git Describe: v6.4-rc1-5-g3ecb4a459a1e
Git Commit: 3ecb4a459a1eeab1ad135f87057aa3ea4c9af1b8
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (gcc-10): 3 warnings
    x86_64_defconfig+kselftest (clang-16): 3 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to=
 !ENDBR: .text+0x1423b6
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to=
 !ENDBR: .text+0x14252b
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to =
!ENDBR: native_write_cr4+0x4
    1    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1b: redunda=
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
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

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
    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1b: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to !END=
BR: .text+0x14252b
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to !END=
BR: .text+0x1423b6
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
