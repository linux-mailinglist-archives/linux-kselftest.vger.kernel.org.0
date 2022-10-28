Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F62610D15
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 11:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJ1JZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 05:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJ1JZH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 05:25:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC75BCB4
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 02:24:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so4020797pji.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JPxn1BTev6eqR+ezs9UlyHS3iMu5dWBTNFe4tVb/ZkM=;
        b=v0hAxf2ZYBCo8Abi6aZSvavr39JlwsU57ZxPlPJ5sIvkA5LpiVi/3tPYDsNKLCEvE4
         1Rr8mdrL3ozhzBOjdiz5j6DehTFReq5NGyTK46Fp1MENsXIlGV3AmQaaEpo5toim3phQ
         xKW154yz/cpQSmphHQcZy96lMZuICmHDdHbvAEH+dLWB6Cx8AEnZx8JsSkl0V4i9Kf2V
         zxBEsYnxakQMSY/IkWr2OXBeR7XcwXc2uKqUaxl7sn86IuMerb6iqxH+hx1oYwZI+eKK
         GSlVZpdM977KDWb5J5Ss8e2Pfnoz9TDscUrIUDxcxTMRLPbALmydnskJgNikkRk4zMDg
         HHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPxn1BTev6eqR+ezs9UlyHS3iMu5dWBTNFe4tVb/ZkM=;
        b=cESdw1QkGMYLQS+6/g3d+8cNMOjE4o7wx9YAW4W114+8Y6dwpGRABiSkJUlvBvQvgN
         AGADkW4JLzZuejDtWdxWaBP1dlPW4/SGq14KzBqajxVfiyVdwRbHEuFkc5p1LJRl+RWx
         tVzlX5w8MJXqPC+vJgRjEVeZweq4sFzDAUCrgJG9B+p3HTuJy5cD6C25AWOnDoS6Qrfc
         MyqlEKnITshnF7zRGEhLzkBO41vDjyokd1Bt/krU+GNrKdgvk8p/it/KuZ5NsxSIBGws
         FlE5JA8/iMKNGMJkG1fZpeuost9o4KUWTJyLp5zwnlrx26t+9bhNHTiB3En8ST3KVYAp
         Qk5A==
X-Gm-Message-State: ACrzQf1ibqmVA3YfQue7ySVafzMGK+dlbfGcy5/BbKyqCsdAUaju89AO
        5JokReAX50PxJ3Q15r+GBHM3S/yFJKg1PDRJ
X-Google-Smtp-Source: AMsMyM6JmzHXmyIgHyt9HC6ZFWRm9Ilvc1jxGf+/HCvnDTgycCrfuZxfOUE/fKqWF1kMQG6qyx0meg==
X-Received: by 2002:a17:90a:198a:b0:213:8a8:dbb with SMTP id 10-20020a17090a198a00b0021308a80dbbmr15175164pji.73.1666949094311;
        Fri, 28 Oct 2022 02:24:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902d18b00b0016d4f05eb95sm2513679plb.272.2022.10.28.02.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 02:24:53 -0700 (PDT)
Message-ID: <635b9fe5.170a0220.1b364.50df@mx.google.com>
Date:   Fri, 28 Oct 2022 02:24:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc1-8-g94fea664ae4ee
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 error (v6.1-rc1-8-g94fea664ae4ee)
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

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 error (v6.1-rc1-8-g94=
fea664ae4ee)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-8-g94fea664ae4ee/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-8-g94fea664ae4ee
Git Commit: 94fea664ae4eea69e90abb4bd01997b9c54cd013
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    1    error: write on a pipe with no reader


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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 1 error, 0 wa=
rnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

---
For more info write to <info@kernelci.org>
