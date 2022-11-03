Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C2B617B6C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKCLSl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 07:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKCLSk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 07:18:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665301145C
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 04:18:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gw22so1304051pjb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zqkh+fOvioinnmrvXC51/zCIHV/8AS+BbSBbVPHDWFA=;
        b=lKT8ztA98VVN+/GSufJZa2DIOdrAvDlSiBDOpebQHJ7YXv8Z3fOTuVaCIvqpOSC+2x
         SzsKRaManomjG7VduFo4L43GpQLRO50Tr/VjS7J7QE/+x2Evb6uwmNf19ngWqAjFx4Rd
         VUvvdIZdRY5el/vFP2L44WJuBB3QyqU5YiRbkmdJ/ARkQsKIJ0YES+5OUuZT0QsRm1Ji
         ylFo5s6I3GScjkSBDdA6p8ZMwXq5/WTXrn6dMXB1kHyVm46SmKVGM3PC545pY9Wvy2a4
         yK0WnvBlRxl0bpcjzy+Eh+fOwSpqyJV/S1qlkA0RzfzCq2nlY/bB2wkiHGqwaOltyGwO
         hI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zqkh+fOvioinnmrvXC51/zCIHV/8AS+BbSBbVPHDWFA=;
        b=e3kykPMGEoAU/lplKDlT5jwmu0//ogQqHbe7oamxUX6JwKr3R3F4qa07Vf9aP33PJ7
         xX7rdKueood1Cxe+vylXgEabKvxrHecrATOUhGCvCwbqCEqZqgYxUnEVsvV4177LNESk
         aCtCxJ6UzZiv9304s8aEIMwXDGwQdUK0G7419d8PEgZ6Pok8OoRmyw7tCmlwPDv2K8ba
         Cbj2Fgu/xZL3VXT6fLz1yyM37KrAZvoNoVS7x5yrgZRfhkYDtaXTu4vXlsAQf+8ARsq1
         S/TSvZPtZ+nwVQ6OOFU+BleP5fdpN5Th6HACKRB/Hb2aX7yPIuJD2zGEZor6S4+rr85t
         RjNw==
X-Gm-Message-State: ACrzQf1W0Y1cKcRAXBBfi6qGMXMSnNc/bC3KYMU9mPuw+oITPuioLexY
        qlkEf+xDaI+o94L4IKE6yjjI8Q==
X-Google-Smtp-Source: AMsMyM725u7aFN6/XooNt0dXX4wq2urDHs9TAZSD+cqvpCrzwNg3V+iFurz1VgzeetdZlrCHTo9Z8Q==
X-Received: by 2002:a17:902:a584:b0:186:6040:87f9 with SMTP id az4-20020a170902a58400b00186604087f9mr30218690plb.36.1667474318968;
        Thu, 03 Nov 2022 04:18:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b00186bc66d2cbsm422270pln.73.2022.11.03.04.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:18:38 -0700 (PDT)
Message-ID: <6363a38e.170a0220.e714b.0948@mx.google.com>
Date:   Thu, 03 Nov 2022 04:18:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc1-14-gd942f231afc0
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 4 builds: 0 failed, 4 passed,
 2 errors (v6.1-rc1-14-gd942f231afc0)
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

kselftest/next build: 4 builds: 0 failed, 4 passed, 2 errors (v6.1-rc1-14-g=
d942f231afc0)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-14-gd942f231afc0/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-14-gd942f231afc0
Git Commit: d942f231afc037490538cea67bb0c667e6d12214
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:
    defconfig+kselftest+arm64-chromebook (clang-15): 1 error

arm:

i386:

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
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 1 er=
ror, 0 warnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 1 error, 0 wa=
rnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

---
For more info write to <info@kernelci.org>
