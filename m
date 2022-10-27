Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9992060F685
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiJ0Luk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 07:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiJ0Lui (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 07:50:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3596BCD5
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 04:50:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pb15so1271080pjb.5
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L5Ubwi8giya8r3DVUz/BqZrJaYFKoLkFAwVanz0bNsM=;
        b=vUFo8bto1u5FMiYD4Gt0U0gJm24+B6E2hDe7Qp6PWc3CZ4BtbHPzu9gh3vv/FKEXXf
         oH9RWSYNG2EWoqTuwv1dROJfj78MvTSfNPD2HBuNxiKEzN9MFVrTFsjpiUwqKtpk+927
         ilMopf+lbYFb4SpNyKNdBxD7R9ypc3eJjf+yPg0aOSjjo0rZtAnHKFLKz/VYKeBPiQzo
         v3HT2iMBcwOb3xtToeDRScNVi+4q/j/N1azps2/1dC97FWh3T8FOXwcmDmhtSqIN/7vE
         caRoU9KKlxA7UlC+4rs57nPB6/Il+EanlsVALrLfhGr9PLux06l3EAZaOye6jUkeooIS
         kbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5Ubwi8giya8r3DVUz/BqZrJaYFKoLkFAwVanz0bNsM=;
        b=qdkNFu9cL2SIdSMs3WyNQDeqG3Z054x8ezt7UNLHgVhY+ZGQR8anXDyYYF5xezNZ8o
         PKHFODOivUnyEw6f0+S7+KH7ZpNoROMXMMBFoz/S0u03grZE/DL2IcdYwOBIM4qQdTWx
         G8dc2T1nwUBZCcvrJrP3Xd9XPEZop1tbaVLsv89rGnFUsxZ4731uOp6cd9XLblZPcTrI
         /vA1H3bWAlQZ5AN25zADRT7AnqvrW6qZzvs21wVCcPpbLnja9K4sYb7qcYf3lM4i5RL8
         HOgewBuyA42pIiEYZ1HsjvGD5vsGRzeTYZqhKVnLqIAzLqYVYgPDtob3yvpAmeHeGAj8
         joRg==
X-Gm-Message-State: ACrzQf0/ZI+Eu9KjFA5Xxsnng9mF3maQGL4ZafQrUrWpw0EHC6sH5Z0e
        8oXGJYyZwYGSSRUOqQP+LBqW1Z6IUzm+XVFa
X-Google-Smtp-Source: AMsMyM74qoqW2z48ht1j75h0w8he6XuQ4tX8GO8EEE/gASLruucFjOfz6cD4AZhAWF0w4ZLkpPQwzg==
X-Received: by 2002:a17:903:41c5:b0:186:ceff:f805 with SMTP id u5-20020a17090341c500b00186cefff805mr11434790ple.31.1666871437326;
        Thu, 27 Oct 2022 04:50:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o72-20020a17090a0a4e00b00200461cfa99sm2540103pjo.11.2022.10.27.04.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 04:50:37 -0700 (PDT)
Message-ID: <635a708d.170a0220.1f0f2.526a@mx.google.com>
Date:   Thu, 27 Oct 2022 04:50:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc1-6-gecc7d67af402
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 3 errors (v6.1-rc1-6-gecc7d67af402)
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

kselftest/next build: 8 builds: 0 failed, 8 passed, 3 errors (v6.1-rc1-6-ge=
cc7d67af402)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-6-gecc7d67af402/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-6-gecc7d67af402
Git Commit: ecc7d67af402dda4b4d353dfa9837339319c9d4d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:
    defconfig+kselftest (clang-15): 1 error
    defconfig+kselftest+arm64-chromebook (clang-15): 1 error

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    3    error: write on a pipe with no reader


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
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 1 error, 0 warnings, =
0 section mismatches

Errors:
    error: write on a pipe with no reader

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

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
