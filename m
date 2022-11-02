Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5D6163A2
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 14:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKBNQP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 09:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiKBNPz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 09:15:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B165CB1EC
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 06:15:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v17so13519721plo.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 06:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pyv7owwJxGy3hHv8dPCbJ3yctaNXhoiGXs0+VZhWrW0=;
        b=HMZc6ZxuEdgzo8Nu6xZn7pgGm+Z1pKkal3WPNNeS0QdkgdW1MLbr7crYfreGqbf2ns
         5SigPFrs41ZUau5+PUZ+81LRXxFId4Om2pzNio10kukLkiJvcH88fYgG2tOuvQlRtUoL
         N1SJlWaHZll0vCAws8MRjfLDHu3ASky7b7nJYOt9tgqA/69M5bS6dB/JQebgrNxj/F4l
         Yqu3mHHmWbdk2C/1VWJfB++MBgUykqdB9696pBYaRF2knnbw5TdaEkDo+TUuayJ8R4OW
         Acft3HjdHJAnlhzeSySsnfLpI7H7CjSsdrFdGU/5Zd3DeBxhQQ9AR/a6foHWH1cSQOcO
         OyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyv7owwJxGy3hHv8dPCbJ3yctaNXhoiGXs0+VZhWrW0=;
        b=2JYXrWxiotG6KhqtFgwJRzp1FU9Y3Gb5oiPo9ihCxOyMXQINDk/qapBs33QBKZaSFI
         EuhAeX4GvRPLBzKNNad5dxu94xZsJ3jfu2wJvJ/C1EH5DGKN8HUjLaC0CYxb90uisuNV
         uzlCIjEEvphAFI+NAL5pQWASvoMjAM2CbURXEgeePmmDTtylttWMkTy/C3yY2qeelsE/
         6OCsCPOi7JDm+63LPG972HAIOUTZ1xAUOG2Qkbk4mWV9PtZ3aQQt+RrQ88HX1gIGiEri
         mIOImaifyQgh6OfKI/697k/4LwtT2qaHOa9Zru19n3HOpgYeED0usDTFWoCvcbHsod5l
         Uj+g==
X-Gm-Message-State: ACrzQf3Yn9oRgakB1jOjy2YQ7vC6rIEfBim5o4ElvnnAjL21cwHefgx8
        /EUJX1Prp0scl7WLSLhaxBPj8g==
X-Google-Smtp-Source: AMsMyM5LpJqmG4Vm2iaD7iUmE52zxnclY/saPf9ymT7NHYkaW8EQAwsBL9bJzgWCVO1w7BdkEUOr1A==
X-Received: by 2002:a17:902:b70c:b0:179:eb79:cf9a with SMTP id d12-20020a170902b70c00b00179eb79cf9amr24638216pls.130.1667394941248;
        Wed, 02 Nov 2022 06:15:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lj5-20020a17090b344500b001f262f6f717sm1458502pjb.3.2022.11.02.06.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 06:15:40 -0700 (PDT)
Message-ID: <63626d7c.170a0220.38232.258e@mx.google.com>
Date:   Wed, 02 Nov 2022 06:15:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 5 builds: 0 failed, 5 passed,
 2 errors (linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67)
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

kselftest/fixes build: 5 builds: 0 failed, 5 passed, 2 errors (linux-kselft=
est-fixes-6.1-rc3-3-g89c1017aac67)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-6.1-rc3-3-g89c1017aac67
Git Commit: 89c1017aac67ca81973b7c8eac5d021315811a93
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Errors Detected:

arm64:
    defconfig+kselftest+arm64-chromebook (clang-15): 1 error

arm:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    2    error: write on a pipe with no reader


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 1 er=
ror, 0 warnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

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
