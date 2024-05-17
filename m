Return-Path: <linux-kselftest+bounces-10330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053BB8C80D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 08:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720CA1F2242F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 06:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265FB1171A;
	Fri, 17 May 2024 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="D3xg/qHU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6A11CB4
	for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715926543; cv=none; b=msgXNQLtDd2lZUaDrvG5tlGd+Q9oXCcJGUfK6IfOGdzdlDjbhFY4LKzAWQ4AUMnqqK1KXirOazxaR7W1qZIq1d+LlnUYLDJNvljZEcjp35mtARywdUCYRMEK1EsSpioDn8MfrypkpUcWXx5Z3Q4NE9sQRddZm+5n9bwmbvjKcWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715926543; c=relaxed/simple;
	bh=RuY+ERdvMuUyuLAtC8D1KvFCW+qLfK0PMKbPdiaG2Nw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=aVc2xV7ZpSmWsxVmSCR8NNQfgQaxG6QFzTJ+FbvdEhu2JW6U/06ZWXbEvaFju/m/hZB04PDvw96+INLsVwXeaKlPrKVys0EhF3ySUlK66esFNyrdKksKoEIJbC/0IFgLFm88VNDw10BKgvP1TBPa9cpsnvtb08/t1QywqN2QHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=D3xg/qHU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f693fb0ab6so150474b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 23:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1715926539; x=1716531339; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vWJD4995vmqVPUOS7YqetBIk5OBDBHtfs8v75/unHEo=;
        b=D3xg/qHUDOjd8qNiz0I+1ZhxOZ2PoHDf3P1atXUUF0tZHlClKh1ztpSPXIP68FWkyz
         9EHST5//vU6MS5p0wLH6JUQsjzw9/sZrz+eZ0YXMtfPNk9/9BCm6Yf97tNEG0WSg1vZt
         dc+q+aNRJH10WVNXduw1EavsmI9BwMHfxSkO5IFoyffI9cZs5JilVM8RFC+RIcbuFW0Z
         6gAigfU9yml5YBwZCkc8leZ/g/GTXh0QayZJ4Qj5/G7j3OEpwRXrXcUcpyrxIrz5Tm6G
         5kI8IIjwtYfDvWDTTdsbNvIRiWys7l2JDvJ+TCE3WP3+qXWtM6ObF5wrzqEvrThB1KZw
         dcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715926539; x=1716531339;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWJD4995vmqVPUOS7YqetBIk5OBDBHtfs8v75/unHEo=;
        b=o8jqGxgt+CPkuPVMLqQ/b/mShNMYM73yIQvN6nrXdLiShHwuUta15/iqwTDkvz6MOv
         x6F3IQqAx1FA54D2JHwQ2Ub49KOPaPWI8xjLmo16+eX01QBI+5Q15PJa9kJEd/tGGAJX
         QlfqOwlofQOgTM+VaFYypyX/bE3NK/Q5GoZ+mwsZAW5ggypdOMzAWJsQK2U973/GPlQN
         AgR6xd102BQZ+z6KOrH7UvNkfL34yueNYrSZIRZcyPPpR80id26bC0C24sdiYP63FvOj
         Wb69IEdQczxzcF0vCoZmMbSXFNNer0gt4W3tXdyqwOQPvUzMrj0rWTS5fwl3aqHGwRbc
         wG0A==
X-Forwarded-Encrypted: i=1; AJvYcCX5eR5DXZaon5VlgE+TSOxwt+odfk/rGQ2162NktFOn9vuKb1EtnKxtQoad+0uM3PSPIn0Ag8xzDom29BsexFBT8TMCmMsTBBx3KoDeeWtu
X-Gm-Message-State: AOJu0YzItGPj1q15Q0sUqMW8IadExa1nxZl4ozivyPkxatI+A9SeDdug
	A9RzFwWU2VoEx8Jc7/HWY2tdLbYUA0OQcUG2860oqULJlVlgG1t3wlkPga4B5Ug=
X-Google-Smtp-Source: AGHT+IGolY5dO9vRuuEyaBpuj4HX+Pc76A9EGzfZOk3+uaLIlQpIKQxmKbS0feEjwo5Ent/0XWRuRQ==
X-Received: by 2002:a05:6a00:2384:b0:6f5:2a7:7a42 with SMTP id d2e1a72fcca58-6f693ff499cmr486705b3a.6.1715926538820;
        Thu, 16 May 2024 23:15:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d90f54easm13775864b3a.18.2024.05.16.23.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 23:15:38 -0700 (PDT)
Message-ID: <6646f60a.620a0220.9856a.4857@mx.google.com>
Date: Thu, 16 May 2024 23:15:38 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-8287-g31a59b76b978
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 6 runs,
 7 regressions (v6.9-8287-g31a59b76b978)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 6 runs, 7 regressions (v6.9-8287-g31a59b7=
6b978)

This legacy KernelCI providing this report will shutdown sometime
soon in favor of our new KernelCI infra. Not all tests are being
migrated.
If you are still using this report and want us to prioritize your
usecase in the new system, please let us know at
kernelci@lists.linux.dev

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 2          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 2          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8192-asurada-spherion-r0   | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 2          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-8287-g31a59b76b978/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-8287-g31a59b76b978
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      31a59b76b9780a9b2d385024e2d6d0d051bb06a5 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 2          =


  Details:     https://kernelci.org/test/plan/id/6646ea71e49c6a41ee4c432c

  Results:     105 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/6646ea71e49c6a41ee4c432e
        new failure (last pass: v6.9-rc4-32-g693fe2f6a9ea) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_entry_2_bitmapped: https://=
kernelci.org/test/case/id/6646ea71e49c6a41ee4c4330
        new failure (last pass: v6.9-rc4-32-g693fe2f6a9ea) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6646e74283cd144db94c442a

  Results:     105 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/ks=
elftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/ks=
elftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/6646e74283cd144db94c442c
        new failure (last pass: v6.9-rc4-32-g693fe2f6a9ea) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/6646e74283cd144db94c4431
        new failure (last pass: v6.9-rc4-32-g693fe2f6a9ea) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6646e90e6ac9380c2b4c4320

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/ks=
elftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/ks=
elftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6646e90e6ac9=
380c2b4c4321
        new failure (last pass: v6.9-rc4-32-g693fe2f6a9ea) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8192-asurada-spherion-r0   | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6646e9e37e6ac711874c42fd

  Results:     105 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/ks=
elftest-seccomp-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/ks=
elftest-seccomp-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/6646e9e37e6ac711874c42ff
        new failure (last pass: v6.9-rc4-32-g693fe2f6a9ea) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/6646e9e37e6ac711874c4304
        new failure (last pass: v6.9-rc4-32-g693fe2f6a9ea) =

 =20

