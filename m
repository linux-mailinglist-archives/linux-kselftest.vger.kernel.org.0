Return-Path: <linux-kselftest+bounces-5152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 531CC85D3D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7728B22347
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A3A3D3B7;
	Wed, 21 Feb 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="t4GIUPjz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF73D38E
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508422; cv=none; b=UqujkqTIzNJbyw0akLdfmrUxI+A7KebDqr7eRgNPHTw7QbVDHrJ0rmhk9ka/+OS33w69ePzKnfSXVLDRabdI2+REbtC28hWdW+vDeISuW9EiRonAvT1O8yLPJ/1Shde6fi3e1n2Yylfu61Bew6n510ilLlfWkCtmz0zXuViJnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508422; c=relaxed/simple;
	bh=HFkHHS+GAdWbBYN1pEhSvDeRxfbJuW8Pm88zkolC+L4=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=T3yPbE0C7CMNpbzMcouZ6S+CgWWdz4ujbIsE6N5JLKHsN3namBdo1R5rkw2hkUguw9PwsIjRBaTTdsx8TBrOG/Xdaba5OZsNPLBJg3NLTXw6nG8kDSSoa6MSCyZVSzEV9jxvDZoouFKsNo9Xezmfwbi3BCmzgz9VOCnnFG9fsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=t4GIUPjz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d94323d547so48097315ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 01:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708508421; x=1709113221; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=btPsSgYd3U39qbx9agK1iDVctNn1snM5vuQ/Okd8fYI=;
        b=t4GIUPjz+Vu8u0K7khMA9wcJA8oPuRK16BXhzT/3uIwr86QFOpuiFu+iEecw5L48yV
         I5+hxp5V/Pi5PrRv4ek6/hqkint3XtUziLHrNiiyrTtt+fKDhH+J2+Ab9DmVPzehb4Ff
         lshxtrzZ0Gkk+Cq/4wF93joJODFopu8E1SG2TBVFsvMF9QoPj/bsa2eCiuqVZn3Btu1O
         iJUmhHIfOoEv/8sRgFnsPqIkq0qIRVPfV/5YUy6bxTwHyFAXqUaNAXF0nEAqi7PWqcp/
         hu1UiF72NWMSZ/ZUx2jQQdveAC6mEIqe0P97NKWNs5+9iHwmQVAvbKerSZM+2gGJpdDF
         V2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508421; x=1709113221;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btPsSgYd3U39qbx9agK1iDVctNn1snM5vuQ/Okd8fYI=;
        b=IUvUMQlgZawApfCk3u48oJiLTshLRQ13Fih3LN+Q8qP1iWmhqqfEmzQHfgGUERJyB1
         KqfBeHlox/dEd7PDRw6bElyzfvqqpytviDoad7FvUhi7dprEneGns6aJymYOC22IsDUj
         cCZ6o1aF41m/Rm29XE/GiTFz75NChdadltbnnsZzMMT6ek6SmuaurmNQ/0seRBuVX7Cz
         mNLukH1wTpqe6yi0We+/P2oAYNpd8J1s+6l6vsbWtQRPm/pX0R33tIFyXYpOVZ8BeNfL
         rBa/Y/jbTp1zG8y28y4rRk9Jl8MuW00cLcT/cOHtHqIId161m+WO4Tt1FZnFeh6c3yMj
         VOIg==
X-Forwarded-Encrypted: i=1; AJvYcCVi+u5Ko3W+QpnIJrNDIHSI1LNdiDNQLT3YNOVDJMt6qnSA1M1k5V2T41FSPb2uAD6qa5UEPAWVL0pvKAi6nytmJrr1SBQIJUVp7qB8NfDp
X-Gm-Message-State: AOJu0YzrtVKFS8BgrgMu9Us5ADNk+vfFyjwJKpnlHegME/ywVuIUVwjq
	5e75L4EOkjSz3ldHfxNJAEX4YroLmo47CU4JeoY5ssoiX/CknzAyIcslJFccJGg=
X-Google-Smtp-Source: AGHT+IGd8hBR588eQeLe0Gg8nFJKupwxhCUbsHRlPgHe7VyFyE7A2lNlKO951Ti7vsEa53AACJYjpg==
X-Received: by 2002:a17:902:8348:b0:1d9:4e4c:23d2 with SMTP id z8-20020a170902834800b001d94e4c23d2mr14843177pln.44.1708508420926;
        Wed, 21 Feb 2024 01:40:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090323d000b001dbac604e4dsm7749115plh.146.2024.02.21.01.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:40:19 -0800 (PST)
Message-ID: <65d5c503.170a0220.6f30e.7a52@mx.google.com>
Date: Wed, 21 Feb 2024 01:40:19 -0800 (PST)
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
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (v6.8-rc1-48-g6f1a214d446b2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.8-rc1-48-g6f1a2=
14d446b2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-48-g6f1a214d446b2/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-48-g6f1a214d446b2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6f1a214d446b2f2f9c8c4b96755a8f0316ba4436 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d5b9d6c5327f8f17637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65d5b9d6c532=
7f8f17637013
        failing since 488 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =20

