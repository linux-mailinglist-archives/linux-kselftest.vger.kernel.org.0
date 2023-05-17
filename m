Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3292A7072B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 22:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjEQUFR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 16:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEQUFQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 16:05:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6229E
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:05:15 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53404873a19so802823a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 13:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684353914; x=1686945914;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz5492UKsw68NBdaP/BbI7o7f5Bu24HXiKp6SagfO1k=;
        b=Mwh9zbqbbzwxOQZyaD8jefaqkvcBgAUZqlENvkFv/3gCbJ7NzmIuDo98iZQYHTveZK
         m4vBwXfTTiUJslYTOfD6aPgVKeVc8E6ByFfonpXPqNIeefUYhnb5qqjNkpKMiW+sTzIS
         a7fd3cuTTLkCD247sFziuCEVKFNyh+7KIQ6c8cQTjIiaQZLSOggWUAxsbmUG9Eg8Vwr2
         YC91ov3SQBFNL3sA5bfmsNaHZN8O0cjFQ/ZTu4qP+qC7XQfY5O7vbeJH8nDVdxam7l6Q
         Df/tB2dCu6JleexO3VfwtcaELE+8ciD1y8Fb5vcY3OmTnNV7K+q1ouk0KtQWOpqA/QGx
         sQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684353914; x=1686945914;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kz5492UKsw68NBdaP/BbI7o7f5Bu24HXiKp6SagfO1k=;
        b=KfGAx++bvP0hvKWo+UTRXFDB3xxBjF6CxbW/BAGx2k9O/df9zi2qhNzgloHGAR2qyD
         dL5Rjqnk9Ab7KXu0hE7BJaMvKwnZu5Uqt7IK53s0XVOzlthM5w4h1FLsju4l6hKDKiqp
         dWn+1JjExo+j24ztBYbkYI5JnJPv4Pt4vD7s54N9CXl/m6Z+dFiThMNdo6IEe1n/3K6e
         QiymvzCHVjIROinWYrEQp+ecaWg29Xi93/F7sdrKU/BqIj54yr00dCgcgRQf1W4sg//V
         A24j5odyNu4Wu+qobXcYb1Eq8gH8USOTbz4SQJ8yWzgRsUh7gLehNofPSMAfEX3Qc8UF
         /URQ==
X-Gm-Message-State: AC+VfDyUMrqG7nvejOO6kTlfjPXixofehdMAfiF8T7swwd4vIIOlcVw8
        RHWnm5AdcQKq3CzYJg23C+TrYiC575m6TEtFEK3bqg==
X-Google-Smtp-Source: ACHHUZ5tfHqgo4isCXzUeL3IZbTCRF1dN/7OzCrcyaW/5HzcGk8DvTVD2RA0cE8o7SHGdZtnvQOmmA==
X-Received: by 2002:a17:90a:5ac3:b0:250:dd3:dc8 with SMTP id n61-20020a17090a5ac300b002500dd30dc8mr65096pji.9.1684353914594;
        Wed, 17 May 2023 13:05:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id hi7-20020a17090b30c700b0024bcad691d4sm2029520pjb.14.2023.05.17.13.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:05:13 -0700 (PDT)
Message-ID: <64653379.170a0220.130f.40ce@mx.google.com>
Date:   Wed, 17 May 2023 13:05:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.4-rc1-5-g3ecb4a459a1e
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 5 runs,
 1 regressions (v6.4-rc1-5-g3ecb4a459a1e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-cpufreq: 5 runs, 1 regressions (v6.4-rc1-5-g3ecb4a=
459a1e)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-5-g3ecb4a459a1e/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-5-g3ecb4a459a1e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3ecb4a459a1eeab1ad135f87057aa3ea4c9af1b8 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465266b1da08b5ea92e864a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-5-g3ec=
b4a459a1e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6465266b1da0=
8b5ea92e864b
        failing since 211 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
