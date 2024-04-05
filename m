Return-Path: <linux-kselftest+bounces-7239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01AE8992C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 03:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DF61C2262F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 01:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511E279CE;
	Fri,  5 Apr 2024 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="oKQQOLK4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACEF6AB6
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712279860; cv=none; b=o/VDWxNJxv7njCtQYAvlsDF1NETpGpHcbuJZLlgtH3OkieURRxzZbov7xtnxvKjMFz76bMflNbi1q+DIpws61FXg0gSdxS/QZAfCsd4ZLJIxgOE19GepRaPAO+tLwe+z08urdWrTq+wQ1dbbCbpnCF/1y14ABLAtqLcilLigr84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712279860; c=relaxed/simple;
	bh=5g1x0JtctFCzehvu5sDOW4RICwseIru6smTTPrGs44w=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Dc8jclD9vJHqrNSHtglRkSkPiegFewy6F5QeYLjnDuUhUBiwkHY9689i69QE3YS4lLaaYXOpsWLPMIsw5gm62oQ3PCXXxRfWrIFMuzu1/rHw6vFTzDWcKQzZ2WzgVju9DzqhTITlCy75RZRU2YiwsTW9N/GFc6j9itn5uvG0B2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=oKQQOLK4; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-221e6bf537dso977680fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 18:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712279858; x=1712884658; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EQxMqZGjO6On0d8fOn36WBa+dZFpEWJ11YL6qy2yIg8=;
        b=oKQQOLK4sh9FcOHkqgKC85jOhRF9Ixr5HuCmvQEdm1ZuilWWmlYBB7TdNjE/Tvtx/T
         dtPWe8hNkcgO6JSVSQoPpbGGg1J7kqauoSjxseZXj9uTS715F3P3SFVkh0+5YnTge9Mn
         w4xWUt9WCjTH43JeKM+eCkP1A4+BscSy/s3P1220wCorL/rP4iDfZpwgDK6fJ+eIn8/o
         Ll6SyaP9mXHza3rvukAiD+TPfHV3SFPYkFupKcC64asUqRN3JLL0h2bbDD6DfV5ui1No
         yfj0Pk9ND0ezKH60FSOBN0qluh24EUKibkw7y3k8Au7qEsUSn97zuwD/ssoN8RDhxQMb
         3Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712279858; x=1712884658;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQxMqZGjO6On0d8fOn36WBa+dZFpEWJ11YL6qy2yIg8=;
        b=TQ5nNEZjvprCQM3SW1HkFiE35hrzu1dTo9MTS+Bn21m5moAllqVLrdW5cJZEEB8/oi
         ksu+rN5cC9jzDz+BWWSZqfwqDo3LNB8DPgnlNfLu1ZlsxEYFWPQQuDXE+6Z7/GvzIs1h
         RCnXu/ilOm1wZsGiVzQINQpuzMYtEcmUwELszgGa3f8+MS7BZMUzsvGFFsz/XULpnqAB
         mYhhUB2PAtvg9I9wc5oAeB05dT908qaA2pYgh7GsOof1oKbscYFo2hDv2Owba6E+ibUz
         qeuTviTt67IWbjMvWhO5E4Ako4AtD11A75XM93l+6NEMpC3sNUzSdpTpl9ZONMHJT9yG
         +yMA==
X-Forwarded-Encrypted: i=1; AJvYcCVevQs9/9YgPz5RMv09X9sfri961ihkI2ULcChcg+iTIqOPjkxLuj3iZPPzaYRSxF7BZjQF7QJNWr24k1q62GYrhb5v7W8O95liWmjRrP65
X-Gm-Message-State: AOJu0YzEMLUeKayRjLe3XEak2Iimrx00kKr9l8FbYLtfnCc772JoNDwW
	pqjQZwpad3OgLKeC/s0zY4dYyvnL9e6u8EWNMiJhe8ZAKa+QH6JzYd6mSrjBEkE=
X-Google-Smtp-Source: AGHT+IGVDtGRMZy/gpg5pPuNMJyltBJ2CXu+51O1REh9PU6eJxwaMixmpw5mUJbo66+9mTp5ZibQ+g==
X-Received: by 2002:a05:6870:7b4a:b0:22e:d3f6:4f09 with SMTP id ji10-20020a0568707b4a00b0022ed3f64f09mr134792oab.34.1712279857902;
        Thu, 04 Apr 2024 18:17:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gx18-20020a056a001e1200b006ea8ba9902asm298784pfb.28.2024.04.04.18.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 18:17:35 -0700 (PDT)
Message-ID: <660f512f.050a0220.ff403.17fe@mx.google.com>
Date: Thu, 04 Apr 2024 18:17:35 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc2-14-g4389636db356
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (v6.9-rc2-14-g4389636db356)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.9-rc2-14-g43896=
36db356)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc2-14-g4389636db356/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc2-14-g4389636db356
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4389636db35667bb5d59422bfdfb3c876c3654c8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660f45e166132f6d684c42de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/660f45e16613=
2f6d684c42df
        failing since 532 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =20

