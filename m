Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91113752A63
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 20:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjGMSjp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 14:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMSjo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 14:39:44 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E11992
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 11:39:43 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5634d8d1db0so769229eaf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689273582; x=1691865582;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VCjekyRY0mF1zPEFz9+TgaqlomUlPOv7ZcelMgfNhgA=;
        b=dIPhe/QKq8Y/Y548Yu3B9t8v/wX4kwNU3ziN8d0GJy7Ue3ouoaUIx0/KZp3MczNC9+
         NuW+lQnGOSoB95+5BLG/PWrrglQHqqpi946rLp5E0f+cTMKD1VwKfRz4PO4t709Sos1K
         T6ZtFQ8DO4nFL3D6FM37ZZMN6oJJxM2GLUodTYpuvqMCyGP9i9aD064kjwU5BC49sHrP
         KSq9SlPvhPK79ZAP85zO4PzY4tcO+eF1ICgQxp4C278FQ1MgFiiIh31hkTk2rBbtfC8s
         7RdhIrYUUXuEmRZFYdSbLnicpIhrMdOjjJdMQIa9W6Nhe5JxhOdJ5ZDNbvsOwJYBad9W
         //aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689273582; x=1691865582;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCjekyRY0mF1zPEFz9+TgaqlomUlPOv7ZcelMgfNhgA=;
        b=SG7maUrUiRtfk7QGeHiw0R91RavcwO7Cnj5nOut/78xrnju+s8C1rabdeMedKF7qyJ
         1oI8+zmB0unFsKW9oAczQCPE12xjrESEka9VHkrS1/7k7c2FT0UDlqWwqghzwVkurEdH
         YTkc4arcjiEQw4N7s53m6Jw2Ifixv6j8s2B1mysb58elk3wyXMP9m8gYXS2K4cDLkWeg
         9o46rwCK9I/8TeSqKbdG0Stqh08gikEWLu2kxEYxrhzfSgBb/ueU7hEis7iZPvNm6XXe
         uoJIFTo0DOpmDFUZ3DAEZVYDylHEiHR9p/GwZObIJhOqaianwUG1qR4uJaUyVwgmBy2P
         sCvQ==
X-Gm-Message-State: ABy/qLZHnqjRohwEuryA92KIYOegKEAHZbiNc3V3JZH5ebwYpHSW7BP+
        rvhMV/oIhaspJulcgJRXyKZ23Q==
X-Google-Smtp-Source: APBJJlFn5o2TvZNL8GfUUdVYBeA5r7iVg2l44yNMjl8MmD38/fHfQ2ofC5M8eXz/S+BM3AXheVZZhw==
X-Received: by 2002:a05:6808:138c:b0:3a3:ed41:5ab with SMTP id c12-20020a056808138c00b003a3ed4105abmr3481663oiw.9.1689273582572;
        Thu, 13 Jul 2023 11:39:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f7-20020aa78b07000000b00640ddad2e0dsm5743254pfd.47.2023.07.13.11.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:39:41 -0700 (PDT)
Message-ID: <64b044ed.a70a0220.67c2c.c890@mx.google.com>
Date:   Thu, 13 Jul 2023 11:39:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.5-rc1
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.5-rc1)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.5-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.5=
-rc1/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.5-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b03862aeeaed1add8ace3a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.5-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.5-rc1/arm64/=
defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccomp=
-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64b03862aeea=
ed1add8ace3b
        failing since 268 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
