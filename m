Return-Path: <linux-kselftest+bounces-11995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EFB9095FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 06:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7577F1F230F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 04:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8FED53F;
	Sat, 15 Jun 2024 04:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="RhC+Q9SR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205EE139D
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Jun 2024 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718426161; cv=none; b=Wi7Osm61ZkSMtC75LuWc4O7wlqrSsgHrUU5fyLzKFT67DZ2HT6nFwqVWV702cRyO4dXXSF7WjqHMJl/K8GDrFsezzlN9ggDhxhTsSx2DTAppXklhubh+bEI5VcRSs9qORpXvQw3jPvmB9Moz8Qbl9RHt8efQnhQyxtMsWgh/RFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718426161; c=relaxed/simple;
	bh=WPUHDj/ql1+C5PtUr7Rm3HC30uWd8up3r4Q7JTCHMIM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=f8s/iyBx/NcQ7G7iWBe5D4jsQ5XMwsxNSSWnQjYkLiQujsBZUNHgLAaCZfUliymhhcZNEhSdmOOtkbNu6wKVJH7Ut30xzHWkdlIRS7p55iOkqRAXSE631E3vWQ1jrnWgq97KGsDvsQ2FDluW6ERC8WjOBuhCePxvPez7oiHb1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=RhC+Q9SR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f7274a453bso25157745ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 21:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718426159; x=1719030959; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Jvpsggak8JLpcPC3VetnTUqT5Gi22aC+kZ2N2ifQ38=;
        b=RhC+Q9SRYXwEqclay6DPVVeLI+Y/FF0PXqEkiDQNuksfYcW/8JujhXQDFx7BVblaJW
         4Hgg9WXS9gSqrOT/zjnRk3djRi2Fl38B0bOTWCZSy2LA2rWGfFhfu3cs9x6mHisLcMMm
         cHQ+4pM/MsH+/5zFnGv8jEFO92rFc9fCQO1cWDjmoa2ClBhoeOHes6LQUsyA7zlZibwc
         zElvCRhA5D+wORZaU8BsxYyBlvu0aWCD21q4UevGRvDsdGJSA7M7fpAyUZd/dQGluZb/
         i6s6qLzoq5PLbVWcIJCgZmmGxB6+HYpTX+plFql2Ln+QaNrlZg8YxMgaZeJkOC29HAHn
         3wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718426159; x=1719030959;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Jvpsggak8JLpcPC3VetnTUqT5Gi22aC+kZ2N2ifQ38=;
        b=YXRt4o2IjNV3WAd6xnXqozCQh1b92IEXpSd0gGt6reHGIAZfb57uFvBGAmeupC0nYx
         c1OwVtlLOO4Ond8I/sH2Ti5zcW97ok67hwN6mRl7kjoV+dYa1En1BBXxB4f9AS5M3XBL
         3S9C/30iF61FSFPMmkgtXA1DpnGOAKX6uvMH13MG43BMNCJTybZQgfY541xWn6aare0v
         1TFXUlkt9zU9MPXLR39dokhMrYyci1zGjlyknBvM/6bdHYDbsHviX/kqkVxqUwS3q+In
         7WETLvy3LSRV4eAun3f0GWzdivYN8lIT6raLGlpD69+kYNyPKfvjgyp9WktUj2Kz/C/D
         WxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgvRzGmkOszGRuMdolcHsl3jEoykX7jL6OSTo2gJi50FwvauQIjo9TwuECtR9IC9xLrjxu5HT3DwHYHV/2MgkmZxCjrHoBe6BPI3Tm0yyH
X-Gm-Message-State: AOJu0YwCPYaoi80/P4+vBp3gmeR2bq3OCexOu+N97Bg7LUI0vjyvP/s1
	kb0zpjQ90+AyBeIMawl1/1jyS36p1eseVLhaMsCLqCq7FIYnbmC1ZACKywoJrY4=
X-Google-Smtp-Source: AGHT+IEa7NpGvy3DuhBsbRDzwktfC3wdE0JurGJaA6DwQXiVqooZo966UXt9nzg4vm7eLEZZmXZynA==
X-Received: by 2002:a17:902:da8c:b0:1f4:6948:1d49 with SMTP id d9443c01a7336-1f8627d49b5mr55726285ad.33.1718426159301;
        Fri, 14 Jun 2024 21:35:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0260csm40861525ad.200.2024.06.14.21.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 21:35:58 -0700 (PDT)
Message-ID: <666d1a2e.170a0220.33b0d.ce2e@mx.google.com>
Date: Fri, 14 Jun 2024 21:35:58 -0700 (PDT)
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
Subject: kselftest/fixes kselftest-cpufreq: 10 runs,
 1 regressions (linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-cpufreq: 10 runs, 1 regressions (linux_kselftest-=
fixes-6.10-rc3-4-ged3994ac847e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.10-rc3-4-ged3994ac847e/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
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


  Details:     https://kernelci.org/test/plan/id/66690e22fe659382037e7078

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.10-rc3-4-ged3994ac847e/arm64/defconfig+kselftest/gcc-10/lab-colla=
bora/kselftest-cpufreq-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.10-rc3-4-ged3994ac847e/arm64/defconfig+kselftest/gcc-10/lab-colla=
bora/kselftest-cpufreq-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/66690e22fe65=
9382037e7079
        new failure (last pass: v6.10-rc1-11-g4bf15b1c657d2) =

 =20

