Return-Path: <linux-kselftest+bounces-5149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9485D3D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504FB1F259C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50DE3D3A1;
	Wed, 21 Feb 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="iSEHKZLY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F833B799
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508421; cv=none; b=JNY7u/9Pkx//swfUkEL0+rJlXZN15kRzI7DN7qEPUUu0UYq2NaMvZ9PBMuulw9uhB0B9fYBHINPPWS5jH6Da9D8ccD3ErHYav40agdMs1KpkNKdeeFVL15oQEo03O9KbKtunxin/YOD4jGy9/eNkm7pyR8OHnuDl3+6gbAA1MQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508421; c=relaxed/simple;
	bh=tKh9ZAtUU4J4QIKzuTlrBzpe58cd5wm+ukU1yETHl8w=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=BTCj//2us+GjN+xUAblnlSYsougL0WWTCZhFfwgKdIe+iODdxdwpV6Lu7q51XaXV7xKibgn55jBhzunW0YVv71QVlXvrXVqQpIj2vRemc0rHq/yLvb6D5OJRSwL5OgYZ3pMe5bwgm0xisuf2UHJDdVJvbCGGxGmFomHtW1ccRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=iSEHKZLY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e46e07ff07so1875010b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 01:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708508419; x=1709113219; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HRMaagyqgI0Z4ycsER5eNMichncnU0jNRapInCRX6Kg=;
        b=iSEHKZLYk6ZwCQom4bEaXDSBHcZeuOezrCjlw0+uDZdYiHUXK5kmE6CTfoDNPxDEPS
         fGANVMFQdyTHbhyLVkQT7FrBN+lJV6cD1T9l9UxNbSl7y6DklEX0QhNDUB6hY2SNIo+t
         juk0hBp/yHvFiR01cXt4QJb5NkFCp8e/TBMBRRkNcn+kj5530DmfdlfoW7ecLnP/AelR
         oN6ZIq05JHAqwYhH7AF8+cRUm8AwAyuR74QJDxUo62IFSJ7BQ/HwBUoHmkE2Y4NN0m9o
         RwJa9m+DweASvmUlJw6SVxrBJRCtW4ObpofKOCwKyphbkA2vHsMSvm2uf615aluhG87Q
         t6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508419; x=1709113219;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRMaagyqgI0Z4ycsER5eNMichncnU0jNRapInCRX6Kg=;
        b=CL0R2gmRVtMc61mgciOlvvVVNFbNYZk+B3lHwAE7fFYfczSlwywQsIARfxUxmJb/vV
         fd/Fh1UALIChS+CHbOBiTml/wDzuVQG1LTpXHgT1EvJGqu8z95xr6m7negqYlkZzsAu/
         t5eRfyUIIMExaKZ1WdD2dB1toctp09DdYdizg6m2u0vcN/HOIm4RpHhmvjvkgSohOc5j
         KubBXXcjsfzwoTgdl8eawhLhFgVRjBjJbKYAJq3F1KooAAVHqLoQBJsNDQEcWvf52Au7
         FhKwjf2PSmvZEoycUoDWrUUEa1e7zavTcShwQLKLE9VstiKoqQlAoaNjwF+uQNDHCchJ
         GAhA==
X-Forwarded-Encrypted: i=1; AJvYcCVWdD0476rGHn784c16dm+aP57J39wNFHon81JM/GAKqzG2ikwUWD7e2Gt5lD7YnmnAjO+qjhXL+2A2CaWruLANsTj/LppCXExn0/Xu3F+I
X-Gm-Message-State: AOJu0YzHJMoSoOyh++DYMcGsiptV848XUWntiSbY3kxCvWKiV+rAJjnd
	pEk0kmDWerW0gY9Cr5LIyGMoeKv2+J31JZ43Li9ANB8LaYthddv/tEICnvb6RaE=
X-Google-Smtp-Source: AGHT+IEK/3JBMN+L50hz1zwmpzD8UYcHsmdsIlQigk6OodLI2v/YlZLcR2UZpMi/0UwfZZHwLkoHOA==
X-Received: by 2002:a05:6a00:2fda:b0:6e2:ed1d:c5c6 with SMTP id fn26-20020a056a002fda00b006e2ed1dc5c6mr9296156pfb.22.1708508419448;
        Wed, 21 Feb 2024 01:40:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fd3-20020a056a002e8300b006e0dd50b0d0sm8427833pfb.8.2024.02.21.01.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:40:18 -0800 (PST)
Message-ID: <65d5c502.050a0220.8e832.96fa@mx.google.com>
Date: Wed, 21 Feb 2024 01:40:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.8-rc1-48-g6f1a214d446b2
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.8-rc1-48-g6f1a214d446b2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-48-g6f1=
a214d446b2)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-48-g6f1a214d446b2/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-48-g6f1a214d446b2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6f1a214d446b2f2f9c8c4b96755a8f0316ba4436 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d5b512280477c68c637017

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/65d5b512280477c68c637019
        failing since 7 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32-=
g345e8abe4c355)

    2024-02-21T08:31:40.711164  / # =


    2024-02-21T08:31:40.719532  =


    2024-02-21T08:31:45.869045  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/12816975/extract-nfsrootfs-ywcdtx_q'

    2024-02-21T08:31:45.883749  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/12816975/extract-nfsrootfs-ywcdtx_q'

    2024-02-21T08:31:48.113802  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-02-21T08:31:48.125014  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-02-21T08:31:48.242969  / # #

    2024-02-21T08:31:48.250650  #

    2024-02-21T08:31:48.368255  / # export SHELL=3D/bin/bash

    2024-02-21T08:31:48.378558  export SHELL=3D/bin/bash
 =

    ... (46 line(s) more)  =

 =20

