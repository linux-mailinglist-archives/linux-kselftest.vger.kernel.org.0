Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE64C67923D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 08:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjAXHpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 02:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjAXHpn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 02:45:43 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D823D916
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jan 2023 23:45:42 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 7so10779100pga.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jan 2023 23:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vJmIox6nYoDKliIWSxm/VUOFrFsfHFNO3hI+IU1v92Q=;
        b=BCbqiuY/C3cqUfcOdYLLYjLEXH3ufOEVw+Cs7qrr/nH/37Q55NPs3swSjzPr87VDqO
         W8EBbmUyxOSTQ6vt2bD36IreEJsTyhvZd6+Ug6oIH5fdu6vBLRAcu+r8WTpn9dvc7v0v
         BUAdk2tHZRpwOTzcRjPe2XpcWk0RSzmQ2r8eQBHy1lYszquMXrpuARq4/G41OUKCj/nO
         tY/ffb3dEn86KIr1HfVfRh9tAuVyq10TWfNR6RoXwv7dmNL/HVXtNXXJeMQbUdjuZI5T
         4qJMN2fFLsfZQ4hoeZ4kE4Jkqv6lpuvUhq3atzzTpmJwWTTZXsVt7/Rbxa+OmLRWeuWD
         dDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJmIox6nYoDKliIWSxm/VUOFrFsfHFNO3hI+IU1v92Q=;
        b=WbDe/WURsafENyhOiuFTj1gly7EgTyKVtKaoU7sIlF6Lv0koIJ+6hTNJZvN3Jf/l2j
         oseAhkxOs26eofd7F8uKH3ivTPkeg8ddRSlnvoS9M67m3s1lE4SZC1JjqXkkfnJZFqNS
         DHAQAV3NzowLOwbeoIaONDiNfaql4VlHc80Ew+hrgU3tvG6SsaSpHjHhrLO3rnRcz1hk
         SPTMqxslZnU+GnRwbEfB951ZtxKadCKXBdMR4OIbZO3+RLvIjNIyYjYiu8MB46YP0gc0
         35e0QUI4aRNXY0VCinXGVd4sGYFPKnL0l+W7F00tlqI1K3q0oZgT/VcAK6xUN8lMFpmc
         sDOQ==
X-Gm-Message-State: AFqh2kr4/cDkPEY7g5OuTL0yM+oAEeekyuuwdi1imrUw+Pl88VKLjkbg
        M4HND3gK3st/FYd8nTV3KvbcrA==
X-Google-Smtp-Source: AMrXdXs06gzgy7A+aueeZwW/WZKJAmaEYyPQ7p4KuEbfjLFhVhB3CEEIt7OTOg57BPZv6sa3mDXfMQ==
X-Received: by 2002:a05:6a00:410c:b0:583:3bb3:438c with SMTP id bu12-20020a056a00410c00b005833bb3438cmr31285930pfb.10.1674546341763;
        Mon, 23 Jan 2023 23:45:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u29-20020a056a00099d00b0058bbdaaa5e4sm857699pfg.162.2023.01.23.23.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:45:41 -0800 (PST)
Message-ID: <63cf8ca5.050a0220.498a0.173d@mx.google.com>
Date:   Mon, 23 Jan 2023 23:45:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 2 warnings (v6.2-rc5)
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

kselftest/next build: 7 builds: 0 failed, 7 passed, 2 warnings (v6.2-rc5)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.2-rc5/

Tree: kselftest
Branch: next
Git Describe: v6.2-rc5
Git Commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
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
