Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B585A58E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 03:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiH3B3e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 21:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH3B3d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 21:29:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F1978582
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 18:29:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so5028931pjj.4
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 18:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=t7UiS3DyDAZ4Ecge7GrjAIcgaFHBa2vl5PWIZOq66Ck=;
        b=DYU+JGp5ZEXzYkG8co5/a55jwIlAAO7m4aTqUxIFb1Chczamx6GePsWiYacVMRp5+A
         HP8xJBPpla2s5t7IENCtc79jxGViJnNyZZKd2OSxletpaNQpSsiyasU4hx1ehmToXDw9
         aQUqXy/GV3nkzdzISi0rWlPi58M8dxEJuuYC3RXrcSVT+wX5bEzHKrocyMUoTlAbdhOG
         wA8pGpvcw1Bb5cwCQLeKclst9v0xSLON5KC+G5I+HdRt5mgP4S1SRMmT6pFAemkixnNO
         Gi4s0YmQ/u+nVd4/VUEvKCtlG19+YO/SMsL0XQGwF/HQxKFtCI+IYL1FwgXcFFOC29ua
         iTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=t7UiS3DyDAZ4Ecge7GrjAIcgaFHBa2vl5PWIZOq66Ck=;
        b=lHweRseHWR9ydiF6PxJu7yT3si0Dqcx+2hduxHDDVEgatbmkiLk4lM3mmBgRE1rLJ7
         tu5nyB03/ND5pWK0L+zwNY/QDsn9E0gZFywq30Yh+hWvJlislNzd2Fq87gmDapXd4tZp
         X4ipKqqmPnoCnSaL5o5eUG1/1Arx4f+n5auA4lwdaMnJE9+3PTI/HTWMdhR9u1k6V6FX
         vJqEXZhgkH5A/85l1xHA0X0G7WlXiyyvKdO4r88bwGI5Pq+M1PQYKwICKpysDbgMAJB+
         J+jCjYpx9C7LydgcsCaBHMvQWWU4AHH8xncD8sNk36oRC20P9ZuRELAbqD/auaNNizsw
         hC8w==
X-Gm-Message-State: ACgBeo01FJRSvyh+1MNhvnYhFcoI+e6DMhcGnRVeFcUM9YgxIIZ5G99G
        0h+UCEdBJWHZ76XMPbq2AuFV2F9RVPsze13KUT0=
X-Google-Smtp-Source: AA6agR7eRH8asLxkbyNob4LLSNQQf9pxXpO+Mon7LY1kezxsWP1rHtwVHmHqiT2JMDUb4xWFH2KyYA==
X-Received: by 2002:a17:90a:c402:b0:1f8:c335:d4d7 with SMTP id i2-20020a17090ac40200b001f8c335d4d7mr21447072pjt.242.1661822972297;
        Mon, 29 Aug 2022 18:29:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 192-20020a6218c9000000b00535e950aa28sm7916337pfy.131.2022.08.29.18.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 18:29:31 -0700 (PDT)
Message-ID: <630d67fb.620a0220.7cef.e226@mx.google.com>
Date:   Mon, 29 Aug 2022 18:29:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux-kselftest-next-6.0-rc2-5-g997fdfc6b9c0
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 1 regressions (linux-kselftest-next-6.0-rc2-5-g997fdfc6b9c0)
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

kselftest/next kselftest-lkdtm: 3 runs, 1 regressions (linux-kselftest-next=
-6.0-rc2-5-g997fdfc6b9c0)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/linu=
x-kselftest-next-6.0-rc2-5-g997fdfc6b9c0/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: linux-kselftest-next-6.0-rc2-5-g997fdfc6b9c0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      997fdfc6b9c041be39ecb9a156cdeeea1a9a4379 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/630d58c57d995ddce035565d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/linux-kselftest=
-next-6.0-rc2-5-g997fdfc6b9c0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-c=
ollabora/kselftest-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/linux-kselftest=
-next-6.0-rc2-5-g997fdfc6b9c0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-c=
ollabora/kselftest-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/630d58c57d995d=
dce035565e
        failing since 7 days (last pass: v6.0-rc1-1-gf1227dc7d0411, first f=
ail: linux-kselftest-next-6.0-rc2-1-gab7039dbcc61) =

 =20
