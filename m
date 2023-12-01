Return-Path: <linux-kselftest+bounces-958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D7A800A89
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 13:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D9F1C20FD3
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F9124B32;
	Fri,  1 Dec 2023 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3cUlFP6B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8CD171C
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Dec 2023 04:11:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d05199f34dso3889365ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Dec 2023 04:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701432689; x=1702037489; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r0S6NvJHSbxI/BXYAiJYQHnanLVxTKSLkGdag7N6spQ=;
        b=3cUlFP6BHnrpwj73TbYLNL0zv4llje2pQLRX2B3z2lGkbVPGal4URnuHblsO5RArN4
         VpQ7SPRS8f6HFG/zfyBaThWv5/AjXlb/x3U9SdMzzG0Hi73yJsC+RXX9v+Gy43akNvDS
         x2zfsmfV3SgqHor02ePhsYJD6THca69bmCOt4YR7HuCjvSldd3RIbJt8G9sjl8TUK79x
         +zwshZjhid1ko5usqM4tT49K7lxxuepz44FWu8n0QG/p6AE/1r4pyaUiYJO72dFWbetG
         9M8ysAPmj6/BA/+vPgylzugt0bq/TENvCwlHehe9Q9yTuNynZbqDA/gWU9iH0b8fjnlG
         R5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432689; x=1702037489;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0S6NvJHSbxI/BXYAiJYQHnanLVxTKSLkGdag7N6spQ=;
        b=EnJVCdBu0fkRq1Lzn6y4tndXz0FeEjI6+3QOB11zwVp+fwiFT4AViPMzTsgdWJtS/7
         fYq5EqQIPuWAOWnVElT4PMokaZILzE3lR5u0UtiRPPCyeJ0Mc4wiVUKs8+kDtoBmhEP/
         FTwmiNMuNyz3/ZAgqajoLzaHdgscrM7jSlgflXK761cYEUE/lrzKlMjCopJwJ4gtM8ee
         mNUAkzs8fA/m799CpFqEHMjuAoeCoUEekI9zr7p/1ZlbcbW3wWsTLAJqqjQJwiqaUYa5
         Zqry8h7/xvMOpaQwRv3ULrgMCKztkY04Io/pnhycyJz634iTSrG0pAyIxbZ5+UI7MFnh
         IccQ==
X-Gm-Message-State: AOJu0Ywf0A4bTh14RuuSDtamyLRwYdQT39mwEbCH0zud3LETES+buVfK
	U/A/0AoBd/qJAcahmKk2lqaHwRr0NoGIQzEqf6aP0Q==
X-Google-Smtp-Source: AGHT+IGNHi4qEiM8UHY66f6sve04jvOoirJdmVVkEnwiMY1x0cQqVOgSKYQe8BpLE7DQVVcuxiN30w==
X-Received: by 2002:a17:902:ce84:b0:1cf:c4d3:6db1 with SMTP id f4-20020a170902ce8400b001cfc4d36db1mr20500356plg.8.1701432689305;
        Fri, 01 Dec 2023 04:11:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001c0cb2aa2easm3157425plg.121.2023.12.01.04.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:11:26 -0800 (PST)
Message-ID: <6569cd6e.170a0220.87388.98d1@mx.google.com>
Date: Fri, 01 Dec 2023 04:11:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.7-rc1-9-g130a83879954a
Subject: kselftest/next kselftest-lib: 2 runs,
 1 regressions (v6.7-rc1-9-g130a83879954a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 2 runs, 1 regressions (v6.7-rc1-9-g130a838799=
54a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.7=
-rc1-9-g130a83879954a/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.7-rc1-9-g130a83879954a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      130a83879954a9fed35cf4474d223b4fcfd479fa =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65697144fa466e500c7e4a83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65697144fa466e50=
0c7e4a84
        failing since 409 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

