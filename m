Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB15760DB7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 08:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiJZGmK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 02:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiJZGmI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 02:42:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC9A8374
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 23:42:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g16so8942356pfr.12
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 23:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RDwe2KHkcSMBQmAAfySpGcccohnunFTuhpFy4g4P8RY=;
        b=syvWIabnEKaJuiHKLsmZP1JDjFbMp5aO5DRKKnekAL2fpCLLed6PRBy8ou3+1jH0g5
         +Vk9Cyj8u/+DdSNz6lXip3j5sT6bDQ21AxCz4TPv1gNqvfSrpk+mFzzk2kTjaEBwG1ev
         PnDhu+7HYCuX1MpLR6Q9hHm+EcqVtEXlzwqL45vYKI7e/h/3q+ENyJ6R1wDrAXXPlYkS
         dVaMnbR+eq90RYY10ClrUl1vr3xclTIOHFlDOW3yw7L8oKl9Yn98ADtEu3Y7ie21vs2+
         gV14HfAfaJbQaBrhBiA9DEaCeJ+24rOJbjkKm2vVBjdzyEp6jb8cd7Gn6dPRGWOY9ECO
         +JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDwe2KHkcSMBQmAAfySpGcccohnunFTuhpFy4g4P8RY=;
        b=6i4yb0ZrCeqChYTLq+ZJgoV6GjsduV+lAAjSmc55Ebtom80VgJ1UIlQL+TaDleqvb2
         YLtgiDGLB2pGHd2Wv9YmV7b7ktPY6H2rwRIhbhghOOsYImWZicaJkkebuwJysX4WWhXk
         Zw02Whe8zDbUI/inktxwtjp8Bar6x7x0jTNoN6xTWHeEYF168MLoRQTpSBoWUlO0sfeM
         1uhb72Lue0FaydNFleBfsd8BXH827DwPLBk/T3+15243tMgzI18fdR2RPCKIRAy5jqQQ
         eZPBNvBweLM0u9sVAqphlx3iflLyAJpZOUlTD+XmH/C2IlI0P0POePhzs49RQDv8Ap/i
         d8Mw==
X-Gm-Message-State: ACrzQf0xt+fwl7cXJGbZoWt5SFReLxSVZa+icm4ZyPXDiI+NTNtKJ8yf
        QuG35un5yEITikbVXKnCgq8ghQ==
X-Google-Smtp-Source: AMsMyM68u2TS+qVmsY7YKI9Un5ABwaxAByDYci7Ndn7cRDDrGQbU/8Obe8+eQSWvGVCUHZxcV4BVng==
X-Received: by 2002:a63:c145:0:b0:44e:9366:f982 with SMTP id p5-20020a63c145000000b0044e9366f982mr35519167pgi.584.1666766527429;
        Tue, 25 Oct 2022 23:42:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a634e44000000b00434e1d3b2ecsm2212894pgl.79.2022.10.25.23.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 23:42:06 -0700 (PDT)
Message-ID: <6358d6be.630a0220.d0876.4a85@mx.google.com>
Date:   Tue, 25 Oct 2022 23:42:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-5-gec7b4511185b
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 2 runs,
 1 regressions (v6.1-rc1-5-gec7b4511185b)
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

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.1-rc1-5-gec7b=
4511185b)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-5-gec7b4511185b/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-5-gec7b4511185b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ec7b4511185bba95fc702c33a388582c8842d454 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6358cae5a3f7ebfabf5e5b78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6358cae5a3=
f7ebfabf5e5b79
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
