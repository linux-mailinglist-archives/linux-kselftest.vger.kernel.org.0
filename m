Return-Path: <linux-kselftest+bounces-5899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8918718AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2F81F22E8C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3952E4EB31;
	Tue,  5 Mar 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="FT6QQofd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB114EB3F
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628873; cv=none; b=aY36pEqXXbcLNlfKUcQN6q4l7TAoBC8zq7hcMz3h0d6L2dCqrXPCdZz1Ork5jHSftPDUrIKWXRrJ35Qf88EM5+o916umDNR7cmAX+NrNsJRZUddwxkB3zmvVbzHYKgIa9hW/AzD6eN4z/OYaculpd5CqADuSyrNFp08UpaC7TGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628873; c=relaxed/simple;
	bh=jBAkKC6LbGLvmExhgFhKpoTLAJML3Aj7f0kMtZvaX7A=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Njr1QwpcSPWKXJar1cP5D4qwX8BwEbKXFsoBET9zuVm7tCywm28m7tcVZ8SFijQxQYIPEL6zMk7HJqkWFMJMcMzQSlIpxRFOmcaM+hbt29Tc6FBzw/xYi+Rx5kM2ufUmD1BENQAsRGnA1o1mfH4qeVwYaof0wXM2mpUaM4E20I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=FT6QQofd; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a0b1936400so2481398eaf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 00:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709628870; x=1710233670; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6vQsSaH8ACT/iCTVtlCi3sgB1oigJs0PvoLSunFObNc=;
        b=FT6QQofdBoZSRVCkpQ5d0uCB72hiR+mYuZxmS3f/xHCLdEJpCVq/EKs8HMRApcltNg
         ggcdAHBnl9eRspNBu5bIapbLVGTaBlHhAgIWPcPpTBx3wjJOTuv6h3vwtgpxF1eKDlUs
         RBGp6DmnzgjoczuFLepSk9dglczFtthQHc/XlFuYxFdtgsaOvxqoITeRnQl9QB3z3kdP
         BzUi8lnSxueI3vsxdV3oczsndHRO1LvmFc6D10eNvSBLGij+GrPYh6kQ1pHjeH96Qgvl
         MxSN/w9oBRNTU1lvJ2cwLPvzX4idD6iQivKO0rD4b1Qj69OdHd5FeJUorEzR/ZqclWdc
         PteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628870; x=1710233670;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vQsSaH8ACT/iCTVtlCi3sgB1oigJs0PvoLSunFObNc=;
        b=qn8kF2WTN4rRscb//L0W5UCiP1T1sQpyDugzNt77fq/gfKH43SNz+uEErmAXhGZ4o8
         /e38l1d7AsgtCnqZ48Eguq8+odiS8NNcOkc2OvPxYZO5dQdJ/MJ+ujcnJjkVps8+c8Oo
         dQ+SAHnv/xtA//O0SU6ZO72jJRwwfdaV+8cwU9r70RN5uS8fcYDIndvYABoyLGZO9sU5
         uumyYyMIZk7F4BHltcjWEPEpifkXe5iUhcg+Eurj0ev9O7rGE5yXFXHTmEQoIPf5W48B
         6rfwo6mA32TV5d2CtDoiJGjxCQ86hP/GxKk0BmXfglHfMtOTIowi6ysQALuMYDhg4RVW
         LRIw==
X-Forwarded-Encrypted: i=1; AJvYcCX+OVBLEkp0L0SYY+tEnlkOqiW9XelYbWIY1k51TON+f7kVYmCjGE2h3rgqupGT5TtN9kBwis/HjaxfGWJqNYVAFtNnnqw7A8NNnA5199Mv
X-Gm-Message-State: AOJu0YzEink6fPR5vanQ4fzaK7uUOQ7Bt1lA9jCFV833a0mmvV+xMNPa
	rT4uH4r02fJYG80USeth5V+rGKqkrpeoL2pVfxdCpvMBo+ztqvX4FD6SCxksi+/hPxSLAQ6+QEU
	NjPc=
X-Google-Smtp-Source: AGHT+IEuNA0JYXjf0FR3gJQx9FfuYydhbXv3AoDcHukUgSvb1B3M89kr2tPVb9D7BzNPFbw2UkZ6rQ==
X-Received: by 2002:a05:6358:41a0:b0:17b:c4a8:1416 with SMTP id w32-20020a05635841a000b0017bc4a81416mr1482286rwc.13.1709628869870;
        Tue, 05 Mar 2024 00:54:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k19-20020a63ff13000000b005cfb6e7b0c7sm8822694pgi.39.2024.03.05.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:54:29 -0800 (PST)
Message-ID: <65e6ddc5.630a0220.b78ac.35c7@mx.google.com>
Date: Tue, 05 Mar 2024 00:54:29 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-57-g5d94da7ff00e
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 4 runs,
 2 regressions (v6.8-rc1-57-g5d94da7ff00e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 4 runs, 2 regressions (v6.8-rc1-57-g5d94da7ff=
00e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-57-g5d94da7ff00e/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-57-g5d94da7ff00e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5d94da7ff00ef45737a64d947e7ff45aca972782 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e6d060dc697f37014c42e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65e6d060dc697f37=
014c42e8
        failing since 504 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e6d2fad46ae4ac044c4311

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson=
-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson=
-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65e6d2fad46ae4ac=
044c4312
        failing since 501 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =20

