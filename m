Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EB56E2A93
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 21:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDNTSa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDNTS3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 15:18:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2DC4221
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 12:18:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d15so2074230pll.12
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681499908; x=1684091908;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0AK0EU69E74zeLdUgai9HTbc4wI9ALd7GaXn8DeYJiE=;
        b=OFUQ8ujxrthjuWM2NNAa1ji/RPPEgILj8UHtz1NQo9AJWAKfSEZn5jisz0zTbke3aW
         /X8K76q+PT8MUQAkr279nNSQ2PJmuTiUm40yjYaSGA1SnlqhA8ql0RS1+AR4WUPuhpZ/
         XNjRrTZ01aJuYN065/T33fXL1DlpBzQLd5sMtZntRbY5ni0hqWoYSMWYKs0v+XIOruRI
         u7aDI6SP7yy9037pvif6Y2NZWBoZEdXNas5rNcL2xFtnh/AM60mchJxLw0gDRe4Re9KB
         /iE8Jm9uwa3KvRxM6iHJDwdFJbWMqTvVlvflz53E5wGBxB4LbwOTmMW3Owl/XjupmiAd
         J+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681499908; x=1684091908;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AK0EU69E74zeLdUgai9HTbc4wI9ALd7GaXn8DeYJiE=;
        b=dYwpRO6yceEwW24DN6UBUHghyn+hEMkZgmv7JJzK7D7oixJ9zFOP/ifWyzwh6dd8HO
         iYSIuMwd4jPCHOawkp7yFlNR0vZjk97B0umhQ06EYzww6DI+nvCQJqGFI/whvYava5zJ
         eQxz6LhyveIqEHzZVKTWitxFbd8Xtd8vdlMf8q2qR5qgU9NgrPrT+nC7DGq3LcFbZSZv
         3EJsUqcQKghodd+1AJMU6UL+Ilev5bPA9DJgKp4q+a+YVZcC9MdayiLiZguqaqRAhRov
         hfAyP0RmX+4DjBqA+N2wkKqUrXZZKtt03ZaRz9pCN+Qe7ixQGbQwUPa3ZAB9VpijWcKF
         027A==
X-Gm-Message-State: AAQBX9dKb9wSCicRBjjsvH9E6xiB6aOLbPXGEJYSJcw5ZWiProVBogOm
        /xMJ03ni5DhTsheNjI1SYx7TyXpYmE24vRoU6lAtO/K0
X-Google-Smtp-Source: AKy350bIaRHAlfGaJ2bLj79ymOzOxvUYA4wtxXrj/b+ex5VVeg21VRH4O9v6RA5xMajXakBAR0VJWg==
X-Received: by 2002:a17:90a:e016:b0:23f:e4b7:afb3 with SMTP id u22-20020a17090ae01600b0023fe4b7afb3mr7109407pjy.9.1681499907770;
        Fri, 14 Apr 2023 12:18:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fh15-20020a17090b034f00b0024744818bc5sm1140497pjb.9.2023.04.14.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 12:18:27 -0700 (PDT)
Message-ID: <6439a703.170a0220.85e9c.2adf@mx.google.com>
Date:   Fri, 14 Apr 2023 12:18:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-25-g50ad2fb7ec2b
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 3 runs,
 1 regressions (v6.3-rc1-25-g50ad2fb7ec2b)
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

kselftest/next kselftest-cpufreq: 3 runs, 1 regressions (v6.3-rc1-25-g50ad2=
fb7ec2b)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-25-g50ad2fb7ec2b/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-25-g50ad2fb7ec2b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      50ad2fb7ec2b18186b8a4fa1c0e00f78b3de5119 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6439997c8af0fcf52a2e8617

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-25-g50=
ad2fb7ec2b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6439997c8af0=
fcf52a2e8618
        failing since 178 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
