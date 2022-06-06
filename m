Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF69253EF19
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jun 2022 22:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiFFUCe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jun 2022 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiFFUC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jun 2022 16:02:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE8727B32
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jun 2022 13:02:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so18816692pjo.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jun 2022 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Yn5rtgKv/4TlUQEzLadmst/DY2ekTj+VQg8Ju0mEsNI=;
        b=pbMqbg4tuXEPDUkzbJfA8nkC/VGh8qhZmKM01L46riILCke5RHNPOTq603QyMYDt0m
         wa+aH6uRaZXIVbqBwv/Gtyj4+7dnZGXALHTlLRb3F2APcIrzdA04JvehsK4WsES2DnL/
         OOyhMK4kX97TZpV1pFdMzE+mjcn/Kklc7N1OM6aufDwlUf7jYZzzDMsBIO4Tj824OxrP
         E9PdAzFLJDTl6dSajEjFbyIYBSYhCfYZZLNgqpn30T7YUJ/SNmYlIQGpiHQlQ7bgCBw3
         G9o7SYIgcFBGWdR1gtKWTKFCpTt46d9mkUxvRn7tSJ1gk4BrPtW9elkzXmPqoIqKLVes
         BvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Yn5rtgKv/4TlUQEzLadmst/DY2ekTj+VQg8Ju0mEsNI=;
        b=0bQEeAs1OF09/JiOeBoL5PhouZfrLI11rKbPv4I4gSSpC5OLXjHVd3iBMZjDAVeNvb
         wzjryRvoH4RowG2j8yEDt+Vq/DZmGyWRKwPqJISftET9pP2jRMP02ctyfdEYU4uIOXN8
         kHtUsgjzLPHZw5Z4nidCPi6TTqxa9uCFxqcam7ne9iQt2KC3NpGXdeW/BU9w0F6i/ueO
         Mv81doN3Z9c2TEKPAczmj+keGqmjX61++UmK+uzc2lrJevvnErpTIFONNQ6iUX9442Dj
         1PvrFMDf5Qs5tzyRsdz8zBNW+fLS1QUneEuPD8QrpFEjlNSA233E6gu4y1dLLcLGQWDS
         0Ngw==
X-Gm-Message-State: AOAM533lSmKNKmoh0KSMoMPFgwwtU4cvrh9SWszRNSz2961tXU9PxdnE
        MYlmR9aatliIachJsv8mK+m95G8LzAS+dSgx
X-Google-Smtp-Source: ABdhPJwZ6rTFMu63Id+2436JevbvhAA2rPtKhqE7Q/DJU+dmotgjRyYgWAqqiQSMXmhgw+Z6KCwPUQ==
X-Received: by 2002:a17:90b:304:b0:1e3:4285:ce1e with SMTP id ay4-20020a17090b030400b001e34285ce1emr28901038pjb.71.1654545743902;
        Mon, 06 Jun 2022 13:02:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090302cc00b0015e8da1fb07sm10841601plk.127.2022.06.06.13.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:02:22 -0700 (PDT)
Message-ID: <629e5d4e.1c69fb81.8c2d7.8765@mx.google.com>
Date:   Mon, 06 Jun 2022 13:02:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc1
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 1 failed, 7 passed (v5.19-rc1)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 8 builds: 1 failed, 7 passed (v5.19-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.19-rc1/

Tree: kselftest
Branch: next
Git Describe: v5.19-rc1
Git Commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Build Failure Detected:

x86_64:
    x86_64_defconfig+kselftest: (gcc-10) FAIL

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
defconfig+kselftest (arm64, clang-14) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-14) =E2=80=94 PASS, 0 er=
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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
