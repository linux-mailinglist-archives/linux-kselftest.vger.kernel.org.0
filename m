Return-Path: <linux-kselftest+bounces-18698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD2198B0AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 01:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E151F226B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 23:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACFB18756E;
	Mon, 30 Sep 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="D2VWHW/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BE5183CA4
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738091; cv=none; b=oNR5pNcvp6ovX43qMJzWWSyUzx3P6Fr27uXHcdoYXiAbfvF77pEJe1jPOvmhKzJVfmEcf/RBEdL8Oko4t/PtQip4wosuDRilhDBcnV2cr0xA9ifdCyg8c7UieOPfI7MFGDfhzhahKlYvLCoVBXst5z/YH3EZ3sOwpPMrRN7jTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738091; c=relaxed/simple;
	bh=BqH2tIEoqCv/x4KrvJbdKi0wX8BWB/VMpOtOEVVAOTg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=GoyQcVR1lMOhI3dfXwohHJofZSoNiA2y9IQXc3/rC1XKRs5BlwdLlXWxSf3dTBD8VW3er+ZdBVqw1MhJBmkPrJ06wgmRsYRUgpx3NmaMyT+PLDxVPgIBgxuTZSj24zlCjwKa+1tHEHv4BCBPl5lWHvjDF+1L6UhboDued8uYdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=D2VWHW/E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b5affde14so19346535ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 16:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727738090; x=1728342890; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0+sINHuX4fsVzN5f7d1LZztkC7qmCq5n1AKt251J7tk=;
        b=D2VWHW/EsvrvpiyLGE0x1j1b3CzyLorG7xBatJVtSYImgJcat1g0fyg/w7MVwbHzGa
         3/M0Er/+1y9WI21PWAIQ2tBfFsLfNPEJSkDgW9rd+OvtZxmL6YRaf/DBpQBOx8VySpFC
         HncryYwG6o882TNHnxhSsUOur8Vvz9I81kmgClfnENC5hGnTreRj7aRa8xCGnY/PgIua
         JmygqbImt+747UKUuENPfKwlf5xvZsRra05A7GdHkaAIfT3EtKmT3LSTD76mjfSJt5rn
         GlHutL/KtPGIqOUUrMw+/nP57+qZiqI9T0sdiaA+eAe6Ls2EvcFF/QUR/MuN68ZGk30e
         rKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738090; x=1728342890;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+sINHuX4fsVzN5f7d1LZztkC7qmCq5n1AKt251J7tk=;
        b=TA63zscAcvVFdZ8oM91zM4taUtuEGsRZLs6DIxWo1N+nrVwCId+h9QLdljTGhvK6x3
         M3O92JJciMuTd8pZhXQeLPYFeglnn6/pASru2l7SFeYgPTT0gSws+NuX4+XzrHCqzbCg
         Yw+iaPMPo2zmWOCxIRjQs1I1l3hCdCRxl49lBv8QMHAPPwzgKnlacahjO1pOqaPZ/rY+
         qEBvt6TU1oJ+BSIoxIBi2l/AASWBZAe+lg48cCGGV3MYRzsqbOfFhZ/5/mvEpE20fdD8
         2/nqFrg4l7p+kgzGFx7qMXKfm0QUrDpiuurem0XBRPLRi0klrV/rPg4R+u0zEA8R4/ag
         xgXg==
X-Forwarded-Encrypted: i=1; AJvYcCUy0uE7U6fruRN3ueE3tfORT3ai3U34tiGTxqmx/BZ0U8ozzNAE4e70zmuDrHxOoV2ZnuQ9/khfFJTltZucR8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YziF8bSPE1PGGMSH0gRTxEqL05Ixc9m9lzF5CbHg1QIcsvUBcx0
	GU3C+Ta9JuiFkM6T58eQuFTzqmLifxsj3xxgx2l/8qb9U9RmmZF6eGzxHCO9AnE=
X-Google-Smtp-Source: AGHT+IEAM9D9q9DjL9qFUMEfHrwiVevJD/3l/UVyDZ8SxHXSCtCJy1Bt3un+fQ3wr5MDGy4XzSO7IQ==
X-Received: by 2002:a17:90a:a897:b0:2d6:1c0f:fea6 with SMTP id 98e67ed59e1d1-2e0b89cf900mr16062876a91.11.1727738089750;
        Mon, 30 Sep 2024 16:14:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e123e454dasm3315429a91.48.2024.09.30.16.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:14:49 -0700 (PDT)
Message-ID: <66fb30e9.170a0220.4ef5d.d6b9@mx.google.com>
Date: Mon, 30 Sep 2024 16:14:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.12-rc1-2-g010b07d11e25
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 1 runs,
 1 regressions (v6.12-rc1-2-g010b07d11e25)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 1 runs, 1 regressions (v6.12-rc1-2-g010b07d11=
e25)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
2-rc1-2-g010b07d11e25/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.12-rc1-2-g010b07d11e25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      010b07d11e259e37d2cd5579b8f2b189342ececb =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66fb2e194be58978c4c86857

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.12-rc1-2-g01=
0b07d11e25/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-li=
b-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.12-rc1-2-g01=
0b07d11e25/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-li=
b-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/66fb2e194be58978=
c4c86858
        failing since 62 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

