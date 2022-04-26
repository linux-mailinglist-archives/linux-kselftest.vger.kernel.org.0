Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E85C50ED65
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 02:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiDZARn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 20:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiDZARm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 20:17:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42E0120D1A
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 17:14:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k29so14632331pgm.12
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 17:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nlWQOpu7wXy4LsBWlR6sN5r0yQVoSCI/DjvoRI01jPs=;
        b=rH/inAj9uxaRkt3FZofdMS71248r9u9pMLBxlhuh51Kxye2zRNSvE6h1SNCQ/1xEAT
         YshoSDQz75bC5grEqWsq3kNf8v7BWcosFrSRULxGJT2VNx9zAup+e/g5l/rr3EUeOJFA
         /AD0Fml22QmbfePrAs4LOYDBw7gwiaLzRbb5JNiS+GKHLPMPEEHXN4TQzL8NdxdRpVga
         lERiZxMKgfbUHezni0Udw2dDtvdAG7p4BLUz7Ege3wlc+VI25/RMKy5d2GMZV1X1jVVf
         OvNQW/qrH6frtVevzaNH8O6WTQin52Br1CwdwGbLGWoDAJOcsPpvGx7ATjfAW/7aeEb9
         YGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nlWQOpu7wXy4LsBWlR6sN5r0yQVoSCI/DjvoRI01jPs=;
        b=cbR+qDqwuO9W98sU80pdMD/5fIsmyQlqbzXSf3FeTHpaqZWxZQfRuZF2d31bjo4GZi
         pQmuxx8Dy/rn4LX3vjUZ9+OPhnafW5AddwuUyhCI774JcZOv1Zs0r7IsMAjoR2Xbhyeh
         N4KrOFlXtLWSeyV6drVEu5VeVhShNCGDQdnBxAUciEH8/Zim1Gz2ACdIDx9zKIX0JjeT
         w+TsqQwW5xmO7ks7zMh5XvNrccoMHmScAfNAhH3bjHOuzVcud7oxjut7PASrgVc10FyM
         vmD7ZN0BZRSMniADwNljPn/bzfFjsBLuyfTAnUP3OpeqT+S3qCEyOGKXMnd9fX/1WE9N
         /FMg==
X-Gm-Message-State: AOAM532F6EeN10ZBD/u6FEQdrV0adXKkXtJIagEKFdfPAnx4zFh4566a
        YX7a4WTNVo2h9HOmd3EOIsnT4mcovnuO7RuMPvs=
X-Google-Smtp-Source: ABdhPJw7St0MqmW5gJ67QoCPcNwyhXeveHyYmXlZCHDYWMIBz0MWYnofpxl2buWGJ14SQZHlX8pIaA==
X-Received: by 2002:a05:6a00:1a8f:b0:50a:8c2d:2ee8 with SMTP id e15-20020a056a001a8f00b0050a8c2d2ee8mr21574821pfv.46.1650932077152;
        Mon, 25 Apr 2022 17:14:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fh20-20020a17090b035400b001cb978f906esm511356pjb.0.2022.04.25.17.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:14:36 -0700 (PDT)
Message-ID: <6267396c.1c69fb81.8cc65.1bfa@mx.google.com>
Date:   Mon, 25 Apr 2022 17:14:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc3-17-g68c4844985d1f
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v5.18-rc3-17-g68c4844985d1f)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v5.18-rc3-17-g68c484498=
5d1f)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.18-rc3-17-g68c4844985d1f/

Tree: kselftest
Branch: next
Git Describe: v5.18-rc3-17-g68c4844985d1f
Git Commit: 68c4844985d1f8c1b1a71dfcdbfacb5a30babc95
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
