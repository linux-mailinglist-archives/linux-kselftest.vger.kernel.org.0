Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7C86AF2DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 19:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjCGS5T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 13:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjCGS5B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 13:57:01 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DEEB4F65
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 10:44:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kb15so14177352pjb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678214666;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L4gKJBsR78XmWvLXIyA809G6HqJa4YV0YFPjWnvNgPk=;
        b=4Z+d4sMpRmCd2KH5IQm3z0Ly5CVRihvjm3IBC2LChANsSohiZuDco5+B8Fg5Jq1oU1
         4o8HS0LDv1kPTrg1oeyTek7NVxYkDkkM98PIS2VDGBQ+Egq/PamEx3RfVCf/kCCGsWo/
         pmBBj8V8LUZxy3os4aA4mzKQ0ewD5FoYuMOzm3i+Ao5I+eOzUwGI/utrzXOmMbW4xZ6q
         wGuCLmQ2z5KcWCSqg9ZD+mdbkMrikoCV19t3tqP2YjliRECJh9JaKD5Jt8cziG2DkMB/
         0cHSF57uWTlHViscuybje7ER1vamcOrrJT+78ym11Cn0SDPLM7IGSGJPUtdYFWz7LbD2
         LzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214666;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4gKJBsR78XmWvLXIyA809G6HqJa4YV0YFPjWnvNgPk=;
        b=aeFTKe6lH5QSTenrnEMvEyjM5vckJ2ii5kH9OTuT2BV5NUukBpzIjOCdfBF0HBe7kZ
         VosDyh4mMjdcgHTUJQcPJmsN6R1ZFG6QfPHI2HISO2KKcqrbWvurKHXPbWlkMrxyySyY
         KRwYwaLZl+liAdxjPiKVSn4UVsgzYdyho3btEvtZCPC7Em4zsjSfrnzcSAFNofLOqN6x
         QF/wxzF1AqFv53aoy5rbQfIlBSXDfgiL0hDKdl/ueDq/qh5o/lK8A0dBAaX1kdXS+K9I
         4zWmcIgPf7oz4PhdOaFQvKfOLUp5d9NcRpx+HrUZDGivomTBDiLuZVA72ZrGqy3v/Y+Y
         v/xQ==
X-Gm-Message-State: AO0yUKVOwkqI6RvyH29kmPNq+DKEsNqsVvxQP/S+qigYU01TXUxUjcTd
        8hgl6AEkVfEWjfKYWH0x6X10qA==
X-Google-Smtp-Source: AK7set8edrpndxmmrRxqi2bvo9zTIHpD7LmNWT52K2HZz1wpgbjXOwEgWy/sXXEO7avBzBpINL4Gag==
X-Received: by 2002:a17:902:f54c:b0:19a:8304:21eb with SMTP id h12-20020a170902f54c00b0019a830421ebmr21451351plf.6.1678214666087;
        Tue, 07 Mar 2023 10:44:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id az11-20020a170902a58b00b0019aa8fd9485sm8652758plb.145.2023.03.07.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:44:25 -0800 (PST)
Message-ID: <64078609.170a0220.c7b5b.f907@mx.google.com>
Date:   Tue, 07 Mar 2023 10:44:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-g2da789cda462
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-cpufreq: 8 runs,
 1 regressions (v6.3-rc1-1-g2da789cda462)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-cpufreq: 8 runs, 1 regressions (v6.3-rc1-1-g2da78=
9cda462)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
3-rc1-1-g2da789cda462/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.3-rc1-1-g2da789cda462
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2da789cda462bda93679f53ee38f9aa2309d47e8 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64077ce5fde2c9a0a08c864b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-1-g2d=
a789cda462/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/64077ce5fde2=
c9a0a08c864c
        failing since 139 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
