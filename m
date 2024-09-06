Return-Path: <linux-kselftest+bounces-17431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA2196FE41
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 00:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D93C1C2143F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 22:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075F915ADA4;
	Fri,  6 Sep 2024 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="nbKBpBN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE69155A59
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663576; cv=none; b=i2LXak/Wq8NiUyJmZpR+DrLV4z3Jh8w+oByBGn03iJCXb+WZ6ZVzX9/crQcpEFk4bJG7YxSU8vMXdsBF734/4jR/8o+mRIYn4+tO0Q8gterBtcqsNinyDQBk/3uoDnBh9KHNUA1v8gRDdV3j8fAI+ANsEmRskr9alV5ZXzDO+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663576; c=relaxed/simple;
	bh=mn7b5762UTNZWCfAe9OIhRYz492v5UVp1qs8Ck0GC4M=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=il3xKI5gC1AryUUFgilDVGGrbo8gHb7jz70RKtkBUZIGF9UsCsmskKQvQO6U2ULhwwbBz5MYx2mgH5pRN9qIIRNQc3pCDoYIHHZVhNzrfTgAbgqBj2BksIPY6UBLfRolKW43/xvke9qc+/B0B+UQSPVrkDuYpmKaO0mYobNb0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=nbKBpBN8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2053616fa36so27488435ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 15:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725663574; x=1726268374; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B+1qQxIcJIkwDCKsBWYGATjTqgjdyvqBMaR7fO8toII=;
        b=nbKBpBN8yDa4RLDLC/7IUWC1WdMvs93+hOpOBZun7AJc9/zSy/cdyDdkirtTm+gX/U
         M6ESTfO63qSQkCOa/NAc0ScdezNxpQa47WPNfURcxw0KZW/qCGMU9b4OJB4qJhKAj0rx
         Lj3Mh+gnT6TNqjtY9RVYgdtDE6dK7N5/vuhxGnaEuIo+YQy2Iq7w6raSQQeh/ElHglbq
         EpzSbu6tG4DybkBvf99ghrz6GtP6a4vs8Z3HthtMEdXt8fSVtpGuWwNlnek+ZJg61BUR
         zKDeTjgf9be1fSSUI+eWr6rPRysNFWV1U4lGdt/E1/3jsZhsmCEwxwIYALva7al6iN03
         VqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725663574; x=1726268374;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+1qQxIcJIkwDCKsBWYGATjTqgjdyvqBMaR7fO8toII=;
        b=PaKhttSR/cgiHGIoCEMoI/XSoM94AKtM9GPlAQns2iqTKlkcNiYO9+9TmYbfdIy15u
         M7ADepaRKga7kuAbiExgcbE30AajMAz8cs20TJTFt4Dh2SVVjzD+kockYcw/lP/e9S1B
         lYQ0B3gSDPCOCED96+LOg+zdbezjt6QNivZvCBUQLlNQJ4dORN8gm1LFQ/TsOUAhxaAm
         3nJ0DeRZNfwUr7hQqWs5Q9IfP9y2ht0+Vgr+FrFihSJ2lKpimgmfM8R94bzwv3fcLZP4
         VlJLyAIeJ/jvWv3KXA1QcRDwRc9NzkUcQibbOeMJ1wEuYApFWr+q83njfVMofevsbI+7
         I6pg==
X-Forwarded-Encrypted: i=1; AJvYcCVf06iQgXUahZXzz3Pc0EQnd0ECD5TqsF3NdgcGVNoPu6bRKMBlghyT2D9RNQWjoTnU+poJasJyAWSbAh25wHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGPy689aiTF/uhIG1Jl8XKl4OG5Bcay1SQ4bPmkRSVYgVnCgG
	HjWdebrRDgncfBCg347BSIkUYfLOEzEBWlaxqgZJE9tv+hLYNiGvIz/xfjFpuQioeDhgCp6C2Dr
	P
X-Google-Smtp-Source: AGHT+IG/rht6mEsYx3QNELyB+1QsVsPtxnaAKK7NIWmjh1T4R5Apcfr0mPNQdcxfW38oM0PadY7Lqw==
X-Received: by 2002:a17:903:94c:b0:206:c60f:494e with SMTP id d9443c01a7336-2070a531e17mr11422605ad.23.1725663574274;
        Fri, 06 Sep 2024 15:59:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e32675sm45105ad.73.2024.09.06.15.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 15:59:33 -0700 (PDT)
Message-ID: <66db8955.170a0220.3c3cc6.0044@mx.google.com>
Date: Fri, 06 Sep 2024 15:59:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-20-gaf1ec38c6ccc3
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (v6.11-rc1-20-gaf1ec38c6ccc3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.11-rc1-20-gaf1e=
c38c6ccc3)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-20-gaf1ec38c6ccc3/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-20-gaf1ec38c6ccc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      af1ec38c6ccc31ec963ac4bcf8f6a7d8f44d210a =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66db7cf3c977f0093dc86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-20-ga=
f1ec38c6ccc3/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
seccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-20-ga=
f1ec38c6ccc3/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
seccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/66db7cf3c977=
f0093dc86856
        failing since 38 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

