Return-Path: <linux-kselftest+bounces-15796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4E959092
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 00:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2935A1C2092E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469B1C7B87;
	Tue, 20 Aug 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="p2CY6igd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5315C13C
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193631; cv=none; b=rBdq2UU7CiL1P802re0mKalRAmFtTSRHrc3VgCpZ3up2i3pizLxCgPeIMYIZQxEUhVyKWzWG6J9VWuvxrRpWjcYYmF0JCQeTdhFYkdHN8ToIsAVwaDUq3cSkSmxd0/S/PUpk+z1loe5vV+ejDSK5O/9QhVtznxQB9jcSsoVkFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193631; c=relaxed/simple;
	bh=o0M+Xl+d1/3U/ge1v9w0WKMEzXXPWf8HHlVyIog7A8c=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=GrBfEUyAX6mPUmvAZShLL8cZiiZTdbVi+jRBlKvAAjZ5R/ZNBjH7oBFE1vhKC7PVXKQFl+wk5yXltO8KyPkD+gFbgQ5V005cLM92Q/z/RDY8ynKdQ1gpr1IDYjbNg/EWuwkfYwhujwB87qxHvk7S66005EI9Bc6NdrGvTNVWIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=p2CY6igd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-713f3b4c9f7so2056414b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 15:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1724193629; x=1724798429; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YhneommDHBjPyuai4Wcp0a/Jk/vH9uUTfkXjXs1iZG8=;
        b=p2CY6igdnuSLSlQP5WR0VuqGzlWQ+hPxzafoYgikr74WeUQMI9OX6VNGnlR56PCs0Q
         5YPp/LNuhHoGm7lyuYMr6rRXYpJG8TSFb0aMuanFkv01WYRL/pWRn8abrDy7ss6mAyPO
         izzTY+T4l9O76k6fABpqAq236P0avwhzgNpEInajwXU1lsLdj+n4QoTNI/4UjF1fNGJ+
         VcBKhUMiui4Mvx9EJdkvd65qbFepISTXDsfSsvBuHWCPLpY9fSKdjKieiAjOTBzL69dA
         nnmGcrJnWPf8UWDE51HcsBNxAVvalEhKVuDaybT1uMnO1XMM6XQhO8WEVTEk3Bloc3sy
         Gg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724193629; x=1724798429;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhneommDHBjPyuai4Wcp0a/Jk/vH9uUTfkXjXs1iZG8=;
        b=dv8EpZEBlX4tklxCqGN7yDKIhARLDqYedRhyo+wcVQKVszk1z/JwegHoAVwx0rcUty
         yprv9L/qmcB1LAP5+9QQGqiyQZJLBkN3sjHyoE2yTkUj/GkqEb2DvunQ9bfP9fs50aUE
         Q6zBRgthwfvJf1ctBuGgN+JCGFpxWU19/qHJTe7NMIhmGZlCYpR8pOf2CABSLS3jGuyn
         bguamvtfXiklHHIjs1rSDAlhhVjP2Xs27nx32nuFAVbAcBkmk3+COPSyzStzKyGJV5OI
         5XbYh/5rtUSlNCjDOQcTDaofWlz3C8CDvDNPw+IWMartx6tGy9XPjByo9VnmcPk7Mv8Z
         bGYw==
X-Forwarded-Encrypted: i=1; AJvYcCUiu1buVhxamtXdZPpbL+14dus6Optow2WEsn7uSvNibfn+qfeY8PIRNTvQV6zX+n3TNnjUH2Vb4AThS6aX4ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2DCunLWwCh3x335E+lz+w2oDD7AvVSbLhjv0BGEA59ETQ+ijM
	VaXib2ctmNJhyXBqr8NGffC661w4b40cU/vB/3YNsmG3sKTEqN8AOcypRcFdVLs=
X-Google-Smtp-Source: AGHT+IHo7kYaztsqk0Hr53UJE2ECEM+7L9i29iyFPAFds4DqAVoyI+bWhuzHyFlOnhoHfW4YPWC+0w==
X-Received: by 2002:a05:6a00:3ccb:b0:710:4d4b:1af with SMTP id d2e1a72fcca58-71423769a5bmr645981b3a.7.1724193628880;
        Tue, 20 Aug 2024 15:40:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6367db7sm9848794a12.88.2024.08.20.15.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:40:28 -0700 (PDT)
Message-ID: <66c51b5c.630a0220.2c1527.2e0c@mx.google.com>
Date: Tue, 20 Aug 2024 15:40:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-13-g41f37c852ac3f
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 1 runs,
 1 regressions (v6.11-rc1-13-g41f37c852ac3f)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 1 runs, 1 regressions (v6.11-rc1-13-g41f37c85=
2ac3f)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-13-g41f37c852ac3f/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-13-g41f37c852ac3f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      41f37c852ac3fbfd072a00281b60dc7ba056be8c =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66c5140122b4b11599c8685e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-13-g4=
1f37c852ac3f/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lib-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-13-g4=
1f37c852ac3f/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lib-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/66c5140122b4b115=
99c8685f
        failing since 21 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

