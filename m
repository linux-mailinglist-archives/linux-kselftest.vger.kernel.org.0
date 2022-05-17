Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20395295D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350592AbiEQAG2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 20:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350561AbiEQAGN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 20:06:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE2563E5
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 17:06:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q76so15519003pgq.10
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 17:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/go1DYJRHiBr+s+l4y9pH8thGdSYPA7M4VoUeXzQQy8=;
        b=eJ1C2ak9+fGHq40n4zHiPOs0OWx5vfND1zEtsWtd/C0W/a2BCnmL5K2lEnPh6YLfDU
         bv2N5+F8czsKPu2OU4uf1rnGwHOjSIV3Q4oy3MQi4+cCHacCDdOb6BYPuhG17p6yzcwT
         4DDRA7+OFTqT3vgEMXSPhvvyRJmFc7jo8u5HH6iCOJ4omJBAkdvVE2axMG/YVTSbyuHk
         t4OG48XIcTBFExBjGcdW8gwYIiXdHhb/taSDA1QydA7nL2mHznBtK/kS2ho0MQlf44aP
         R8CJeCxUc5qvXdtLW90QvuIGtgH8M4O9esuBaSGPqYWQFEr/gG4Kk/LqEYBRUMXzeNLT
         gyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/go1DYJRHiBr+s+l4y9pH8thGdSYPA7M4VoUeXzQQy8=;
        b=jauo9wk3vX/mbq2D3mvLkBtSTMzfdcIRoX7aiPmHwCO5qbYMsV8ANAFWivyPT5osmZ
         KUpXFWC48raFL2yvQ6A19RIXGSueSYtM6ktc9DyFlootN2ilqT72IKIPN7Y1sej2toBT
         1u3x/04Y+NwwhPCdZUI2la0Li4Vg7KkD25wqyhHbsZTFZxTDq0U0kQAh9wP5SpaSiZkF
         bbacc5aq+CjKOpUZfLYv8aiIG9kYkdWHtQhvmjCcQ+loziijSKHAUnKfmAgw94bFE+kn
         82nk7VlJX/e5b8jUdGCdQik7QcTAcrxqfflgTnyXgwsDVXeUvpOii+J9U1XOZn7OuJ3u
         wGVQ==
X-Gm-Message-State: AOAM530xGRtCzbXZZ397y8bqo993I6JjgrPbuwMLwcJU4P026UWtaxvq
        uSyAufnn8nRIsiLMaNXYTF/gnQ==
X-Google-Smtp-Source: ABdhPJwDhWYF0rmvYDrn9/w7ysOnTR0v/rQLYe6gp/z+p6+EBRivf9YtGFuj6mwN7pwBwqKYPHWuSw==
X-Received: by 2002:a05:6a00:1acf:b0:50e:1872:c6b1 with SMTP id f15-20020a056a001acf00b0050e1872c6b1mr19456841pfv.76.1652745971493;
        Mon, 16 May 2022 17:06:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id je11-20020a170903264b00b00161527e1d9fsm5144405plb.294.2022.05.16.17.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:06:11 -0700 (PDT)
Message-ID: <6282e6f3.1c69fb81.73a17.cb49@mx.google.com>
Date:   Mon, 16 May 2022 17:06:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc3-19-g15477b31db104
Subject: kselftest/next kselftest-seccomp: 5 runs,
 4 regressions (v5.18-rc3-19-g15477b31db104)
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

kselftest/next kselftest-seccomp: 5 runs, 4 regressions (v5.18-rc3-19-g1547=
7b31db104)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3-19-g15477b31db104/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3-19-g15477b31db104
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      15477b31db104bc795dd1acccb3e9b89465fff01 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:     https://kernelci.org/test/plan/id/6282d7eb9a301f44b48f57a4

  Results:     87 PASS, 4 FAIL, 8 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-19-g1=
5477b31db104/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-19-g1=
5477b31db104/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf: https://kernelci.org/test/case/i=
d/6282d7eb9a301f44b48f57a7
        failing since 81 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence_no_tid_in_err: https://kernelci.org/test/case/id/6282d7eb9a301f44b48f=
57a8
        failing since 81 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence: https://kernelci.org/test/case/id/6282d7eb9a301f44b48f57a9
        failing since 81 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6282d7eb9a301f44b48f57ad
        failing since 81 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =

 =20
