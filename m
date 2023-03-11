Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA2F6B5830
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 05:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCKEhm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 23:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCKEhk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 23:37:40 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E911F690
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 20:37:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h8so7704436plf.10
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 20:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678509457;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gEhGybZHEiMi3gxmtoPVbzwjxUYTR/OzuKB9bqKRzHA=;
        b=RAbMmLdYi64wEZuRuiYIBb1IWa9mDO9RipO3v13CpubPasX+5HXbOdiSEoCthG8nlZ
         SC41z2hYhJQjmFpneA28PrXIpTEE2YYA+6A70itrYCPahLfRPFcWTBKz57cPfbBaos3f
         /wVuxBvjZgq6Mh8r5QKXHxtyVis8Gp/yJOdQB98QQ+pOldhcw9SL8IMkSiFUBl7XD6rK
         Hxl7HnOmqR15KpLDtKJtjcYKHZo/VOYqc7e1TUwNJeOv1mihhGideGK6AM2seXWAZAYZ
         PsHUipu9ZJMywv2msuDDJuZKW2E6mLHIP2DzISSOCx+nYXP8zAjRR0rc2RRnTZ7CUGhx
         1A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678509457;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEhGybZHEiMi3gxmtoPVbzwjxUYTR/OzuKB9bqKRzHA=;
        b=okkDt4LiqO4mwg0ByR7DM8V5odBu4Uv3ldWDFX0QxjSPrG+AEAZVYnT08oRhy+uo0Z
         HXOBesgUkI6uHwvi/mp64INOmD18kcYklS/0Vm4BiDbJl6JP3uq9CRZIpfUGaFFyiXY/
         ZtIkC/FFTJAhQCFDCnf2InAjC5vSne5URxQfMasSjOSvcDnNwefFtMi7uyOJqhW1KwSq
         RJGfkIfJyVYxsAR4PP3WpqXHgzwi83A3+XWCGl4h+rLnVvZtARlPc7cO1QNfbtP0hj2h
         wyn+GLs92IgwuhOuDz+yKv/z2AppgaYkqrOC6RFK06A5gbFfdUY+hj2VQKscZ6pJ3gQR
         yLKw==
X-Gm-Message-State: AO0yUKUpJFtPKxk+19uoHR4u8N4bzD+saJCAaUi5kDCc71Gui2DIUCjp
        Y2lmyIwzheCGnMKISHn621T28A==
X-Google-Smtp-Source: AK7set+Mo29L0x1F64lwCI0/ipMkMm8+BTO7X/i9BdmURIXnyf9PGIRNh4NkBPo8cnkkfvtyl5cacQ==
X-Received: by 2002:a17:902:7891:b0:19a:a267:f16c with SMTP id q17-20020a170902789100b0019aa267f16cmr25518292pll.31.1678509457637;
        Fri, 10 Mar 2023 20:37:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bb12-20020a170902bc8c00b00199536fbc6fsm675758plb.280.2023.03.10.20.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 20:37:36 -0800 (PST)
Message-ID: <640c0590.170a0220.792c3.1cac@mx.google.com>
Date:   Fri, 10 Mar 2023 20:37:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-2-g624c60f326c6e
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lkdtm: 7 runs,
 3 regressions (v6.3-rc1-2-g624c60f326c6e)
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

kselftest/fixes kselftest-lkdtm: 7 runs, 3 regressions (v6.3-rc1-2-g624c60f=
326c6e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
3-rc1-2-g624c60f326c6e/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.3-rc1-2-g624c60f326c6e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      624c60f326c6e5a80b008e8a5c7feffe8c27dc72 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf56c4beda27a5f8c8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/640bf56c4beda2=
7a5f8c8645
        failing since 144 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf89b925234c9e38c8632

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/640bf89b925234=
c9e38c8633
        failing since 142 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf8a043d936b5788c8649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/640bf8a043d936=
b5788c864a
        failing since 142 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20
