Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7435F65663E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 01:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiL0ATo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 19:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiL0ATn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 19:19:43 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8BE1026
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 16:19:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 4so11840504plj.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 16:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cFHiXrcHu1k2Ej3qtTrTS5+55EExN8OVm9wDGqbfcA8=;
        b=S6M5i/rZSHQgZK85I46gVFUByVYOMnlIkv1QJvqDPJFcuBPHnj26qCyCdUVwNIj0Fh
         Cmkpqhl3nqE1RYMSolAElGOCj78N+yv7vGqsp+2XagQq85KUQRxua0DTjd0HkTxCHyPC
         Zm9uLFarPQjS2JA583nJtmvvD8FLXvpV98ffve4MMAGVafCIH57FJ9UNi8X88cd25FJJ
         1YUgD59WUPphXhbocbvoKrocDONl2rnQJvmtQFXM5MSi6yLwFida7qwcjpbD9grag9Vb
         hHpqD4QWPkG80mNu0cexSxFFc9nkg4Rd9vNDD9HyiZLbsW+dYv3xQgZvoum3hLrKL+YF
         SOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFHiXrcHu1k2Ej3qtTrTS5+55EExN8OVm9wDGqbfcA8=;
        b=4anYYJSiS0/ap48ePD5xwMj6VOCJZTcPEGiPpzHe6S+lY0Teux5TOXxmKDcL/IvOBk
         i3C6VJeek0hlPsvRDloYwliUdqiSVgDt/LB9k44sxwtQLgjJX5YY28Oc3L7K+k1AmOsA
         1W73hxOHEy+xF4I3KCc5gFYO2V0plYn3rE4i8lpgDvBKfhIBSwqyf7RlU42WfKQ/XjGf
         T6CgIg6cif7xe6ihWTECaIoxyCewl/PsZzZZx7Hs+0G4oj1goos76FN6PrCy/fUJqQ+e
         q4sU9GmeHoL0tGrQCbHkRWO5EHdApjriJuhgZ0CwyOqUQSDLnjVPWe/rdbjzXtSGzFkq
         TcJQ==
X-Gm-Message-State: AFqh2koFnW1nba5JN6cjv0MS7Apm48Ln+saeDdt5KnERtqJlAH3Xt0Pq
        lt7GYapf5gXXpixMT1JldlZIoHEv+uXBvIlPuHQ=
X-Google-Smtp-Source: AMrXdXtwIWGM2XGoX3hgBoncrb0jCqh3i9JdQA8/JftGnIP2Xr4MdU5UJkXo7uJRWIFkLoDf3em/iA==
X-Received: by 2002:a05:6a20:3d84:b0:b0:1abd:8604 with SMTP id s4-20020a056a203d8400b000b01abd8604mr33536487pzi.41.1672100381962;
        Mon, 26 Dec 2022 16:19:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y5-20020a63ce05000000b00478f0aa945csm6907086pgf.7.2022.12.26.16.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 16:19:41 -0800 (PST)
Message-ID: <63aa3a1d.630a0220.b4c3.c61b@mx.google.com>
Date:   Mon, 26 Dec 2022 16:19:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 7 builds: 0 failed, 7 passed,
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

kselftest/fixes build: 7 builds: 0 failed, 7 passed, 3 warnings (v6.2-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.2-rc1/

Tree: kselftest
Branch: fixes
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
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

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
