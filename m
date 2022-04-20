Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61B5508066
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 07:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiDTFI2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 01:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359379AbiDTFI1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 01:08:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E9428E2E
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 22:05:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k14so598786pga.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 22:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/09oZ90BkQ600FSWJlNv4ie+bbYWQSfYYvQZRSZuUEw=;
        b=B5rXE5kQmAUeFRx0XJOy2rklc8TGfN3xmJAflDVYtiIBpStZzj0GGC92DkrQT10bCM
         KiBNhISviSze/grklCCbMBpaNsJoU9Y7ObGK+kYhJigFDprEKyb71RO7aV+q9hzoIX1U
         7Zbt1j9eZeuxR/3hRZ/2zTVXWbHD4RcDSDdxXIjyxqdd7Wa9vnKTAzzjw1nfzZ8qqFnG
         xYOgeb/jMezIjbYdtsT6ZjmdaXQSu5SgVWvdRQiQjqTvuW/wjr5HWvms/DIqqFwvRN0L
         dWBrlT9EXVCPEkrezLpjJgpGrcIfmAROtsRjn6CjM+mfF0IJICdTrZB0r7jmy7ZkXYqm
         RPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/09oZ90BkQ600FSWJlNv4ie+bbYWQSfYYvQZRSZuUEw=;
        b=2qHuW2huIxeUt4KFuVZPPZyudZudt1Yhtwkme76HWZr7rI+JavybqQgQ1mrw4abGQa
         Rzb48sOD+gVQHcI+29jyQEVncrFYT/+9JGls9PvSV9vAalN00M+LOFOsrDdRLPSJpBkV
         7upv+MCM+XybnXae7tLFHHhNa2oFqJFQ8ph/y0yOeEFn/nuZ3bpZgGH5ILknC++w8vmf
         OS16tdrYnyyH/3SAfXOa1mjWHJpfjruEC32ljv0YVlxdqDh2rXz3vOqI873PhE3DnkH8
         eyUBlbFmaaZqJzTD5UIkr6klG1bJ0O2wK1nl6MvHh/ynFCneckuUYIjlt3N/i4Zp8Vak
         n+NQ==
X-Gm-Message-State: AOAM530AVrllY2Joyt8zb1DIZnWkpMrzqtPaiDf5cdCUe71lxRVj5bW2
        GhVFf2HnBJq9QjT8h8hv3U4N1A==
X-Google-Smtp-Source: ABdhPJyBskG/L2cl1yWZuFR1f97eWP9kLzx/5bCiApn5wHs3upqE94FhIFKh1MuzgCazXEWCzuwdnA==
X-Received: by 2002:a05:6a00:134e:b0:50a:7b72:57b1 with SMTP id k14-20020a056a00134e00b0050a7b7257b1mr12800091pfu.50.1650431139908;
        Tue, 19 Apr 2022 22:05:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k9-20020a635a49000000b0039cc5dc237fsm18168009pgm.8.2022.04.19.22.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 22:05:39 -0700 (PDT)
Message-ID: <625f94a3.1c69fb81.b66f0.b921@mx.google.com>
Date:   Tue, 19 Apr 2022 22:05:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc3-3-gabd26d348b2a3
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 1 regressions (v5.18-rc3-3-gabd26d348b2a3)
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

kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v5.18-rc3-3-gabd26d3=
48b2a3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3-3-gabd26d348b2a3/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3-3-gabd26d348b2a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      abd26d348b2a366f8947e8c3c2ab9bc881ac9415 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/625f85d67200243d98ae06dc

  Results:     56 PASS, 8 FAIL, 26 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-3-gab=
d26d348b2a3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-3-gab=
d26d348b2a3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_READ_AFTER_FREE_sh: https://kernelci.org/test/cas=
e/id/625f85d67200243d98ae0717
        failing since 14 days (last pass: v5.17-rc5-22-gf6d344cd5fa6, first=
 fail: v5.18-rc1) =

 =20
