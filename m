Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C347072F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjEQUXt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 16:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEQUXr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 16:23:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE83D83E5
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:23:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64389a44895so980137b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684355024; x=1686947024;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mkDSgja90eXRJBxKe0HJ0xe1D0c+m5n3w/FeNIYXxMM=;
        b=H9Z4HV6r25FbX+fiPHRD4fSllQCvCLuKvVRWXegqNmcOb0JjqPqKcBLHoCQbO79evz
         7kMMI9+glmndMizrAo5tmY/mkOk23GhIb5BALq/tv/gWG9FBbHAe7H1QcsqlIJOwV7iF
         SshsnlPGrG5hV5OGrLM4hbtlgHAnicoUfO/G/X/du0rXpL/Fad0zUKzTf2V4ADDD372k
         G/4YrmMG31POJgIl7p7IGjH0MY1JZACWRTkjKqKJ7A3SZggF+55aAwB/b8wQhPTZXmvW
         0W73C2c/ElGob2vndIYLJKUyUJ+lzwAan1mdZN32pn4UtEdlbJXCZ9W8UzGa+wC/04PU
         rsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684355024; x=1686947024;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkDSgja90eXRJBxKe0HJ0xe1D0c+m5n3w/FeNIYXxMM=;
        b=Lv6xDIs84+WIRuuePrlBQiiCX0KC2jgkssvyCRNEm3bkIPIc1jtKaG4N/4afkkBya/
         wfgcQ7jEt/i+Fekj0IbNW8HSbscF5pSww6Ih3Wnx6BRs/vQh2aa0AyPsCmWnyxiyfzVr
         bVG6LQ9JgTh4t6Z6KlXGHd88pJOYAxKZ0V99KDXG51yTzBaDkrD5cXg9YrkEOmbqHdTB
         8JD4mTIZ2tSCNqgDarDZDO7A9o6jA4KrfoZDx4ZoBPKNg4kaKaXwNIBkfJH/4qJnR5X9
         X56lRDBdCY52XauGJ/zYGxCSiE4/CHzRd/VmLQiHf9CygDwSjiv0E0bzLIloKo5Lr8aJ
         218w==
X-Gm-Message-State: AC+VfDwjXHlSuPreWvxbN6gktFX43SH0pw348auppmizPuGzUxQKtdfT
        0FDpkJxD0Biq7G++fY+xl3isrA==
X-Google-Smtp-Source: ACHHUZ5J7qnRPuNNn6tgdoC64/4wNyzbrVwP29Ai3j1nrgZDWvbBu08lMDyBziZHxmQR/BaE+qM2RA==
X-Received: by 2002:a05:6a20:4325:b0:100:ac13:9a57 with SMTP id h37-20020a056a20432500b00100ac139a57mr46985536pzk.55.1684355024429;
        Wed, 17 May 2023 13:23:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e19-20020a17090ac21300b0024e33c69ee5sm2055141pjt.5.2023.05.17.13.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:23:43 -0700 (PDT)
Message-ID: <646537cf.170a0220.1c996.421d@mx.google.com>
Date:   Wed, 17 May 2023 13:23:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.4-rc3
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-seccomp: 2 runs,
 1 regressions (linux-kselftest-fixes-6.4-rc3)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-seccomp: 2 runs, 1 regressions (linux-kselftest-f=
ixes-6.4-rc3)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.4-rc3/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.4-rc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      dbcf76390eb9a65d5d0c37b0cd57335218564e37 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64652426a0658315ce2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kself=
test-seccomp-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.4-rc3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kself=
test-seccomp-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64652426a065=
8315ce2e85e7
        failing since 141 days (last pass: linux-kselftest-fixes-6.1-rc3-3-=
g89c1017aac67, first fail: v6.2-rc1) =

 =20
