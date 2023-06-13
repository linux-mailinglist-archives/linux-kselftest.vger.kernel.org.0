Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C164372D894
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 06:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjFMEZ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 00:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbjFMEZT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 00:25:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49524296E
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 21:22:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b3a9e5bf6aso17144895ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 21:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686630145; x=1689222145;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FLNBJHRjCUHKkQs7rhR7/THuZPStR9ZW6ZUYbUXJGoU=;
        b=aqjAmnWQNYHEJXuYZ1eJKPCrfGYrQ/GDoy18ENdmd6qrVMBB7PbkIk/VrvIgu1pu1Z
         f550rsbDhanE5TJf0mua+Qx1vn2BHh1EBY/NQybfKpMEO+0MhDYIMXQT3K9mWm8akgwk
         tAw80S6KNypi5lDn6PKcIVtUDs0WnPdMH0aQO1i2eKvS0CNMbLdeagwA7e3JOty+Simz
         FLBsccmoODLiMYAXjG+faIuZlz66XEL2nakoGRleKN6PxWhXG7FjzgP1GDfRkJqxmPDV
         8+YwaJb2QPQTXHKGQOx6Ibb3ZdfpjLzG1z7n332l2g0DRMpDBL6pNvvWOY1H0VBxZOm3
         bfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686630145; x=1689222145;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLNBJHRjCUHKkQs7rhR7/THuZPStR9ZW6ZUYbUXJGoU=;
        b=kJDS7mAtg5lQ9Oh0SErP/7VnDYfu6PiCBkUTBU84Ek7WFlHJ6GA/XY0vdFahHhJ3HE
         g0l7Kl60iAn3cTFVKbXG5sx9BfIV7Q2YS6fCt7Bmmbmxaicq4NAZXKmn6oQyVLzMi0gD
         PDxKaRvs/L89kE3nVCZKtA/NC/j1Ux8dO6CBXHQBq+Y6scl0GL2EUaMQOtgvqGXvgTO0
         OW4YxLQ3TZhV9E23NOPB9dOgt6HHi97oP+npV5a9NG0bz6kDmkMFVaWnq8v2fZP7r3Z0
         y46+NzWRjA3aPbbo6+3hwvxFT26fCRtw3HS+MiRoSNr6ZU8nkip5mceVeUPP9YohR5gA
         yxOw==
X-Gm-Message-State: AC+VfDxasT8akqWciq6gsukxyD3Ugz3tR041+a+BG8R4E5pHC+XQeP9y
        39N8X1I7GDxab4qOd6DFjvGq9VAudny+iGT1RXWVLQ==
X-Google-Smtp-Source: ACHHUZ66ewyHTSd/dOaau4Sr33K1a7Uia7PzEU5JBhwzRGZT2wrVRfhnABsa5My5LABCbFC4sZ40nw==
X-Received: by 2002:a17:903:124f:b0:1b0:3a74:7fc4 with SMTP id u15-20020a170903124f00b001b03a747fc4mr9413703plh.24.1686630144638;
        Mon, 12 Jun 2023 21:22:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y12-20020a1709027c8c00b001b3d6088993sm2357852pll.24.2023.06.12.21.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 21:22:24 -0700 (PDT)
Message-ID: <6487ef00.170a0220.f2a64.5274@mx.google.com>
Date:   Mon, 12 Jun 2023 21:22:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.4-rc6-10-g8cd0d8633e2d
Subject: kselftest/next build: 3 builds: 0 failed, 3 passed,
 3 warnings (v6.4-rc6-10-g8cd0d8633e2d)
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

kselftest/next build: 3 builds: 0 failed, 3 passed, 3 warnings (v6.4-rc6-10=
-g8cd0d8633e2d)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.4-rc6-10-g8cd0d8633e2d/

Tree: kselftest
Branch: next
Git Describe: v6.4-rc6-10-g8cd0d8633e2d
Git Commit: 8cd0d8633e2de4e6dd9ddae7980432e726220fdb
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm64:

i386:

x86_64:
    x86_64_defconfig+kselftest (gcc-10): 3 warnings


Warnings summary:

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
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

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

---
For more info write to <info@kernelci.org>
