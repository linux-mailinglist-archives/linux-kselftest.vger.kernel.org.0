Return-Path: <linux-kselftest+bounces-64-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76837EA8CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 03:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61E2280FEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 02:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5D17D1;
	Tue, 14 Nov 2023 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pSUh1CRS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ABD187E
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Nov 2023 02:48:22 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA10D52
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Nov 2023 18:48:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c18a3387f5so1036541a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Nov 2023 18:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699930101; x=1700534901; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HLiSmxPS6EZsbksBBka43/S1m6Shsr/ROEVW3ewSYaI=;
        b=pSUh1CRSq0N61kQ12pckiGkM+YJ5fhTbcpxK938sQigmBii0ail4dXXl4ChviCbLtL
         lyajs3rmW0UdYvooaAEmkUyUbExYFCsNbaP2ASls1lAL6xZKeuYItksuxAgGPqPrE8X9
         SzQR1j7VvefcK944VvOgk1OJFq25ZKiyJpMruRX3fvEmJ9M3oz8FKgoLKVqKgRcBwz9m
         i0YHd5VU1gxz0WDX54cSjk6Hg0YFcbdSKYlYFbqSFCGPVgaEPOQWfB9rC/l2mm51c026
         3Ze1gzPYTtDrF3AqaszyDF1C/76sqawD9Ms7QMcZbHVpvQ3BxIEK8lQV6RgYspQqZONW
         Q6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699930101; x=1700534901;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLiSmxPS6EZsbksBBka43/S1m6Shsr/ROEVW3ewSYaI=;
        b=YkARh0sMELkeRaX8x5IDfsCNFs2kx1kC5pt1tAZgUl1h4a7hw8Iqpc+T32HERNePyw
         nqfMTeFPbLlupM7sJf09MqNNDGBhk9lquLdjp1vGaQaVxqSJTWXACDGZ2tIIvTkeExtf
         SeAqZR/TgJ+AKRe8OKkc6SQ4N+vhjTeizkwIeZz1EeDyVROgk6A2weMah2TmoWMv6Z2v
         XBQ1N0e/xfci0kxwKx8IOHf7ERzosrriTBgTCJSiXaj9+ddZ9nnDYvJwrxPTOar+EXmW
         RvLOyqmV4mIdn9ISgyinYsyuLYMdldvUUhdbS1NmUzbMhK1XAAOCrF4ruwMVbd+6SNxu
         5Egw==
X-Gm-Message-State: AOJu0YwGlO+Lcd/kv+FLK0ZlLPZ9helov1DRaVqyKAN6NMpp8C9u3SJp
	Y8CPoEB2kqVd0CnoQ29H9VFfkQ==
X-Google-Smtp-Source: AGHT+IGKEHiTrPkKiT845oIF76lLFdnbqPOocdDprLmiN8Sj0dEfozT1rSLznl+DLdS9HNb34kgqpA==
X-Received: by 2002:a05:6a20:8421:b0:140:6979:295d with SMTP id c33-20020a056a20842100b001406979295dmr7398022pzd.2.1699930100605;
        Mon, 13 Nov 2023 18:48:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bj8-20020a170902850800b001cc79f3c60csm4660735plb.31.2023.11.13.18.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 18:48:20 -0800 (PST)
Message-ID: <6552dff4.170a0220.2776e.acc3@mx.google.com>
Date: Mon, 13 Nov 2023 18:48:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.7-rc1
Subject: kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.7-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.7-rc1)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.7=
-rc1/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.7-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b85ea95d086471afb4ad062012a4d73cd328fa86 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6552d8e2f99dd3968f7e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.7-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.7-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6552d8e2f99dd3=
968f7e4a6e
        failing since 348 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =20

