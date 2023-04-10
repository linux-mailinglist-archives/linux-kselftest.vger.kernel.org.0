Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215116DCDA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDJWng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 18:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDJWnf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 18:43:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA6C172C
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 15:43:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso8996806pjs.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681166614; x=1683758614;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QInQwTBOccqqWHViz6Wc36lLpGZCU/rZ6nhw4PvpKSI=;
        b=NnbF3cbSlTE6ASVC+bpFxegqzahvCtI4pA2Ws5APFk43x/lBXIvF1N1P7+a1daVwb0
         N9NEGy/Zo1SdadypxU40hUgIrSYDiBp3zY0RarAF+u/ttbas2me7fGiSd19chN8sKEMw
         LT6YMWWg6wD+GCRWkfXg2n8rktP3Cf8FTqIckgXiT+PHTlOMqeZaJvfXu08lABmabOSR
         YMht+/h4y9L1JgdYCqaFOBMGKfsC5dFKjSV0+9UR//aXR0g+uduLy9aV4Dk1rNh6V/4n
         ZZEBWe9nhi82FJjhmD+y0Pxcspc3ss5I1hT+k175Gf1el3D3rkM/qO/5bALZlfOzYIRK
         XfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681166614; x=1683758614;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QInQwTBOccqqWHViz6Wc36lLpGZCU/rZ6nhw4PvpKSI=;
        b=3VGJTr+RMrk/lHN3iwV2sgoSDMJJAnCRkHkkSLsEZJhBI98x6yLW/TuOKS+iZkyfc4
         D6QVoRoyi4bxehfFEq6xak1nHu8F01okZZIFtseaI1jX/eaRWVGpTZiWH9kIumCJErOk
         VdBlDvRdB7Ybl7etKzIfz8Sz0pN6irbfMY+89AYOPjCA/5t92raIRjI7UgfqGvwl2c9J
         nATLXxnopQ315NAaftOoPPTe2iwemvdj9BQI5hNv7OtTbn2y9I28FtXzIoBoCOwxH8ih
         Tl9kWymFlmPNTYSeby4NiEiyooeajEoYPodxYiCNBEe2Fukr08SxBAN4fGdh6Q8JTogG
         oa1w==
X-Gm-Message-State: AAQBX9eQNBBLszVln3A8OIyrkcABsrNCTqA9llGQxdImLCENXlbsBU4B
        WxZ8dHMuBMAa7XNloZVuNgtbtg==
X-Google-Smtp-Source: AKy350aid4JEsD15iKF9KgviH4yKoem4oSeNUYUhOm1mNPQVbqTuaKMpLIVBEtAavXmqcLAKIKtsYg==
X-Received: by 2002:a05:6a20:cd45:b0:da:6652:b1f1 with SMTP id hn5-20020a056a20cd4500b000da6652b1f1mr358297pzb.35.1681166614304;
        Mon, 10 Apr 2023 15:43:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bm1-20020a056a00320100b0062dd8809d67sm8636703pfb.141.2023.04.10.15.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Message-ID: <64349115.050a0220.8cd2b.02e0@mx.google.com>
Date:   Mon, 10 Apr 2023 15:43:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-14-g5874a6a187f2
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 4 runs,
 3 regressions (v6.3-rc1-14-g5874a6a187f2)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-lkdtm: 4 runs, 3 regressions (v6.3-rc1-14-g5874a6a=
187f2)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-14-g5874a6a187f2/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-14-g5874a6a187f2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5874a6a187f2e814542d7fdf918fd29f79ff25c3 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64347be74c89b6021d2e85f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64347be74c89b6=
021d2e85f1
        failing since 131 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6434812f32b8898c522e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6434812f32b889=
8c522e85f2
        failing since 174 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6434863a382be783322e860d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-14-g58=
74a6a187f2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6434863a382be7=
83322e860e
        failing since 174 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
