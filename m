Return-Path: <linux-kselftest+bounces-10803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB218D27B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 00:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DD9B255ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E8613DBA8;
	Tue, 28 May 2024 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="EE69IDOV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70C1DFD2
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933877; cv=none; b=cOf/FQlesntulvt/UP6UH0AWgvDy/3Tcg028hqK9nh76LwAUgY3Lk1BPKYnWncL3lFkLezjc13iwbct/BH/gapuQG0vR2uCoIVXqeO/zE9XEpbmSqD5ohMkkkoSGDY+3O3KcNX4dZQT9pPSmagL0/WgoOa7LAFVkMjjtEf3TKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933877; c=relaxed/simple;
	bh=vRs83M09ugBkim8RwCPc1VkveE/WP3j/hLbUG0gdHBg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=RuRBVh4kvnjsnXcRCnOMtZMtnghoejXlYQrLgWmeRJmTMWYLU8rBcVEQDL4HjOlbXUMS1G0SHbjKT8hz/+iGuAP2ejLOEMe/L9w6DRNMqhTqVb9xO/S7fZ+DAQfpuNH4ZiCDRy3WNp3bbrg1AQcW0zQAIo5jgqIFdgynuqew2PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=EE69IDOV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bf59381a11so1220180a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 15:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1716933875; x=1717538675; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yptlYsx07VhNeDnZlBhX5Dg1fuTKwCFvt50aMku//kw=;
        b=EE69IDOVKFwCsDT5yVU0TOOkQGWT8rrA9sQC/rZNvslXOB0UR5VkO2qX6oZDUd4msO
         A1pirK8VTNNVi955hLVvcTI//eCRhdUzxI+TEpJc/CYVBLiK9WvFrnfG/W3XsR/D4yhf
         Dq1kU3ownXOPulXf9MG3R32k4MS/2V412ktD44Dow6QT3Ca6wQ/4GnVeE/HmTiyQx1WA
         cNjKvaWAYgoF9p9iCWmN9vY/oLbZo4CSB77htTtMsrFBYhojdmvhBXgDEX99kFry95XN
         w77YEbxJIQPoHBeSa+FvluLqgH4IbsfDRfNv9e8W6RJN4kE8gHkdpEPd6uzgwpaPZBJr
         ZuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716933875; x=1717538675;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yptlYsx07VhNeDnZlBhX5Dg1fuTKwCFvt50aMku//kw=;
        b=xJWAfYNFPYZUOmLwPrYHkWa2WhfgPpyqZ3+W/BY4l19qBKhWLURlmnCvoqTkDyNxqj
         cneuqWQ77BTPU3EL+4brRsgyoLd/U/rjcNun0phKwOfe/1o4AqSPgsDUy8SbPbIwmwAz
         jIy4yYurZXRFch6q3w4Yl1rdHSOx6k7xPk5MAKqKJaVVdhft0Hl2Nwf0G4r2TR4KgkQE
         wwP/y8kfZOxe9b5SEIFouB4Z+8iuxAAUw1x7f6tlIjhwRwtXciNF2c7vWx7B4+TI4UaF
         uM9CSYz//xh0U8W2qGzdBRHe1bx1FrjMVFR0ORnN2kDt8nssFpnPjJGxsxtikd2Xvk43
         TLZA==
X-Forwarded-Encrypted: i=1; AJvYcCXwkQlu3E0gWqXIpF2NzS92plP1IO3OuT63RjccK1mNAtReKN3YziIgPzhRmvcFjAdC3xuwprK9IHGj2T/pafwTUr8n+QhlAaD0DfMGDeny
X-Gm-Message-State: AOJu0YxOy5yInsTGlOWHR3GvhnUVCXKC24rxjWrKrjcgTrVXVNpp6HMj
	8ZvIzpZY6IfbbvwE7N7DyrEPi1qh1rPeYU+LeU9VG+kFMf5w9WUhl1Zj1xBMUfo=
X-Google-Smtp-Source: AGHT+IHEaYIOQQ80WDlMmchs7QA9XHxNjeiVr2STlhw5xIsX907Zzu3HWk4mVgTlZDDUolU8ViPbeg==
X-Received: by 2002:a17:90b:1085:b0:2bd:ec55:9f38 with SMTP id 98e67ed59e1d1-2bf5ee1ff20mr12086952a91.29.1716933875178;
        Tue, 28 May 2024 15:04:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f614036sm8265468a91.33.2024.05.28.15.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 15:04:34 -0700 (PDT)
Message-ID: <665654f2.170a0220.f8a1e.5c04@mx.google.com>
Date: Tue, 28 May 2024 15:04:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 7 runs, 1 regressions (v6.10-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-cpufreq: 7 runs, 1 regressions (v6.10-rc1)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/665647f6b0f1e6815c7e7073

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-cpufre=
q-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-cpufre=
q-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/665647f6b0f1=
e6815c7e7074
        new failure (last pass: v6.9-8287-g31a59b76b978) =

 =20

