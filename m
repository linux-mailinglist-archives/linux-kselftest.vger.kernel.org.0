Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC35B10E4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 02:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIHATU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 20:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIHATU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 20:19:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57524C2FA5
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Sep 2022 17:19:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so592801pja.5
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Sep 2022 17:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=RdONs/X586ASk42wkKUPEixLX2JNDhkR14dJhQivFfQ=;
        b=UUpFqwP0wtzNtw3vff9fvn1+AjKLzthBCUnqLMD+dd1X2L3iAZ2TdE4M/KartSL/YR
         Bnt6TOpvOcJhVoJ1XyjtFiRxV783s1kcJOAcS4ux+cu4JhiCmp78mlLwZpasT9BNogMJ
         0IQnHGHu6C/irxxtYEANXmnDs+ByPx2tYvtw8+nzUme5iptRQBpxaPRiJ9EeS5GK8qPA
         5yYfbhMCo7jqoPrW6nWPpq1RZlHxBfhlCppVklf8fCfWD/+2+14qkWabhX1Jp8o8cqsE
         4QHxPb8ms4ZbSH1y1O1LvxasSObiM5CIXK58xiY1NKHvsed7KiwW4n2m5QsMcFjFIfr+
         EsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=RdONs/X586ASk42wkKUPEixLX2JNDhkR14dJhQivFfQ=;
        b=piQJyke5NNwu9IKT3dfsAW+QAGSnbwzME6n+Xpe8x6F1EMBBpF3z9kLMqDlCFwhugd
         l/QH7dN7JXoBfKyAQt64fm16mtvfCU37PRDzrrQV+KnP60FTgI2v6NhnsDQw/GILH7en
         I9MMVBLA7LgowvdDIatBOLQOujSQMekCzfIW4rdBvrWh9nIBl0xsgAbZFE8zMnfXdh+b
         7h/Ori/AYPa36jhTtq4/Ngs3ETMG1mDcUnf05ZzdWmMjf+IRFvWF2eWiRNbujGxS3Bly
         xkDHDNqK4yxhGUe1/WWMvRvLHI4uSwtAt4mwxIxVX5lg/ADa1XjKqaYOr0X433TN9rmE
         1oJw==
X-Gm-Message-State: ACgBeo2DkRzYE7DLyNOaHZujdsNgx7BIivS6i05A+IZy2yOZUfMO/73l
        sz+FA3K+qr1dUsNHjJgdi1YZlvpS0jd7kaH8UJg=
X-Google-Smtp-Source: AA6agR4Q0c5D3ckyvxAAd2wu0/ZJLKgBvt0IP76YgRgSX0UBbxx8ynnHRBmwkFD0Uho4oxYNLeYvDg==
X-Received: by 2002:a17:903:2c9:b0:172:57d5:d6f0 with SMTP id s9-20020a17090302c900b0017257d5d6f0mr6536325plk.61.1662596358819;
        Wed, 07 Sep 2022 17:19:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v125-20020a622f83000000b0053e85a4a2ccsm1884964pfv.26.2022.09.07.17.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:19:18 -0700 (PDT)
Message-ID: <63193506.620a0220.947e0.3527@mx.google.com>
Date:   Wed, 07 Sep 2022 17:19:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-next-6.0-rc2-11-g144eeb2fc761
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 1 regressions (linux-kselftest-next-6.0-rc2-11-g144eeb2fc761)
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

kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (linux-kselftest-next=
-6.0-rc2-11-g144eeb2fc761)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/linu=
x-kselftest-next-6.0-rc2-11-g144eeb2fc761/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: linux-kselftest-next-6.0-rc2-11-g144eeb2fc761
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      144eeb2fc761f966f71ab8b4b7d2a2198ecc400f =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6319235877d2cc81a935564f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/linux-kselftest=
-next-6.0-rc2-11-g144eeb2fc761/arm/multi_v7_defconfig+kselftest/gcc-10/lab-=
collabora/kselftest-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/linux-kselftest=
-next-6.0-rc2-11-g144eeb2fc761/arm/multi_v7_defconfig+kselftest/gcc-10/lab-=
collabora/kselftest-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6319235877d2cc=
81a9355650
        failing since 15 days (last pass: v6.0-rc1-1-gf1227dc7d0411, first =
fail: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61) =

 =20
