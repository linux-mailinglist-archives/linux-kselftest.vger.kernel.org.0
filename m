Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBF4786595
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 04:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbjHXCzl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 22:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbjHXCzK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 22:55:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21528E4B
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 19:55:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc63ef9959so49109545ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692845707; x=1693450507;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qCrHQhkh8nqO8UgkRxywxPr/H+4hfuHYxYoAWDp+dCw=;
        b=O6bwL0Cv+Nad9hml8B+qUK2rzn4NjO0sm3jx5QT8ST22yO5PrlRzl32az5iUOtSooA
         cLQU84Cj1WMHSXVTpCdblIu8cH4N5OAXBXhE4xwLiT7aNr2R1k+P1C/CLrj2/5lunMw5
         /rsiLIs20WuGRXrlpQrUYMXhuxKyf+VzSYihv4iRKzgdAHlDklHpvQ1z/asDRLVTJUZ/
         VQJEa0jXhqDM6xVSc/WTyBCGFbxFUyremFMO9QSJ9DACSr1UK1iohS7ISkZ+14E1qhM4
         Yn9CXJ5bGtuTGrjf+SOljrl6GyilYRLxEZCFc9kXxUeX3yYVfOgjt0D2EV7nUTwgAsxD
         uDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692845707; x=1693450507;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCrHQhkh8nqO8UgkRxywxPr/H+4hfuHYxYoAWDp+dCw=;
        b=fUayii2Ak3nXy1EFuQdsrNSQ1x4KllIufyVebkF+mBNWfpMVVKyj8pnTOzthQ5YnHW
         Nhy3bsC19HRQWIzmadHGAzoXPXcHwJ4X5/bBUPbp3BTuGMxVdDtwAMHgpDCOGogZTbN0
         HuS2T8ml9/bKzM07Vkz/p/2FcGXSq8AIf/IUGa5OtSdovUSmFTW5gmwO9cCqWuJuzdIC
         yKsSwQVT11+6kUaUFa6XLsRyvqnzgBjKu9hCyTpn+pifVpRLF8MM3ZWsI8PNQKGTTOZk
         ePD4H85DhmRgmp/mFUkv41SrrUKsN3UfkKn+cVZETVDsiD7hzSv5jRj9Vw/Nf5SnIcKH
         XoKA==
X-Gm-Message-State: AOJu0Ywi2gzL4UwPY7Gp2WUJRWVYcZarsRmraGhUcgPNUui0LV0y+jTy
        aY0DAtTLV2WxD/N1Lh7n4WvXzzpRM9v2JzslvTk=
X-Google-Smtp-Source: AGHT+IHeeV4hvXJENVALf+iRf9qoiy4wkyb2x5Y4oEbDHcgL6UkLTf0PHi7MRm6Y6qsCmPzz9fZjQQ==
X-Received: by 2002:a17:903:234e:b0:1bd:aeb3:9504 with SMTP id c14-20020a170903234e00b001bdaeb39504mr17311463plh.15.1692845707622;
        Wed, 23 Aug 2023 19:55:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902b40200b001bc68602e54sm11544722plr.142.2023.08.23.19.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 19:55:07 -0700 (PDT)
Message-ID: <64e6c68b.170a0220.b664b.6870@mx.google.com>
Date:   Wed, 23 Aug 2023 19:55:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc3-32-g9b1db732866b
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (v6.5-rc3-32-g9b1db732866b)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.5-rc3-32-g9b1db=
732866b)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.5=
-rc3-32-g9b1db732866b/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.5-rc3-32-g9b1db732866b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      9b1db732866bee060b9bca9493e5ebf5e8874c48 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd560fd1781e463035b1e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.5-rc3-32-g9b=
1db732866b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.5-rc3-32-g9b=
1db732866b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64dd560fd178=
1e463035b1e4
        failing since 303 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20
