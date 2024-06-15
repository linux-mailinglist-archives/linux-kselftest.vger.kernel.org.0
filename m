Return-Path: <linux-kselftest+bounces-12002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CF790961E
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 07:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC2E1C214BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 05:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99410979;
	Sat, 15 Jun 2024 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="fb5OS+gs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74D1078F
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Jun 2024 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718429030; cv=none; b=VzBTJKruAihV1en6/oRd2Ir/lu02+TxnUH1+yX7jEqtPV0pSWfdJjxqb8H+FQZYigs1+8Tbw9V/hE+b1nd976tl1EXDtyKnrxnSK0buVkob8kyF5FLH0Id2O6tvEzX2ZR1sw5LgJ8fF5mYipKSSLUdAWk9zYPOsYHITy/ZWS3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718429030; c=relaxed/simple;
	bh=ptVpEBeB0m1Tb07xrpHA9/tqjXnwpzB2lBqwQ/r1qLA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=PlVbdooVize/2kTC37iJHuZBWQB3M539m7NsliprbxP8RIDFsK1H18bwNGGdGUv9UJe82fzV/dxYPomn6GtCrV6sRLGxaXrkfBLQz6FX3sNebCX3+jfGI7pS+bbcWH4KoZOYx+levRR/CND6kgtWnw6fSfpJkDr4qwd96hE8EqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=fb5OS+gs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6bfd4b88608so2036381a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 22:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718429029; x=1719033829; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qLvfHaF/5QojDjswE5VMRi3pZQVbjAYAjozU2hQu1VA=;
        b=fb5OS+gsLnB/zngdMmOffgQ5zaXmxit39AfvVjqGZnma57JtAgz/ZRTVYTZpH4oixS
         F+rghmGghooT0YL0onAZc5PDuFhcS+KYQ8vFULln9TEP1PqC0+I81KwfIWKU4q//O4ge
         TfJs5HuhkbndKwEGSUGV/E973MrFpVdH98bBHPKJUvGrRhhNX9uKWtTjQ5vMJy+dp4Uv
         pMoxU/4MrK/tb4WrJhm9fPg4HGWUfdzCK86areo9VCFEBo/8w03OkT0nQPU10l0QkZHI
         XwLOD1uetaR2qSirYwXjN+BFJHYFLyrhtSFiI0UvAaxjDikvvA0W/GHavG9HZn03v13Q
         vQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718429029; x=1719033829;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLvfHaF/5QojDjswE5VMRi3pZQVbjAYAjozU2hQu1VA=;
        b=NceXSeHVUOpDaAcC4cGATD6THGusF/YkhbbfxmY6CAfjSAlcieU9U5LND7Ai085Gcn
         O2PGZZmbH576av8hyTOln1dUmTP/xu/r3EsX1Zyhl/DBNyEoi3jqUEwxgHSitBqh2bIw
         b8fzEBIHtBbfsM7g1ZaqpWr4rzpidn6WfLQ0DfIAIG5u9oxc1sV2ie7UICqfltHCZ77U
         dRiogvdcD0qv3BBp/vZ5t92V3nLgjLUjctmfcePn0PU9r0TrZUMzxdjALJHeIKgYFKaf
         6VE/wCatyFRYdtO5nR6I6M5w8IX/SciOfAnLOuYUpItirukT1XHrGhYZathWPaUMJl6D
         FJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjUnlHYQ8DkfimwCVEs1ofCi2oShRySfTI+21PZBjmK/0Yt+yKEc54k+wN//8F/rL1Zf6YrEhfCcHwJZCMETPnr28RDOiPu194eEfvnwA4
X-Gm-Message-State: AOJu0YxgsYMXj4ynF3hWOexQHt7EZcqWsdV0f2SGqKadkKMeqvtHEKxN
	bg7pVbzL1TOEQFVRCVPUcRQkwPg42NO5+ejPSl5C9HmeNAK5nJoAai2om+TAyOJsCMsAzA8Kgyj
	J
X-Google-Smtp-Source: AGHT+IFrYO+aSFo6q9IPF6fXTccHXRTC10hzhbUiCcGL5WU49sOVRdZtWKKgXOzFbq0JJOBEWG4ArQ==
X-Received: by 2002:a05:6a20:3d82:b0:1af:4faf:e4a8 with SMTP id adf61e73a8af0-1bae7f0f0e7mr5034511637.33.1718429028613;
        Fri, 14 Jun 2024 22:23:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c467c6besm4924481a91.52.2024.06.14.22.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 22:23:46 -0700 (PDT)
Message-ID: <666d2562.170a0220.1856.fc53@mx.google.com>
Date: Fri, 14 Jun 2024 22:23:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-2-g64f5bc57b24e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 5 runs,
 5 regressions (v6.10-rc1-2-g64f5bc57b24e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 5 runs, 5 regressions (v6.10-rc1-2-g64f5b=
c57b24e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 2          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 3          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-2-g64f5bc57b24e/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-2-g64f5bc57b24e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      64f5bc57b24e8c7935d51732571d405acfcf4b99 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/666902b8b345dd39097e7147

  Results:     105 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/666902b8b345dd39097e7149
        new failure (last pass: v6.10-rc1) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/666902b8b345dd39097e714e
        new failure (last pass: v6.10-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/666906510673daf6a77e706d

  Results:     101 PASS, 3 FAIL, 3 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/666906510673daf6a77e706f
        new failure (last pass: v6.10-rc1) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_1_bitmapped_2_bitmapped: ht=
tps://kernelci.org/test/case/id/666906510673daf6a77e7073
        new failure (last pass: v6.10-rc1) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/666906510673daf6a77e7074
        new failure (last pass: v6.10-rc1) =

 =20

