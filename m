Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1E53F1F4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jun 2022 00:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiFFWJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jun 2022 18:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiFFWI7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jun 2022 18:08:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F05362CDA
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jun 2022 15:08:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d129so14056990pgc.9
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jun 2022 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zY3kQVWOHg491rmnC+okim4Epxx2lHqyFElH0Vm+zSI=;
        b=XdmDttvE4TPk05/irfbuanC+JyztC4vQUWsab00UBmjhWbAexijw4/OpSlTS42OotS
         OgQLq9o7xXHxANZ+F9prdqTeEBY71zqnW1g/1tbTJXBruobsoTOo4zmFw767pGHaG2tm
         BLxWJIQ5Z9QKpKKXYL4DWKWP0Go7T/as5UmQaJ0XATrtsvpkqhBO51r/O/N+d7bMBnn8
         k+bVNZnbRFqE2eNPh0V3XI7g1SuiZSmAg0Ok7SNd9ctb9NrSnb1nzrJ1XIVSLo68SBrw
         ov4kcEefm9rVMS4L1jGq7vH9Rayg4mKWKiiPLJ1LZ3QYEkArAG29FzEaLRhfYKfssCbp
         Fyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zY3kQVWOHg491rmnC+okim4Epxx2lHqyFElH0Vm+zSI=;
        b=2SPkM7GhijwI7FQCXd40wfpWJiBeXzEsbuNgJITh0u8PQJMuyj2sfea7azteg38zbM
         TheGmHhqdJmZ97Fvrmjt1Ac/nXGb0fpUh7LsygLujiajwvEp5H98o3294D2ghx76TQ+X
         8cMLa7RVIwS4aY+tw+RpWfV6425nC+tGmtn+zh6AhhhSnFpQHgsKv7z4Cv4RkPdgmwkg
         sfe7TtyqO1NtldQEv0ASRgNSc2CCFkDN4sjTe8hRXJwsS0ucaLbXlAdtA43HMuc9sm2z
         eXpnJth1UWgHhhXFLgtFxgzpi7bC6zfbsTQMpj8PgyRcCVN3CJac2Jd4IwKj6FZL2g0V
         CaCA==
X-Gm-Message-State: AOAM531QH3+An18nPTfWBcMNqSwOYrlcNsab8baH8njihVCe9zUQ0fiL
        b8WHypEdx5NQ7QXgvwVCfebWJuyjkvnSQjQD
X-Google-Smtp-Source: ABdhPJxsXRtceXE599+dI5CFRC0VHhbNtgz87LGr+j9XgXvE3cka2qG7WZX9khns9jn2S4vHfFudxA==
X-Received: by 2002:a63:e40d:0:b0:3fc:580e:3a04 with SMTP id a13-20020a63e40d000000b003fc580e3a04mr23094933pgi.155.1654553337743;
        Mon, 06 Jun 2022 15:08:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090ab98700b001e095a5477bsm13002194pjr.33.2022.06.06.15.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 15:08:57 -0700 (PDT)
Message-ID: <629e7af9.1c69fb81.e26cc.ea7e@mx.google.com>
Date:   Mon, 06 Jun 2022 15:08:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc1
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lkdtm: 3 runs, 1 regressions (v5.19-rc1)
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

kselftest/fixes kselftest-lkdtm: 3 runs, 1 regressions (v5.19-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-14 | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v5.=
19-rc1/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: v5.19-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f2906aa863381afb0015a9eb7fefad885d4e5a56 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-14 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/629e69e95a466f769da39c12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-14 (Debian clang version 14.0.5-++20220603023205+576e5=
b39ae4d-1~exp1~20220603143239.145)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v5.19-rc1/arm6=
4/defconfig+kselftest+arm64-chromebook/clang-14/lab-collabora/kselftest-lkd=
tm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v5.19-rc1/arm6=
4/defconfig+kselftest+arm64-chromebook/clang-14/lab-collabora/kselftest-lkd=
tm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220603.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/629e69e95a466f=
769da39c13
        new failure (last pass: linux-kselftest-fixes-5.18-rc2-1-gce64763c6=
385) =

 =20
