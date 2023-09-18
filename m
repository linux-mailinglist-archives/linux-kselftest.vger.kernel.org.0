Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38417A563D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 01:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjIRXi3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 19:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXi2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 19:38:28 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537EE90
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 16:38:23 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5735282d713so3145369eaf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695080302; x=1695685102; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b61eJdAUHHyW9c/wiUXnRwQvuTdMKlluXzVD2r5kkVE=;
        b=rYZQqus8aCph5rj6cX9eTxLPkqT6fCU6Trmx1FWslrRZzfScaRGMcG3qpQAxrXkMz2
         gsfy6NaS2tIW63yO6W+GHl618OQpVZV0oxPYGs5Bma02HiVEiMQ00ZQMT6RGJHMWyJGh
         tOOIx1Bybf5IVjpkAK4L3yiQXsl0SC1WP3M8ap72RUUy80mvxA/4kdwDqnc3Cu7uht2k
         ckKUCYAkeh+6Q8VyQWWt7uH3McM3PIr0HjOjg3efuiGIOBRp/6Sb5XsaTzFNr+DxQty6
         8CeMqL48tTrOl+wZ7C6m2XtjGRxmmViXFqU/AqIuaFRYIboCNb/uZtuczhK6FBH9JZ9e
         ektA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695080302; x=1695685102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b61eJdAUHHyW9c/wiUXnRwQvuTdMKlluXzVD2r5kkVE=;
        b=Ywh2KhwUcVXZNxWuGByzl6QoGCW0HucW+vN50IRpr5FhRbW6KfXJgHiZfTcDYSTWfN
         Ty3CJ+2PCJebN1lD+2bc71zuTxknlqznp9iXBiRF2g0E748I9balA6deafVFK2ylMb+x
         dpgHBIeocGPLKRerPZZjNnF0FUUlRKdaFpRLl3NeAqWPyUr7QzRoGRuzkmRVLL7ULNKG
         K13YWR1RXX0B5qL09vppi4XPPuUQwkz2RhVq6nKy2YauqkGaaoUxEag0GsarC9t4YmMM
         hpQgPoGrr0Ii4NnKiMD9Q48QtPffxCdMwq6rpY/bw5cL5DwANoFbp1Df8qnh+SWEeaDA
         vdkQ==
X-Gm-Message-State: AOJu0Yx8ZmGFkwocF+JapYWvRa1OwXlWGk7eYIpHpldbfS01WyAu2iio
        IQWDFSwXqPYGUpGJbccOLEyRMtloi2cfULXpt93GGA==
X-Google-Smtp-Source: AGHT+IFIWpOr0JrTejbyQ4MXQl/Y6QSTUBRoiBaK8Yx2Xx69Jrqw3jAykDDeRHm2AmNeoZehB0CPFw==
X-Received: by 2002:a05:6358:9f9d:b0:143:1063:d1ed with SMTP id fy29-20020a0563589f9d00b001431063d1edmr7012370rwb.26.1695080302440;
        Mon, 18 Sep 2023 16:38:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p17-20020a63b811000000b0056946623d7esm2142674pge.55.2023.09.18.16.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 16:38:21 -0700 (PDT)
Message-ID: <6508df6d.630a0220.98a85.7052@mx.google.com>
Date:   Mon, 18 Sep 2023 16:38:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc2-1-g8ed99af4a266
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.6-rc2-1-g8ed99af4a266)
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

kselftest/fixes build: 6 builds: 0 failed, 6 passed, 1 warning (v6.6-rc2-1-=
g8ed99af4a266)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.6-rc2-1-g8ed99af4a266/

Tree: kselftest
Branch: fixes
Git Describe: v6.6-rc2-1-g8ed99af4a266
Git Commit: 8ed99af4a266a3492d773b5d85c3f8e9f81254b6
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
