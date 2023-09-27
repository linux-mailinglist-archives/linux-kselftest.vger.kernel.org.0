Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFC7AF8F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 06:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjI0ED1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 00:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjI0ECX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 00:02:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB859ED
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:16:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c60a514f3aso59089445ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695784598; x=1696389398; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwPqS9zdjIAOmqizettJa7RJup0wVDxhXWmE8GHOHxA=;
        b=yKjI1L76kvszq4BkHdSR0jWtFw7/hDOyi0PnoBHHUQH2TxHxAbrwfs43Bv6/UDhMJ8
         zs0Brv6MGL5pGZALXyHa276gq+sYIV9O58PyBtIskU6JLZgYsLQPo0J/3IhsUdu/JrbU
         WrmKizM3P5AwtdLcnVZ66oGAcQ888deXBGYQD6m8J7/0KwmuHphLMgXdXDITfabYUuSF
         ofvJ+1zB0QFCV79i4FM5MWeMT5BDDz3DZ1MMzBPA28fEOn1mOJCRuol/ZgE5PfirTUbq
         BRPF6H41ylLpphZUX0cCC/lw8Z3PMZpFDMWnQO0WUoeRhHS1vlndH9RLr43rm++n33JM
         Qaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784598; x=1696389398;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwPqS9zdjIAOmqizettJa7RJup0wVDxhXWmE8GHOHxA=;
        b=DoZ2KHbptHYvJwd2CzSpxCAHuNQkajB/hmLK6MxdTk+Y+E+PSXA6IVJxWKWJf5hbGu
         IZOoHIfQnNJiGpvY7z6QhKzApVbPbXyBbXxLwT2x/HfsKX5449ovSJ5GOSnY6jbCa+a9
         SJNcH1DdO10kar6oSdo/Am0g1EU4PdCT04z6Nli2iOkeVv4LWzIcCvLX2+yFe0ltE34G
         NjZeZcS2l0VlpUm1c86j6tFhOPKlJ22YIbGG6lB7nJrzPawxrqbHT+r3Uvu81JE4ZZob
         OY0VfXPyNJi198QEOfYymmybYA0WKLGWxNiNPyxhyoUZKAk0cRYuH8ZJyoW0dKLnUSJX
         OlOw==
X-Gm-Message-State: AOJu0YxFh3fRlMkOhZbpeRe5A15jhesaJfXhLZsS0kh7nwt2zPtVfyq/
        uc4p9nHYqfeXqGFMmidKJg7PVw==
X-Google-Smtp-Source: AGHT+IE0b8oPT0V0CEhlQKSvfh6tddNxTmD2KcVBSQJF/YAm0rUpk/H7c2MbSsU3ufIyKajUfG5K9g==
X-Received: by 2002:a17:903:44b:b0:1c3:2532:ac6a with SMTP id iw11-20020a170903044b00b001c32532ac6amr597538plb.33.1695784598676;
        Tue, 26 Sep 2023 20:16:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902820500b001b1a2c14a4asm11743041pln.38.2023.09.26.20.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:16:35 -0700 (PDT)
Message-ID: <65139e93.170a0220.e4bc6.2b6b@mx.google.com>
Date:   Tue, 26 Sep 2023 20:16:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lkdtm: 3 runs,
 2 regressions (linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df)
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

kselftest/fixes kselftest-lkdtm: 3 runs, 2 regressions (linux-kselftest-fix=
es-6.6-rc4-1-g6f874fa021df)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.6-rc4-1-g6f874fa021df/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651392c6d11cf0c92c8a0a4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/651392c6d11cf0=
c92c8a0a4f
        failing since 342 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651392bcd11cf0c92c8a0a45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.6-rc4-1-g6f874fa021df/arm64/defconfig+kselftest+arm64-chromebook/=
gcc-10/lab-collabora/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/651392bcd11cf0=
c92c8a0a46
        failing since 342 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
