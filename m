Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223A460672C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJTRjp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 13:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJTRjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 13:39:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA151CFE9
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 10:39:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m6so284346pfb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hqaTzHCRPp2+sVIhyCt5Y4kQHODIV7EMCSyBYa1UPro=;
        b=QjWja1TxZUHTsku4rSgWdY+cm5R73hcFchmSuPqFs7cMh8Oh7yt2WQzlx2Zu9eAR6a
         oEl46YUO5bYSDl8kG4Mw7ZIJBG2vDpT+U6N9LG58wvIOHMLOdL6y+T8bVCcJPfSc8c7X
         uw1/bSBhFABlbGlkNlBnL4rvqPydxWrmHM3Gi80MURYCGso1yCKjKLivGEhA5pH19+8y
         WLSsYYG/t3NmsBhxta5gK6U6P37M2SB0MBHTBYX06WPpjjaUUkvkdPc2SCVE78az/dWa
         6wvD+sXY5AVSZABNSP0lQYsV79p+EkyRI5XYEPjPPsjwWfKAZy+lkTH2RG11djyPhx/G
         DtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqaTzHCRPp2+sVIhyCt5Y4kQHODIV7EMCSyBYa1UPro=;
        b=RqtAlc8/PCeD4nHhRhc1H1mPtqTyOlz7vEWOSkY75W7LAv1YQvincb/nCXfXsRz6AP
         IFO30qnYIjnNZTYq1E+jwb4hcozZqher8jg67H+9Pzyf3WHFs8fAgdI/0ycgUxzxaBBO
         xAOKf/xb6BizQbnvSj1QoG/3jmKzqNhElY2EOSiodaCeS69n+PANBw1xXg0IhEVWN8p6
         doXD48lhyGg7mjWbdSfgLvpCXXgurtSbJKiB9/DFV6Y14zZ3xjAv/bV9n13UfVJqj20w
         CpZgqxHsadtwrrrdh4UP9gpE0+qMDAgSfOzk/e+zm66ViN60BCKsqQh6P6vW2FJfZMYj
         7AgQ==
X-Gm-Message-State: ACrzQf038ImYfeP+BOgit4tSTDalzkwjuJdYOQW7gwK01N+YQOFy9l3p
        MqlthoQ5rfFwz/Xrks7Byl8tZw==
X-Google-Smtp-Source: AMsMyM4Ch24JNT+ogi/XMz0naofZ6EVtn/1vu8BOxqmp+j/HWpdn9hbqoOci+Ckwl3yvr7ik1hJxeA==
X-Received: by 2002:a05:6a00:14d4:b0:563:9296:f320 with SMTP id w20-20020a056a0014d400b005639296f320mr14757883pfu.27.1666287576682;
        Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 33-20020a630d61000000b004351358f056sm11870177pgn.85.2022.10.20.10.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
Message-ID: <635187d8.630a0220.c94c7.6b04@mx.google.com>
Date:   Thu, 20 Oct 2022 10:39:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-1-gde3ee3f63400a
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 3 runs,
 2 regressions (v6.1-rc1-1-gde3ee3f63400a)
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

kselftest/next kselftest-livepatch: 3 runs, 2 regressions (v6.1-rc1-1-gde3e=
e3f63400a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-1-gde3ee3f63400a/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-1-gde3ee3f63400a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      de3ee3f63400a23954e7c1ad1cb8c20f29ab6fe3 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63517cf2bdae37f7375e5b4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.2-++20221003113153+5f620=
d003fda-1~exp1~20221003113249.70)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63517cf2bd=
ae37f7375e5b4e
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6351766afb907c8a5b5e5b3e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-1-gde3=
ee3f63400a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6351766afb=
907c8a5b5e5b3f
        failing since 2 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
