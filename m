Return-Path: <linux-kselftest+bounces-11079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B30B8D6D54
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 03:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163B3286A08
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 01:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B571101D4;
	Sat,  1 Jun 2024 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3DfOnOeW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B9DDBB
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Jun 2024 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206171; cv=none; b=YmIT2Zt2JDai8Ygvvem2jyUrBfZm6CmguOBJxg6wdg89j51aykEjQTyZdZWUykm5S3exntssYSbod2VGnOKSf9+AHjlbZuKmVMnHuIrIHSeYg2Q2Dt3J0Ya0BLfJdzdS0kN+mHElCJX0WBBdaNx/H623lL+X3dmsa0K1tnZ/6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206171; c=relaxed/simple;
	bh=cGSbC9TDHmiZfytu9W9Zj8ZmWvln8hbzX8VZWgr5a6Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=eh4U4928qsGgct3bHlipyeivDKXx91O3qVT4NqYSdNZTfHuHSk4TMXLAkUbU3IHxoxuQsAfKdkrTB9eugCZYle9iN4s6Hexv862MoA8afO9A5nTVZcmYcrvdlcfhHyC1gW2h0FVrfFj1HsQM+rYTPd3klZQrzf5mCWCjrCGxVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=3DfOnOeW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f62a628b4cso15101375ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717206169; x=1717810969; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p4Nu3TkZpe9ALyys23atxxO7zhgxVXQtVq9WZmfF2nE=;
        b=3DfOnOeWKw8GDWPvVPFAH30JllRJZXJsvg0lj8csBJWI4kaEkSIH16tVvIlU+DInFQ
         AvOTLTzS3TCppVOISo9cPiDu28GUu+MhJxHJOqMgHJ8i3ez1CYkE5wIkRNn6ts3PDYv+
         p8/sEE4MYrbHt1vPd+ePy6ItyrMS4Ni8ZQpFp+mGBRKrhyQxb78Hq4s+aSI7ed1Z+Man
         ncq3uHabYBgHGI/F/DZnlvXifPim9SanPGXj64rN539p0Itlw9YGDjg68fbnt2nPsNCK
         msjXxVqlcT1ZNTWID741w7QGyaf+5e9Avpc3FV1kglmMdZZ5jTcqripRoWhjnfSphyp2
         Vd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206169; x=1717810969;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4Nu3TkZpe9ALyys23atxxO7zhgxVXQtVq9WZmfF2nE=;
        b=OM80IaqvDqqXGqs/plIizfr0CT61sqF5MurnWkwXl6DQi840u7Hi4T1chn9KpMUsLa
         owcQiHxtNCo54VWqIIXLeT/lBiV0NO/FuZKWVectuwYWU48Y892qEr6u8Y4d44SiEAtG
         GlP1F2QOuxRaJ5zfwyUBGtpnhygiRFZ996Dh61HM7P0yroiOyI+H+z6sHnyr5AJNf6GD
         gWycdFQofrG/cFVj8bDC0YTxYXeJEHfQWXLqup9akliZeRyUNaiJTnj+Eryxi6bEei4F
         4NSIHl4GcskheeZZLv9BYiv3SOfVIsvbn6Nhvg88f6ozZ79QOh37zOZc0adOQxbxouB+
         vCWA==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZLk9cqlVrSP++sEg9ILc5BI5jvoRcPHbXPCOt3vpuA/ij58vBX7yLDv/C4eBWm0/wW0JyYym3tAqMM5EjJeKY9gtOfWC2esTlzckAJmo
X-Gm-Message-State: AOJu0YxzULKx0qkPbzbzO7kICyDf3IPtMWkR6QgyIHkxji/RIWw6Q9vD
	wq6IZWXdX/wn31BdJfvoXxUhD4rDcM453XcAw09jnzy9rXSbqv1Xx01rP/PuzGg=
X-Google-Smtp-Source: AGHT+IG5nAi49y9lVawQbAaRZC9urfcsD4OVXnBDsvGMnMPlJ1BQvfg3CtqwqBnEAYulQcl3UcMw5Q==
X-Received: by 2002:a17:902:ecca:b0:1f4:7d47:b88b with SMTP id d9443c01a7336-1f636fe89damr50420325ad.11.1717206169167;
        Fri, 31 May 2024 18:42:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ff85csm22784585ad.237.2024.05.31.18.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:48 -0700 (PDT)
Message-ID: <665a7c98.170a0220.1158a1.6ef0@mx.google.com>
Date: Fri, 31 May 2024 18:42:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-11-g4bf15b1c657d2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-seccomp: 5 runs,
 1 regressions (v6.10-rc1-11-g4bf15b1c657d2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-seccomp: 5 runs, 1 regressions (v6.10-rc1-11-g4bf=
15b1c657d2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-11-g4bf15b1c657d2/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1-11-g4bf15b1c657d2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4bf15b1c657d22d1d70173e43264e4606dfe75ff =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/665a7398431722871e7e7074

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-11-g=
4bf15b1c657d2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccom=
p-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-11-g=
4bf15b1c657d2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccom=
p-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/665a73984317=
22871e7e7075
        new failure (last pass: v6.10-rc1-9-g0f42bdf59b4e4) =

 =20

