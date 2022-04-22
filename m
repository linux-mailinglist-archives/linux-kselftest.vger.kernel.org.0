Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5703050B712
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378106AbiDVMOa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 08:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447452AbiDVMO0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 08:14:26 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A2E56C17
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 05:11:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r83so7203360pgr.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Umzvy4xbpwThi6hgLuBxy80f+xNnEgAAWs96IlRRZuM=;
        b=x/wPs8s97X5dEIMQc00Yux11O2MvhPzj8ap9Yn6BaDVtLO/IgMCtweD7f93F4gLk9t
         SzBEF2xLaGsiPeRuyoiCzsjczJRVJ7R+/7cDpW6HiXLB6NENw+JMEHfQt1VRVEuGrmWL
         GcdlWOOMsa9RlCBDEPHCaOPO/9zFRY7baW+gG3r1VtnuGl6leeNd799/Zm1q3fK4fMYC
         IZwCbK4d4vUK4NabLdvut0gA0snSZ5P4/u76e7oS+b0/fNB0xGHu+dCWEQzPz45SDUuI
         /73JPsYH/XZu74m6WpQAP7NyqDYq5YhIWkD5AM/iSzi0qtY+AGTx+mda/K9H9i56R2Yg
         eUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Umzvy4xbpwThi6hgLuBxy80f+xNnEgAAWs96IlRRZuM=;
        b=ptCwmxJk+uywg6fuZaGbuRgQgsE2zbEkqAQw1BI5vs/22Dsz8gJBM3SCyTD6kN8kzk
         iXXZOdeQYmhe1YbDkuEJu87vjGqNgCa9yIVXhgXLhpr1CF26cczcHCnAWfI3vxgJvISz
         7pb5qOFEB+Ce8bvZ5btKG82Pt/iidqSMSsWzlLH6FIZdwBrBPoNbRCQ7tHJkJ8dT9zas
         TifFj2bHDGR6CCJ6z39taxU+n4wKEvIy5S9l0++xL4dsFbKO+H7E8IxIwesOz8TDXhVm
         ynn1Zk5TDPoYSs1iTthKDguVegkvN/LaRiAvGczXLWC0JFk2Tpc1jbTUygqVps8ioQLI
         lLvg==
X-Gm-Message-State: AOAM5311wcawp+cMpWc2YxRG9FdIAAbWjy7dPmFdEoziO3uOGAZO0DQw
        dLoY/7UZAhnVFpS5I3YJQZIapK9oPthWEtJU/2M=
X-Google-Smtp-Source: ABdhPJzqZEbq235s/WyLguMnYATQQf/RcIaldQtSbhy6TW5+3k68Xl3kw5k1afUzIZdjWBEFpv0QmA==
X-Received: by 2002:a65:6e88:0:b0:382:3851:50c8 with SMTP id bm8-20020a656e88000000b00382385150c8mr3777318pgb.270.1650629490977;
        Fri, 22 Apr 2022 05:11:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090ab94400b001cd4989ff5dsm5991919pjw.36.2022.04.22.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:11:30 -0700 (PDT)
Message-ID: <62629b72.1c69fb81.27079.ea83@mx.google.com>
Date:   Fri, 22 Apr 2022 05:11:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux-kselftest-fixes-5.18-rc3-4-ge8f0c8965932
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
Subject: kselftest/fixes build: 8 builds: 0 failed,
 8 passed (linux-kselftest-fixes-5.18-rc3-4-ge8f0c8965932)
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

kselftest/fixes build: 8 builds: 0 failed, 8 passed (linux-kselftest-fixes-=
5.18-rc3-4-ge8f0c8965932)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-5.18-rc3-4-ge8f0c8965932/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-5.18-rc3-4-ge8f0c8965932
Git Commit: e8f0c89659323f3ddf60dcedcd56fe3ac36a37bf
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
