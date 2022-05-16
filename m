Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963EA5294B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 01:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350207AbiEPXIB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 19:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350157AbiEPXIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 19:08:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9984235246
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 16:07:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s14so15850506plk.8
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dRMqJVi6mtgjfzOWBCQgMqEDeAykb7kAMdVFOVBwEJo=;
        b=SLfTVHPaWyDYGtoMFC+ootCs2X5fJrsLsfDXn92eqF7JrnuMfdTFLmLyyCGmt8Vap/
         d5JMrvP0LS6BoiB/C+zzZs4f19B/SN06EH2CbkKXkwJMOHp7p0PbLNqAFRh4av9yzWZz
         vNYpaobqFlCpNmUPdb+nX7I/q1G8p808QlAsFxXbyYxlAjyPiPeKS3+8L0eTLMx+3sAM
         5js2aJcGp2yqf1d8zBjXzxGDM+dCdyzrqXTZprNoXOb4KMFKT5M6Q8b2d9dRAFN/mtaD
         0eZrmmQMFEh8kzmLqpCB30DnbAmDQlzVF3NEGlSll8W38ROymHE5SEc5OLpO2eQf/jGM
         MrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dRMqJVi6mtgjfzOWBCQgMqEDeAykb7kAMdVFOVBwEJo=;
        b=WxXRuzHfq24JCTns6cAgNuza2wEFVMDoCywzPrDKpAa1KYT/6zp5dpaW5oA3G6z5v0
         CDx1BFEw2YUlT1c/s7xJmKqxHpGD+b1OBfTQzeBwiG2//Ks8VthPrGtTDcHobw6iB+qQ
         6++UFPLlaHmh/KKThnStcSfRzpODuNqegLXUyfPQbbRUWPOBuwOW7AMldG4HG1jcBXG1
         rDoxny9g7BF9Wn6p4KZ7ixQR8I2utksZqN8T9tE8Fy7cF6WRgrhCEPeq0W7asns1q7Pn
         lMY9xKmG3Byi/P9XHPkesjQSObwW9mJ6nA+zA5H+ZVXO0wSaHpvHT5fFU+TRhMWvK1bl
         AW1g==
X-Gm-Message-State: AOAM531dT5qn57zQzWPwAc0VMQiLS6yLhUbS40ODT7bEPGBbjoVba9bo
        hNW6/uyaW6dahc8F4mn7+FpI/g==
X-Google-Smtp-Source: ABdhPJzUMxeMo+qtmH559xCwmrc+1O73b6bGCUlKpt9uTNmv+Rab0JPS2tGRV4SREqovk37p/MXp5Q==
X-Received: by 2002:a17:902:e84c:b0:161:a1a0:73fa with SMTP id t12-20020a170902e84c00b00161a1a073famr1500649plg.125.1652742479147;
        Mon, 16 May 2022 16:07:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m25-20020a62a219000000b0050dc7628140sm7324033pff.26.2022.05.16.16.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 16:07:58 -0700 (PDT)
Message-ID: <6282d94e.1c69fb81.cec9d.28c4@mx.google.com>
Date:   Mon, 16 May 2022 16:07:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc3-19-g15477b31db104
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v5.18-rc3-19-g15477b31db104)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v5.18-rc3-19-g15477b31d=
b104)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.18-rc3-19-g15477b31db104/

Tree: kselftest
Branch: next
Git Describe: v5.18-rc3-19-g15477b31db104
Git Commit: 15477b31db104bc795dd1acccb3e9b89465fff01
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
