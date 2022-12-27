Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6AC656662
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 02:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiL0BSi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Dec 2022 20:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiL0BSh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Dec 2022 20:18:37 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85BD2AD1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:18:32 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v23so11893764pju.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Dec 2022 17:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Bq2OkWSLCJIeOKae3pK3bSXY1VmI56D3OnGSezzYbk=;
        b=vuk22j5d9Wx/8fYHx3O9zoIkoq5tfN0Ls96xrz5V6Wmtskx3LYQfGV7T7sdi0zGzvL
         RyqNSHL9DmU+ZUHfda3ncLWA6NOkw89zEgfRbJpiyZQeORyVVr1SN4fsGFxDvWjYzpuN
         r15HaQnPgKVs3FRNUhcKc2ZPfWKjQBZvWVdzXKn8QZD0Tj8O2bmDkpoZMxA5V3mxEdGP
         veiAG9V0R6eYE6OFbx/+rk/F6jATmfJ5TJ4lrYIFR7N/FICbDwh0oZGYSWSmM0zQguHq
         7ddwyJOUTXyfau8v9odHokPQpBgXMJsTxYsNYFfBCr4wc0iQsCQo43uxcWMlPtGSLrbz
         amdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Bq2OkWSLCJIeOKae3pK3bSXY1VmI56D3OnGSezzYbk=;
        b=uTcbSDG63E0y6UTqo18Dr/FPtAlHTPXKj0PTjoExCHBl7TdPhHdxzE8zUHO6oiPES9
         Gxi5SuEjA2WHmsnUOWfto7LV9EIaKYpBbqjfEezHQDZTSVn82oQkeXPrFlL2I7wt5Rv8
         KhvZ3MbWejnKXo3ezQsDAZ35jJoW8pVVdcTvwTd0wic2YDQxgDFe0M2agT84Ecfi7zmk
         eho+yaNAz8EF1OGNYGUUvxaNyJZ6+Nv8o29aAqN5F0Aw9TeTBlMTFjqfjvU3O4mf/u/+
         ZW+fAZkngqis5sNWyOk2WlHEQqlEFAaE4xZlGwvA/Z+JIGoYsNUS4ELNObxbMm2fJXJq
         vAkg==
X-Gm-Message-State: AFqh2krFdSjoH2yLJBkduz9GlxaQ5IkLBLPDQ52CARQWhB7s/KtsHlpP
        LfgNN8sQ0HzN6XHvK25lDMe+d941RZWDdoNyxmY=
X-Google-Smtp-Source: AMrXdXtgfc2NN7E8QqEw25d1NqruWY5cR/XDo7p5R5XSWG5QP2lV/plRwgvN/E8rx5IfMK70+Oo9Fg==
X-Received: by 2002:a17:902:ce90:b0:192:8a1e:3293 with SMTP id f16-20020a170902ce9000b001928a1e3293mr2701185plg.63.1672103912297;
        Mon, 26 Dec 2022 17:18:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902e49200b0018157b415dbsm7783126ple.63.2022.12.26.17.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 17:18:31 -0800 (PST)
Message-ID: <63aa47e7.170a0220.2fd17.e527@mx.google.com>
Date:   Mon, 26 Dec 2022 17:18:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-cpufreq: 2 runs, 2 regressions (v6.2-rc1)
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

kselftest/fixes kselftest-cpufreq: 2 runs, 2 regressions (v6.2-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
2-rc1/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.2-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1b929c02afd37871d5afb9d498426f83432e71c2 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa39682703dc87014eee19

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-cpuf=
req-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora/kselftest-cpuf=
req-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63aa39682703=
dc87014eee1a
        failing since 68 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63aa3a1c751108c4c54eee26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-cpufre=
q-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.2-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-cpufre=
q-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63aa3a1c7511=
08c4c54eee27
        failing since 68 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
