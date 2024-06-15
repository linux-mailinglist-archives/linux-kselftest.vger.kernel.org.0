Return-Path: <linux-kselftest+bounces-11997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8405F9095FD
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 06:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415531C218D7
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 04:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A92DF6B;
	Sat, 15 Jun 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GQPBVB0o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8ADD517
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Jun 2024 04:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718426162; cv=none; b=FRLjM5XmdQDErqxpY8TFSzt2XCLHYPJwjlJmcMSorY4KmA5tN+sGb+TaTPWXAzEUq2WOhzuMaGbwlb1iF2dik66bcQlTE/wPjCV2XciiQBsZuX31CI1PDEJY4P3YucZRiVJAthbBF3fouQbnECTW2UL6NlEcvYWLsagLYVGaxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718426162; c=relaxed/simple;
	bh=ZsaDfWIDh1r9N7k7/b78LoG6VvwlWBcQu8F1k8xAySM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=BOmsQewqcxmXHqH1eucmW8WtPMw0O/8WwPQSxMcAwF107NqRI9hVASekN6afbt3aJTh27HsNDL/tn8TfmxfXbcu0QXJJpjRzKxfNmNXw+LFjOmfdMnEQUxMjzJ2+GYTdMwz6K5OYUm60/OfNBTsmVlwppLS5oRkNYEdKitmIFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=GQPBVB0o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-705959a2dfbso2019973b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 21:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718426161; x=1719030961; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J2KQxdTP05YivIosi9xVAWMwASbVjC53Jknj55buZBQ=;
        b=GQPBVB0oEcxxpK8aQKKKCoBJNH/afTU/RvQ2uYU4zELZCj6vddmZrcjAiBp4tA7+hN
         BnNMKgwpE/a4Fc3LbFFi8CR4sz0Zt0a/LAUFHW3cNMiPMb25yJxm5AjN98ZHCYCUdTcQ
         KbnjKYpSMMo6XqvLsRvi0o660qW8xOjx0QGbQBepTnGx07XN0PA2kuv5DSooRR0T3ade
         YOl7lbSmn66OOHmlXyX4J4wqg8uFv8h8qwK99mvtflGNB+m4Q/Tp+rlTnEGn/7NMBQci
         Np1E/SSgvKigoMRBv1hz3FvrUUd1A6u7L455KVwazvSH3t0e4L+A/io/P1l0ciRCS2w1
         zKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718426161; x=1719030961;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2KQxdTP05YivIosi9xVAWMwASbVjC53Jknj55buZBQ=;
        b=q2TDhVsPUAKFVNv0KQm7u0oBESlvYumFtALknbdk2Ud8GQOA0TJwhKnA0Jh7x7sM0S
         vQzRe0pomISpg/DKLCKfT47+RsaGcYnCzbojZ+wTb3nZ0e4vfadul7HSKmktZM1WGuoC
         tzwwIRdXIHqRDb5Qd+2zMEyf4QzHRBnncJ/5K4IU4EHCiMHFZ9sFAD3LujoTmdFmBb+m
         V7Zqj9wxVXtQgAQWUKNhvuFYmuoqOS/5rZDj44/91cv65r/58BByUEirmhFvXvnh46uQ
         OkCyjade0FFZk0DvwOXzfyA42uNN/XnkAXdmtQEeOYQ+6C4ybeOlGEY6hEuvq5VY6fpe
         Mfvw==
X-Forwarded-Encrypted: i=1; AJvYcCUPsYHMr6sGHG4Hka+YSCO/PEeZ855+dGv7zpxy0JVtWGaC9MHKV8mR+ZdTR6BCMgD3mrXrBRqYYWmQzUQHFTb5xx6tj3jVrZZsmHk4BfaQ
X-Gm-Message-State: AOJu0YxIWDezhKje6YIL0Q+1JTU4TaqdvHsYyrlxS7+eT43K1otSa8Tv
	/MWT/q3XCedip+LnRWjGWI49rQVPfdYABfU5bqm6A6/hlDo1uiIB3tYpABIh+Sk=
X-Google-Smtp-Source: AGHT+IEBPW7VjikKhr6XBdxzU5PqhptYEArxh6m3yibzWK/zGa8Fiiecif+NkjmaFNlbA03DS7I4qw==
X-Received: by 2002:aa7:84d4:0:b0:705:c9f5:a808 with SMTP id d2e1a72fcca58-705c9f5aab9mr9574626b3a.2.1718426160585;
        Fri, 14 Jun 2024 21:36:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee3c9f7b9sm3440015a12.86.2024.06.14.21.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 21:35:59 -0700 (PDT)
Message-ID: <666d1a2f.630a0220.a90f1.ad2e@mx.google.com>
Date: Fri, 14 Jun 2024 21:35:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lib: 4 runs,
 2 regressions (linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lib: 4 runs, 2 regressions (linux_kselftest-fixes=
-6.10-rc3-4-ged3994ac847e)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.10-rc3-4-ged3994ac847e/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ed3994ac847e0d6605f248e7f6776b1d4f445f4b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66690daa1f76ee1e617e707f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.10-rc3-4-ged3994ac847e/arm64/defconfig+kselftest/gcc-10/lab-colla=
bora/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.10-rc3-4-ged3994ac847e/arm64/defconfig+kselftest/gcc-10/lab-colla=
bora/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/66690daa1f76ee1e=
617e7080
        new failure (last pass: v6.10-rc1-11-g4bf15b1c657d2) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/666a1233f9891e3f3d7e7097

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.10-rc3-4-ged3994ac847e/arm64/defconfig+kselftest/gcc-10/lab-broon=
ie/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.10-rc3-4-ged3994ac847e/arm64/defconfig+kselftest/gcc-10/lab-broon=
ie/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/666a1233f9891e3f=
3d7e7098
        failing since 11 days (last pass: v6.10-rc1-9-g0f42bdf59b4e4, first=
 fail: v6.10-rc1-11-g4bf15b1c657d2) =

 =20

