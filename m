Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1E360DB80
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 08:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiJZGmL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 02:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiJZGmJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 02:42:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D944A837A
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 23:42:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f193so13964210pgc.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aZJU6eVysZ2NcMQZSa1vaVoq32uoCoXxflg/nRkmqcQ=;
        b=TyAZBsBtCC3fMyR47VjFHtJLW/uGWdjgQ9F7DbVn8bUvwSr6ErElLLLcpeiQL7jKOK
         +7Azc3M5q2SX/iSRAhQRjYeynBOenwgiibraJhyyGEPLHz6drRWwZTT5Fsvy0ojPJ+HK
         EZaLlKn6lNEmJLyRF2sJ+/qhN3gZ/C6WN3fl7NYxNBcDij/Jmz28X+oYbouwgQ/6TpLJ
         xr+qIOaANTK1i+7SvOz/2jnXjrxdfiveWDa05+vWiUhPbGD+56ksYB4JAJg07Sd/fmUe
         mwn6uQGxWqrHLHQGXg/2xS1wMUqwVhAksWKTKbC4WcHEie9Ahtwg/TCuZEwS01nrj/C+
         TRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZJU6eVysZ2NcMQZSa1vaVoq32uoCoXxflg/nRkmqcQ=;
        b=yTPOKh4LoTMajhQU/fPFEd1D2UNZ0d4j/jwCM8X8Pk0gFxxSTu97iYsL01VqE8YQIE
         7/C5HHcILeZBlQHTKw0Zgysx56dMQV/DmF+8+oSfHeizGUHm6cPUsKSJTQ5JpqdMAnEN
         lCJsGK0by9vRZTGwF3JNcXX+65t6OwOfxkEudUl3/6ilRxszxoPTNZi6HaFaIvUXgGWq
         CWK1uhHAOOC8iM1pVyz9mv3Rjf/zW8tkcP/ig/YHo8eAeHTjap5x4iHgwOih3Lt1ONdh
         M23LSKumJ3sLay/RpOa96QluLz38REGwno0/iLhlkGEMSYISnL/2G5/nCZ8YBk9meI4b
         7GQA==
X-Gm-Message-State: ACrzQf18QJ0tjW7PQ2HMLE1NuMmKfgqKypWDwVmNyRH6wtIusoxADCHK
        X3wZn86FfSNFUKgCvNtWs6hAUA==
X-Google-Smtp-Source: AMsMyM7yOU3kbiUXlc8wCN9IzQa9eDHYILbJwnKUzNUaXV+ymst3XG0U8AZMwjUkXqdwpdnmfc7kuA==
X-Received: by 2002:a05:6a00:c91:b0:562:aa06:2848 with SMTP id a17-20020a056a000c9100b00562aa062848mr43706493pfv.2.1666766527790;
        Tue, 25 Oct 2022 23:42:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r26-20020aa79eda000000b0056bc5ad4862sm2376592pfq.28.2022.10.25.23.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 23:42:06 -0700 (PDT)
Message-ID: <6358d6be.a70a0220.7e9c4.5424@mx.google.com>
Date:   Tue, 25 Oct 2022 23:42:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-5-gec7b4511185b
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 3 regressions (v6.1-rc1-5-gec7b4511185b)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-lkdtm: 3 runs, 3 regressions (v6.1-rc1-5-gec7b4511=
185b)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-5-gec7b4511185b/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-5-gec7b4511185b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ec7b4511185bba95fc702c33a388582c8842d454 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6358cc8cc32197fbba5e5b41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6358cc8cc32197=
fbba5e5b42
        failing since 64 days (last pass: v6.0-rc1-1-gf1227dc7d0411, first =
fail: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6358cbd2e100c36c595e5c58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6358cbd2e100c3=
6c595e5c59
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6358c7d6b7caaf4a875e5bea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6358c7d6b7caaf=
4a875e5beb
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
