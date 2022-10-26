Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66560DB7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 08:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiJZGmJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 02:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiJZGmI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 02:42:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB86A7ABF
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 23:42:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ez6so13172597pjb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 23:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Na30G+N6LVQGntcKv24wTGhoAKN6H35Xq8E9Ef/nVE=;
        b=xCDitSZzpdNRLtXwzXRLboXVBwabPAfVQ4Bub/whVagrPSDOqnn1qh3r6Z9KzXWhk7
         J5n4mDKUk+XHGNT1vdXaMKcTgqVkHJO9sW6x//yLklwmzI/CyJ79Y+qg50XGpDj6gp3A
         NAC2/iauDvsj0tz912l379RWdCOG9MJzquQ/rezbjKdd1vTEZ++P1yQ7MohXL+ZiNyaK
         8MJNux09mwQ4pZnnIRXvaKapuDPKaUTRpETYqWtN61NnZDNGsdVUKXnV9jUF0K34g0ax
         txvvgC2eMFOMGjB8haRBvKlfarFWautjRT0VdqNDIv0kNyHeOrTI9LYop2NifLUljEqI
         TCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Na30G+N6LVQGntcKv24wTGhoAKN6H35Xq8E9Ef/nVE=;
        b=mwIT2waIkUFuo5GFDq0c4X6on/+AiD1XMMB8Oy+C9EkhOkDC1haBz6/abNLf9Lnhl+
         rIbv1GrnCu1xhUWuYxFLo5eYfBWMm7bcGDdV0L6mxVikUQsjskS9wDJLnDMTtMV2/NoH
         UIPFebWiqmPH0ZsY7/S6Z232AJgs//zEpRXyzT+B+e2iLn/mfMxVEOwuhLGkfN9DGz87
         cCwAP8wMziEfCLF5hpm65KObsyZdjaqPhXGfg+CDxzm8HpqySxyXs+l65q+9ycAnDzGJ
         rrjrM+fiA6MwyhJIFoDuVKR1LoHQKoL3T0gr0yLdj3yu3Co3iFkZqqCBcAs6K44MprLY
         pT4Q==
X-Gm-Message-State: ACrzQf3ICmqKjKsJx8kw5ejiO8Z822vxGPngIyuN85sSmSl/OG0L3BJo
        t8Xm1wfvodipEu3vqn8vkrgF7xICvTRNkaL9
X-Google-Smtp-Source: AMsMyM6o97G8/A+jXsgyakY9k8VEVG5F6JxO0V+C5qFidSKM3R5Ln0T5/JZUzeMXvAkwSPVcBvT5Yg==
X-Received: by 2002:a17:902:9308:b0:182:b2ba:755 with SMTP id bc8-20020a170902930800b00182b2ba0755mr42700935plb.107.1666766526580;
        Tue, 25 Oct 2022 23:42:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n14-20020a170903110e00b00180cf894b67sm2208445plh.130.2022.10.25.23.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 23:42:06 -0700 (PDT)
Message-ID: <6358d6be.170a0220.e73ce.4c1a@mx.google.com>
Date:   Tue, 25 Oct 2022 23:42:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-5-gec7b4511185b
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 1 runs,
 1 regressions (v6.1-rc1-5-gec7b4511185b)
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

kselftest/next kselftest-cpufreq: 1 runs, 1 regressions (v6.1-rc1-5-gec7b45=
11185b)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-5-gec7b4511185b/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-5-gec7b4511185b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ec7b4511185bba95fc702c33a388582c8842d454 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6358cb03d3a9368a545e5b62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6358cb03d3a9=
368a545e5b63
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
