Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523BC7233E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 02:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjFFAC4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 20:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFFAC4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 20:02:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED782F4
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 17:02:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-653bed78635so2305487b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 17:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686009774; x=1688601774;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3txAL4tUz33rSMCI2yQVPOCizPf3fNc/lfq9ABYQ9M4=;
        b=VqgPpF2n5C2EyQiNrrPjHfSwDev3Wh9h75zAZEn/MFZltOS1a+Fe5fNPSKoPGF7drJ
         7B6VzqYLi9mg5NjjUwcIFPTgRqW/ZIKsuxCytI8kPfvTBVC0d39FXZV0lML2JKG6chkW
         PKP3tlFuaaEjueDE6xEy2ia7/X7KKv9FUBo3kZ9jZlM3WlLtFsWwrRxmYTMOU8JC6K/q
         TeKCzM2PoGgXJag1hVnVnSfkhoM/A4CRo1FonI+wmmWEID8cptZO/T77tat2ODCfI5N2
         bF4PCjhwmEee1eWYyvQc4u09oAQj7TlDw6ayiANWNoFgKJd8SwX9oxyo+gcyAMoOZbeZ
         iKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009774; x=1688601774;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3txAL4tUz33rSMCI2yQVPOCizPf3fNc/lfq9ABYQ9M4=;
        b=C7Li3g01SUK0Li15PAia6QhMpRQ2ndjfSXww3L24Gm8UYBQiZxrORZcOPAm036PvIS
         nfyxl3USCU4fVdS7r86IpEvHHDZyNZ+dJdnEZ9316WjEX82zlUhEvBJEnTvwhlP9dyGI
         kO0gylN6GC2yKTdtsDvc1x6BmfjFGnBwT/7n0/tyVWJTiwUG3p889ewz4LuiJyhC6bHz
         PViVJMQM+eZKfZta87pcWZbtuX+k3Vh/1mFi6CFEJ6WzMubbSPJ5zAkL3CeifqoVviJp
         qHCxb5DYe8pTGQ7zgrGjKblCQ5640dVlHxNJhRQdgBfnCaW5QS97HLfnp3yT4FZ1pv3X
         i7xg==
X-Gm-Message-State: AC+VfDyQHAf05paXn33aVYfqFgEQiKC1QRUm/rVn5vE6sjuuKHNroBst
        6cgqgvPs0Fn64R2NvKCL1KRNIjBoasanCpIGsBf8dw==
X-Google-Smtp-Source: ACHHUZ6JV5yWPvGG+TUzf1W44u/FOwb+mfm1xsZHZWqdxQorhrWAxwk6l/+JHzbsDXMpAeZ2TzjCgw==
X-Received: by 2002:a17:902:c949:b0:1b0:3d03:4179 with SMTP id i9-20020a170902c94900b001b03d034179mr568139pla.6.1686009774422;
        Mon, 05 Jun 2023 17:02:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001ae7fad1598sm7124599plk.29.2023.06.05.17.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:02:53 -0700 (PDT)
Message-ID: <647e77ad.170a0220.acb11.d7d7@mx.google.com>
Date:   Mon, 05 Jun 2023 17:02:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-9-g4d1deb59f3ff
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 5 runs,
 1 regressions (v6.4-rc1-9-g4d1deb59f3ff)
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

kselftest/next kselftest-cpufreq: 5 runs, 1 regressions (v6.4-rc1-9-g4d1deb=
59f3ff)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-9-g4d1deb59f3ff/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-9-g4d1deb59f3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4d1deb59f3ff643bd2d442bdd4dd5f58515a1629 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e6c448567b355bcf5de52

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-g4d1=
deb59f3ff/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/647e6c448567=
b355bcf5de53
        failing since 231 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
