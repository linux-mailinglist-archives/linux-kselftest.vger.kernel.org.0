Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE94C30F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 17:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiBXQJM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 11:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiBXQJG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 11:09:06 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C958188860
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 08:08:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id ay3so2133019plb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 08:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fk4uwFyCWKeNdpuYkDDDNFnzmEB/UamiIfB3Zrt5+vI=;
        b=K2jWfRmqO9sEF7LcsDD2MtfnE3WuuZLkFnlFWmbs3j/wY/Wst8vsaiNlJHJh0LMQyQ
         8x+IxYA5xoSqjRRaeddJarbBmFHEaNm3Ffv7jLbmHw5dLOLSYYuhmctmiK189kjq8c+C
         pISqV5+/B5fWMy6CJeFpopQRuE8oGxj4/jiSgESCy8DTTVg3CZGPrTQ+lzdCV4+cTsyh
         FSQETrfTpDwvEQMKovg/9ph3sCNUy9vj5fn9fiPyx5V/uhGYdYZBKscVlpbkUca3g4co
         v3WxHPtSkCo1v9Hz9WNKA7bS87OvqIt68T6v+CKm9mS5c4SizkZgDr1AwZqNzM69APmo
         m2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fk4uwFyCWKeNdpuYkDDDNFnzmEB/UamiIfB3Zrt5+vI=;
        b=b1sSe8dqqUYqJ1g3ZKiFZ0xTj8hMfy2D3z98g93AEcimevG6WqYhgv9T0WEtRKn0kM
         hAvQoPzImKcPw0U+2L/hJXGsc1R3V1pQ2DPoMdzoFJC9RPCu1N9vRcXsei8L4XU8o5uR
         0SaOZv9qjVPOeyCPWOwmuh5gN+NgfAp2H/W3yVKc2hqDtFCPCRXVeoRwRbylgaXUdaoY
         rGgujX1TaRyopJg+CUJXKHTW4deKtQkbE06aKzhJua+7b6r7A0uGRORAd9yIdwX9P7Te
         oyyADWv08Nkl2kCbExJeYriNPjgsff2V1leb7ofOhmBd9C5G/ucdnFnKQdCaGkDvyh4K
         YRjQ==
X-Gm-Message-State: AOAM532/1TJUsSieZk+2usVQAR+v/hRXpLFisiYFLd0Ds3U3Uug9MKYd
        ztUJu6X5Pmth2WuiHlHbf9BWBOQyayO7cZ3dWTo=
X-Google-Smtp-Source: ABdhPJxXnQzzlB5GlCnlO8GoeXnksyYsHnDNeJqOwFzW1CBPKKM3oe44pzheFNKQT9i2AMt+KtBOsw==
X-Received: by 2002:a17:902:b204:b0:14d:a8c8:af37 with SMTP id t4-20020a170902b20400b0014da8c8af37mr3215981plr.108.1645718838278;
        Thu, 24 Feb 2022 08:07:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bd13sm3582518pfb.60.2022.02.24.08.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:07:17 -0800 (PST)
Message-ID: <6217ad35.1c69fb81.f4fc.93c3@mx.google.com>
Date:   Thu, 24 Feb 2022 08:07:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.17-rc5-16-g1900be289b59
Subject: kselftest/next kselftest-seccomp: 2 runs,
 4 regressions (v5.17-rc5-16-g1900be289b59)
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

kselftest/next kselftest-seccomp: 2 runs, 4 regressions (v5.17-rc5-16-g1900=
be289b59)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
7-rc5-16-g1900be289b59/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.17-rc5-16-g1900be289b59
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1900be289b598b2c553b3add13e491c0bb8a8550 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:     https://kernelci.org/test/plan/id/62179887662699179cc62968

  Results:     87 PASS, 4 FAIL, 7 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.17-rc5-16-g1=
900be289b59/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.17-rc5-16-g1=
900be289b59/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220218.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf: https://kernelci.org/test/case/i=
d/62179887662699179cc6296b
        new failure (last pass: v5.17-rc1-2-g6d468898d774) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence_no_tid_in_err: https://kernelci.org/test/case/id/62179887662699179cc6=
296c
        new failure (last pass: v5.17-rc1-2-g6d468898d774) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence: https://kernelci.org/test/case/id/62179887662699179cc6296d
        new failure (last pass: v5.17-rc1-2-g6d468898d774) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/62179887662699179cc62971
        new failure (last pass: v5.17-rc1-2-g6d468898d774) =

 =20
