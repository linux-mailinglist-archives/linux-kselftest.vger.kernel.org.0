Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64662668764
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 23:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjALW64 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 17:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjALW6z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 17:58:55 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1952C46
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 14:58:54 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso25232168pjt.0
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6C8WUYI9TsIr3sw8Ii9BIlh9epC1vvNDZkqodo9dEVE=;
        b=R3+XiJFGBKp1yD/E/ZQTe48hSMk91AXzkxS5m7gNMpExTT0F4RPKn9R2ve29dbzoE9
         aYgJELNO7qKl5T+ltDh6j0xh87kcbnqEAS9GU2IjcjQ48PZBMYmVWVVqUuwPgTOZbZTv
         WOfev77A8jHdiGuwc/bxn8mFSRxHbsVIGNed1W+6zeMrrvz+tG8cVy41OfB2SD8A7J09
         xTZMEqOJe0VD9xwuBMxZKj7PHbF/JC6QeTWH9w5+Uk0YqRvREXMsMxdZQkGbetO6u6o2
         wt7wF53hMtil2lZ/pYuGnDiWWzII7h1LocgvLURLssTCVFCHRqPemX5SG6DiHBwo5zte
         hvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6C8WUYI9TsIr3sw8Ii9BIlh9epC1vvNDZkqodo9dEVE=;
        b=B8LfVYxtTfh4RzFly1oGPPlpQyo4T2TZJjIdf7JPyOHTeXv2Rs92L4m8CF7FfrHSv0
         SbRW0XZ00EllnWfDyZrWhgAgdywuVQPyKLMBQT2vb+LHTPhMXZNMEVfJ+SSfGGgwi1Tp
         BKX5PKi2fGvGm9ethiwYW5K10PvEwacp+2on8ebdwT07R7BUTljTpUSJY7LbDvI+gJm3
         FKgalRTa4bYKx3P4l7WnT3waP65t/9roYIdPWCgPO77PP8GB3saIt4u6R7JZlkeBIz7r
         AzFPZNW51G54G+mvKce/aAwWsD4q9TDeh3Nhs068AhVdVU+YHYur2w6QuXppJKB9K2mS
         Z0Cg==
X-Gm-Message-State: AFqh2kqavmMFjqQAOJ/bdNvhKwKHhaE/hyv+wa9PPDoeui6NNgRMErXY
        vK/oOMvrk/EBBWghTDbv8zXHIg==
X-Google-Smtp-Source: AMrXdXuwKgEUZJ+MGfwjOZuPW9/lsVUMh0D65leE8Cy0NJUuCaaNYFq/sjTsq1C9Sr5lHJiE30Jbjw==
X-Received: by 2002:a17:902:7d93:b0:186:644f:bef1 with SMTP id a19-20020a1709027d9300b00186644fbef1mr81541475plm.6.1673564333766;
        Thu, 12 Jan 2023 14:58:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b00168dadc7354sm12771867plg.78.2023.01.12.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:58:53 -0800 (PST)
Message-ID: <63c090ad.170a0220.46bb8.4985@mx.google.com>
Date:   Thu, 12 Jan 2023 14:58:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1-1-g9fdaca2c1e15
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 3 warnings (v6.2-rc1-1-g9fdaca2c1e15)
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

kselftest/fixes build: 6 builds: 0 failed, 6 passed, 3 warnings (v6.2-rc1-1=
-g9fdaca2c1e15)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.2-rc1-1-g9fdaca2c1e15/

Tree: kselftest
Branch: fixes
Git Describe: v6.2-rc1-1-g9fdaca2c1e15
Git Commit: 9fdaca2c1e157dc0a3c0faecf3a6a68e7d8d0c7b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm64:

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
