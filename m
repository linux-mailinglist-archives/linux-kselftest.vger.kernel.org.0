Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382EE614873
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 12:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKALXe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 07:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiKALX3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 07:23:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F8DDEB
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 04:23:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso18479898pjg.5
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 04:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz4QmDiqF/u9s1U1cF1DlvOxA8QhHZY8L4eG/2VzOOs=;
        b=JEIblLkme+qrP+QtNkb2/tLMwVi/157UHtp4YqsT69pzk0V1+8E/WUz2B40Yv0CDcc
         I1v/nwjfxjywefOPtQFxBIKP6NXUc3HwBTy65w5K2B4dad009D3PIeD4U+jFICzmtwaY
         MtG0Poq3h7LxsWkSAHVqtxVM4+OU/W91EgMLSiJSC8bsTow9N+PqxS4PcEiU0rrFXPEW
         YrsbAts4RC7+/5tR8cgnOUiG+20/s72F49eZPrDkDadleXXeL2csDyuQwWfl+V7nkFs2
         oC/DdKApnoRcY0Av2I7BBYDR6IRXpaY+ipv3AEYSpuxht4aaTCui7gRB7v95yEfNUbcV
         mVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oz4QmDiqF/u9s1U1cF1DlvOxA8QhHZY8L4eG/2VzOOs=;
        b=nlPCsj+m5DFacEUB4J1bn0Cfz3YQB9034XFfHt+tEcXRw1cimoMiZGiGWevxJRUxp6
         1WhmUr6GIKTUdf3PYPB712FXdFDO00BiEbYMipOIE5+3qnk3G3AeC6D/uq3nc9WmJP21
         DTEUWY/ld8Kon2jxaxQ/Oo7/gyFmYUUnCSTdLn5nYYgIVO1JUNLCiNv0C2WXYh6HMqlN
         kws61Hj6oiAkLKMB78UuqevOnjtVVouUE/IoNDWXWDqHkjM/9256ryYrtkeKUKyusJQj
         uvm50ysf60QJ3djoAicYrOkmQVNJ3RWr/Y0+pxKEuHVF6cfFwl74jITif/pR3ry/2WQw
         kDUA==
X-Gm-Message-State: ACrzQf1szX7wAz11sysIL7+Hdl2A9CaVI+0eqP/+SVi5OU2ZDSXJV15U
        aIuWCVxGmBHgN2VLG52Or9iQMB/wADs5WdJI
X-Google-Smtp-Source: AMsMyM5SgvHMs+WwAY7UwhWykNcu5L+t0o90+g6MFGi+udGnCesF6vMUQqfeEohHtxzSdLw8Gw8w3A==
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr18396456plh.142.1667301805459;
        Tue, 01 Nov 2022 04:23:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b0017f73caf588sm6109004plg.218.2022.11.01.04.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:23:25 -0700 (PDT)
Message-ID: <636101ad.170a0220.dacfe.a8db@mx.google.com>
Date:   Tue, 01 Nov 2022 04:23:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-13-g67c0b2b52916
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 3 runs,
 2 regressions (v6.1-rc1-13-g67c0b2b52916)
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

kselftest/next kselftest-seccomp: 3 runs, 2 regressions (v6.1-rc1-13-g67c0b=
2b52916)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-13-g67c0b2b52916/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-13-g67c0b2b52916
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      67c0b2b5291656cbcb15371f835f5152fae2f7a2 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6360f5d22eeca7d1eae7db62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6360f5d22eec=
a7d1eae7db63
        failing since 14 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6360f38d37744a5bb2e7db5d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-13-g67=
c0b2b52916/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6360f38d3774=
4a5bb2e7db5e
        failing since 14 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
