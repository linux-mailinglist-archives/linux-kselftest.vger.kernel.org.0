Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F736971AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 00:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBNXRs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 18:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBNXRr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 18:17:47 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04E01BEF
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 15:17:46 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so335935pjb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 15:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d9E8QmsFSubxXiA4fmde3ncityaGLqo7S+vlQk7e2a4=;
        b=CLb99hMf+ZAj3gEEL2Ajbj0M4+bsvid+/U89xjekE8kFUMKefqPVWDlSIqT7ww+Kp1
         hDEQjUycsPg/ZuAp4d45X/1skVztdOfd7RmS67CyNpJkD9BwGgS1eQhC2zU4Kj00IQQB
         KuNVtG8wmDLM+fjUVR3G9V7RtfkkRorQIej/dLAdlfTvV2FaK/Fev6LAtJFM1br/g7EK
         6ijtELhx4CuLqG46wUbsQ4V29JdMPWqPRxOEDHGQ8vYbmdNFVyJEgUQHlJTqaKtD2E9q
         lnMdFoUjMtsJs+0vWnwHsDQlTfphxxT2JMOOv2d4I8GVM4zGhcp0U8z1ws3v2tGpKGMi
         Q9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9E8QmsFSubxXiA4fmde3ncityaGLqo7S+vlQk7e2a4=;
        b=ghw0bSVHYbnZtSqpiO6SMgXGF6xeQ0V6MZds5T6Hm5k9+vqchpkuCoM+yaM8PzKPV3
         0rCjr4o+t/W9SCwAdGcocZ1VKvq/MJxkSRyPlF20uKnMwNvF2nJjRqkTyudK6Rm05m8S
         4ZhUyfEPGmnM/5VtGLQ5yhRBlNVGI4UMUpcibE7zrQ4H00t+9ehtzsYxEEdn0k+SFJ4O
         S9x/s1UCJ6DR6jTvpYZHaaRgRfdJ5Qi2Tc+txM/ufDBXP3QEBtXN3H6MZkKnGHxal5bh
         dbYvBuPsh+H4ZSlCUneeChGqRmX+IVnlmketZ4Q5V/F+kCNK5HtjqxWUZh/I19T0vGdx
         e0HA==
X-Gm-Message-State: AO0yUKX6xC65Pn20oYoX6bUCVNTYsnZr5iJqmE3R6lWGZ4eqAKuCyFtu
        gUNRnC0R21TcvHKvOUTnBCXKBVldf3rOPxHBFAM=
X-Google-Smtp-Source: AK7set+d5AaSx7pvaeVB2MzyBXvQsNh+6hFlfysfglPawobG/IR9cLYJhwEZ1V9YGYZqAaHTc+pVIA==
X-Received: by 2002:a05:6a20:4421:b0:bc:d288:a67b with SMTP id ce33-20020a056a20442100b000bcd288a67bmr5375109pzb.43.1676416666334;
        Tue, 14 Feb 2023 15:17:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709027c0300b0019934030f46sm10750136pll.132.2023.02.14.15.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:17:45 -0800 (PST)
Message-ID: <63ec1699.170a0220.fa302.3eb0@mx.google.com>
Date:   Tue, 14 Feb 2023 15:17:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-40-g0eb15a47bf43
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 3 warnings (v6.2-rc5-40-g0eb15a47bf43)
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

kselftest/next build: 8 builds: 0 failed, 8 passed, 3 warnings (v6.2-rc5-40=
-g0eb15a47bf43)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.2-rc5-40-g0eb15a47bf43/

Tree: kselftest
Branch: next
Git Describe: v6.2-rc5-40-g0eb15a47bf43
Git Commit: 0eb15a47bf437a268b69ab1a1a45fdf1f609b69f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 3 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x144456
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x1445cb
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to =
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
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 PASS, 0 er=
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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x1445cb
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x144456
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>
