Return-Path: <linux-kselftest+bounces-955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AB9800A86
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 13:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5519E1C20AAB
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBC424A1C;
	Fri,  1 Dec 2023 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xLazqwW7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B34A1725
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Dec 2023 04:11:27 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cdedb683f9so1438896b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Dec 2023 04:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701432687; x=1702037487; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xJ+wTytZ0AQPWd2yQ2Z6oUS8yKsiDIhvsHbcefaVayg=;
        b=xLazqwW7YlWrAK//GZPpzdWEjRGgxQ/w2c1oYtldF4+I+Wl9oLhl+50mheIbMRNsms
         cUYNdMPochAU80umgpyxKdDDSQqmkjxL2Ugv0yf0BpEX8cZnl1ANIZD30pbCDn6LLTY5
         IUYRodEoYYSmbU8XT4mIb+l4AGTuajPNxrRNUKKVlSe6VE5KUdc1376QTsbj2W+XFn9h
         RQRT3w1ruwh7FNNUoxJlD6WqYwxKZDcVbUztZGiD+qrD7QiC7MlGsgre0Vv6QKhoRnd2
         UNgJOU2nMBl3Vk8SyFHSmhPXIjEIbJejh6LoZNgNFyajBEHd0B83CHduj57RqwdfdbSz
         CGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432687; x=1702037487;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJ+wTytZ0AQPWd2yQ2Z6oUS8yKsiDIhvsHbcefaVayg=;
        b=oBxh0ZhwKu+3/CFoYoA7a2qiLcJ05Hlihrgos0nYxQ0k6MdUgVHFbyDmdjDv3j9Rbz
         0+KSDPWgWpn36ZJiK+vimHnx2b2PKmWcqocVN1PhL9s2whwpk7ApINqgjHlnq3IVAx1D
         S25C3Z4HQyUfE8MZiHWcgeE9fLiqSV1DMVEB1203Qt+uGc2KAv9cCnprKkXa2c46bxgh
         krRHSn6ZyihGqztDtg8xGPmo+6Mjv/E5Z+rEiAvVn24fPnM8SfmuueXuppamy3ySP1mQ
         cvapBFtc88b86i+193OEsie0jsKJtX9iRAy7updwKvp5mYmdLPz6TNlrP+a1e+e85l5g
         zuzw==
X-Gm-Message-State: AOJu0Yxy6HiFUEPLpsAUopAHiEPtLKZ0zrnQB4uYuRWeAlvaU/kZXSrE
	saOdJwHTCV+RsuN6SifIocnQsvBI7cbAQoNqBeNTIQ==
X-Google-Smtp-Source: AGHT+IF2cGI7jJgbPQGZZfTnuT4JFW0ikOxm8VClgRFItjOVSNWbCbh8VV9AKBhV0NyEQB+2hwF5TA==
X-Received: by 2002:a17:903:22d2:b0:1cf:6bc2:223f with SMTP id y18-20020a17090322d200b001cf6bc2223fmr26200050plg.51.1701432686891;
        Fri, 01 Dec 2023 04:11:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y8-20020a170902700800b001cfba46e407sm3155192plk.129.2023.12.01.04.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:11:26 -0800 (PST)
Message-ID: <6569cd6e.170a0220.e9604.9530@mx.google.com>
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
Subject: kselftest/next kselftest-cpufreq: 4 runs,
 1 regressions (v6.7-rc1-9-g130a83879954a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-cpufreq: 4 runs, 1 regressions (v6.7-rc1-9-g130a83=
879954a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.7=
-rc1-9-g130a83879954a/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.7-rc1-9-g130a83879954a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      130a83879954a9fed35cf4474d223b4fcfd479fa =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65697121192e7ddd9c7e4a78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65697121192e=
7ddd9c7e4a79
        failing since 409 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

