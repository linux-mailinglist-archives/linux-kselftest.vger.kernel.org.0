Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400967BF230
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 07:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346354AbjJJF2o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 01:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344471AbjJJF2n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 01:28:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB74A3
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 22:28:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c737d61a00so41467295ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 22:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696915722; x=1697520522; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X9ZsR6oiTKpL3tU8UCjrNY6hD9AL5gas7WdByI5SG/w=;
        b=NN2AGPhJo0PsYe2yvM7yW3dwYTziDKhRBcXwmvzv8qnWntJSqOsykl5nKFPWPpUq5p
         3KiFLpKKcTi6bvW0fs/BD+ZHWTNIwsR68u6G3OveCHZIXTloCd8NAPCCHHmiUwjW9Shy
         FAcu5YfAJv8afB4ETdAxfpWvNlhdqOA2p/xNvA0pjnCEmMiKqKCyG+/TsFEuaVc8yFQJ
         MGeUcRreKvrjpFeXFe9vI/Sx6Ffv2K2/lebG728ol1bMI0hEw6wR7LT8ThhaLhjWhGp+
         e8CKIviLkqU5k2bc7XM3Utfh0bF076wPlgAhCCuOetYRdzBywx9AklmUIpjNphlsSWyk
         tLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696915722; x=1697520522;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9ZsR6oiTKpL3tU8UCjrNY6hD9AL5gas7WdByI5SG/w=;
        b=aygDId+eH+yphlHn4KFH+K1Ar6Ofa2JQnzASb7iE/EwVkB5e+po6W/e+3M7jwC6NKs
         w6jieWexqwU7g3Wd5loRVEuKWJoBd6mYtZtfYHhKb9m6/YWz2qhk3WIlFJzGOJhe4d1p
         9d7hdShQvrUMqEnSf+GJZ7EYxHTLupEk1Oe517GootjC8VQewiyLy1nnezSMnl450YL7
         ZOLFdfsFS/K7wyTfDVWKUXflElerwz/+qv4Og11n+f6e5VUMpZWz6gqgZdckwStLfBv3
         45uzP36DkzpQraBz8bwpI3yAPUmsRfScrPptDp3P1puave8MYlYem2knZBx8Kqaunh5N
         PU/Q==
X-Gm-Message-State: AOJu0Yz0ZY9di/VwXZ/jh8U0JcmA+UeVzcm52i4SvSaS0CLMFPhvXFgv
        ZpZgg9rF6557ynOhLwieO4eyLA==
X-Google-Smtp-Source: AGHT+IGX1somSqflhqtog4uP81pPUVNRwb0DcQHbd4NPTc7BaVq5AFANNE92OhUlDmjNnJEdaCXvUw==
X-Received: by 2002:a17:902:ab4a:b0:1c9:b166:462b with SMTP id ij10-20020a170902ab4a00b001c9b166462bmr1026270plb.59.1696915722100;
        Mon, 09 Oct 2023 22:28:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001c3267ae317sm10678777plo.165.2023.10.09.22.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:28:41 -0700 (PDT)
Message-ID: <6524e109.170a0220.f27b3.cc23@mx.google.com>
Date:   Mon, 09 Oct 2023 22:28:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-18-g2531f374f922e
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.6-rc2-18-g2531f374f922e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.6-rc2-18-=
g2531f374f922e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.6-rc2-18-g2531f374f922e/

Tree: kselftest
Branch: next
Git Describe: v6.6-rc2-18-g2531f374f922e
Git Commit: 2531f374f922e77ba51f24d1aa6fa11c7f4c36b8
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x13950b

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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x13950b

---
For more info write to <info@kernelci.org>
