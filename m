Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934E17072B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjEQUFS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 16:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQUFR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 16:05:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956F115
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:05:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643465067d1so963163b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684353916; x=1686945916;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=96I7ch0ewx6FHyAcX5qkCKXl/fEf+QBabcZtdS+vDtk=;
        b=v4OilojNHfNYiiiXji67IH+dHELNg0S6pOp60B8RtYIrXjb65QefnG0XyYTAaRtsrE
         UrRecyIHDJNn8khUY7C9mhYsXrTEoHxdrr1gGxH4At3JzMQn8IynFp/elrcYswlU7Npq
         YPQ8QpkgtuF/xuMI/A5K03l5n24dbDrGs3S1N//WPpyghDEPLlpy1dMjJcwUqrnlek1f
         b4m+zC6/XMGY4OP/JxfFq8mohwqzhZ5pAr1OZ4fqJOjutAi79MWnxdnvFljR7gUOt0Va
         Fz0fPe0dCd1LzP+Zr70ltySJxOGRRaBRq7se74H3ynPFqaK5HlsuhbPqIL7VnT2wVLCu
         SNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684353916; x=1686945916;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96I7ch0ewx6FHyAcX5qkCKXl/fEf+QBabcZtdS+vDtk=;
        b=isgpe2p9JElvbbDpV8NhWaFo0Dq+k+kh6H6IPjHlMJoKIhwEYSKV2uJq5yNGY1T7pI
         pGz4pRLNaccn0/gr25hXfH/xTQNsHpH8IMzjmAZTjDSusot2IbqraTLX0vAetPYvXy1V
         /X6+cCjo/LDliHTmGmuUKr01rPEtL2TSK7y08UVFSeflQzorgUq07GoZ7HTnu+C82CEN
         /Gk3uituBRgBImaX6s6uR5a7bQqdKBv2WliQQB+vtxcIGomadD1F5vjsF26JtBZgrESM
         WtzqkAnPGqcsCnJM/YTvt0K2Erxq31T0NAfYB5ZzPEovJbhucg7RZls15FAlMgIsp490
         sw0g==
X-Gm-Message-State: AC+VfDzi93C7aLYzykdXfnHexMtdDIBSGfpOrUkOER+QmOH/x50dZU5n
        zSAVmbVhsvgxysFieI4S/PrWnyfQ9c4Ejjll7SJrHw==
X-Google-Smtp-Source: ACHHUZ4EDXk/ZxH16NrwKxNRRivc6m++CtzSmqn6WyegKI2CrZDTKpTMX9r9OUOw/Ub5T4z4MJlF6Q==
X-Received: by 2002:a05:6a20:748c:b0:104:ffd0:2338 with SMTP id p12-20020a056a20748c00b00104ffd02338mr21548888pzd.26.1684353916002;
        Wed, 17 May 2023 13:05:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x93-20020a17090a38e600b0024e11f31012sm2109363pjb.5.2023.05.17.13.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:05:14 -0700 (PDT)
Message-ID: <6465337a.170a0220.491c3.4805@mx.google.com>
Date:   Wed, 17 May 2023 13:05:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-5-g3ecb4a459a1e
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 3 runs,
 3 regressions (v6.4-rc1-5-g3ecb4a459a1e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-lib: 3 runs, 3 regressions (v6.4-rc1-5-g3ecb4a459a=
1e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-5-g3ecb4a459a1e/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-5-g3ecb4a459a1e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3ecb4a459a1eeab1ad135f87057aa3ea4c9af1b8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646520ab85908320d22e8643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ib-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/646520ab85908320=
d22e8644
        failing since 141 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6465249db08cbd2b272e8666

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meso=
n-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6465249db08cbd2b=
272e8667
        failing since 211 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64652821690282cb092e8625

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64652821690282cb=
092e8626
        failing since 211 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
