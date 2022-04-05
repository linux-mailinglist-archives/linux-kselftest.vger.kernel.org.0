Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008BB4F4CAA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 03:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbiDEX1S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Apr 2022 19:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457679AbiDEQfi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Apr 2022 12:35:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF47312
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Apr 2022 09:33:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s72so11449433pgc.5
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Apr 2022 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ERLDbFSoUxB0gAAtrus5KErs43s40gKVlRiojlW1ydo=;
        b=Nl/2YDS9Vo2doQF/iapJbMj3HvPptPieDO1FXnU77utZKAh0oP1TVPmyPpWHFe9kb1
         iW7gw+Tbo8gQaO/THpIcws/qAPdivoV6W2mbhDkAOOjV88HBFEFTZNysSB10DLLSI36Z
         ZLUcmn318/qXVvtLKn3LTq5UTQ72jNjqjIvA69rT5tGTFbBDzvQ2TTCJz68bZYWIShL7
         +JRTf0V7+AxDSW0ZPOSw96XG7u9PN+73nYyQbF89rRCrnKYGlb0xfsMXfyURfM5cGPHT
         AWpA003bNp6q0VWr62uquBAenX7tzefF8pNJVM7Ax056eKmlFLFDe3a9JfWKiss0E8zO
         RLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ERLDbFSoUxB0gAAtrus5KErs43s40gKVlRiojlW1ydo=;
        b=emu5+jZpUE/VYyv48ZJMZc/2UzmX0uHMQx8Q26/lzvhxBCfTEPpUd9IYHF42bgHGoN
         pzHsvL3qrgv/7idlNKYyL4ohINC+X/VPvaZ06fxs0Tzq0KxqS3QfvaEcOPpgqk84cVzv
         oqhwMANPudXons5NjjeVvQz994QHJLxgw3qygD45fZiQt9p6yuPwrrmdusluEwGfs9fj
         PVaEiJfLpzHbsowsLX7lSALX7sooVSB82QMT9NG/sGoAvnhDp9IsRczJWpQ1bPC7GqDy
         4jJea6xnWcMBZYZ96juAy8Al+vH8HZiIsIFNh1Q9RtaA97ThlmNJaRCelpbolAem7o/3
         TtSA==
X-Gm-Message-State: AOAM531Va1bIO5E3trL6StiHfAeOA7/OC2YGx5ORJ/koCuMdWWuNCn+k
        XnnyyC62D8syC1MaPeFXriCA0Q==
X-Google-Smtp-Source: ABdhPJwzWGjQZEOZf/BXltkeFbbJnRGHjSADMQBQctfEGLvEjKCkzNP4tfNeC4DKI+NuHwxplutd6Q==
X-Received: by 2002:a63:3ec1:0:b0:398:9e2b:739 with SMTP id l184-20020a633ec1000000b003989e2b0739mr3466624pga.569.1649176418928;
        Tue, 05 Apr 2022 09:33:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b14-20020a056a000cce00b004fabc39519esm16868947pfv.5.2022.04.05.09.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:33:38 -0700 (PDT)
Message-ID: <624c6f62.1c69fb81.cd3ef.c2a2@mx.google.com>
Date:   Tue, 05 Apr 2022 09:33:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc1
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-rtc: 2 runs, 1 regressions (v5.18-rc1)
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

kselftest/next kselftest-rtc: 2 runs, 1 regressions (v5.18-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc1/plan/kselftest-rtc/

  Test:     kselftest-rtc
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3123109284176b1532874591f7c81f3837bbdc17 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624c5e204798164637ae06a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-rtc-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-rtc-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/arm64/initrd.cpio.gz =



  * kselftest-rtc.login: https://kernelci.org/test/case/id/624c5e2047981646=
37ae06a8
        new failure (last pass: v5.17-rc5-22-gf6d344cd5fa6) =

 =20
