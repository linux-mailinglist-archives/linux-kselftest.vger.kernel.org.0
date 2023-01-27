Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FF467DCAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 04:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjA0Dby (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 22:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjA0Dbx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 22:31:53 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598203BD8B
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 19:31:52 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m11so3415726pji.0
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 19:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AA+kP/YOv+WAjNwHGVLfH0MNEWp1obV9wnovIO6fFro=;
        b=ERPoHWJMb8QBf+5PBgPIn7DF2d77Krl71fVrGlRyjaqBjyIn72OuGgEqEWItAS63IT
         RUvHmAwYZKE0duUA9yKK12f8/bTY15VX4vljOX7k452cia98x4dlEwq87PUVA3kC88Rj
         B6StUdnHC/TFX+xyhHCH6cQWfrdX176PYDSgcsVbOIFH8mhkUqNuGmDLBEu84PdVlv2S
         KUdyrBl7IhSXy+pzE4JQZ3AyC1hbfqpp/IvSgQjM6xn19eeBw42skzM1UDwDWmXZJhiW
         FC8oDK+52WF670I7Dmv57YQZSD9xb4v90o/ZIDZ8JUJOtHnuc+F1pTxJ41tWr6lgTHyu
         x+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AA+kP/YOv+WAjNwHGVLfH0MNEWp1obV9wnovIO6fFro=;
        b=k6m4k121kFZXJ9WoXYHRejR3CkxCUZWqOnsXdk4Ddh7abjvJ0FYOyjhqdQNYlrmqkT
         FClF9fDOZ6At6b7yvIclig1Pa9LpsDDgKlBOaxP8vnVzh+SP13e6Nr/5DWpVwDnanj6k
         oKFHdA8G0RLd5H8GwdGxVkATUFvRVwq09C3fQPBJ0dMUWHD34FUWbW54RpJzh42ImK8L
         PwjVsvJCw1DqICgZiz9HNpNaEDxVkDKMd/gerF+nv7p3OUPKg25oKZ5FOjUNAh6ZUOHF
         ZGllTfw8P3cEGFSoyTIO67MEqnmuk8DcoC0BMUQLotDscSloDhh9ocol/ik8Ayo+x31M
         8t1w==
X-Gm-Message-State: AO0yUKX7R6xsdC0DqQaOhMXAh747PRl6MfQnixsgiGLr5Ay9WzSDg+0Y
        hq7w7ymR62XyY8HVqVzXRVZhGe9oXZ8twyJqtCG+jw==
X-Google-Smtp-Source: AK7set93r9fsJftBKF8SxQilUlUMqimIcdxuAV+5AmmXrUeyL5rIPcxNMpRVUAolNM+Vk4FYD5iNrg==
X-Received: by 2002:a17:902:e3d1:b0:194:a7cd:7e09 with SMTP id r17-20020a170902e3d100b00194a7cd7e09mr3176407ple.50.1674790311892;
        Thu, 26 Jan 2023 19:31:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jg20-20020a17090326d400b00195f249e688sm1680575plb.248.2023.01.26.19.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 19:31:51 -0800 (PST)
Message-ID: <63d345a7.170a0220.2e1f4.318f@mx.google.com>
Date:   Thu, 26 Jan 2023 19:31:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-1-g65177e47d303
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 2 warnings (v6.2-rc5-1-g65177e47d303)
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

kselftest/next build: 6 builds: 0 failed, 6 passed, 2 warnings (v6.2-rc5-1-=
g65177e47d303)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.2-rc5-1-g65177e47d303/

Tree: kselftest
Branch: next
Git Describe: v6.2-rc5-1-g65177e47d303
Git Commit: 65177e47d3035c083cff034ffbfc7ab750a4675c
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
