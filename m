Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4498E6DE7E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 01:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjDKXRV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 19:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDKXRU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 19:17:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0271173E
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 16:17:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q2so14328489pll.7
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681255039; x=1683847039;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmfia/gJuQvdsYsPknT4DUO+3nWhkibhRs+9tXc6bPs=;
        b=FnC1TRy+t8hjlHhFsMiypUpoKFNvcrJ9ZMbW2pBWh9KmJo0OLs24PmKMgkusfbevRY
         tglgFdtOtclmWHBrt7xTB2BHTiry1st6IhItMnbDd+v/5n965cMbl8gajFCtTkYufmqT
         cdxY9qmdz2SQC0brXevtod92TwcuImuYPoA8H9bXI+y25gCnpjS5SLIy3WWVyKLuspm2
         6j19N9XT981I4shulcNSyqxp05Y764dWPoLi1tK6LlLqB4l3yP331kFXxuLVFrtlPKex
         oQi0fDOloJs6Sm2YISaUQxYzJyvqkkvAMj183ddMY7e5FcSCY2jcO1sarfC4hnsKkher
         b8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681255039; x=1683847039;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mmfia/gJuQvdsYsPknT4DUO+3nWhkibhRs+9tXc6bPs=;
        b=baaUjUDmi47D4pz8i1vdn4FGdsXdvr1USx99MZpAEmz/61VBBVNlnOjQMv5NH9Dw4D
         U1mn8RoDkfolA284gY6Ldpq+H8q76GQ0h2St/3iM0YgUYrWpKCSK349sjfsv4zomwanX
         03Y8k9oRfLC69AfyEi6BrGtEHiblE2FNr37Kuxj8gsOCT4CJasrjbb2MWUir1q9S/TZp
         RGWlCkQKYlDNLcsJob4h9skd/4l4LDC+M4CwamD+q6sneMKHAfLJL1c2j9dDvVzpGr4k
         f1S3iPVbInPrtwyv9JG1qZlLsZj0lGGF9e6YgXqGyX+qeX+6tpLLrg7mqfW+J9q9Ioyy
         f20g==
X-Gm-Message-State: AAQBX9ctQgjawSthDXYIz3xdt8Z1QcIuw6z6j6hUykvzyScbn2UZN8fb
        qZ37p75rkrlkOid0YsmuuLT+d08L7rVG5dJVREgF4Q==
X-Google-Smtp-Source: AKy350ap6tUkZKKUjneknKpUp6YHRzytaFM7ASgPqv9vouZ0VihVcdDRsEIjMJZz2fNjbiQJMNUDYA==
X-Received: by 2002:a05:6a20:4f18:b0:ce:2fb4:5fc4 with SMTP id gi24-20020a056a204f1800b000ce2fb45fc4mr15611522pzb.38.1681255039205;
        Tue, 11 Apr 2023 16:17:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78687000000b0056283e2bdbdsm6763594pfo.138.2023.04.11.16.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:17:18 -0700 (PDT)
Message-ID: <6435ea7e.a70a0220.7dc1b.cba8@mx.google.com>
Date:   Tue, 11 Apr 2023 16:17:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-17-g266679ffd867
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 3 runs,
 2 regressions (v6.3-rc1-17-g266679ffd867)
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

kselftest/next kselftest-livepatch: 3 runs, 2 regressions (v6.3-rc1-17-g266=
679ffd867)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-17-g266679ffd867/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-17-g266679ffd867
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      266679ffd867cb247c36717ea4d7998e9304823b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6435dc6c5c96d1d5aa2e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6435dc6c5c=
96d1d5aa2e85f2
        failing since 105 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6435dc5c26e20546922e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-17-g26=
6679ffd867/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6435dc5c26=
e20546922e85f4
        failing since 175 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
