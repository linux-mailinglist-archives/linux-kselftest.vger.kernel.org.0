Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DFA63D6E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 14:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiK3NjE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 08:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiK3Nit (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 08:38:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8794773B83
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:38:32 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o12so7875761pjo.4
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KHZc/c4zAba4oep6LvsNgvscUR+W20M8agPDm1s9iOk=;
        b=IFMgMgwP5NWAx+K7G6qOKCgiI/c8kKVdzzqnUHtlJpwN2w9uIcE9SjKQ/xPFAre1Dn
         A/z8iYUoIWbve4WcSoR6z8n9t+9+QBo3uhc1WFCyvJx8XAVWa48SrPQoUJ0d73bjW2gv
         yPVHhbpZyz2wL9TbKTiEzB4iMOBJem3bz9m5rzK4ea8MohgUYwTNwKH/tgCbDvjA+C9W
         kGJX5wQV2IpGqqfArzdlxBzf9GGb6snm9IqBI0rgMlYloif9MXhizCI+SBMar4/iZq2M
         b0WMN8yTP/8ZmUn9yU/ck7b/xiCU+bZuKHlMDxPaTUxEMBo8/NiaWPCMvQI6t6cAqVZR
         GYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHZc/c4zAba4oep6LvsNgvscUR+W20M8agPDm1s9iOk=;
        b=vN5Vbk+W7hyCPLkMa/kDpKtWNhAV9qmsHeiY8lDDIK8ILkLDx/IMera6Yeu0dvJaSd
         jafOZDbMebzB01fVnleCM61jZk/CyFsL33BOj5p1S9sG3/8d029Mp06cBJj+AyEyfFRf
         QECQ+Bnr/UT8HUMI/x8jJTe1+pYMgQn7f9r6ZvrMiQ6CYlhx+8dWktGIApJk2oYW7i3E
         sgc6dhuCUHDB8eVhi2TYHSRLi4ZspJ/FDZV/4HL34N3+DSGUk8CVHCVOlisZ/gZhezeF
         +t/qMyjaVO6KRMB72qLWe2zsxPHKwxrudX+nkBpa5EjceolwfYg2+TWPWtUSYXIdXtEd
         8R0w==
X-Gm-Message-State: ANoB5pksCdr7mLRT6pTRv3kSZHQXGGFUkP9pln2i+FECdHsv7io33ee7
        k2wet/e7x+qs+s+ALaNES4OD0f4kKENoLaEjs8U=
X-Google-Smtp-Source: AA0mqf6uQw/7Sm8x2PyyT0UFHbxQxedNX2KoPV3V/oqOEa4NRv168QwB7Ek7UN29ATk2wYiZ8WF4UQ==
X-Received: by 2002:a17:902:f70c:b0:189:bee:65ee with SMTP id h12-20020a170902f70c00b001890bee65eemr43542544plo.107.1669815512080;
        Wed, 30 Nov 2022 05:38:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b00174c0dd29f0sm1485623ple.144.2022.11.30.05.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:38:31 -0800 (PST)
Message-ID: <63875cd7.170a0220.1ccd7.20d6@mx.google.com>
Date:   Wed, 30 Nov 2022 05:38:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g8008d88e6d16
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 1 runs,
 1 regressions (v6.1-rc1-23-g8008d88e6d16)
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

kselftest/next kselftest-cpufreq: 1 runs, 1 regressions (v6.1-rc1-23-g8008d=
88e6d16)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-23-g8008d88e6d16/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-23-g8008d88e6d16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      8008d88e6d160c4e73de5be7c3dcc54e3ccccf49 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6387504e08ab4e6dd52abd11

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6387504e08ab=
4e6dd52abd12
        failing since 43 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
