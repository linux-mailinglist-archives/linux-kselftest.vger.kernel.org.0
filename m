Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5AA695762
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 04:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjBNDYE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 22:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjBNDYD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 22:24:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4D15CA4
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 19:24:02 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o13so13869126pjg.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 19:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/vfndtrbnzfxWsIabmkYOblNw3EUhS7jwI2n5gEZjHI=;
        b=oVu+ESiNjBtAbddfBPMFLoitO2OHUUxb/n1WUudvmhqaTPngxNhmYESTAvCBzP8WMO
         6ffrobZMAC3VMB0wTLHJAwjZX6OJPE8STCgSg4sLX3PE/DCBsV7na9LEe2Y7l4/HroyD
         lL+LRJjKDUOMQfKZK1kbykl7vo9XpaRBPXciRu7qr2E4fZjt2TDr5gJwXSKoWE+/zCJb
         I0WCJRMsG11g+ng2XZqg44yehnT1damDgW2CKCFvRTTLykEszQ4ZJHLeDG7xs+NVIorq
         7h9Q6c0VZcKCALc6H2GynAgVFcErSuGU5LUVqrxvkL3h8pI3EZaxJioP+Cs3iIZ2JnqG
         +U7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vfndtrbnzfxWsIabmkYOblNw3EUhS7jwI2n5gEZjHI=;
        b=q8/x4rAjaPCcQErGq/w6R6oOxyD/zTtEXaOid2W2v5iVwHfiYPnTpL7RaOk9xqUxpc
         36vpXZ7lrH1bGzrloxeON8iHrYvs7IcDpCzxQO24dE5rTrOnvSlp8mp5gN+2tPlnolfW
         faZjLt3LlmBfnssuLFFHZDSnrkzMYJmTjJVzF619l6bVJUvfEm68Rl00sOwwJT4+uAP8
         t/P7bSrQTgo88actRe3I8l3llsSp9Ynfjlkyk70QvhivQqQm1he5YG2ihKho2MxwyVso
         Jh5epsjp4weC2Duj7CxK+e7seAPAQgu8nfaYyLDdml2hsFVa11MXaeuLmNtCl9t2ufkY
         ku2g==
X-Gm-Message-State: AO0yUKWBF4b5jkTP2uV6J0mHdpTMVxDs5zfsP+XgR9N8N68ZpOx3Ejh/
        z5kiqC9SPc9MbamEu55495Ik6DfoKIbblI3k6oE=
X-Google-Smtp-Source: AK7set80UTpiiO8mDFEochPHLwzLnE5igud0fPxrdeOj3s733EOHKz776iLnJPV+DNY8WO8V6/lXrg==
X-Received: by 2002:a17:90b:e0b:b0:233:e2f3:9d3e with SMTP id ge11-20020a17090b0e0b00b00233e2f39d3emr715096pjb.31.1676345041948;
        Mon, 13 Feb 2023 19:24:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t18-20020a63a612000000b0048988ed9e4bsm7796268pge.19.2023.02.13.19.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 19:24:01 -0800 (PST)
Message-ID: <63eafed1.630a0220.6a117.e4b4@mx.google.com>
Date:   Mon, 13 Feb 2023 19:24:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-39-gaca5a0944c30
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 4 runs,
 1 regressions (v6.2-rc5-39-gaca5a0944c30)
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

kselftest/next kselftest-cpufreq: 4 runs, 1 regressions (v6.2-rc5-39-gaca5a=
0944c30)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-39-gaca5a0944c30/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-39-gaca5a0944c30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      aca5a0944c309c56267b0c1d001aa999ddb2fb1e =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63eaf14ee953e276168c863e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-39-gac=
a5a0944c30/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63eaf14ee953=
e276168c863f
        failing since 119 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
