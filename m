Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8864C7AFA45
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 07:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjI0Fqr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 01:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjI0FqU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 01:46:20 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB611BC
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 19:18:48 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7740729ae12so669130285a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 19:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695781128; x=1696385928; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jGxeWMzeYXSlNNZD+YH/mLPO8wwgHbmNq3BVgqv8uxQ=;
        b=taxl7KU1cMY+3t/W7ddMJ5cyKBdu8oPxsMCKICwlequ8DXOXC8woOBOxb2a8eJIabq
         9dj3YQi1QSa2uYGFGJxoly/6ddghQSUYNYYZuAAMLkqbu0ylz3+257Pbh7gfH9f8E86D
         lSFj1S3H+q+fIduQix1PcEDUZF/4QTyluFLkSRDpMoljf3ftJK0Z904plAJchE8/ttI2
         b4Vn+bDECUlMUsCqXX1982Jo4M+k4ibLqyYEH2M4ltH+FNpCaZSUl+G1mSPdqNhpiaKO
         v02UZzQtLuWz/frBAs7zknMholHNpZLdTsCI2oiOu4BCOYnmJE+SbShetLhpIbV/dlcg
         530g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695781128; x=1696385928;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGxeWMzeYXSlNNZD+YH/mLPO8wwgHbmNq3BVgqv8uxQ=;
        b=SHSa7PEP24lCnYuEVpT4o8AsM6TEH3b6FMtwmCG38N3B4usHLuR/xbvFa3kOql0mkN
         apu76+NdtIESi9veIP+PM71CgMSmBdB52RMOq5i8QBqkfcgTvtWODCwippKDxhaq/4hj
         iJLk0Xz8n9FRtEXZwHqhjUS61wJ0h6MRliH1ivBHr4JSewduuHZU9ZRsk+KevVxzW6Sm
         xBYgXn1lQHUd0FmMH4fGnOkFmxNhxyL7eU/Xq074H7oFObA+31OAXy7N30/EMd+bHB/s
         5+rzq7Wry5mChPN0+YIn+aImhHMAQZMniEWnjKicOmnk32aB+mvo0n9XkzdvI1p8JJj9
         MhwQ==
X-Gm-Message-State: AOJu0YxKV9shtH2pKvmh0AhFyRbDhZoEFqbqATEBDAXrjKsx9x1RnGsZ
        MEDENa2p555JEuogoEXEL3ERk8rfin2iCyadCSSjrw==
X-Google-Smtp-Source: AGHT+IGHgo0n04y2GVOtdYiSRUlqq+n4kg7ti/pSDj4uQC6gb3T2xo5GoIKpuqe/N6jzcetYvb5vGw==
X-Received: by 2002:a05:620a:414a:b0:775:6a43:930b with SMTP id k10-20020a05620a414a00b007756a43930bmr797460qko.50.1695781128118;
        Tue, 26 Sep 2023 19:18:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i4-20020a63e444000000b0056428865aadsm10398974pgk.82.2023.09.26.19.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 19:18:47 -0700 (PDT)
Message-ID: <65139107.630a0220.6c563.bfee@mx.google.com>
Date:   Tue, 26 Sep 2023 19:18:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc2-2-g078a2ead544c
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.6-rc2-2-g078a2ead544c)
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

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.6-rc2-2-g=
078a2ead544c)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.6-rc2-2-g078a2ead544c/

Tree: kselftest
Branch: next
Git Describe: v6.6-rc2-2-g078a2ead544c
Git Commit: 078a2ead544c56fbe6a3bed8cc90b5151a328b81
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
