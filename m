Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA063D6EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 14:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiK3NjG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 08:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiK3Nit (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 08:38:49 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E230F75
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:38:34 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 6so16056654pgm.6
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BfmF4B65p5UuhAQhHJ7HmdACdSjTQn/LxEMPbxk5ETQ=;
        b=BTXjWofD0zto1dCXIc3gmZZacjM3eck82qRhDh66Yi3SgKOcRI9kWaqed1vNabJg9x
         gNmrz5UIAqTX3DK0NX0j02h3q1KSkqTPufsNo7vET+O7GY5PEcVV/Ul+O55xk3W9xki5
         IC95huhaXabCh2ce0dLk/32o1IhYcS+o5tJYgEvtI/vebmcBNlnFiaWAu5KoB0q9TlT8
         3pw8/0NktBN9H63uSpDPubiB+xEz5ujtvim5pe6NUI0DUIqEAQVed3o8ratoVpgXhwZV
         2mRbkSN/QhTZrvPvEWT2yYuBaegWLJXTdqWi7sMMkLHPVQ6y/XjRflLI+02g8XPg7GTi
         J4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfmF4B65p5UuhAQhHJ7HmdACdSjTQn/LxEMPbxk5ETQ=;
        b=aT/q5k1KT3XARBAsiKYoHH7KfZP2xZIdzcH9DbU0lPS0xeErt/cEghgKCI3JNp+1hx
         l6jPVKO41wmH+6IuuM+oTMoY8v5hb0dpl1n6IcN4YgJrJ73q9Z136zUWFK7Ogu8qNYUb
         VeSF0NyLNekWHjTKBkktb14FDTGNXvG4n94ZaChFZ09J1PpYPSiFDJSZLvXNv2pNfoPm
         Yj3QEDE4EEAuQbDtPBuy2kEoNQV3tz6sXpqj7LsU3IYOvWffpK9HTPcDXCcmchWeu0ks
         F0TWXH2x5LLk4rGvvhx3jVF3avtsIQj2VSuRUk2+y6LGU7DJfyQvvD8X49YGsr3YYlM8
         CQFQ==
X-Gm-Message-State: ANoB5pmcSExwGCPQG0Y0BnLvIkzUWqiBRN142ggig1aNd3aoDvziKVkp
        EBePmE7E0rZZdJ0t+WB9jGDTVtwJu61FRczpYNI=
X-Google-Smtp-Source: AA0mqf7Ct3l7Zo/W9pRQchSA6x+DLz0mqjoKS8u/BywcPFeNjIBWLzi/ZVgeQ0efjjSveu0ZZZ0pNg==
X-Received: by 2002:a63:110d:0:b0:46f:6225:c2f9 with SMTP id g13-20020a63110d000000b0046f6225c2f9mr54530432pgl.225.1669815513578;
        Wed, 30 Nov 2022 05:38:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b2-20020a62a102000000b005745635c5b5sm1386643pff.183.2022.11.30.05.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:38:33 -0800 (PST)
Message-ID: <63875cd9.620a0220.9e91a.2314@mx.google.com>
Date:   Wed, 30 Nov 2022 05:38:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g8008d88e6d16
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 2 runs,
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

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.1-rc1-23-g800=
8d88e6d16)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-23-g8008d88e6d16/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
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


  Details:     https://kernelci.org/test/plan/id/6387504e9b8d4fdce72abd27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.6)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g80=
08d88e6d16/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221125.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6387504e9b=
8d4fdce72abd28
        failing since 43 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20
