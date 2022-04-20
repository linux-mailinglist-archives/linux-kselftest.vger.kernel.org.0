Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52FB507F72
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 05:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359134AbiDTDKp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 23:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359236AbiDTDK3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 23:10:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7707BDFDB
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 20:07:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a15so650486pfv.11
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 20:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=bPGUwdK5CjIu1kG7gaOpaMYwE4ZpMdyvOlX/FI24ULw=;
        b=49idnB3dNvEgf8guR+cNdlg2lOZbLrwsrdP56AgpGVZOXzmUfcbaihS+rtHcA4Xe/5
         6Sdu8FydPeORWyy/DnzCvEUnI07fQNHuKkazZwIDoLP1FU+Bq1W07d6ZP8sQPDEXDqAF
         C8ogv87he+MZYGJhRrmvjrtOqlEtwrxPtusHJf5AePJ8DH0hhJQ7OKBhV1QzCyum07Om
         ZLnqq2yJZcfluNk4wfvOrK4rmoKEkwTtDmGJfENjOS/zcTTSGcpE9KP1Y5EgLEUWnpVK
         r1SpfzAbahDDhOxc7abzlmbIG4nS2tD5Xa4t2YfmjS4qjiwOnRGVtmLgHn3YadinyPzY
         wSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=bPGUwdK5CjIu1kG7gaOpaMYwE4ZpMdyvOlX/FI24ULw=;
        b=pc3NHu6wjtL1ztoNfS6pX93RgOCsFH0bDBR9jnc4FgOEiR1fdzng/T8DzIehFOSK1R
         b4O/dgs1QmRQqGczsol5tYHOp0aM+kiurcGR8FNl77B6wcRMgg/8/cUa8yE196UDn9J9
         p70tOfm9awezFGlvjn2Tg+W4HX/Iv2od9EO0q6jXF9IeZUcm8GG030WJE1j2E9AhNp2P
         izKnPReD882gk0sJe1MB5Y2PVRAV6tqPMEN9UXnJHcwy+2FfhfVrO9/DhMplgt/9V3ki
         IghtaSgJuDVNms3WKAm9lPYUwmnuDZTIFF3qWDpVcvF+gYZpXqYyfHI0IokJFolsrJ0d
         uf4A==
X-Gm-Message-State: AOAM531DLsJKsELJ9q1US6kknyqEfEsCY+o6IpNlMY8wTDyykyTfEWES
        OTjmWiB2paxCJrXhn0yR/sDCiA==
X-Google-Smtp-Source: ABdhPJyGXFyIWbdy1psaJGdCo8uny9Add/y66MN1XcFJjjJ2IrrNVLve26smNJ6EyBtUUEGOMDIlSQ==
X-Received: by 2002:a63:fc5b:0:b0:3a9:f988:98b4 with SMTP id r27-20020a63fc5b000000b003a9f98898b4mr11319856pgk.504.1650424058058;
        Tue, 19 Apr 2022 20:07:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a630a00b001c685cfd9d1sm17202694pjj.20.2022.04.19.20.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:07:37 -0700 (PDT)
Message-ID: <625f78f9.1c69fb81.cc197.9b98@mx.google.com>
Date:   Tue, 19 Apr 2022 20:07:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc3
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 5 runs, 4 regressions (v5.18-rc3)
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

kselftest/next kselftest-seccomp: 5 runs, 4 regressions (v5.18-rc3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b2d229d4ddb17db541098b83524d901257e93845 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:     https://kernelci.org/test/plan/id/625f6a7477bc9aedf8ae073a

  Results:     87 PASS, 4 FAIL, 8 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccom=
p-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccom=
p-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf: https://kernelci.org/test/case/i=
d/625f6a7477bc9aedf8ae073d
        failing since 54 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence_no_tid_in_err: https://kernelci.org/test/case/id/625f6a7477bc9aedf8ae=
073e
        failing since 54 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence: https://kernelci.org/test/case/id/625f6a7477bc9aedf8ae073f
        failing since 54 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/625f6a7477bc9aedf8ae0743
        failing since 54 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =

 =20
