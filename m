Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9F617C54
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 13:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiKCMRa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 08:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiKCMR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 08:17:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A910A63E7
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 05:17:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k15so1428231pfg.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wJBcIBohR46LwONWRIwg8bWzxrId8gjXIpqZFMxLyzA=;
        b=JBIbvnWtzSZyqGFyw6HZabe+0jF0qi3pR2xJqdlkl6a0tfb8mtExxIjf5ZP4vL9kId
         5XxGkkCqkOKb3QUI4cquPXSXqxtpYQyEOOG2obmXDJ5pVT1SaIhjb38XLZij+hKa4AmJ
         tpXDVSjKNsjGXIjh2Ss0QIwAsbBnqIfRDW+Klt7yHsOmZaOq2pHNjnr5APBVuSmlKn0f
         067R/qnz4c7zVZqN2268WOHk7/xyN8VR0TMoo6RPD6DhH+H5b/wPYedJR1K83Jf6V4st
         D6poK3DWTOxti5Ac5fA2P4g1DXnLsTKm2GGy+a25Zb62ZibIRpOXE03T1tyzA72975uf
         Hogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJBcIBohR46LwONWRIwg8bWzxrId8gjXIpqZFMxLyzA=;
        b=duvPcDA9t4Vh7X9DWW4EeJY6CLCUmn1m6tNQE5EAfnvnLMd81qou3Lw5v7Dv3ihH2O
         MokoCHS5AWZmdl/tWyETc9pHHfB8ufO93q4MXP8Z7a1gzCgxRsxGWE2UFuAp93aam8bn
         sWogr6zB62Ul6K9hN6Tt70IBZFUa3ZGSZ5JxJ4BMEcPSNDoaJqoBD0CEQ+Bu0Ser8kw6
         tZytgPCbWjy7d5bfeX4hS//qwdt5WpSNw6l3J0nS92+vZNp0K5tbn6xa5dzruFXj+awW
         7qVlWYIv+0GXM2s8R0G+tCDbQCvFAVxX+PMe8ruGgVsx+M2WIjaGG/0iWRVOlUi58aE5
         eaxQ==
X-Gm-Message-State: ACrzQf1btEB388LqNSf0gJQiliptszbCBVj4JV0JpUUoop+wXid935fQ
        icHyzBoszPJsVaDT83muPXpobw==
X-Google-Smtp-Source: AMsMyM5hBHRpEGSSJOGouxOnEXgnFQHZQVEk+eAZ2ed2kTd3xUgeIzZHdM9/nKjk/fcm36zbj7YA0A==
X-Received: by 2002:aa7:8c15:0:b0:56b:ead2:3950 with SMTP id c21-20020aa78c15000000b0056bead23950mr30527425pfd.77.1667477845233;
        Thu, 03 Nov 2022 05:17:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c08600b00183ba0fd54dsm442270pld.262.2022.11.03.05.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:17:24 -0700 (PDT)
Message-ID: <6363b154.170a0220.d8b4e.0965@mx.google.com>
Date:   Thu, 03 Nov 2022 05:17:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-14-gd942f231afc0
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 2 runs,
 1 regressions (v6.1-rc1-14-gd942f231afc0)
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

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.1-rc1-14-gd94=
2f231afc0)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-14-gd942f231afc0/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-14-gd942f231afc0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d942f231afc037490538cea67bb0c667e6d12214 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6363a18737e742c598e7db51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6363a18737=
e742c598e7db52
        failing since 16 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
