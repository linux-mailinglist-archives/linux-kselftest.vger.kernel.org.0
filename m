Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C6A682BCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 12:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjAaLte (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 06:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjAaLt0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 06:49:26 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2217A173F
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 03:49:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so13694260pjp.3
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 03:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2MoX6HGRrVPMLc455WO+UrDeA7+3Pj+oqINY3ct/xLE=;
        b=lru6F850JR0wm/mROc+X4XxJbzbJid9ZZNv9cPb7by1F+u2uTEMEQW208u4CrqIB5J
         lGyVjgfymjlcFJBAsAZ/TH09sFsiq4QxBmOsj3JNpNtpSAUN2E/sGb1IQkNyO07hI+am
         kr7SIJOxRH4UP3jQO2/R6Ds4Ndiy35A+rcTI9nfte/1IixIekWZcBEF47AKqGEj9RTvJ
         LN3E/rUV5aKAea9q4Qvi8NnHt7RzbZ3mdmb7L6KDQokJJ+vrxCLNM281pHtsKwI6LwC+
         tDb+UuL78nl1h6fuXWzbfpHy5A2uLMZ/rcHQVrKWm90xhYgdeFOty6/uQwNZk2RUSFyc
         1Bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MoX6HGRrVPMLc455WO+UrDeA7+3Pj+oqINY3ct/xLE=;
        b=Qj0UzA1U727NlnvDa2unvBb/pT5vW9yOczPkg1OYwr7SEYW7EL7V9JPivKNnXQ+i5Q
         SbThoC5Tgkiys2mcWbKI8QOTpzoYqd7RkbOT0Aq9TiUMghVD/0yxzmMzYhwogs4m3bq0
         9l/6NwNI9S5+cP91iPAOxD2Yw82B9CEIJtV5lS1BL7u+C4n2Dvh7PjwVWjDaof/3GRNG
         oJBu9vZvuRpplvMHDYsiRo68r6ieJcTAAB4IQOUT0EEX0w7zZ0xiJUEue5HAXgGnNfxh
         5uPJJyCivIoYav0WREQDGGT9z2PBUYFDy9ZEPD5ypmsZxhIYfGcOOvp1D/+nYopQy6c8
         r7pw==
X-Gm-Message-State: AO0yUKXW3VTe6J5CYk/xzeGcdKPLnhdmSPN+lFY0XqFcPqhQgmSjweq7
        KPIkAxEhdIRFE8j049Sp/byDeg==
X-Google-Smtp-Source: AK7set8MWkNqufxemcSu14XlT6N+s7MI5wCgHEITYgGoJzyQ3xoXINvayKnYs0hxOSFT4b7/7XS8dw==
X-Received: by 2002:a17:903:2283:b0:198:a347:44b8 with SMTP id b3-20020a170903228300b00198a34744b8mr494241plh.31.1675165763693;
        Tue, 31 Jan 2023 03:49:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902b10500b00192740bb02dsm9686252plr.45.2023.01.31.03.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:49:23 -0800 (PST)
Message-ID: <63d90043.170a0220.34ad1.05e2@mx.google.com>
Date:   Tue, 31 Jan 2023 03:49:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-31-gc837391e4499
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 2 warnings (v6.2-rc5-31-gc837391e4499)
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

kselftest/next build: 7 builds: 0 failed, 7 passed, 2 warnings (v6.2-rc5-31=
-gc837391e4499)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.2-rc5-31-gc837391e4499/

Tree: kselftest
Branch: next
Git Describe: v6.2-rc5-31-gc837391e4499
Git Commit: c837391e449979b550a9aabfcc253d245b5436a1
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
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 0 errors, 2 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x141ef6
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xcc: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
