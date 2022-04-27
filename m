Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD61511703
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 14:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiD0LyV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 07:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiD0LyU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 07:54:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733FD36165
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 04:51:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so1345683plh.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=n5+c85HRWXh6j4YE4vGJ9a7gDB5MWg0o4UtkFE2ERXQ=;
        b=ZYx45zGiveD7YhlgVwtht72HlaScWUispG2HvTjEBd9lsIVYEzV0m5hRhEt3QqMmQM
         DTfj5c6KQir/MR3fDNZm4uKGr8Q1RHXqUpa4aNW1UuoJEQ5a4UAMzFawyfAy7y0PhQ7v
         TMSnsq1YHAW2D/4FKPBLfojCga85iCEhH8QYe0+pcrV+fM/N5n13/CwmXxcAEnTqKqn0
         feAUKTq7KT4b7szm5+uDwqwNlhpOxoKgls8B/2DS7P0wQVMzUSpFgiDFFpgnd0wfM5Ri
         K6Sls9+euELR84UH7cLs+Ng3LiHfqz65kHeT0Q+6L6r+d+7QYV+RRuUw7z1eUpkCO1GU
         mZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=n5+c85HRWXh6j4YE4vGJ9a7gDB5MWg0o4UtkFE2ERXQ=;
        b=weWzH3ezfy36DUEQLRY3E/zjVaffpM8iUGWjgIY+iwB+Upi6ltzeMiZ+0avRVXaMok
         1hcRCHkYq8qJFAECRmrWdwOVDxS2/8nbbf9U265d7cab4wQFUtPdMvZaCIcl/MLWc8vR
         Yt7IGmPLYull/PA8yDlvAQwHp3lLpkgDVdmbDcho7XzG6qt1xhZynBG1ikZozgmuYZOb
         OvNJfNFd/E4tiJWrG6jZCONlMPRLNRUeMzdqLnJXJ4cah734CqXCbMXnOL2skFljy6bw
         lzrHiJT4MrwW/TFPeaSkomd0h5UZvKpBG38SLpSinpcraVmbtKjZafaTaXpheQsTmYNJ
         k9WA==
X-Gm-Message-State: AOAM533Y4ylN6lSokNLuQUnApv0gewrwbUt1ithtUUSnROTcctiBvwdY
        iJpkWsdAcqJNTT4qlpOxsngefA==
X-Google-Smtp-Source: ABdhPJydNGqGEONazxBq4DiGXorsBj9taEH6NbcUkDbq/fDc6DMcnNZMsoKkjA4wUu7d0T35LRo/FQ==
X-Received: by 2002:a17:90b:3889:b0:1d9:b8f8:b451 with SMTP id mu9-20020a17090b388900b001d9b8f8b451mr7920167pjb.186.1651060267000;
        Wed, 27 Apr 2022 04:51:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b00505793566f7sm18285258pfo.211.2022.04.27.04.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 04:51:06 -0700 (PDT)
Message-ID: <62692e2a.1c69fb81.3b754.b5c3@mx.google.com>
Date:   Wed, 27 Apr 2022 04:51:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc3-18-gc7b607fa9325
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next kselftest-seccomp: 5 runs,
 4 regressions (v5.18-rc3-18-gc7b607fa9325)
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

kselftest/next kselftest-seccomp: 5 runs, 4 regressions (v5.18-rc3-18-gc7b6=
07fa9325)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3-18-gc7b607fa9325/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3-18-gc7b607fa9325
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      c7b607fa9325ccc94982774c505176677117689c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:     https://kernelci.org/test/plan/id/6269201a9919ed77faff9468

  Results:     87 PASS, 4 FAIL, 8 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-18-gc=
7b607fa9325/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-18-gc=
7b607fa9325/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220422.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf: https://kernelci.org/test/case/i=
d/6269201a9919ed77faff946b
        failing since 61 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence_no_tid_in_err: https://kernelci.org/test/case/id/6269201a9919ed77faff=
946c
        failing since 61 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence: https://kernelci.org/test/case/id/6269201a9919ed77faff946d
        failing since 61 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6269201a9919ed77faff9471
        failing since 61 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =

 =20
