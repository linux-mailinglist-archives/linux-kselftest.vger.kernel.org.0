Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A069260F7F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiJ0Mtn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 08:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiJ0Mtc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 08:49:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D627B2C4
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 05:49:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso1366774pjc.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 05:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=95x41vOfUpoqmR1gjpdwmzH9fRuoM45PA0hBCnah+gg=;
        b=7Q2vtj+NKMLU8Cb6Xi2Y8oTCDYpWhjj4i4HbcOAKTGETFZ2NupToFuPwy5KwlqWY6x
         8WHT83HAmktQjZEHWg8xzznh8oxYioMOfGziNeit/mdl5kO5JTGdkdu+cMaPEC0g8T0S
         8vUjVLztgMVUOtJO4sn0n4Ayc78XlUMhtrn9dblLBNOYxRhydKcDOc1OCJEJPA6/sQ0S
         QF6PqlHDS6NogwScRkP4mQp6nH7hYOPf5ERO8Epg8d8OJOogBr8iUpm+i23W4OHRspAQ
         O+wBlxtpF36k2LdoDQsVhgFG4XhDedHhsoxaPVBc8SAQXS6km+XdGUAzNwZm4GSbUWN/
         rFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95x41vOfUpoqmR1gjpdwmzH9fRuoM45PA0hBCnah+gg=;
        b=bGBYvYRI1//8aF2OdeuqDEUU/l0lalluMRpGh0tRx4vucdXmppULQo6qOsq7eGkk2X
         HtAykbE2s3Mg0+DV0SBFvP6X2/ZC7ZnT1w1Uz4/7blUsepgveVJsR1hgrF9vHBaWsoRu
         Yy3ICd0QUYg7CN0fxvqYfj/TZ5iaWKnPUY2ZcQkdZ2CbfipT/n9XBGWPwMkI9kooqJTX
         Us9hd9uW9LmgrWdn5L+lVyxjBs/kgOIVRYiKV/8ak9OhpN8NfZx4Zv8Ee5fKsVFlGfc6
         bqVseCMN0CUwpd2ikVcd0JzDGHwFFziQdRLZ4g0KkE3RrsciIQyqYxL4Va4bqlgwqpfu
         FSlw==
X-Gm-Message-State: ACrzQf1jfQTJFsVzSVUqY4LCiuBsWAmwlsz4mSHpHxWxCA7aVi5jbYPN
        eo+2JcEuhxZHS1pN4xR/HedURJUbuWIZgHdm
X-Google-Smtp-Source: AMsMyM4l5213qIB6DbSWgJvxekuI5/cQ7yfrgg/eutBkjOGeakhTzM7ms4E6wiBhnjxRWnQ8qJC1wg==
X-Received: by 2002:a17:90b:1c8b:b0:203:dcf1:128a with SMTP id oo11-20020a17090b1c8b00b00203dcf1128amr9732270pjb.182.1666874966415;
        Thu, 27 Oct 2022 05:49:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b00186c54188b4sm1100583plk.240.2022.10.27.05.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:49:25 -0700 (PDT)
Message-ID: <635a7e55.170a0220.e5581.1b6a@mx.google.com>
Date:   Thu, 27 Oct 2022 05:49:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-6-gecc7d67af402
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 3 runs,
 2 regressions (v6.1-rc1-6-gecc7d67af402)
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

kselftest/next kselftest-livepatch: 3 runs, 2 regressions (v6.1-rc1-6-gecc7=
d67af402)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-6-gecc7d67af402/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-6-gecc7d67af402
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ecc7d67af402dda4b4d353dfa9837339319c9d4d =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635a70f4e7af9f1d58e7db78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/635a70f4e7=
af9f1d58e7db79
        failing since 9 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635a70c9387659e487e7db6b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-6-gecc=
7d67af402/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/635a70c938=
7659e487e7db6c
        failing since 9 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20
