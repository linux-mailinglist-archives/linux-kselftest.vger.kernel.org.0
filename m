Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE3A59529F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 08:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiHPGiA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 02:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiHPGhl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 02:37:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0098C12D4
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 18:15:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 17so7850091plj.10
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 18:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=LBQ4ZI1aDTAi2IeJuyiyd22cG0+VQ4d7tD2F2USyWq4=;
        b=jI4SSNSAB34n24tGBDhec1oqet+b7sOPTdA/N0k/QjK/eGrGt7bhuUlWOJ2y9zv/bR
         Dav5z/kWjVXWYO4OFEyMSo6j9a4CetlR/ZXQ31un6QVhfsYWgH9qaJF/kkzS4CyZgrcY
         6ga3Ctra2YEcfmSKY/GQTpoSQ8ZgTdxmAR9sfmNNNTZdoW4zR71F9CpVflDUXAasoSfs
         WwDPa94HdXKflQlLrVG9o+2wqF4MjfF2yp/dNwPAZx1qg5bxvXW6fghSpJ5n+SyPUrMj
         vynk0njg1jbat9F7AIrdm537LGtPQFGVzpH0yqGCybU3BBIOKwTjKNA4dye9GVQy5AB2
         0Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=LBQ4ZI1aDTAi2IeJuyiyd22cG0+VQ4d7tD2F2USyWq4=;
        b=jr2cxmaWzwX1UXhmJs0f5+K7t6PvStLyZy9li52/rMriJhtRmJjsspjaOIpEEWAXuM
         P9L7pZZX6EuLOOEAh4FsZKeHVbCKfHnOjwSvck6qrzxATV64XZR4eocagNoHptKEmcdm
         fOIws6W1BN2w/AzpVWqFUfRa255/fyX2RVZk6zx9PWMQ2BpBJ2UTteA0NXsomIIxWb9/
         NyHltQpocb+B8cUIZ8oNS3tNNj3/HXGZn9mqNQbFcdfny1ZNNt3nZaSDPBztgm+h0QZ2
         X80UYseLltofTrDe3MYiQCz/t/rByCYuA67blZPbSws+Vv5hVl3e2h+gPFPYRBLlHVdu
         20TQ==
X-Gm-Message-State: ACgBeo2hu1SnyM3GMonqFnlet5DSCjgHSa8dvJ7Gou/kaqHwsTLVVJia
        xrvQYa4DOqSU3U4KPLYmZKpEk9PkQfg1MZNc
X-Google-Smtp-Source: AA6agR4MgCXAD5CQHIur9xqucNCNUjKdCFy50a0Dyld/C+pbsfLL/0i8HxCGMgDG/kJjJJjGdfudtA==
X-Received: by 2002:a17:902:f606:b0:172:6522:4bfc with SMTP id n6-20020a170902f60600b0017265224bfcmr10724317plg.133.1660612552135;
        Mon, 15 Aug 2022 18:15:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0016bd8fb1fafsm7600438plg.307.2022.08.15.18.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 18:15:51 -0700 (PDT)
Message-ID: <62faefc7.170a0220.6c642.ce9d@mx.google.com>
Date:   Mon, 15 Aug 2022 18:15:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.0-rc1-1-g5f4d1fd5b5d35
Subject: kselftest/fixes build: 6 builds: 0 failed,
 6 passed (v6.0-rc1-1-g5f4d1fd5b5d35)
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

kselftest/fixes build: 6 builds: 0 failed, 6 passed (v6.0-rc1-1-g5f4d1fd5b5=
d35)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.0-rc1-1-g5f4d1fd5b5d35/

Tree: kselftest
Branch: fixes
Git Describe: v6.0-rc1-1-g5f4d1fd5b5d35
Git Commit: 5f4d1fd5b5d3506759b5d9cf20bb5fb5b8bdcab1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
