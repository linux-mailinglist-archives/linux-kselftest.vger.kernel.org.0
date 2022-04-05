Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F4E4F4CE4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 03:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiDEXfv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Apr 2022 19:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457681AbiDEQfi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Apr 2022 12:35:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF2B314
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Apr 2022 09:33:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so3083606pjn.3
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Apr 2022 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ddZHgyCkbGw3TtoyrC9EaFxPffvSqmgFh14Tq0AEYpI=;
        b=U4lbn2mAf1mtYrIzdQhKwWzXgXrfV5eYkVEoDr5ymm9FKhOjNkMORzWSbYIPoa2jqz
         wA15ZRsVzH3sHz9F3fa+GR/j0JO4uJv/PRh3g3RYl+vZ57bccoHj7Zk3x1m8LfCKdRfY
         6KD8qS9p0B3XJgZ4G1ERBPu9E7OGExRk5D9bw2InIKrQrXq0ooc5CvTKcM/7oGfE7taA
         O0LYHgAQSMvQ2m6OslsGZ2ptJSZr3zO7QzoPZzepm42yU498/2UgquG21kZkjTU5qAPT
         /dMwtIr3BBDg5ghLzxh/+eT0daBHIQAJWCTkv+Qd5A9F0Wg0oVa7Eq/EKgBRqRAdR5hR
         ktZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ddZHgyCkbGw3TtoyrC9EaFxPffvSqmgFh14Tq0AEYpI=;
        b=orfFKLaMb1bdQgOf63/INVgOfZlmQIoLrB/R2c/wr9tyvPCGw2r1R55QOK+z7BN1pA
         Sp2PnX+hYr1vQhzXIBGrtF7HRVcrJAY2+pxAH7R7u+rUS+DriGQpGjKo3dN++AAtdvD4
         Xr3WTBVTR1bKs9DJ+p7Kfepqapm0ax9c2kLdK2vnX8Oqq/B4D9IoFuXEeGjk7K8pvuzy
         aHzdUzaZom1mU9C5de6sXWSMKFjcL9i8TvIw3h1dLrTWeEodPyZmBMQcor1xejelnVth
         UpbEy1fNvytKwB9eqNWQwF6PKgIimkoMQjwAGQ8nBl3PMiq9rAe4Qs8JpwtDliuJyR11
         f+LQ==
X-Gm-Message-State: AOAM531ZYSPQuF+1PFluaWMyBF4407n9XEP77rFCkNvpJf+ocBr7oBV1
        odlPFsCUnec9zHI5oE5qRmVUwlKX4Lhal8NUlfo=
X-Google-Smtp-Source: ABdhPJzacVUiM6LejGmUo8FmKHWmqyEnOwqJjMKCv+ObAh8RpO0cMraTcXKAVdxg8I52BwobR1zs8Q==
X-Received: by 2002:a17:90a:fa95:b0:1bc:509f:c668 with SMTP id cu21-20020a17090afa9500b001bc509fc668mr5082834pjb.189.1649176419183;
        Tue, 05 Apr 2022 09:33:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k137-20020a633d8f000000b0039800918b00sm13636201pga.77.2022.04.05.09.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:33:38 -0700 (PDT)
Message-ID: <624c6f62.1c69fb81.a84db.3e2d@mx.google.com>
Date:   Tue, 05 Apr 2022 09:33:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc1
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 1 runs, 4 regressions (v5.18-rc1)
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

kselftest/next kselftest-seccomp: 1 runs, 4 regressions (v5.18-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc1/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
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
mebook | 4          =


  Details:     https://kernelci.org/test/plan/id/624c5f0c2105dfb7c1ae067e

  Results:     87 PASS, 4 FAIL, 8 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccom=
p-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccom=
p-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf: https://kernelci.org/test/case/i=
d/624c5f0c2105dfb7c1ae0681
        failing since 40 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence_no_tid_in_err: https://kernelci.org/test/case/id/624c5f0c2105dfb7c1ae=
0682
        failing since 40 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence: https://kernelci.org/test/case/id/624c5f0c2105dfb7c1ae0683
        failing since 40 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/624c5f0c2105dfb7c1ae0687
        failing since 40 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =

 =20
