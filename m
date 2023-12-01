Return-Path: <linux-kselftest+bounces-959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53980800A8A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 13:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862001C209BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E7C24B3E;
	Fri,  1 Dec 2023 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Fm+ESFyx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5A51715
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Dec 2023 04:11:31 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cddb35ef8bso1933216b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Dec 2023 04:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701432690; x=1702037490; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D+PtnPyBdXmcDjhpzbyamtCXwObRGDDI5ak/mbN4R34=;
        b=Fm+ESFyxauPcVuKK/RDbRxNZLOwPaFamleEK4WfbM2qRHPH/shSPmOwnRliPVraPLJ
         4Ai9lSY9BfABrorPcbvEsE8GlddB7ElOW4DsTyUZC7wrsqlVnc8wC1FTm3xGRkHAAcg8
         pnsOqmwTCq/ieRwef9t51mJP1WjinWaql9n1YiGc/kJZ1XXPRPpgMpMVvZ9i5mOoC0uX
         MEFZwkU/dckAx+VqyTWyU0GPk6OKP9w+lSF2KztJvNI17pNgOtrq4yk1xJ5ov+G9Oq4G
         gVXrBF8VcHe0Ivdj46wo4VisHkPq5toFWaHTQ8piyN6YbKvFuFm3I3cfiK0aF0PsdjKE
         K7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432690; x=1702037490;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+PtnPyBdXmcDjhpzbyamtCXwObRGDDI5ak/mbN4R34=;
        b=Oi0lo2wzOJTIR5eeFSGu4XXmZIlimMMStiKiRqqAh5FqhtGs/nu0NAky2rqO2ttHbu
         XI1a3VkSTJkZ8VnCClcbLFVq1RAOX53dKlf6SssiY8F8M4OTIRw8wl4ZYd3H5ylKyD6C
         m1j6Ur0Pv1Fmc8qseDtUdg0CUxEc/JgUXfDWdoZ8DPCVh4WL6AXUO6CnkPfElW1X8rJf
         668PSHs76xbQKkXaDOuTWiEOxcsU0Q8Z9ZdQDyebkELP6CnefDQCPHqvFR5sS4mavFu0
         VE7TtiKp527sC/oH3rZcmjD8nbkC4c5I2NhaqxnEHhPaVY5PO9XxLP187FmlVfMX7CLY
         /PPA==
X-Gm-Message-State: AOJu0Yy5nSdLvayiyVyc2nKa2hoBJiBAlg0aO4Kqq/Wsq+s5bK9YA7w+
	dtfveax6xZvb8bFFq8YDzUjCi4KOH7zuM58ceXYrvg==
X-Google-Smtp-Source: AGHT+IHgV1QwVHtbPm9wG9qnNgoo5XopnguCzIu4o+8S1ZvbLefsKLxJw32CxzIi9SbnyCOHaJ4GBQ==
X-Received: by 2002:a05:6a00:302a:b0:6cd:ebc3:1146 with SMTP id ay42-20020a056a00302a00b006cdebc31146mr5504884pfb.2.1701432690640;
        Fri, 01 Dec 2023 04:11:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g2-20020a62e302000000b006cbb18865a7sm2849598pfh.154.2023.12.01.04.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:11:26 -0800 (PST)
Message-ID: <6569cd6e.620a0220.1b9a1.8d23@mx.google.com>
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
Subject: kselftest/next kselftest-seccomp: 4 runs,
 2 regressions (v6.7-rc1-9-g130a83879954a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 4 runs, 2 regressions (v6.7-rc1-9-g130a83=
879954a)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.7=
-rc1-9-g130a83879954a/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.7-rc1-9-g130a83879954a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      130a83879954a9fed35cf4474d223b4fcfd479fa =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65697135192e7ddd9c7e4a8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65697135192e=
7ddd9c7e4a8e
        failing since 409 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6569714d40de7dd8837e4a74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6569714d40de=
7dd8837e4a75
        failing since 409 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

