Return-Path: <linux-kselftest+bounces-11735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F78904965
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 05:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2241F23D45
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 03:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25F917C77;
	Wed, 12 Jun 2024 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="hn0FVuvz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F3BA31
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161794; cv=none; b=QIdA7aAGzOSsQK3ihZMMWhYWtMcID9NgYf3mFP+KgNw9ZF50ResYKagD1I3iETreQ3o69cb1WsAo71qHQ4mbxb7GlZy9g6Kt9pl7gW75BtozN3vTMz/IZXDBdA+J+z9QpFZG/7a3AQT2DBnG4LB34ztlyMN2NavKFVtSz6KAbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161794; c=relaxed/simple;
	bh=ptVpEBeB0m1Tb07xrpHA9/tqjXnwpzB2lBqwQ/r1qLA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=CCLivtJdOJFMsCCo9biA0KEWtd6bc46tJaGDceNKYA30Xv7AsY1Xd+qZ5x7lfvBbn2g3sPvj2qdvaRBmmBRN3H2JFfYT7ixVJstmzpwJdufHErsNVXwI9FiNV6qTV1/PZBTn31JN8xowa6B0DppRnQWTvH0XFPMStI9VP0WLxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=hn0FVuvz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso5178488a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 20:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718161793; x=1718766593; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qLvfHaF/5QojDjswE5VMRi3pZQVbjAYAjozU2hQu1VA=;
        b=hn0FVuvzoKaHIWQJhT6c7XizpMErXxtCHPtvWGFEzHjTkJIMW7iVns2mLm8jrLvFzi
         KZYfG1xD7t+RRmwpbH7fh298ojxSVInrzOus5QpucRVV/9SCqS05/wdfNMAWOKL4Lt0A
         QDfG2U2p/7kmc1txqwzwPaQP7ubCQ7i6t8SuAJh+oX0q15nIy1+WxjpwbQgcPe1EhCFQ
         qgKsDx9DvdSnsQoZSPMC2ZH4gZepQ+XMlACROI9H5ON1SDhbpyvciZdnzRsCKV7bU/vG
         gx2XxFiaXOk8mRUCq/WRXUVMzZfeLK/Gqm9Efx5jEg2hL2dF+30BHgX+D2l8dywTsLuD
         VnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718161793; x=1718766593;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLvfHaF/5QojDjswE5VMRi3pZQVbjAYAjozU2hQu1VA=;
        b=dZegex3XzShm5jh4/dae3yD/90Dys9PYLNP7u9HVSRYRmmbETtGzqePwxfz/8RDKYM
         sdvdc1+dIUxIeunYjmI4Q37rlraZeq/7j4HQIFNZJ4nF+Y4Qyhv9v3LgTQi010vSm/Cm
         p8S6UZZETGdWJGYOXf6rqu8F2Inr+DgL77vxBrCR2F3s9y12+7zjg9w/bLr87m8GxTjw
         l6VM+ZgEhYC0CbiAKX5W6DAEWZZlyUm07QDvxL1JTONp5Ep8TAxYbfoXkK8tNvcaY4pw
         47JoD1R2sG2AByjOL1FGSj6eSiexxffbKbB3HVDwMuH8OIkqiLevdK7SrY9Y0YSALqOz
         taEw==
X-Forwarded-Encrypted: i=1; AJvYcCUqaL+7GaiY4tPqgswKNuNk9b+Ns/esamOGUppXnTskWJslV82QHtvKED5VN24/FuP4MJSaVG/dt8wXeei+gWg0TruberGnyM0MDDX+KVn7
X-Gm-Message-State: AOJu0YzkIHoLeJ9JivFNXK38Eoi33L0RW761QtEKaCZ7cLrG4J6lzAT3
	oGWFlrG/tzpWsf10Sk9ltnb+9CzOazT5OYspVpEffe/wLqhUFPdGfNhdzAnmbRk=
X-Google-Smtp-Source: AGHT+IEZYiHe6jjWv+tsjpg8X+fcCA9fqON+JR2sANHZr2FsJ29lAOZkfD+Vknx4JEttWXHPEJGmyA==
X-Received: by 2002:a05:6a20:a11e:b0:1b6:63b6:ea6d with SMTP id adf61e73a8af0-1b8a9b3627bmr816629637.11.1718161792445;
        Tue, 11 Jun 2024 20:09:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e0438sm109380805ad.185.2024.06.11.20.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:09:52 -0700 (PDT)
Message-ID: <66691180.170a0220.10a696.feb5@mx.google.com>
Date: Tue, 11 Jun 2024 20:09:52 -0700 (PDT)
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

