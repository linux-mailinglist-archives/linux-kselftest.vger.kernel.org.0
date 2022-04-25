Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE64750ECB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiDYXnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 19:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiDYXnl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 19:43:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EE21AF27
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 16:40:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a11so5052787pff.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 16:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XpIOxKKDw8BFlQMrU/iEuFst9R8oEEgBLxRULL2rs3M=;
        b=5GfRIg4EI4GuKWBiSXLk3b79jmkgEP8OI9qNHaZQbxXHrCFb2G9Ci92ez76cKgav1y
         4zU+oT2VgFNJy6BaGF52zW2oYS2/Wjz5Jj9AWQl75IoLbSjOYacH8+I+Wo444LIbq1EQ
         gpB5VB+ZsuTzfM3VS4x+MNquL01OYd/+T68BSZ8rvlfGRvueRiPraSptZQRRrRNIVFq+
         wVXESvwPbtjWTZn04d+76iJOgaIT2Yvb0tmZpJxWWOv7qAxpN9cI6FKAY4yLK4vrSC6w
         BqE0V2/+wOpiIaRQJVVgYBy7UUtUvtBP24T5hgM1vknzspYSSAwAKH88lI/Yl6pDdozu
         0jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XpIOxKKDw8BFlQMrU/iEuFst9R8oEEgBLxRULL2rs3M=;
        b=dmsfEtKXN6GWX1t/lk5Ppv+UsuFXqGU7WgplHP+IZKuqRDKfMTej0cDYam0QtOAtxU
         dFBAflHxlfdYmV60jC8PZDfAnwmBtZMo6gH/YduZ0L2J7kX+7laMqnXsq+3jRTuWB+zt
         r/RcXfdbwseiLw7TVAj4e/S6VixpoK1n8LAADgdZ/TeRr1aH8fSHyqRr5LGqXAD530cq
         YdYfeQ8/4qHjhaNe82BnIXxLX0bgpEC8CyCvXwFlR8ZEIsVNx7lXBqnCUGLkloKofpFs
         Oi9ZtJCBlZ2DGoqPKJD76J1P/hc8RniG2dVL5DqpuDOy5RLN/9b2jashbDVvxrp/d+ac
         Nlqg==
X-Gm-Message-State: AOAM530XNtheMDrTn4CtZz9zTSoVI/UJUItpwfg2+3u9fdLjXAZa4Lv6
        kro2CgVfMRL9tjQjH+GlqBMjZw==
X-Google-Smtp-Source: ABdhPJzrCpN83TnvGh49V4kp4qJVvVBfB3EkWXDo0XMpi6CA7iY9zBd3ky1tCL1lXXBvJGVrpfR1QA==
X-Received: by 2002:aa7:9109:0:b0:50a:78c8:8603 with SMTP id 9-20020aa79109000000b0050a78c88603mr21213070pfh.77.1650930033112;
        Mon, 25 Apr 2022 16:40:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a628100b001cd4989fec6sm435101pjj.18.2022.04.25.16.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 16:40:32 -0700 (PDT)
Message-ID: <62673170.1c69fb81.eee7.18f4@mx.google.com>
Date:   Mon, 25 Apr 2022 16:40:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc3-9-g170d1c23f2a3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 1 regressions (v5.18-rc3-9-g170d1c23f2a3)
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

kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v5.18-rc3-9-g170d1c2=
3f2a3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3-9-g170d1c23f2a3/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3-9-g170d1c23f2a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      170d1c23f2a356932259034f73d579d0bab857d6 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/626721f54303a515a1ff9459

  Results:     56 PASS, 8 FAIL, 26 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-9-g17=
0d1c23f2a3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-9-g17=
0d1c23f2a3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220422.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_READ_AFTER_FREE_sh: https://kernelci.org/test/cas=
e/id/626721f54303a515a1ff9495
        failing since 20 days (last pass: v5.17-rc5-22-gf6d344cd5fa6, first=
 fail: v5.18-rc1) =

 =20
