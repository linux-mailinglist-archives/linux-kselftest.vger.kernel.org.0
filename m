Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20769552A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 01:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBNAHA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 19:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBNAG7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 19:06:59 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611BE18B07
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 16:06:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z1so15300562plg.6
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 16:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9wXIEnaI6c+vIuqI+m8VQFzm3yETKhK9xFUu6c0K0Tk=;
        b=OBanl/mtI3Gj7HpulfagZW7VRZbKazvq0UcLawOLstl5ZLxUeBMkb5ycYZaGimXIX8
         6OBhwRph7s4ySl/J/udPRwbqobRl/rIhku5s0TFaaEKWLB4hQzpYJfjVKD/jqf8tG1hU
         Gt4bLAFLonDQg7+FmVIxXm8PT+Mvo59gJLkhLbip/O67cRD5WbWrn3NAZqbzaKiMM2Or
         XW623oZzrvP7y/T5/T/8dxebJXRvNffWY15ALyj4Ww1USaB206qj6dP3EvKdURei+CxU
         ieAQmaZGlopBAobS8Yo2B1PT6m7in/MCUSfPobOGx2o2qQ2nWMSJS5j2CyI18HRHcMrK
         plqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wXIEnaI6c+vIuqI+m8VQFzm3yETKhK9xFUu6c0K0Tk=;
        b=egK0lN3ab4b9UBARhe3qHtW4wF7RNO+fTPNTIWGjk4wvl3/zUWuXc1OaL3nSY7hmMb
         OKsPxiaYj4jhVf3lCJhzcwX+OZUzeaq8THyJLmawp8fHvS43UbHwjXzPs2lXq6jzTVAw
         Ecu80gyaLm1/5kT9LZednmSL5CkIoxHNGXQuBZ1nmcdw5xJN7KkFlDh/Ys3rGddideNV
         yGdLWYoFGAX4xOMF5Adl3mpESV7PolUZZ7kVsqZBSgm1oMdfJK9Ik3KMN3fguZ7Cevx1
         xi3hoZqAPnjvdpPJ9XgTyfElrn6SH2AdF0iIJaffnBGIYgWOYWfr0s9sTK0A17a24tX5
         Dfpw==
X-Gm-Message-State: AO0yUKWAP7e4sKMJ1R1c+PvCdgpO9Vs3TdCnIQcQvK+WSQzTwStsOsj9
        uyfgzfezUf2rMeYjuQbQo2TZow==
X-Google-Smtp-Source: AK7set/xK5W+ETZ0yfpCrtciU8TB6aRZ/cCCXfcM9klTNnl43FmRDKtCkcHhSQ+0zwxZtERrfPOULA==
X-Received: by 2002:a17:902:e550:b0:195:f3e3:b923 with SMTP id n16-20020a170902e55000b00195f3e3b923mr952438plf.8.1676333214867;
        Mon, 13 Feb 2023 16:06:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902761200b001932a9e4f2csm8737569pll.255.2023.02.13.16.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 16:06:54 -0800 (PST)
Message-ID: <63ead09e.170a0220.c9963.fcd5@mx.google.com>
Date:   Mon, 13 Feb 2023 16:06:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-36-g6e81461b06b6
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 4 runs,
 1 regressions (v6.2-rc5-36-g6e81461b06b6)
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

kselftest/next kselftest-cpufreq: 4 runs, 1 regressions (v6.2-rc5-36-g6e814=
61b06b6)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-36-g6e81461b06b6/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-36-g6e81461b06b6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6e81461b06b6a4a24bf97fca37d9b89f72ce8126 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eac14c8d3bbc994f8c8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g6e=
81461b06b6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63eac14c8d3b=
bc994f8c8636
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
