Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C567C9043
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 00:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJMW0M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 18:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjJMW0L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 18:26:11 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C26EBB
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 15:26:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c737d61a00so21945085ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697235969; x=1697840769; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vlqv5v5B7XAw4LiYLlbYDq2mALXXjpDJEz1vGxXmlFU=;
        b=CWIOTil7/wGM6jmvJbsCJyQU2U3v06TmIFcBk4xcBtLXwwZyNV78ecjxxxFKv5e/mV
         C6Ru3n1fkNbhKjfcBhZjCVSwgbwGVAGboBV3PMOGCKttEMajkJGEzIbADoQOMiJrG6Yd
         JAoZc7KIIyMfEzT20wZfd36ZUMzsOKVdyHJrJcKpQy8osXS5SwXiKp0q8FcH3j5F7aeB
         1XABTTS8s2OCqHE6atXootTWD8/r7SeSrBRFbMlBtRuCa/VrbQ1PysqT0PXq8mbunmAa
         txH8NukYfBFYFG91IssOIpClz2Q1M+rWsyMv0PLqptDzRyf6izU4ApC087uNEgqw2Yfj
         wlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697235969; x=1697840769;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlqv5v5B7XAw4LiYLlbYDq2mALXXjpDJEz1vGxXmlFU=;
        b=isMmIisNsRQIeruDC8h6vJ8v70W0PBrflk7cjSubt/QW5iky6LbRR//uRqDalQ0+8f
         FDHHOiecuiRVrs0zwq9NMFC3MNUF0PUMWguOKcT7DNe1jcEV7BEsTgmtmtMxmRhxcvdr
         OsVLiz4rEJvH0+UiUFEBxXFdIfwYI7mooLT0MJEgPFJtlZYnlwQKkpdwIkxV2QCTtQa/
         VmF5Pj8tCxUQMSqha9yBTm6RxwYvn92S0kvuo+cEfyK3SF54VVBtGpmRryiLOnLTswta
         M8v0PCWxuEvvvkbjK6E6747MyfKFD2U7mcLa2d6c9fhZl1paziKVN7BA/V45aNfHUzZg
         O/pQ==
X-Gm-Message-State: AOJu0YzmEqUJCIa0MLfFOHVZXPy3tprL2Dd6K5THLIflU5f/vkjULslF
        Spm9nx6kjU93PmxJwKH1ZfjhPCwTPx01akTLAWaGyQ==
X-Google-Smtp-Source: AGHT+IHat15C3T+9mdZO5Qz07d639FLIP2w3jH7zxan81Y1ya7eiTt8mcgZzeXd+nmLSPj6DowQ8xA==
X-Received: by 2002:a17:902:d48f:b0:1c9:d358:b3c9 with SMTP id c15-20020a170902d48f00b001c9d358b3c9mr8906256plg.19.1697235969031;
        Fri, 13 Oct 2023 15:26:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ee1200b001b8b2a6c4a4sm4335146plb.172.2023.10.13.15.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:26:08 -0700 (PDT)
Message-ID: <6529c400.170a0220.c1346.f1b7@mx.google.com>
Date:   Fri, 13 Oct 2023 15:26:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-43-g508934b5d15ab
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.6-rc2-43-g508934b5d15ab)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.6-rc2-43-=
g508934b5d15ab)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.6-rc2-43-g508934b5d15ab/

Tree: kselftest
Branch: next
Git Describe: v6.6-rc2-43-g508934b5d15ab
Git Commit: 508934b5d15ab79fd5895cc2a6063bc9d95f6a55
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
